#!/usr/bin/env rake
# encoding: UTF-8

SET_FILE    = "/Developer/usr/bin/SetFile"
NON_SCRIPTS = %w[ MIT_LICENSE README.md Rakefile lib ]
HIDE_EXTS   = "rb"

task :default => [:"hide-extensions", :"hide-nonscripts"]

desc "Set script files to have their extensions hidden in the Finder and hence in the FastScripts menu."
task :"hide-extensions" do
  system SET_FILE, "-a", "E", *Dir["Applications/**/*.{#{HIDE_EXTS}}"], *Dir["*.{#{HIDE_EXTS}}"]
end

desc "Hide files that are not scripts from the Finder, and hence, from the FastScripts menu."
task :"hide-nonscripts" do
  system SET_FILE, "-a", "V", *NON_SCRIPTS
end
