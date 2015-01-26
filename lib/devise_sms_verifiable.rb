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
  mattr_accessor :sms_answer_field
  @@sms_answer_field = :sms_answer

  mattr_accessor :phone_field
  @@phone_field = :phone

  mattr_accessor :phone_confirmation_field
  @@phone_confirmation_field = :phone_confirm

  mattr_accessor :successful_path
  @@successful_path = '/'

  mattr_accessor :token_generator
  @@token_generator = :default

  mattr_accessor :sms_provider
  @@sms_provider = DeviseSmsVerifiable::Provider

  mattr_accessor :provider_silent
  @@provider_silent = true

  mattr_accessor :provider_login
  @@provider_login = ''

  mattr_accessor :provider_password
  @@provider_password = ''

  mattr_accessor :provider_from
  @@provider_from = ''
end

Devise.add_module :sms_verifiable, controller: :sms_verifiables, model: 'devise_sms_verifiable/model' , route: :sms_verifiable
