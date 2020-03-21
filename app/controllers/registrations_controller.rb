class RegistrationsController < ApplicationController
  def new
    @credential = Credential.new  email_address: EmailAddress.new,
                                      password_model: Password.new,
                                      agent: Agent.new
  end
  
  def create
    ApplicationRecord.transaction do
      email_address = EmailAddress.create(credential_params[:email_address_attributes])
      agent = Agent.create(name: credential_params[:agent_attributes][:name], email_address: email_address)
      @credential = Credential.create email_address: email_address,
                                      password_model: Password.create(credential_params[:password_model_attributes]),
                                      agent: agent
    
    end
    if @credential.valid?
      user = User.create credential: @credential, expires_at: 2.minutes.from_now
      session[:current_user_id] = user.id
      redirect_to root_path
    end
  end

  def destroy
    
  end

private

  def credential_params
    params.require(:credential).permit :password, :password_confirmation, 
                                        email_address_attributes: [:email], 
                                        password_model_attributes: [:password, :password_confirmation], 
                                        agent_attributes: [:name]
  end
end
