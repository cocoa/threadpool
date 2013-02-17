require 'spec_helper'

include Threadpool

describe Threadpool do

  it "should return correct version string" do
    Tpool.version_string.should == "ThreadPool version #{Threadpool::VERSION}"
  end

  it "should be created with correct pool size" do
  	tp = Tpool.new(5)
  	tp.max_size.should == 5
	end

	it "should run N threads simoultaneously" do
		max_threads = 2
		tp = Tpool.new(max_threads)
		1.upto(10) do |i|
			tp.dispatch(i) do |n|
				puts "Started #{n}..."
				sleep(3)
				puts "Ended #{n}..."
			end
		end
		sleep(0.1)
		tp.pool.size.should == max_threads
	end

end