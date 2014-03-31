require 'rails/generators/base'

module DeviseSmsVerifiable
  class MigrationGenerator < Rails::Generators::Base

    def add_migrations
      table_name = Devise::default_scope.to_s.pluralize
      exist_migration = Dir.glob('db/migrate/*_devise_sms_verifiable_add_to_*')
      if exist_migration.any? && self.behavior == :invoke
        p("Check db/migrate, look like have sms verifiable migration")
      end
      if exist_migration.blank? && self.behavior != :revoke
        migration_path = "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_devise_sms_verifiable_add_to_#{table_name}.rb"
        migration_template = <<-RUBY
class DeviseSmsVerifiableAddTo#{table_name.camelize} < ActiveRecord::Migration
  def self.up
    change_table :#{table_name} do |t|
      t.string   :phone
      t.string   :sms_answer
      t.boolean  :phone_confirm, default: false
      t.datetime  :sms_token_sent_at
      t.datetime  :sms_token_confirmed_at
    end
  end

  def self.down
    remove_column :#{table_name}, :phone
    remove_column :#{table_name}, :sms_answer
    remove_column :#{table_name}, :phone_confirm
    remove_column :#{table_name}, :sms_token_sent_at
    remove_column :#{table_name}, :sms_token_confirmed_at
  end
end
RUBY
        create_file(migration_path, migration_template)
      elsif self.behavior == :revoke
        FileUtils.rm_rf *exist_migration if exist_migration.any?
      end
    end
  end
end

