# License (X11 License)
# Copyright (c) 2012, Kim Burgestrand
# Permission is hereby granted, free of charge, to any 
# person obtaining a copy of this software and associated
# documentation files (the “Software”), to deal in the
# Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit 
# persons to whom the Software is furnished to do so, subject 
# to the following conditions:
# The above copyright notice and this permission notice shall 
# be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


require 'thread'

module Threadpool

	class Tpoolqueue

		def initialize(size)
			@size = size
			@jobs = Queue.new
			@pool = Array.new(size) do |i|
				Thread.new do
					Thread.current[:id] = i
					catch(:exit) do
						loop do
							job, args = @jobs.pop
							job.call(*args)
						end
					end
				end
			end
		end


		def schedule(*args, &block)
			@jobs << [block, args]
		end


		def shutdown
			@size.times do
				schedule { throw :exit }
			end
			@pool.map(&:join)
		end

	end


	#########
	# example
	#########

	p = Tpoolqueue.new(10)

	20.times do |i|
		p.schedule do
			sleep rand(4)+2
			p "Job #{i} finished by thread #{Thread.current[:id]}"
		end
	end

	at_exit {p.shutdown}

end