require 'rails/generators/base'

module DeviseSmsVerifiable
  #module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Add DeviseSmsVerifiable config variables to the Devise initializer."

      def add_config_options_to_initializer
        devise_initializer_path = "config/initializers/devise.rb"
        if File.exist?(devise_initializer_path)
          old_content = File.read(devise_initializer_path)

          if old_content.match(Regexp.new(/^# ==> Configuration for :sms_verifiable\n/))
            false
          else
            inject_into_file(devise_initializer_path, before: "# ==> Configuration for :database_authenticatable\n") do
<<-CONTENT
  # ==> Configuration for :sms_verifiable
  # Field in model for confirm phone(must be boolean)
  #config.phone_confirmation_field = :phone_confirm
  # Method for check sms confirmation. Define in ApplicationController
  #config.sms_confirmation_method = :sms_confirmation?
  # Method generate secret and write to model. Define in ApplicationController
  #config.sms_secret_method = :sms_secret
  # Attribut on model return rigth answer
  #config.sms_answer_field = ""
  # SMS provider module(have default for STREAM-TELECOM)
  #config.sms_provider = DeviseSmsVerifiable::Provider
  # Field in model which phone number
  #config.phone_field = :phone
  # Field in model for confirm phone(must be boolean)
  #config.phone_confirmation_field = :phone_confirm
  # Send sms silent for test
  #config.provider_silent = true
  # SMS provider login
  #config.provider_login = :provider_login
  # SMS provider password
  #config.provider_password :provider_password
  # SMS provider from
  #config.provider_from :provider_from
  #\n
CONTENT
            end
          end
        end
      end

      #def show_readme
        #readme "README"
      #end

    end
  #end
end
