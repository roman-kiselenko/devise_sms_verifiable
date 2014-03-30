class Devise::SmsVerifiableController < DeviseController
  append_before_filter :sms_check_settings!

  def new
  end

  def create
    resource.sms_secret = public_send("current_#{resource_name}").public_send(Devise::sms_answer_field)
    secret = params[:user][:sms_secret]
    if secret && resource.sms_secret && resource.valid_secret?(secret)
      public_send("current_#{resource_name}").public_send(:update, Hash[Devise::phone_confirmation_field, true])
      redirect_to Devise::successful_path
    else
      render :new
    end
  end

  def send_pass
    number = public_send("current_#{resource_name}").public_send(Devise::phone_field)
    provider = Devise::sms_provider
    pass_word = public_send("current_#{resource_name}").generate_token!
    if [number, provider, pass_word].all?
      provider.public_send(:send_sms, number, pass_word)
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

