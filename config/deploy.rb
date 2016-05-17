require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm' # for rvm support. (http://rvm.io)
require 'mina/whenever'


# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :term_mode, nil

#set :domain, '104.131.127.9'
#set :deploy_to, '/var/www/manes'
#set :repository, 'git@git.sistematis.com.ar:snappler/manes'
#set :branch, 'master'
#set :user, 'deploy'    # Username in the server to SSH to.


# For system-wide RVM install.
set :rvm_path, '/home/deploy/.rvm/scripts/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, %w(public/uploads config/database.yml config/secrets.yml log config/unicorn.rb unicorn_shared)

# Optional settings:

#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.

  invoke :'rvm:use[ruby-2.3.0@manes]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/public/uploads"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/uploads"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared/pids"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared/sockets"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/unicorn_shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/unicorn_shared"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/unicorn.rb"]
  queue %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml', 'secrets.yml' and 'unicorn.rb'"]

  # queue %[
  #   repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
  #   repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
  #   if [ -z "${repo_port}" ]; then repo_port=22; fi &&
  #   ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  # ]
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  to :before_hook do
    # Put things to run locally before ssh
    # BASH
    # if git branch -v | grep feature/ | grep -q ahead; then echo 1; else echo 0; fi
  end

  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_create' #Esta linea se puede remover despues del primer deploy exitoso
    invoke :'rails:db_migrate:force'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue! 'echo "-----> Unicorn Restart"'
      invoke :'unicorn:restart'
      invoke :'whenever:update'

      #   queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      #   queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end

namespace :nginx do
  desc 'Reiniciar el servidor nginx'
  task :restart do
    queue 'sudo service nginx restart'
  end
end

namespace :unicorn do
  desc 'Iniciar la applicaion unicorn - con environment'
  task :start do
    queue "sudo /etc/init.d/unicorn_manes_#{rails_env} start"
  end

  desc 'Frena la applicaion unicorn - con environment'
  task :stop do
    queue "sudo /etc/init.d/unicorn_manes_#{rails_env} stop"
  end

  desc 'Reinicia la applicaion unicorn - con environment'
  task :restart do
    queue "sudo /etc/init.d/unicorn_manes_#{rails_env} stop"
    queue 'sleep 3'
    queue "sudo /etc/init.d/unicorn_manes_#{rails_env} start"
  end
end

namespace :logs do
  desc 'Muestra logs del servidor'
  task :server do
    queue "tail -f #{deploy_to}/#{shared_path}/log/nginx.*"
  end

  desc 'Muestra logs de la aplicacion'
  task :app do
    queue "tail -f #{deploy_to}/#{shared_path}/log/#{rails_env}.log"
  end
end


# Dump production DB and put on your environment
# https://weluse.de/blog/syncing-database-content-using-mina.html

RYAML = <<-BASH
 function ryaml {
   ruby -ryaml -e 'puts ARGV[1..-1].inject(YAML.load(File.read(ARGV[0]))) {|acc, key| acc[key] }' "$@"
 };
BASH

namespace :db do
  task :clone do
    isolate do
      invoke :environment

      queue RYAML
      queue "USERNAME=$(ryaml #{deploy_to}/#{shared_path}/config//database.yml #{rails_env} username)"
      queue "PASSWORD=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} password)"
      queue "DATABASE=$(ryaml #{deploy_to}/#{shared_path}/config/database.yml #{rails_env} database)"
      queue "mysqldump $DATABASE --user=$USERNAME --password=$PASSWORD > #{deploy_to}/dump.sql"
      queue "gzip -f #{deploy_to}/dump.sql"

      mina_cleanup!
    end

    %x[scp deploy@#{domain}:#{deploy_to}/dump.sql.gz .]
    %x[gunzip -f dump.sql.gz]
    %x[#{RYAML} mysql --verbose --user=$(ryaml config/database.yml development username) $(ryaml config/database.yml development database) < dump.sql]
    %x[rm dump.sql]
  end
end


# HOLA = <<-BASH
#  function culo {
#    echo `date` >> /tmp/test.do.txt
#  };
# BASH
#
# namespace :test do
#   task :do do
#     %x[#{HOLA} culo]
#   end
# end

# https://github.com/mina-deploy/mina