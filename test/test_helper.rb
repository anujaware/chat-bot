# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
#require 'database_cleaner'

##TODO Required for mintest matchers to test associations
## But not working
#require 'minitest/autorun'
#require 'mongoid'
#require 'mongoid-minitest'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class ActiveSupport::TestCase
  DatabaseCleaner.strategy = :truncation
  setup { DatabaseCleaner.start }
  teardown  { DatabaseCleaner.clean }

  include Mongoid::FixtureSet::TestHelper
  self.fixture_path = "#{Rails.root}/test/fixtures"

  ##TODO Required for mintest matchers to test associations
  ##  include Mongoid::Matchers
end

=begin
# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.fixtures :all
end
=end
