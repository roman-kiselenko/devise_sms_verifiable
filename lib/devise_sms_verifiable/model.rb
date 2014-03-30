module Devise
  module Models
    module SmsVerifiable
      extend ActiveSupport::Concern
      mattr_accessor :sms_secret
      @@sms_secret = nil

      def generate_token!
        number = rand(1200..4500)
        public_send(:update, Hash[Devise::sms_answer_field, number])
        number
      end

      def valid_secret?(incoming_secret)
        @@sms_secret == incoming_secret.to_s
      end
    end
  end
end

