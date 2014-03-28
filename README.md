## DeviseSmsVerifiable ##
This is alpha-version

Just a simple module for [Devise](https://github.com/plataformatec/devise) provide sms functions, easy to use and customize.
```rbcon
# Developed and tested on:
Ruby 2.1.0
Rails 4.0.3
Devise 3.2
```
## Install
* Add to `Gemfile` and `bundle install`
```ruby
gem 'devise_sms_verifiable',  git: 'git://github.com/fishbullet/devise_sms_verifiable.git'
```
* If [Devise](https://github.com/plataformatec/devise) is installed,
run the generator to add configuration settings
to [Devise](https://github.com/plataformatec/devise) initializer.
Otherwise use [this generators](https://github.com/fishbullet/devise_sms_verifiable#generators):
```irb
$ rails generate devise_sms_verifiable:install
```
* Generate migration:
```irb
$ rails generate devise_sms_verifiable:migration
```
* To generate views run:
```irb
$ rails generate devise_sms_verifiable:views
```
After successful installation you should have routes ```rake routes```
```irb
send_pass_user_sms_path  POST	 /user/sms/send_pass(.:format)	 devise/sms_verifiable#send_pass
user_sms_path	           POST	 /user/sms(.:format)	           devise/sms_verifiable#create
new_user_sms_path	       GET	 /user/sms/new(.:format)	       devise/sms_verifiable#new
```
## How it works ##
Method(:sms_secret) generates secret word and writes it to the model, returns secret word.
Devise_sms_verifiable controller uses this method to generate secret word.
Add this code to ApplicationController:
```ruby
class ApplicationController < ActionController::Base
  def sms_secret
    answer = (10..48).to_a.shuffle.take(4).join
    current_user.update(sms_answer: answer)
    answer
  end
end
```
Migration will add several fields to model
```ruby
< User id: 1,
email: "shindu666<bla>gmail.com",
created_at: "2014-03-25 15:24:30",
updated_at: "2014-03-25 15:26:44",
phone: "+79818327398",             <----------| phone field
sms_answer: 1245,                  <----------| answer field
phone_confirm: false >             <----------| need confirmation?
```
### Model ###

Add module `:sms_verifiable` to model:
```ruby
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
                                    :validatable,
                                    :sms_verifiable,
                                    :recoverable
end
```
### Available options ###

* * *

* Boolean field in model for phone confirmation
```ruby
config.phone_confirmation_field = :phone_confirm
```
* Method that generates, writes the word in the model, returns the secret word.
```ruby
config.sms_secret_method = :sms_secret
```
* Field in the model which returns the correct answer
```ruby
config.sms_answer_field = :sms_answer
```
* Field in model with phone number
```ruby
config.phone_field = :phone
```
* Path after successful confirmation
```ruby
config.successful_path = '/'
```
* SMS provider module(there is default module for STREAM-TELECOM)
you can define your own. Provider module should contain method `:send_sms`.
```ruby
## You can  own provider module
## in module should be a method
## YouAwesomeProvider.send_sms(number_phone, message)
config.sms_provider = DeviseSmsVerifiable::Provider
```
* * *
Module includes default Provider, some settings below:

* Send sms silently for test
```ruby
config.provider_silent = true
```
* SMS provider login
```ryby
config.provider_login = :provider_login
```
* SMS provider password
```ruby
config.provider_password :provider_password
```
* SMS provider from
```ruby
config.provider_from :provider_from
```
* * *

### Generators ###
```irb
$ rails generate devise:install
```

Kiselenko Roman 2014-03-16
This project rocks and uses MIT-LICENSE.

