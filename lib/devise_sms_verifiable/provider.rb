require 'rest_client'

module DeviseSmsVerifiable
  # This implementation only for "STREAM-TELECOM"
  module Provider
    MAIN_URL = "http://web.szk-info.ru/sendsms.php"
    SENT_SMS_URL = "#{MAIN_URL}?user=%s&pwd=%s&sadr=%s&dadr=%s&text=%s"
    CHECK_SMS_URL = "#{MAIN_URL}?user=%s&pwd=%s&smsid=%s"

    def self.send_sms(number, message)
      return 'test' if Devise::provider_silent
      number = number.gsub(/\+/, '')
      url = URI.escape(SENT_SMS_URL % [Devise::provider_login,
                                       Devise::provider_password,
                                       Devise::provider_from,
                                       number,
                                       message])
      RestClient.get(url)
    end

    def self.check_status(sms_id)
      url = CHECK_SMS_URL % [Devise::provider_login,
                             Devise::provider_password,
                             sms_id]
      response = case RestClient.get(url)
                 when /Send/ then :send
                 when /deliver/ then :deliver
                 end
      response
    end
  end
end


