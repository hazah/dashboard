module RegistrationsHelper
  def credential
    @credential
  end

  def registration_id
    :registration
  end

  alias :registration_class :registration_id

  def registration_options
    {
      id: registration_id,
      class: registration_class
    }
  end

  def email_credential credential_form
    credential_form.fields_for :basic_profile, @credential.build_basic_profile do |profile_form|
        profile_form.fields_for :detail, @credential.basic_profile.build_detail do |detail_form|
          detail_form.fields_for :email_model, @credential.basic_profile.detail.build_email_model do |email_form| 
            render "application/form_group", field: :email, field_type: :email_field, form: email_form
          end
        end
      end
  end

  def password_credential credential_form
    credential_form.fields_for :datum, @credential.build_datum do |datum_form|
        datum_form.fields_for :password_model, @credential.datum.build_password_model do |password_form|          
          render "application/form_group", field: :password, field_type: :password_field, form: password_form
        end
      end
  end

  def password_confirmation_credential credential_form
    credential_form.fields_for :datum, @credential.build_datum do |datum_form|
      datum_form.fields_for :password_model, @credential.datum.build_password_model do |password_form|          
        render "application/form_group", field: :password_confirmation, field_type: :password_field, form: password_form
      end
    end
  end

  def name_credential credential_form
    credential_form.fields_for :basic_profile, @credential.basic_profile do |profile_form|
        profile_form.fields_for :detail, @credential.basic_profile.build_detail do |detail_form|
          detail_form.fields_for :name_model, @credential.basic_profile.detail.build_name_model do |name_form|
            render "application/form_group", field: :name, field_type: :text_field, form: name_form
          end
        end
      end
  end
end
