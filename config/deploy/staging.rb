set :domain, '159.203.127.247'
set :deploy_to, '/var/www/manes/staging'
set :repository, 'git@git.sistematis.com.ar:snappler/manes'
set :branch, ENV['branch'] || 'master'
set :user, 'deploy'
set :rails_env, 'staging'

