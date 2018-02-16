require 'spec_helper'

# Base Module
module Run
  def test_exception
    return self::TestException if is_a?(Class)
    self.class::TestException
  end

  def run(retry_count, sleep_time = nil, exceptions = [StandardError])
    counter = 5
    retryable(retry_count, sleep_time, exceptions) do
      counter -= 1
      raise test_exception if counter.positive?
    end
    counter
  end
end

# Test Exception with other ancestors than StandardError, which is
# catched by simple rescue
#
# ScriptError.ancestors
# => [ScriptError, Exception, Object, Kernel, BasicObject]
# StandardError.ancestors
# => [StandardError, Exception, Object, Kernel, BasicObject]
#  RuntimeError.ancestors
# => [RuntimeError, StandardError, Exception, Object, Kernel, BasicObject]
class OtherException < ScriptError; end

# Class for test retryable with raise StandardError
class RetryableTest
  include RetryableBlock
  include Run
  TestException = StandardError

  class << self
    include Run
  end
end

# Class for test retryable with raise other Exception than StandardError
class OtherExceptionRetryableTest
  include RetryableBlock
  include Run
  TestException = OtherException

  class << self
    include Run
  end
end

shared_examples 'tests' do
  it 'should retry n times' do
    n = object.run(4, sleep_time)
    expect(n).to eql 0
  end

  it 'should raise exception at n + 1 times' do
    n = 3
    expect { object.run(n, sleep_time) }.to raise_error
  end

  it 'should raise exception, because it is not StandardError' do
    n = 4
    expect { object.run(n, sleep_time, [OtherException]) }.to raise_error
  end
end

describe RetryableBlock do
  let(:sleep_time) { 0.01 }

  context 'class with StandardError' do
    let(:object) { RetryableTest }

    include_examples 'tests'
  end

  context 'class with OtherException' do
    let(:object) { OtherExceptionRetryableTest }

    it 'should not raise exception' do
      n = object.run(4, sleep_time, [OtherException])
      expect(n).to eql 0
    end
  end

  context 'instance with StandardError' do
    let(:object) { RetryableTest.new }

    include_examples 'tests'
  end

  context 'instance with OtherException' do
    let(:object) { OtherExceptionRetryableTest.new }

    it 'should not raise exception' do
      n = object.run(4, sleep_time, [OtherException])
      expect(n).to eql 0
    end
  end
end
