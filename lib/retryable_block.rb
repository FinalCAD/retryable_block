require "retryable_block/version"

module RetryableBlock
  def self.included(base)
    base.extend ClassMethods
  end

  def retryable(n = 3, sleep_time = nil, exceptions = [StandardError], &block)
    self.class.retryable(n, sleep_time, exceptions, &block)
  end

  module ClassMethods
    def retryable(n = 3, sleep_time = nil, exceptions = [StandardError])
      tries = 0
      begin
        yield
      rescue *exceptions
        if (tries += 1) <= n
          sleep sleep_time if sleep_time
          retry
        end
        raise
      end
    end
  end
end
