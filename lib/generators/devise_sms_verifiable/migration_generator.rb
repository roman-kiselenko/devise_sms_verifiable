require 'rails/generators/base'

module DeviseSmsVerifiable
  class MigrationGenerator < Rails::Generators::Base

    def add_migrations
      table_name = Devise::default_scope.to_s.pluralize
      exist_migration = Dir.glob('db/migrate/*_devise_sms_verifiable_add_to_*')
      exist_migration.any? ? p("Check db/migrate, look like have sms verifiable migration") : nil
      if exist_migration.blank?
        migration_path = "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_devise_sms_verifiable_add_to_#{table_name}.rb"
        migration_template = <<-RUBY
class DeviseSmsVerifiableAddTo#{table_name.camelize} < ActiveRecord::Migration
  def self.up
    change_table :#{table_name} do |t|
      # Field in the model which phone number
      t.string   :phone
      # Field in the model which returns the correct answer
      t.string   :sms_answer
      # Field in the model which returns phone confirm or no
      t.boolean  :phone_confirm, default: false
    end
  end

  def self.down
    remove_column :#{table_name}, :phone
    remove_column :#{table_name}, :sms_answer
    remove_column :#{table_name}, :phone_confirm
  end
end
RUBY
        create_file(migration_path, migration_template)
      end
    end
  end
end

