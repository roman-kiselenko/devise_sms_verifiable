require 'spec_helper'

describe DeviseSmsVerifiable::Provider do
  let(:provider) { DeviseSmsVerifiable::Provider }

  it 'request url' do
    expect(provider::MAIN_URL).to eq('http://web.szk-info.ru/sendsms.php')
  end

  it 'raise error if silent true' do
    #Devise::provider_silent = true
    #expect do
      #DeviseSmsPassword::Provider.send_sms('+77777777', 'hello')
    #end.to raise_error(ArgumentError)
  end

  it 'method to send sms' do
    expect(provider.respond_to?(:send_sms)).to be_true
  end

  it 'method to check status sms' do
    expect(provider.respond_to?(:check_status)).to be_true
  end

  it 'silent sent for test' do
    expect(Devise::provider_silent).to be_true
  end

  it 'provider login' do
    expect(Devise::provider_login).to be_instance_of String
  end

  it 'provider password' do
    expect(Devise::provider_password).to be_instance_of String
  end

  it 'provider default from' do
    expect(Devise::provider_from).to be_instance_of String
  end

end
