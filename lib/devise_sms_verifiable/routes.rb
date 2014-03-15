module ActionDispatch::Routing
  class Mapper

    protected
    def devise_sms_verifiable(mapping, controllers)
      resource :sms, only: %i[new create], path: mapping.path_names[:sms], controller: controllers[:sms_verifiable] do
        post :send_pass, to: :send_pass
      end
      DeviseController.send(:include, DeviseSmsVerifiable::Controllers::InternalHelpers)
    end
  end
end

