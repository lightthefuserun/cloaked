# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'active_record'
require 'bundler/setup'
require 'cloaked'
require 'database_cleaner'
require 'sqlite3'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define(version: 1) do
  create_table :posts do |t|
    t.string :public_id, index: true

    t.timestamps
  end
end

class Post < ActiveRecord::Base
  include Cloaked

  with_cloaked_keys :public_id
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
