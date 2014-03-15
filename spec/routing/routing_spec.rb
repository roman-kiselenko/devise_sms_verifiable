require "spec_helper"

describe 'routes for sms module' do
  it { expect(post(send_pass_user_sms_path)).to route_to("devise/sms_verifiable#send_pass") }
  it { expect(post(user_sms_path)).to route_to("devise/sms_verifiable#create") }
  it { expect(get(new_user_sms_path)).to route_to('devise/sms_verifiable#new') }
end
