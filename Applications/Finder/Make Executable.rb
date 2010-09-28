#!/usr/bin/env ruby
# encoding: UTF-8

#################################################################################
# Make the files selected in the Finder executable.
# This script may be called from the shell by other scripts passing `chmod_flags`
# as first argument, so that it performs chmod operations other than activating
# the executable bit.
#################################################################################

require 'appscript'

finder      = Appscript::app("Finder")
paths       = finder.selection.get(:result_type => :alias).map(&:path)
file_paths  = paths.select { |path| File.file? path }
chmod_flags = ARGV[0] || "ugo+x"

system "chmod", chmod_flags, *file_paths unless file_paths.empty?
