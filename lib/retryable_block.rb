require "retryable_block/version"

module RetryableBlock
  def self.included(base)
    base.extend ClassMethods
  end

  def retryable(n=3, sleep_time=nil, &block)
    self.class.retryable(n, sleep_time, &block)
  end

  module ClassMethods
    def retryable(n=3, sleep_time=nil)
      tries = 0
      begin
        yield
      rescue
        if (tries+=1) <= n
          if sleep_time
            sleep sleep_time
          end
          retry
        else
          raise
        end
      end
    end
  end
end
