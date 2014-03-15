module DeviseSmsVerifiable
  module Controllers
    module InternalHelpers
      extend ActiveSupport::Concern

      def sms_check_settings
        raise UnauthorizedAccess unless signed_in?(Devise::default_scope)
        raise PhoneFieldNotFound unless public_send("current_#{resource_name}").respond_to?(Devise::phone_field)
        raise PhoneFieldEmpty unless public_send("current_#{resource_name}").public_send(Devise::phone_field)
        raise SecretMethodNotFound unless InternalHelpers::valid_method?(self, Devise::sms_secret_method)
        raise ValidSendSmsMethodNotFound unless InternalHelpers::valid_method?(Devise::sms_provider, :send_sms)
      rescue DeviseSmsVerifiableError, ArgumentError
        raise "DeviseSmsVerifiableError module error: #{$!.message} "
      end

      def self.valid_method?(caller, method)
        method.kind_of?(Symbol) && caller.respond_to?(method)
      end
    end
  end
end

