require 'rails/generators/base'

module DeviseSmsVerifiable
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../app/views", __FILE__)

    def copy_views_sms
      exist_path = 'app/views/devise'
       if File.exist? exist_path
         directory('devise', exist_path)
       end
    end
  end
end
