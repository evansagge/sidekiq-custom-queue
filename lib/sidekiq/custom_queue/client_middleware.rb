module Sidekiq
  module CustomQueue
    class ClientMiddleware
      def call(worker_class, msg, queue, _redis_pool)
        worker = worker_class.constantize
        queue.replace(worker.custom_queue(msg).to_s) if worker.respond_to?(:custom_queue)
        yield
      end
    end
  end
end
