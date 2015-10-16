require 'simplecov'
require "codeclimate-test-reporter"

SimpleCov.start do
  formatter CodeClimate::TestReporter::Formatter
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sidekiq/custom/queue'
require 'sidekiq/api'
