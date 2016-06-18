# Gml - The Generic Monitor Log

I wrote this gem because I wanted to have a super simple super easy way to log events and
messages within Ruby code that was simple, clean, and could be used in a stand-alone
fashion without any dependencies.

I've looked at other Ruby logging options and they either had dependencies on things that
I didn't want to install, or part of a whole bigger framework that had to be installed in
order to use, or they where just really way more complex than what I needed and wanted.

So, I decided that perhaps I should roll my own.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gml

## Usage

Usage is fairly straightforward.

### Basic Usage

    require "gml"

    logger = GenericMonitorLog.new

    logger.log_panic("My code is panicking!")
    logger.log_info("My code has useful information")
    logger.log_verbose("My code is being verbose")
    logger.log_debug("My code wants to output some debugging information")
    logger.log_trace("My code wants to log entering/exiting methods/code blocks.")

Optionally, there is a `log` method that is an alias of `log_info`.

The default logging level is info, so panics and info would be logged, but not verbose,
debug, or trace.

### More Advanced Usage

    require "gml"

    # We want to log everything!
    #
    logger = GenericMonitorLog.new(:log_level => Gml::LOG_LEVEL_TRACE, :output => "some_log_file.log")

    ...

    # Whoa! too much log! Let's dial it back.
    #
    logger.options[:log_level] = Gml::LOG_LEVEL_VERBOSE

    ...

    # I'd rather just log to the log file and not to my console
    #
    logger.options[:console] = nil

    ...

    # Maybe I'd rather log to STDOUT instead of the default STDERR for my console
    #
    logger.options[:console] = STDOUT

You kind of get the point.  You can set any of the keys found in `Gml::DEFAULT_OPTIONS`
either as a hash at instantiation, or you can set them via the `options` afterwards.

The supported log levels (in order of more logging) are:

1. `LOG_LEVEL_OFF` - Turn logging off
2. `LOG_LEVEL_PANIC` - Don't log anything but panics
3. `LOG_LEVEL_INFO` - Log generic info type messages
4. `LOG_LEVEL_VERBOSE` - Log some more verbose stuff
5. `LOG_LEVEL_DEBUG` - Log debugging type stuff
6. `LOG_LEVEL_TRACE` - Log tracing type stuff


### Typical Usage

At least how I use generally use gml, though it's really pretty much up to you how you
want to use it.

    require "gml"

    class SomeClass

        def initialize()
            @logger = GenericMonitorLog.new
        end

        def some_method(arg1 = "", arg2 = "")
            @logger.log_trace("Enter")

            begin
                @logger.log_verbose("Doing some work")

                # Do some init work
                #
                data = "some data"

                @logger.log_debug("arg1:#{arg1}, arg2:#{arg2}, data:#{data}")

            rescue => error
                @logger.log_panic("#{error.to_s} - #{error.backtrace.inspect}")

            ensure
                @logger.log_verbose("Cleaning up")

                @logger.log_trace("Exit")
        end
    end

You get the point.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a
new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push git commits
and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gml.
This project is intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

