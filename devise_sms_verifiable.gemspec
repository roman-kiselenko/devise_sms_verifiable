$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_sms_verifiable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_sms_verifiable"
  s.version     = DeviseSmsVerifiable::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DeviseSmsVerifiable."
  s.description = "TODO: Description of DeviseSmsVerifiable."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.3"

  s.add_development_dependency "sqlite3"
end
