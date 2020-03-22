class SessionsController < ApplicationController
  def new
    @credential = PasswordCredential.new agent: Agent.new
    @credential.password_credential_datum = PasswordCredentialDatum.new email_address: EmailAddress.new,
                                                                        password_model: Password.new
  end
  
  def create
    credential = PasswordCredentialDatum.find_by(email_address: EmailAddress.find_by(email: credential_params[:email]))&.password_credential
    if credential
      if credential.authenticate credential_params[:password]
        user = User.create credential: credential, expires_at: auth.session_timeout.minutes.from_now
        session[:current_user_id] = user.id
        cookies.encrypted[:user_id] = user.id
        redirect_to root_path
      end
    end
  end

  def destroy
    current_user.update expires_at: Time.now
    current_user = nil
    session.delete :current_user_id
    cookies.delete :user_id
    redirect_to [:new, :session]
  end

private

  def credential_params
    params.require(:password_credential).permit :email, :password
  end
end
