#!/usr/bin/env ruby
# encoding: UTF-8
require 'appscript'

#############################################################################
# Open the frontmost application's Scripting Dictionary on AppleScript Editor
#############################################################################

processes                  = Appscript::app("System Events").processes
is_frontmost_condition     = Appscript.its.frontmost.eq(true)
frontmost_application      = processes[is_frontmost_condition].first
frontmost_application_path = frontmost_application.application_file.get(:result_type => :file_ref).path

system('open', '-a', 'AppleScript Editor', frontmost_application_path)
