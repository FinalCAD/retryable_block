require 'spec_helper'

module Run
  def run(retry_count, sleep_time=nil)
    counter = 5
    retryable(retry_count, sleep_time) do
      counter -= 1
      if counter > 0
        raise "test error"
      end
    end
    counter
  end
end

class RetryableTest
  include RetryableBlock
  include Run

  class << self
    include Run
  end
end

shared_examples 'tests' do
  it "should retry n times" do
    n = 4
    n = object.run(4, sleep_time)
    expect(n).to eql 0
  end

  it "should raise exception at n + 1 times" do
    n = 3
    expect { object.run(n, sleep_time) }.to raise_error
  end
end

describe RetryableBlock do
  let(:sleep_time) { 0.01 }

  context 'class' do
    let(:object) { RetryableTest }

    include_examples 'tests'
  end

  context 'instance' do
    let(:object) { RetryableTest.new }

    include_examples 'tests'
  end
end
