class SessionsController < ApplicationController
  before_action if: :current_user?, except: :destroy do
    SessionPingJob.perform_later current_user
    respond_to do |format|
      format.js   { head :ok }
      format.html { redirect_to root_path }
    end
  end

  def new
    @credential = PasswordCredential.new
  end
  
  def create
    @email = Email.find_by email: credential_params[:basic_profile_attributes][:detail_attributes][:email_model_attributes][:email]
    @detail = BasicProfileDetail.find_by email_model: @email if @email
    
    @credential = @detail.basic_profile.credentials.detect { |credential| credential.authenticate credential_params[:datum_attributes][:password_model_attributes][:password] } if @detail
    
    if @credential
      user = User.create credential: @credential, expires_at: auth.session_timeout.minutes.from_now
      session[:current_user_id] = user.id
      ActionCable.server.remote_connections.where(visit: cookies.encrypted[:visit]).disconnect
      redirect_to root_path
    end
  end

  def destroy
    current_user.update expires_at: Time.now
    session.delete :current_user_id
    ActionCable.server.remote_connections.where(visit: cookies.encrypted[:visit]).disconnect
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
