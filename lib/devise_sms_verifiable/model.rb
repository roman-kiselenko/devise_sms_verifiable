module Devise
  module Models
    module SmsVerifiable
      extend ActiveSupport::Concern
      mattr_accessor :sms_secret
      @@sms_secret = nil

      def valid_secret?(incoming_secret)
        @@sms_secret == incoming_secret.to_s
      end
    end
  end
end

