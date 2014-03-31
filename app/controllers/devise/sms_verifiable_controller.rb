class Devise::SmsVerifiableController < DeviseController
  append_before_filter :sms_check_settings!

  def new
    set_flash_message :notice, :sms_activation_required
  end

  def create
    resource.sms_secret = public_send("current_#{resource_name}").public_send(Devise::sms_answer_field)
    secret = params[:user][:sms_secret]
    if secret && resource.sms_secret && resource.valid_token?(secret)
      public_send("current_#{resource_name}").public_send(:update, Hash[Devise::phone_confirmation_field, true])
      public_send("current_#{resource_name}").public_send(:update, Hash[:sms_token_confirmed_at, DateTime.now])
      redirect_to Devise::successful_path
    else
      set_flash_message :notice, :sms_token_invalid
      render :new
    end
  end

  def send_pass
    number = public_send("current_#{resource_name}").public_send(Devise::phone_field)
    provider = Devise::sms_provider
    if [number, provider].all? && !public_send("current_#{resource_name}").sms_confirmed?
      token = public_send("current_#{resource_name}").sms_confirm!
      set_flash_message :notice, :send_token, phone: number
      provider.public_send(:send_sms, number, token)
    end
    render :new
  end

  protected

  def resource
    _resource = resource_class.new
    instance_variable_set(:@user, _resource)
    _resource
  end
end

