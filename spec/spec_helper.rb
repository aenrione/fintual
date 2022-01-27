require 'dotenv/load' # <============= 1
require 'simplecov'
require 'fintual'

SimpleCov.start 'rails' do # <============= 2
  add_filter 'spec/'
  add_filter '.github/'
  add_filter 'lib/generators/templates/'
  add_filter 'lib/fintual/version'
end

if ENV['CI'] == 'true' # <============= 3
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
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

ENV['RAILS_ENV'] = 'test' # <============= 5
