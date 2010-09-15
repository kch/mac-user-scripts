#!/usr/bin/env ruby
# encoding: UTF-8

###############################################################################
# Copy the path to the files of the selected tracks in iTunes to the clipboard.
# If multiple tracks are selected, copy every path, each on a separate line.
###############################################################################

require 'appscript'

itunes = Appscript::app("iTunes")
tracks = itunes.selection.get
paths  = tracks.map { |track| track.location.get(:result_type => :alias).to_s }

open('|pbcopy', 'w') { |io| io.write paths.join("\n") }
