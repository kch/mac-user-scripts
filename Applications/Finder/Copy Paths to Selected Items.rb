#!/usr/bin/env ruby
# encoding: UTF-8

############################################################################################################
# Copy the path to the selected item in the active Finder window to the clipboard.
# If multiple items are selected, copy every path, each on a separate line.
# If no items are selected, copy the path to the active window. The active window may be the user's Desktop.
############################################################################################################

require 'appscript'

finder = Appscript::app("Finder")
paths  = finder.selection.get(:result_type => :alias).map(&:path).join("\n")
paths << finder.insertion_location.get(:result_type => :file_ref).get(:result_type => :alias).path if paths.empty?

open('|pbcopy', 'w') { |io| io.write paths }
