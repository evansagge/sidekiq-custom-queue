require 'spec_helper'

describe Sidekiq::CustomQueue do
  it 'has a version number' do
    expect(Sidekiq::CustomQueue::VERSION).not_to be nil
  end

  context 'when a worker has .custom_queue defined' do
    class WorkerWithCustomQueue
      include Sidekiq::Worker

      def self.custom_queue(msg)
        "#{msg['args'][0]}_queue"
      end

      def perform(_type, _arg1)
      end
    end

    describe '.perform_async' do
      subject do
        WorkerWithCustomQueue.perform_async('xyz', 1)
      end

      it 'calculates the queue name using the custom_queue method and enqueues that job in that queue' do
        expect { subject }.to change { Sidekiq::Queue.new('xyz_queue').size }.by(1)
        WorkerWithCustomQueue.sidekiq_options['queue'].should eq("default")
      end
    end
  end

  context 'when a worker has no .custom_queue defined' do
    class WorkerWithNoCustomQueue
      include Sidekiq::Worker

      sidekiq_options queue: 'my_queue'

      def perform(_type, _arg1)
      end
    end

    describe '.perform_async' do
      subject do
        WorkerWithNoCustomQueue.perform_async('xyz', 1)
      end

      it 'does not enqueue into that custom queue' do
        expect { subject }.not_to change { Sidekiq::Queue.new('xyz_queue').size }
      end

      it 'enqueues into the queue defined in the worker options' do
        expect { subject }.to change { Sidekiq::Queue.new('my_queue').size }.by(1)
      end
    end
  end
end
