class Devise::SmsVerifiableController < ApplicationController
  include Devise::Controllers
  append_before_filter :sms_check_settings
  helper_method :resource, :resource_name, :devise_mapping

  def new;end

  def create
    resource.sms_secret = public_send("current_#{resource_name}").public_send(Devise::sms_answer_field)
    secret = params[:user][:sms_secret]
    if secret && resource.sms_secret && resource.valid_secret?(secret)
      public_send("current_#{resource_name}").public_send(:update, Hash[Devise::phone_confirmation_field, true])
      redirect_to after_successful_phone_confirmation_path(resource)
    else
      render :new
    end
  end

  def send_pass
    number = public_send("current_#{resource_name}").public_send(Devise::phone_field)
    provider = Devise::sms_provider
    pass_word = public_send(Devise::sms_secret_method)
    if [number, provider, pass_word].all?
      provider.public_send(:send_sms, number, pass_word)
    end
    render :new
  end

  protected

  def after_successful_phone_confirmation_path(resource)
    root_path
  end
end

