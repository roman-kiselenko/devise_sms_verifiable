module Devise
  module Models
    module SmsVerifiable
      extend ActiveSupport::Concern
      mattr_accessor :sms_secret
      @@sms_secret = nil

      def sms_confirmed?
        public_send("#{Devise::phone_confirmation_field}?")
      end

      def sms_confirm!
        token = generate_token!
        public_send(:update, Hash[Devise::sms_answer_field, token])
        public_send(:update, Hash[:sms_token_sent_at, DateTime.now])
        token
      end

      def valid_token?(incoming_token)
        @@sms_secret == incoming_token.to_s
      end

      protected

      def generate_token!
        rand(1000..2000)
      end
    end
  end
end

