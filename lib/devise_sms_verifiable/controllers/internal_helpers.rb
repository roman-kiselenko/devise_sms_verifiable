module DeviseSmsVerifiable
  module Controllers
    module InternalHelpers

      def sms_check_settings!
        if public_send("current_#{Devise::default_scope}").nil?
          public_send(:redirect_to, %I[new #{Devise::default_scope} session]) and return
        end
        raise PhoneFieldNotFound unless public_send("current_#{Devise::default_scope}").respond_to?(Devise::phone_field)
        raise PhoneFieldEmpty unless public_send("current_#{Devise::default_scope}").public_send(Devise::phone_field)
        raise SecretMethodNotFound unless InternalHelpers::valid_method?(self, Devise::sms_secret_method)
        raise ValidSendSmsMethodNotFound unless InternalHelpers::valid_method?(Devise::sms_provider, :send_sms)
      rescue DeviseSmsVerifiableError, ArgumentError
        raise "DeviseSmsVerifiableError module error: #{$!.message} "
      end

      def require_sms_verifiable!
        sms_check_settings!
        unless public_send(:"current_#{Devise::default_scope}").public_send("#{Devise::phone_confirmation_field}?")
          redirect_to %I[new #{Devise::default_scope} sms] and return
        end
      end

      protected

      def self.valid_method?(caller, method)
        method.kind_of?(Symbol) && caller.respond_to?(method)
      end
    end
  end
end
ActionController::Base.send :include, DeviseSmsVerifiable::Controllers::InternalHelpers

