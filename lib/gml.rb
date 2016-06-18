require "gml/version"
require "gml/generic_monitor_log"

##
# This module provides static data for the GenericMonitorLog.

module Gml

  ##
  # Log everything

  LOG_LEVEL_TRACE   = 5

  ##
  # Log debug messages and below

  LOG_LEVEL_DEBUG   = 4

  ##
  # Log verbose messages and below

  LOG_LEVEL_VERBOSE = 3

  ##
  # Log information messages and below

  LOG_LEVEL_INFO    = 2

  ##
  # Log panic messages

  LOG_LEVEL_PANIC   = 1

  ##
  # Turn logging off

  LOG_LEVEL_OFF     = 0

  ##
  # The string equivalents of the log levels, used for output.

  LOG_STRINGS = {
    LOG_LEVEL_PANIC   => ":PANIC:  ",
    LOG_LEVEL_INFO    => ":INFO:   ",
    LOG_LEVEL_VERBOSE => ":VERBOSE:",
    LOG_LEVEL_DEBUG   => ":DEBUG:  ",
    LOG_LEVEL_TRACE   => ":TRACE:  "
  }

  ##
  # The default options for GenericMonitorLog.
  #
  #   {
  #     :console      => STDERR               // An IO object to output to.  Defaults to STDERR, set to nil to disable,
  #                                           // or set to an IO object like STDOUT or STDERR.
  #     :log_level    => Gml::LOG_LEVEL_INFO  // The logging level. Defaults to LOG_LEVEL_INFO.
  #     :output       => nil                  // The filename or IO object to write log entries to.
  #                                           // Set to nil to disable, or a file name in the form of a string, or
  #                                           // an IO object if you want to manage the log file separately.
  #     :time_format  => "%c"                 // The time format.  Can be set to the format as specified in
  #                                           // Time.strftime
  #   }

  DEFAULT_OPTIONS = {
    :console      => STDERR,
    :log_level    => Gml::LOG_LEVEL_INFO,
    :output       => nil,
    :time_format  => "%c"
  }

end
