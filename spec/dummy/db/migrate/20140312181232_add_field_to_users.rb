class AddFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :sms_answer, :string
    add_column :users, :phone_confirm, :boolean, default: false
  end
end
