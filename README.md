## DeviseSmsVerifiable ##
Just a simple module for [Devise](https://github.com/plataformatec/devise) to provide sms functions, easy to use and customize.

This is the working version.
```rbcon
# Developed and tested on:
Ruby 2.1.0
Rails 4.0.3
Devise 3.2
```
## Getting started
1. Add to `Gemfile` and `bundle install`

   ```ruby
   gem 'devise_sms_verifiable',  git: 'git://github.com/fishbullet/devise_sms_verifiable.git'
   ```
2. If [Devise](https://github.com/plataformatec/devise) is installed,
run the generator to add configuration settings
to [Devise](https://github.com/plataformatec/devise) initializer:

   ```irb
   $ rails generate devise_sms_verifiable:install
   ```
   Otherwise use this generator:
   ```irb
   $ rails generate devise:install
   ```
3. Generate migration:

   ```irb
   $ rails generate devise_sms_verifiable:migration
   ```
   And run  `rake db:migrate`. Migration will add several fields to model:
   ```ruby
   < User id: 1,
   email: "shindu666<bla>gmail.com",
   created_at: "2014-03-25 15:24:30",
   updated_at: "2014-03-25 15:26:44",
   phone: "+79818327398",             <----------| phone field
   sms_answer: 1245,                  <----------| answer field
   phone_confirm: false >             <----------| need confirmation?
   ```
4. Configure model

   ```ruby
   class User < ActiveRecord::Base
     devise :database_authenticatable, :registerable,
                                       ...
                                       :sms_verifiable,
                                       ...
                                       :recoverable
   end
   ```

That's it. You got your module working.

## Configure module
This module is very customizable, check it out:

1. Generate views

   ```irb
   $ rails generate devise_sms_verifiable:views
  ```
2. Boolean field in model for phone confirmation

   ```ruby
   config.phone_confirmation_field = :phone_confirm
   ```
4. Field returning the correct answer

   ```ruby
   config.sms_answer_field = :sms_answer
   ```
5. Field with phone number

   ```ruby
   config.phone_field = :phone
   ```
6. Path after successful confirmation

   ```ruby
   config.successful_path = '/'
   ```
7. SMS provider module

   There is a default module for STREAM-TELECOM, but you can define your own.<br>

   ```ruby
   ## You can define other provider module.
   ## It should have a method :send_sms with 2 args
   ## e.g.:
   ## YourAwesomeProvider.send_sms(number_phone, message)
   config.sms_provider = YourAwesomeProvider
   ```

## Configure default provider
1. Send sms silently for test

   ```ruby
   config.provider_silent = true
   ```
2. SMS provider login

   ```ruby
   config.provider_login = 'provider_login'
   ```
3. SMS provider password

   ```ruby
   config.provider_password = 'provider_password'
   ```
4. SMS provider 'from' field

   ```ruby
   config.provider_from = 'provider_from'
   ```

* * *

Kiselenko Roman 2014-03-16

This project rocks and uses MIT-LICENSE.
