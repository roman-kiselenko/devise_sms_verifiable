class DeviseSmsVerifiableAddToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string   :phone
      t.string   :sms_answer
      t.boolean  :phone_confirm, default: false
      t.datetime  :sms_token_sent_at
      t.datetime  :sms_token_confirmed_at
    end
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :sms_answer
    remove_column :users, :phone_confirm
    remove_column :users, :sms_token_sent_at
    remove_column :users, :sms_token_confirmed_at
  end
end
