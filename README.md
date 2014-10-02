# RetryableBlock [![Build Status](https://travis-ci.org/s12chung/retryable_block.svg?branch=master)](https://travis-ci.org/s12chung/retryable_block)

A module that adds `#retryable` to your classes, which retries blocks when an exception occurs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'retryable_block'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install retryable_block

## Usage

Include `RetryableBlock` to your class and use `retryable(n=3, sleep_time=nil, &block)`

## Contributing

1. Fork it ( https://github.com/[my-github-username]/retryable_block/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
