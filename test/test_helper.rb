require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
  add_filter "/app/helpers/"
  add_filter "/config/environment.rb"
  add_filter "/config/environments/"

end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require "minispec-metadata"
require 'vcr'
require 'minitest-vcr'
require 'webmock/minitest'
require "minitest/reporters"

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
MinitestVcr::Spec.configure!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
