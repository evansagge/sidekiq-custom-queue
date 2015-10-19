# Sidekiq Custom Queue

[![Build Status](https://travis-ci.org/evansagge/sidekiq-custom-queue.svg)](https://travis-ci.org/evansagge/sidekiq-custom-queue)
[![Code Climate](https://codeclimate.com/github/evansagge/sidekiq-custom-queue/badges/gpa.svg)](https://codeclimate.com/github/evansagge/sidekiq-custom-queue)
[![Test Coverage](https://codeclimate.com/github/evansagge/sidekiq-custom-queue/badges/coverage.svg)](https://codeclimate.com/github/evansagge/sidekiq-custom-queue/coverage)

A Sidekiq plugin for allowing workers to define custom/dynamic queues based on the queued message.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-custom-queue'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-custom-queue

## Usage

Define a `custom_queue` class method in your worker class that can accept a single argument. This argument will contains the job message
as described in https://github.com/mperham/sidekiq/wiki/Job-Format. Define how to use the whole message or parts of to create the name
for your custom queue:

```
class WorkerWithCustomQueue
  include Sidekiq::Worker

  def self.custom_queue(msg)
    "#{msg['args'][0]}_queue"
  end

  def perform(type, arg1)
    # Your code here
  end
end
```

When you enqueue a job for this worker using `.perform_async` or `.perform_in`, it will generate the queue name from the `.custom_queue`
method and put that job in this queue:

```
WorkerWithCustomQueue.perform_async('xyz', 1) # gets enqueued in the 'xyz_queue' instead of the default queue
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sidekiq-custom-queue.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

