module DeviseSmsVerifiable
  module Controllers
    module InternalHelpers
      extend ActiveSupport::Concern

      def sms_check_settings
        raise PhoneFieldNotFound unless resource.respond_to?(Devise::phone_field)
        raise PhoneFieldEmpty unless public_send("current_#{resource_name}").public_send(Devise::phone_field)
        raise SecretMethodNotFound unless InternalHelpers::valid_method?(self, Devise::sms_secret_method)
        raise ValidSendSmsMethodNotFound unless InternalHelpers::valid_method?(Devise::sms_provider, :send_sms)
      rescue DeviseSmsPasswordError, ArgumentError
        raise "DeviseSmsVerifiableError module error: #{$!.message} "
      end

      def resource
        @resource ||= self.public_send(:resource_name).to_s.classify.constantize.new
      end

      def resource_name
        Devise::default_scope
      end

      def devise_mapping
        @devise_mapping ||= Devise.mappings[resource_name]
      end

      def self.valid_method?(caller, method)
        method.kind_of?(Symbol) && caller.respond_to?(method)
      end
    end
  end
end

