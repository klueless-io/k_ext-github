# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'k_ext/github'
# require 'k_usecases'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Most of the tests work directly against the git hub repos.
  # There is no mocks or vcr going on, so if you want to test
  # correctly, you have to configure the access tokens and set
  # integration_tests: false

  # set to true before pushing so that tests do not run on Actions
  config.filter_run_excluding integration_tests: true

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
