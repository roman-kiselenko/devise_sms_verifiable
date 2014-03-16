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
  mattr_accessor :sms_confirmation_method
  @@sms_confirmation_method = :sms_confirmation?

  mattr_accessor :sms_secret_method
  @@sms_secret_method = :sms_secret

  mattr_accessor :sms_answer_field
  @@sms_answer_field = :sms_answer

  mattr_accessor :sms_provider
  @@sms_provider = DeviseSmsVerifiable::Provider

  mattr_accessor :phone_field
  @@phone_field = :phone

  mattr_accessor :phone_confirmation_field
  @@phone_confirmation_field = :phone_confirm

  mattr_accessor :provider_silent
  @@provider_silent = true

  mattr_accessor :provider_login
  @@provider_login = 'kechinov'

  mattr_accessor :provider_password
  @@provider_password = 'KZslIzwL'

  mattr_accessor :provider_from
  @@provider_from = 'polis-test'
end

Devise.add_module :sms_verifiable, controller: :sms_verifiables, model: 'devise_sms_verifiable/model' , route: :sms_verifiable
