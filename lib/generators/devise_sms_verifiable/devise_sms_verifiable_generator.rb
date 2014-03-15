require 'rails/generators/named_base'

module DeviseSmsVerifiable
  #module Generators
    class DeviseSmsVerifiableGenerator < Rails::Generators::NamedBase
      namespace "devise_sms_verifiable"

      desc "Add :sms_verifiable directive in the given model."

      def inject_devise_sms_verifiable_content
        path = File.join("app", "models", "#{file_path}.rb")
        inject_into_file(path, "sms_verifiable, :", after: "devise :") if File.exists?(path)
      end
    end
  #end
end
