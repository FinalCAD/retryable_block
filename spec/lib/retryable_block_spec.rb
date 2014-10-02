require 'spec_helper'

class RetryableTest
  include RetryableBlock
end

describe RetryableBlock do
  it "should respond to retryable" do
    expect(RetryableTest).to receive(:retryable)

    RetryableTest.retryable do
      puts "test"
    end
  end
end