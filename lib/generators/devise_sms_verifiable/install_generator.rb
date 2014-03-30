require 'rails/generators/base'

module DeviseSmsVerifiable
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add_config_options_to_initializer
      devise_initializer_path = "config/initializers/devise.rb"
      if File.exist?(devise_initializer_path)
        old_content = File.read(devise_initializer_path)

        if old_content.match(Regexp.new(/^\s# ==> Configuration for :sms_verifiable\n/))
          false
        else
          inject_into_file(devise_initializer_path, before: "# ==> Configuration for :database_authenticatable\n") do
<<-CONTENT
# ==> Configuration for :sms_verifiable
  # Field in model for confirm phone(must be boolean)
  #config.phone_confirmation_field = :phone_confirm
  # Attribut on model return rigth answer
  #config.sms_answer_field = :sms_answer
  # Field in model which phone number
  #config.phone_field = :phone
  # Field in model for confirm phone(must be boolean)
  #config.phone_confirmation_field = :phone_confirm
  # Path after successful confirmation
  #config.successful_path = '/'
  # SMS provider module(have default for STREAM-TELECOM)
  #config.sms_provider = DeviseSmsVerifiable::Provider
  # Send sms silent for test
  #config.provider_silent = true
  # SMS provider login
  #config.provider_login = ""
  # SMS provider password
  #config.provider_password = ""
  # SMS provider from
  #config.provider_from = ""
  \n
CONTENT
          end
        end
      end
    end

    def show_readme
      readme "README"
    end
  end
end
