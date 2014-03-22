# DeviseSmsVerifiable #

## Generators ##

* If the `devise` is installed, run the generator to add configuration settings:
<br>
`rails generate devise_sms_verifiable:install`

* If `devise` not installed, run before generator:
<br>
`rails generate devise:install`

* Generate migration:
<br>
`rails generate devise_sms_verifiable:migration`

* For generate views run:
<br>
`rails generate devise_sms_verifiable:views`

## Model ##

Add module `:sms_verifiable` to model:
```
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
                                    :validatable,
                                    :sms_verifiable,
                                    :recoverable
end
```
## ApplicationController ##

Define 2 methods in `ApplicationController`
```
  class ApplicationController < ActionController::Base
    # Method for check need confirmation or no
    def sms_confirmation?
      return true if current_user && !current_user.phone_confirm? && current_user.phone
    end

    # Method generate secret write to model and return secret
    def sms_secret
      answer = (10..48).to_a.shuffle.take(4).join
      current_user.update(sms_answer: answer)
      answer
    end
  end
```
## Migration ##

Add field to model.
```
  class AddFieldToUsers < ActiveRecord::Migration
    def change
      # Field in the model which phone number
      add_column :users, :phone, :string
      # Field in the model which returns the correct answer
      add_column :users, :sms_answer, :string
      # Field in the model which returns phone confirm or no
      add_column :users, :phone_confirm, :boolean, default: false
    end
  end
```
## Available options ##

* * *

* You need field in model for confirm phone(must be boolean).
<br>
`config.phone_confirmation_field = :phone_confirm`

* You need define method for check sms confirmation.
<br>
`config.sms_confirmation_method = :sms_confirmation?`

* Need a method that generates, writes the word model, returns the secret word.
<br>
`config.sms_secret_method = :sms_secret`

* Field in the model which returns the correct answer
<br>
`config.sms_answer_field = :sms_answer`

* Field in model which phone number
<br>
`config.phone_field = :phone`

* Path after successful confirmation
<br>
`config.successful_path = '/'`

* SMS provider module(have default for STREAM-TELECOM) you can define own
Provider module should be a method `:send_sms`
<br>
`config.sms_provider = DeviseSmsVerifiable::Provider`

* Send sms silent for test
<br>
`config.provider_silent = true`

* SMS provider login
<br>
`config.provider_login = :provider_login`

* SMS provider password
<br>
`config.provider_password :provider_password`

* SMS provider from
<br>
`config.provider_from :provider_from`

===============================================================================

Kiselenko Roman 2014-03-16

This project rocks and uses MIT-LICENSE.

