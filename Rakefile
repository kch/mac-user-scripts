#!/usr/bin/env rake

SET_FILE = '/Developer/usr/bin/SetFile'
HIDE_EXTS = %w[ rb ]

task :default => [:"hide-extensions", :"hide-nonscripts"]

desc "Set script files to have their extensions hidden in the Finder, and, hence, in the FastScripts menu."
task :"hide-extensions" do
  glob = "*.{#{HIDE_EXTS.join(',')}}"
  files = Dir["Applications/**/#{glob}"] + Dir[glob]
  puts "Hiding file extensions for #{files.size} files..."
  system SET_FILE, "-a", "E", *files
end

desc "Hide files that are not scripts from the Finder, and, hence, from the FastScripts menu."
task :"hide-nonscripts" do
  files = %w[ MIT_LICENSE README.md Rakefile lib ].select { |f| File.exist? f }
  puts "Hiding #{files.size} non-script files..."
  system SET_FILE, "-a", "V", *files
end
