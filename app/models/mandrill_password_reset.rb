class MandrillPasswordReset
  require 'mandrill'
  include Rails.application.routes.url_helpers

  HOST = 'localhost:3000'
  TEMPLATE_NAME = 'manes-reset-password-with-style'

  def initialize(user)
    @email = user.email
    @name = "#{user.first_name} #{user.last_name}"
    @url = edit_password_reset_url(host: HOST, id: user.reset_password_token)
  end

  def submit!
    mandrill_api.send_template(TEMPLATE_NAME, [], message)
  end

  def message
    {
      from_email: 'develop@snappler.com',
      to: [{email: @email, name: @name}],
      subject: 'Reiniciar contraseña',
      global_merge_vars: [
        {name: 'USER_NAME', content: @name},
        {name: 'URL', content: @url}
      ]
    }
  end

  def mandrill_api
    Mandrill::API.new('Ge8QzfGINPwInzV4F7gPAg').messages
  end

end