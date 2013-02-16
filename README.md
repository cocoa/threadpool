# Threadpool

Based on Ruby cooking, this gem allows to run a limited pool of threads simultaneously. The gem doesn't mantain a pool of threads acepting works, it creates a new thread for every incoming work and run N of them simultaneously instead.

## Installation

Add this line to your application's Gemfile:

    gem 'threadpool'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install threadpool

## Usage

		include Treadpool
		tp = Tpool.new(2)
		1.upto(10) do |i|
			tp.dispatch(i) do |n|
				puts "Started #{n}..."
				sleep(3)
				puts "Ended #{n}..."
			end
		end
		tp.shutdown

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
