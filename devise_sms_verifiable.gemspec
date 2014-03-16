$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_sms_verifiable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_sms_verifiable"
  s.version     = DeviseSmsVerifiable::VERSION
  s.authors     = ["Kiselenko Roman"]
  s.email       = %w(shindu666@gmail.com)
  s.homepage    = "https://github.com/fishbullet/devise_sms_verifiable"
  s.summary     = "DeviseSmsVerifiable it is simple fork devise_sms_activable for my project`s"
  s.description = <<-DESC
                     Module provide sms functions, easy to use and customize.
                     DESC

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails",  "~> 4.0.3"
  s.add_dependency "devise", "~> 3.2"
  s.add_runtime_dependency "rest_client"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'pry'
  s.add_development_dependency "sqlite3"
end

