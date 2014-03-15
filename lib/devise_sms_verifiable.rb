require "devise"
require "devise_sms_verifiable/engine"

module DeviseSmsVerifiable
  autoload :Provider, 'devise_sms_verifiable/provider'
end

require 'devise_sms_verifiable/routes'
require 'devise_sms_verifiable/controllers/internal_helpers'
require 'devise_sms_verifiable/controllers/url_helpers'
require 'devise_sms_verifiable/engine'
require 'devise_sms_verifiable/errors'

module Devise
  # Method for check sms confirmation
  mattr_accessor :sms_confirmation_method
  @@sms_confirmation_method = :sms_confirmation?

  # Method generate secret and write to model
  mattr_accessor :sms_secret_method
  @@sms_secret_method = :sms_secret

  # Attribut on model return rigth answer
  mattr_accessor :sms_answer_field
  @@sms_answer_field = ""

  # SMS provider module(for STREAM-TELECOM)
  mattr_accessor :sms_provider
  @@sms_provider = DeviseSmsVerifiable::Provider

  # Field in model with phone number
  mattr_accessor :phone_field
  @@phone_field = :phone

  # Field in model for confirm phone(must be boolean)
  mattr_accessor :phone_confirmation_field
  @@phone_confirmation_field = :phone_confirm

  # Send sms silent for test
  mattr_accessor :provider_silent
  @@provider_silent = true

  # SMS provider login
  mattr_accessor :provider_login
  @@provider_login = ""

  # SMS provider password
  mattr_accessor :provider_password
  @@provider_password = ""

  # SMS provider from
  mattr_accessor :provider_from
  @@provider_from = ""
end

Devise.add_module :sms_verifiable, controller: :sms_verifiables, model: 'devise_sms_verifiable/model' , route: :sms_verifiable
#config.provider_silent = true
#  config.provider_login = "kechinov"
#  config.provider_password = "KZslIzwL"
#  config.provider_from = "polis-test"
#  config.phone_field = :phone
#  config.phone_confirmation_field = :phone_confirm
#  config.sms_confirmation_method = :sms_confirmation?
#  config.sms_secret_method = :sms_secret
#  config.sms_answer_field = :sms_answer
