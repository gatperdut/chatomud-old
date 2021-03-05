require File.expand_path("../config/environment", __dir__)

require "rspec/rails"

RSpec.configure do |config|
  config.file_fixture_path = "spec/fixtures"
end

require "byebug"

Rails.env = "test"
