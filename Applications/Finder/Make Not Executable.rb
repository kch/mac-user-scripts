#!/usr/bin/env ruby
# encoding: UTF-8

###############################################################################
# Unset the executable bit for selected files in the Finder.
# This script calls "Make Executable.rb" passing "ugo-x" to it, which overrides
# its default chmod flags, causing it to unset the executable bits instead.
###############################################################################

require 'pathname'
system Pathname.new(__FILE__).dirname.realpath.join("Make Executable.rb").to_s, "ugo-x"
