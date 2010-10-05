#!/usr/bin/env macruby
# encoding: UTF-8

###################################################################################################
# Paste paths from the clipboard as relative symlinks in the folder for the active Finder window.
# The clipboard data may come from selecting Copy (⌘C) in the Finder, or it can be just plain-text
# paths, each on a separate line.
# For each path in the clipboard, one symlink will be created in the current folder with the path's
# basename for its name. The symlink value will be a relative path.
# If the target basename for the link exists, a unique serial number is appended to it with a dash.
###################################################################################################

require   'pathname'
require   'fileutils'
framework 'Cocoa'
framework 'ScriptingBridge'

# try to get honest-to-god paths from the clipboard (you'd get these via ⌘C in the Finder)
paths_from_clipboard = Array.new NSPasteboard.generalPasteboard.pasteboardItems # <- The Array.new bit is to ensure we end up with a real ruby Array,
  .map { |pbi | pbi.stringForType('public.file-url') }.compact                  #    not just a Cocoa NSArray. This is important later when we call
  .map { |url | NSURL.URLWithString(url).path }                                 #    #count(arg) on a derived array.
  .map { |path| Pathname.new(path) }

# the above failing, try to get plain-text from the clipboard and check if it maps to actual paths
if paths_from_clipboard.empty?
  text_paths_from_clipboard = `pbpaste`.split("\n").map { |path| Pathname.new(path).realpath rescue nil }
  paths_from_clipboard = text_paths_from_clipboard if text_paths_from_clipboard.all?(&:exist?) unless text_paths_from_clipboard.any?(&:nil?)
end

($stderr.puts "Clipboard does not contain path data"; exit 2) if paths_from_clipboard.empty?


# Get the Finder's insertion location via ScriptingBridge because rb-appscript doesn't work with macruby ATM
abs_path_to_link_destination_folder = Pathname.new(NSURL.URLWithString(SBApplication.applicationWithBundleIdentifier('com.apple.finder').properties["insertionLocation"].properties["URL"]).path)

rel_path_to_link_sources_and_target_basenames = paths_from_clipboard.map { |abs_path_to_link_source|
  [ abs_path_to_link_source.relative_path_from(abs_path_to_link_destination_folder),
    abs_path_to_link_source.basename.to_s] }

# ensure target link names are unique
target_basenames = rel_path_to_link_sources_and_target_basenames.map(&:last)
target_basenames.each do |basename|
  until target_basenames.count(basename) + (abs_path_to_link_destination_folder.join(basename).exist? ? 1 : 0) <= 1
    basename.sub!(/(-(\d+))?(\.[^.]+)?\z/) { "-#{($2||1).to_i.succ}#{$3}" }
  end
end

# write out the links
rel_path_to_link_sources_and_target_basenames.each { |rel_path_to_link_source, target_basename|
  FileUtils::ln_s(rel_path_to_link_source, abs_path_to_link_destination_folder.join(target_basename)) }
