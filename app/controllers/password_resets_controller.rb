class PasswordResetsController < ApplicationController
  skip_before_filter :require_login
  layout 'sessions'

  def new
  end

  # request password reset.
  # you get here when the user entered his email in the reset password form and submitted it.
  def create
    @user = User.find_by_email(params[:email])

    # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
    # TODO: Enviar instrucciones por Mandril
    # @user.deliver_reset_password_instructions! if @user
    if @user
      @user.generate_reset_password_token!
      MandrillPasswordReset.new(@user).submit!
      redirect_to login_path, notice: 'Se han enviado instrucciones a su correo electrónico.'
    else
      redirect_to new_password_reset_path, alert: 'El correo electrónico especificado no es válido.'
    end
  end

  # This is the reset password form.
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
    end
  end

  # This action fires when the user has sent the reset password form.
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      redirect_to(login_path, notice: 'Contraseña actualizada correctamente.')
    else
      render 'edit'
    end
  end
end