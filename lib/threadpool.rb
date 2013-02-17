require 'thread'

module Threadpool
  class Tpool

    attr_reader :max_size, :pool

    def initialize(max_size)
      @pool = []
      @max_size = max_size
      @pool_mutex = Mutex.new
      @cv = ConditionVariable.new  
    end

    def dispatch(*args)    
      Thread.new do
        @pool_mutex.synchronize do
          while @pool.size >= @max_size          
            print "Pool is full; waiting to run #{args.join(',')}...\n" if $DEBUG
            @cv.wait(@pool_mutex)
          end
        end
        @pool << Thread.current
        begin
          yield(*args)
        rescue => e
          exception(self, e, *args)
        ensure
          @pool_mutex.synchronize do
            @pool.delete(Thread.current)
            @cv.signal            
          end
        end
      end
    end

    def shutdown
      sleep(0.1)
      @pool_mutex.synchronize {@cv.wait(@pool_mutex) until @pool.empty? }
    end

    def exception(thread, exception, *original_args)
      puts "Exception in thread #{thread}: #{exception}"
    end

    def self.version_string
      "ThreadPool version #{VERSION}"
    end
  end


end



=begin
$DEBUG = true
pool = ThreadPool.new(3)

1.upto(5) do |i| 
  pool.dispatch(i) do |i|
    print "Job #{i} started.\n"
    sleep(5-i)
    print "Job #{i} complete.\n"
  end
end

pool.shutdown
=end