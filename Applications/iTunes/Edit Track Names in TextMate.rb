#!/usr/bin/env ruby
# encoding: UTF-8
require 'appscript'
require 'open3'

################################################################################
# Edit the names of the selected iTunes tracks in TextMate.
# A document is opened in TextMate with each track name on a separate line.
# Once it's saved and closed, the contents from its changed lines in will be
# used in updating the tracks' name metadata.
# Replace "mate -w" with another tool, such as "edit -w" to use another editor.
################################################################################

itunes          = Appscript::app("iTunes")
tracks          = itunes.selection.get
old_track_names = tracks.map { |track| track.name.get }
new_track_names = Open3::popen3("mate -w") do |stdin, stdout, stderr|
  stdin.puts old_track_names.join("\n")
  stdin.close
  stdout.readlines.map(&:strip)
end

tracks.zip(old_track_names, new_track_names)
  .select { |*, new_name, old_name| new_name != old_name    }
  .each   { |track, *, new_name   | track.name.set new_name }
