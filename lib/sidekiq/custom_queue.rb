require 'sidekiq'
require 'sidekiq/custom_queue/client_middleware'
require 'sidekiq/custom_queue/version'

module Sidekiq
  module CustomQueue
  end
end

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::CustomQueue::ClientMiddleware
  end
end
