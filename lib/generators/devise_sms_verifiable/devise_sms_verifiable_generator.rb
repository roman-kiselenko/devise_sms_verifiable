require 'rails/generators/named_base'

module DeviseSmsVerifiable
  class DeviseSmsVerifiableGenerator < Rails::Generators::NamedBase
    namespace "devise_sms_verifiable"
    desc "Choose:
    \n
\033[31mrails g devise_sms_verifiable:install\e[0m\n
Add config variables to devise initializer.\n
\033[31mrails generate devise_sms_verifiable:views\e[0m\n
Install views to your app\n
\033[31mrails g devise_sms_verifiable:migration\e[0m\n
Add migration."
  end
end
