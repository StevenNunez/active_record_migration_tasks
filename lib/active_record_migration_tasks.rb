require 'active_record'
require "active_record_migration_tasks/version"

module ActiveRecordMigrationTasks
  def self.included(_)
    seed_loader = Object.new
    def seed_loader.load_seed
      Kernel.load "db/seeds.rb"
    end

    ActiveRecord::Tasks::DatabaseTasks.db_dir = 'db'
    ActiveRecord::Tasks::DatabaseTasks.migrations_paths = 'db/migrate'
    ActiveRecord::Tasks::DatabaseTasks.seed_loader = seed_loader
    ActiveRecord::Tasks::DatabaseTasks.env = ENV["DB_ENV"] || 'development'
    Kernel.load 'active_record/railties/databases.rake'
  end
end
