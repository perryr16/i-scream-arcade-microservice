ENV['RACK_ENV'] = 'test'
require "./config/environment"

SimpleCov.start

RSpec.configure do |config|
  require 'webmock/rspec'
  config.include Rack::Test::Methods
  config.before(:each) do
    $db = []
  end 
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end 
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end 
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end 
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('GAME_API') { ENV['GAME_API'] }
  config.configure_rspec_metadata!
end