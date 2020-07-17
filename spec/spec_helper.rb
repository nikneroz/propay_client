require 'bundler/setup'
require 'propay_client'
require 'dotenv'
require 'vcr'
require 'factory_bot'
require 'awesome_print'

Dotenv.load('.test.env')

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :excon
  config.filter_sensitive_data('<PROPAY_API_KEY>') { ENV['PROPAY_API_KEY'] }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:all) do
    PropayClient.configure do |config|
      config.api_key = ENV['PROPAY_API_KEY']
      config.endpoint = ENV['ENDPOINT']
    end
  end
end

# require 'simplecov'
# require 'codecov'
# SimpleCov.formatter = SimpleCov::Formatter::Codecov
# SimpleCov.start
