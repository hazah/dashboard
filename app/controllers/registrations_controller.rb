class RegistrationsController < ApplicationController
  def new
    @credential = PasswordCredential.new agent: Agent.new
    @credential.password_credential_datum = PasswordCredentialDatum.new email_address: EmailAddress.new,
                                                                        password_model: Password.new
  end
  
  def create
    logger.debug credential_params
    ApplicationRecord.transaction do
      email_address = EmailAddress.create(credential_params[:password_credential_datum_attributes][:email_address_attributes])
      agent = Agent.create(name: credential_params[:agent_attributes][:name], email_address: email_address)
      
      @credential = PasswordCredential.create agent: agent
      
      PasswordCredentialDatum.create  password_credential: @credential,
                                      email_address: email_address,
                                      password_model: Password.create(credential_params[:password_credential_datum_attributes][:password_model_attributes])
                                      
    
    end
    if @credential.password_credential_datum.valid?
      user = User.create credential: @credential, expires_at: auth.session_timeout.minutes.from_now
      session[:current_user_id] = user.id
      redirect_to root_path
    end
  end

  def destroy
    
  end

private

  def credential_params
    params.require(:password_credential).
            permit  password_credential_datum_attributes: [
                      email_address_attributes: [:email], 
                      password_model_attributes: [:password, :password_confirmation], 
                    ],
                    agent_attributes: [:name]
  end
end
