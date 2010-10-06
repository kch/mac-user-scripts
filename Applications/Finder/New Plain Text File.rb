#!/usr/bin/env ruby
# encoding: UTF-8

###########################################################################################
# Create a new file in the folder of the active Finder window, enter rename mode for it.
# The new file is empty. It's named untitled.txt, with a space and a serial number appended
# if necessary to ensure a unique name.
###########################################################################################

require 'appscript'
require 'fileutils'
require 'pathname'


TFF        = Appscript::app("Finder")
TFFProcess = Appscript::app("System Events").application_processes["Finder.app"]

path_to_desktop             = Pathname.new "#{ENV['HOME']}/Desktop"
path_of_insertion_location  = Pathname.new TFF.insertion_location.get(:result_type => :file_ref).get(:result_type => :alias).path
path_of_first_finder_window = Pathname.new TFF.Finder_windows.first.target.get(:result_type => :alias).path rescue nil
is_desktop_the_active_view  = path_to_desktop == path_of_insertion_location && path_of_first_finder_window != path_to_desktop

basename  = "untitled.txt".tap { |s| s.sub!(/( (\d+))?(?=\.txt\z)/) { " #{($2||1).to_i.succ}" } while path_of_insertion_location.join(s).exist? }
file_path = path_of_insertion_location.join(basename)
FileUtils.touch(file_path)

TFF.activate
TFF.insertion_location.update
sleep 0.3 # increase the chances that the \r keystroke that follows will hit the proper selection

# attempt to select the newly created file
is_desktop_the_active_view                      ?   # When you call `select` for an item on the Desktop, a new Finder window is opened and the
  TFFProcess.keystroke(file_path.basename.to_s) :   # file is selected in that window. We don't want that, so if the Desktop is active, we try
  TFF.select(MacTypes::Alias.path(file_path.to_s))  # to type out the file name to cause its selection directly on the Desktop. /hack

# press return to enter rename mode
TFFProcess.keystroke("\r")
