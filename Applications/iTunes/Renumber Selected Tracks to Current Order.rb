#!/usr/bin/env ruby
# encoding: UTF-8
require 'appscript'

##########################################################################################
# Set the track number for the selected tracks in iTunes according to their current order.
# This will also set the track count (the y in "track x of y") to the number of tracks
# currently selected, unless this value is already set and greater than the new one.
##########################################################################################

tracks      = Appscript.app("iTunes").selection.get
track_count = tracks.length

tracks.each_with_index do |track, ix|
  track.track_number.set ix + 1
  track.track_count.set track_count if track_count > track.track_count.get
end
