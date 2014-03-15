module DeviseSmsVerifiable
  class Engine < ::Rails::Engine
    isolate_namespace DeviseSmsVerifiable
    ActiveSupport.on_load(:action_controller) { include DeviseSmsVerifiable::Controllers::UrlHelpers }
    ActiveSupport.on_load(:action_view) { include DeviseSmsVerifiable::Controllers::UrlHelpers }
  end
end

