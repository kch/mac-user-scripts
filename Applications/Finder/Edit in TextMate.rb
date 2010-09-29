#!/usr/bin/env ruby
# encoding: UTF-8

########################################################################
# Edit the Finder selection in TextMate.
# If there's no selection, edit the folder for the active Finder window.
########################################################################

require 'appscript'

finder = Appscript::app('Finder')
paths  = finder.selection.get(:result_type => :alias).map(&:path)
paths << finder.insertion_location.get(:result_type => :file_ref).get(:result_type => :alias).path if paths.empty?

system "mate", *paths unless paths.empty?
