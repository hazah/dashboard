class RegistrationsController < ApplicationController
  before_action if: :current_user?, only: :new do
    redirect_to root_path
  end

  def new
    @credential = PasswordCredential.new
  end

  def create
    @credential = PasswordCredential.new
    @credential.build_basic_profile.tap do |profile|
      profile.build_human.build_detail
      profile.build_detail.tap do |detail|
        detail.build_name_model
        detail.build_email_model
      end
    end
    @credential.build_datum.build_password_model
    @credential.attributes = credential_params
    
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
    [:type, { detail_attributes: profile_detail_attributes, human_attributes: human_attributes }]
  end

  def profile_detail_attributes
    { profile_attributes: [:id], email_model_attributes: email_model_attributes, name_model_attributes: name_model_attributes }
  end

  def email_model_attributes
    [:email]
  end

  def name_model_attributes
    [:name]
  end

  def human_attributes
    { detail_attributes: human_detail_attributes }
  end

  def human_detail_attributes
    [:id]
  end

  def datum_attributes
    { password_model_attributes: password_model_attributes }
  end

  def password_model_attributes
    [:password, :password_confirmation]
  end
end
