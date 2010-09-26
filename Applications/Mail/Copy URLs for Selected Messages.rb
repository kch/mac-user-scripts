#!/usr/bin/env ruby
# encoding: UTF-8
require 'appscript'
require 'cgi'

###################################################################
# Copy the URLs for the selected messages in Mail to the clipboard.
###################################################################


mail = Appscript::app("Mail")
urls = mail.selection.get.map { |msg| "message://" + CGI.escape("<#{msg.message_id.get}>") }

open('|pbcopy', 'w') { |io| io.write urls.join("\n") }
