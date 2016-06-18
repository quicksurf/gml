require "time"

##
# This class provides a generic and simple way to log ruby code.

class GenericMonitorLog

  attr_reader :options

  ##
  # The class constructor.

  def initialize(options = {})
    raise StandardError.new("'options' must be a Hash or nil.") if !options.is_a?(Hash)

    @options = DEFAULT_OPTIONS.merge(options)
  end

  ##
  # The main method that logs the messages.

  def entry(log_level = Gml::LOG_LEVEL_INFO, log_entry = "", caller_depth = 1)
    if ((log_level <= @options[:log_level]) && (@options[:console] || @options[:output]))
      at = caller_locations()[caller_depth]
      out =   "[#{Time.now.strftime(@options[:time_format])}] #{Gml::LOG_STRINGS[log_level]} "
      out <<  "[#{File.basename(at.absolute_path)}->#{at.label}: #{at.lineno}]"
      out <<  " - " if log_entry.size > 0
      out <<  log_entry

      @options[:console].puts(out) if @options[:console]

      if (@options[:output])
        if (@options[:output].is_a?(IO))
          @options[:output].puts(out)

        else
          out << "\n"
          File.write(@options[:output], out, (File.exist?(@options[:output]) ? File.size(@options[:output]) : 0))
        end

      end

    end
  end

  ##
  # Log a panic message. This is a convenience method.

  def log_panic(log_entry = "")
    entry(Gml::LOG_LEVEL_PANIC, log_entry, 1)
  end

  ##
  # Log an info message. This is a convenience method.

  def log_info(log_entry = "")
    entry(Gml::LOG_LEVEL_INFO, log_entry, 1)
  end

  alias_method :log, :log_info

  ##
  # Log a verbose message. This is a convenience method.

  def log_verbose(log_entry = "")
    entry(Gml::LOG_LEVEL_VERBOSE, log_entry, 1)
  end

  ##
  # Log a debug message. This is a convenience method.

  def log_debug(log_entry = "")
    entry(Gml::LOG_LEVEL_DEBUG, log_entry, 1)
  end

  ##
  # Log a trace message. This is a convenience method.

  def log_trace(log_entry = "")
    entry(Gml::LOG_LEVEL_TRACE, log_entry, 1)
  end

end
