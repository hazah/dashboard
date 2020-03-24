class SessionsController < ApplicationController
  def new
    @credential = PasswordCredential.new
  end
  
  def create
    logger.debug params
    @email = Email.find_by email: credential_params[:basic_profile_attributes][:detail_attributes][:email_model_attributes][:email]
    @detail = BasicProfileDetail.find_by email_model: @email if @email
    
    @credential = @detail.basic_profile.credentials.detect { |credential| credential.authenticate credential_params[:datum_attributes][:password_model_attributes][:password] } if @detail
    
    if @credential
      user = User.create credential: @credential, expires_at: auth.session_timeout.minutes.from_now
      session[:current_user_id] = user.id
      cookies.encrypted[:user_id] = user.id
      redirect_to root_path
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
    params.require(:password_credential).permit basic_profile_attributes: basic_profile_attributes, datum_attributes: datum_attributes
  end

  def basic_profile_attributes
    { detail_attributes: detail_attributes }
  end

  def detail_attributes
    { email_model_attributes: email_model_attributes }
  end

  def email_model_attributes
    [:email]
  end

  def datum_attributes
    { password_model_attributes: password_model_attributes }
  end

  def password_model_attributes
    [:password]
  end
end
