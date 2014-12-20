module Devise
  module Models
    module SmsVerifiable
      extend ActiveSupport::Concern
      mattr_accessor :sms_secret
      @@sms_secret = nil

      def sms_confirmed?
        public_send("#{Devise::phone_confirmation_field}?")
      end

      def sms_unconfirm!
	unconfirm_hash = Hash[Devise::sms_answer_field, nil,
		              Devise::phone_confirmation_field, false,
			      Devise::sms_token_sent_at, nil,
			      Devise::sms_token_confirmed_at, nil]
        public_send(:update, unconfirm_hash)
      end

      def sms_confirm!
        token = generate_token!
        public_send(:update, Hash[Devise::sms_answer_field, token,
				  :sms_token_sent_at, DateTime.now])
        token
      end

      def valid_token?(incoming_token)
        @@sms_secret == incoming_token.to_s
      end

      protected

      def generate_token!
	meth = Devise::token_generator
	token = if meth.is_a? Symbol
		  rand(2000..4000)
		elsif meth.is_a? Proc
		  meth.call
		end
	token
      end
    end
  end
end

