class UserMailer < ActionMailer::Base
  require 'mandrill'
  
  default from: 'no-reply@manes.com'
  layout 'mailer'
  
  def self.mandrill_client
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_API_KEY']
  end  
  
  def self.new_mail(user, title, message, subject= nil, url= nil)
    template_name = 'manes-basic'
    template_content = []
    user_name = user.to_s
    content_title = title
    content_message = message
    subject ||= 'Nueva notificación'
    url ||= Const::URL
    action = "Ir al sitio"
    message = {
      to: [{email: "test@test.com", name: user_name}],
      subject: "[Sistema Manes] #{subject}",
      global_merge_vars: [
        {name: "USER_NAME", content: user_name },
        {name: "CONTENT_TITLE", content: content_title},
        {name: "CONTENT_MESSAGE", content: content_message},
        {name: "ACTION", content: action},
        {name: "URL", content: url }
      ]
    }
    # TODO Enable send emails
    # mandrill_client.messages.send_template template_name, template_content, message
  end
end


