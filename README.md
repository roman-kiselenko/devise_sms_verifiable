## DeviseSmsVerifiable ##
Module provide sms functions, easy to use and customize.
```rbcon
# Developed and tested on:
Ruby 2.1.0
Rails 4.0.3
```
## Install
* Add to `Gemfile` and `bundle install`
```ruby
gem 'devise_sms_verifiable',  git: 'git://github.com/fishbullet/devise_sms_verifiable.git'
```
* Run generators
__If the devise is installed,
run the generator to add configuration settings
to Devise initializer__:
```irb
$ rails generate devise_sms_verifiable:install
```
* Generate migration:
```irb
$ rails generate devise_sms_verifiable:migration
```
* For generate views run:
```irb
$ rails generate devise_sms_verifiable:views
```
After successful instalation you should have routes ```rake routes```
```irb
send_pass_user_sms_path  POST	 /user/sms/send_pass(.:format)	 devise/sms_verifiable#send_pass
user_sms_path	           POST	 /user/sms(.:format)	           devise/sms_verifiable#create
new_user_sms_path	       GET	 /user/sms/new(.:format)	       devise/sms_verifiable#new
```
## How works ##
Method(:sms_secret) generate secret and write to model , must return secret word,
devise_sms_verifiable controller use this method for generate secret.
```ruby
class ApplicationController < ActionController::Base
  def sms_secret
    answer = (10..48).to_a.shuffle.take(4).join
    current_user.update(sms_answer: answer)
    answer
  end
end
```
Add several fields to model through generator
```ruby
< User id: 1,
email: "shindu666<bla>gmail.com",
created_at: "2014-03-25 15:24:30",
updated_at: "2014-03-25 15:26:44",
phone: "+79818327398",             <----------| phone field
sms_answer: 1245,                  <----------| answer field
phone_confirm: false >             <----------| need confirmation?
```
### Generators ###
* If ***devise*** not installed, run before generator
*  add Devise initializer:
```irb
$ rails generate devise:install
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

* You need field in model for confirm phone(must be boolean).
<br>
```ruby
config.phone_confirmation_field = :phone_confirm
```
* Need a method that generates, writes the word model, returns the secret word.
```ruby
config.sms_secret_method = :sms_secret
```
* Field in the model which returns the correct answer
```ruby
config.sms_answer_field = :sms_answer
```
* Field in model which phone number
```ruby
config.phone_field = :phone
```
* Path after successful confirmation
```ruby
config.successful_path = '/'
```
* SMS provider module(have default for STREAM-TELECOM)
you can define own. Provider module should be a method `:send_sms`
```ruby
config.sms_provider = DeviseSmsVerifiable::Provider
```
* Send sms silent for test
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
===============================================================================

Kiselenko Roman 2014-03-16

This project rocks and uses MIT-LICENSE.

