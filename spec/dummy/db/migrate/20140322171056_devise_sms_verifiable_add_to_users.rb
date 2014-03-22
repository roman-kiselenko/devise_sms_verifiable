class DeviseSmsVerifiableAddToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      # Field in the model which phone number
      t.string   :phone
      # Field in the model which returns the correct answer
      t.string   :sms_answer
      # Field in the model which returns phone confirm or no
      t.boolean  :phone_confirm, default: false
    end
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :sms_answer
    remove_column :users, :phone_confirm
  end
end
