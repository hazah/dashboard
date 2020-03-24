class RegistrationsController < ApplicationController
  before_action if: :current_user?, only: :new do
    head :no_content
  end

  def new
    @credential = PasswordCredential.new
  end
  
  def create
    @credential = PasswordCredential.new credential_params
    
    if @credential.save
      user = User.create credential: @credential, expires_at: auth.session_timeout.minutes.from_now
      session[:current_user_id] = user.id
      redirect_to root_path
    end
  end

  def update
  end

  def destroy
    
  end

private
  
  def credential_params
    params.require(:password_credential).permit basic_profile_attributes: basic_profile_attributes, datum_attributes: datum_attributes
  end

  def basic_profile_attributes
    [:type, { detail_attributes: detail_attributes, agent_attributes: agent_attributes }]
  end

  def detail_attributes
    { profile_attributes: [:id], email_model_attributes: email_model_attributes, name_model_attributes: name_model_attributes }
  end

  def email_model_attributes
    [:email]
  end

  def name_model_attributes
    [:name]
  end

  def agent_attributes
    [:id]
  end

  def datum_attributes
    { password_model_attributes: password_model_attributes }
  end

  def password_model_attributes
    [:password, :password_confirmation]
  end
end
