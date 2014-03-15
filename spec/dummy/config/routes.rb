Rails.application.routes.draw do

  mount DeviseSmsVerifiable::Engine => "/devise_sms_verifiable"
end
