class UserMailer < ActionMailer::Base
  require 'mandrill'
  
  default from: 'no-reply@manes.com'
  layout 'mailer'
  
  def self.mandrill_client
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_API_KEY']
  end  
  
  def self.new_mail
    template_name = 'manes-basic'
    template_content = []
    user_name = "Francisco"
    content_title = "Este es el título"
    content_message = "Este es el contenido"
    action = "Ir al sitio"
    message = {
      to: [{email: "francisco@snappler.com", name: user_name}],
      subject: "[Sistema Manes] Nueva notificación ",
      global_merge_vars: [
        {name: "USER_NAME", content: user_name },
        {name: "CONTENT_TITLE", content: content_title},
        {name: "CONTENT_MESSAGE", content: content_message},
        {name: "ACTION", content: action},
        {name: "URL", content: "http://localhost:3000" }
      ]
    }
    
    mandrill_client.messages.send_template template_name, template_content, message
  end
end


