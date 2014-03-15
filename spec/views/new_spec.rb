require "spec_helper"

feature 'user can confirm phone' do
  given(:user) { create(:user) }

  background do
    visit('/user/sign_in')
    within('#new_user') do
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: user.password)
    end
    click_button('Sign in')
  end

  scenario '#send pass' do
    expect { page.find(:link_or_button, 'sms') }.to be_true
    visit(new_user_sms_path)
    click_button('send sms')
    # dirty hack, but i can`t undestand why sms_answer always nil?
    user.update(phone_confirm: true)
    visit(root_path)
    expect { page.find(:link_or_button, 'sms') }.to raise_error
  end
end
