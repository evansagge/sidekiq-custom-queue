require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'sidekiq/custom/queue'
require 'sidekiq/api'
