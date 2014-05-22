These are scripts that I use with [FastScripts][] to extend functionality in Mac OS X applications.

I'm writing a [series of blogs about them][intro]. This is what I've got so far:

* Finder
  * [New Plain Text File](http://stdout.caiochassot.com/post/1255338573/script-finder-new-plain-text-file) ⌃⌘N
  * [Paste as symlink](http://stdout.caiochassot.com/post/1241385588/script-finder-paste-as-symlink) ⌥⌘V
  * [Edit in TextMate](http://stdout.caiochassot.com/post/1213271039/script-finder-edit-in-textmate) ⇧⌘E
  * [Make executable](http://stdout.caiochassot.com/post/1206665621/script-finder-make-executable) ⇧⌘X
  * [Copy Paths to Selected Items](http://stdout.caiochassot.com/post/1158279688/script-finder-copy-paths-to-selected-items) ⇧⌘C

* iTunes
  * [Copy Paths to Selected Tracks](http://stdout.caiochassot.com/post/1162995684/script-itunes-copy-paths-to-selected-tracks) ⇧⌘C
  * [Renumber Selected Tracks to Current Order](http://stdout.caiochassot.com/post/1169602162/script-itunes-renumber-selected-tracks-to-current)
  * [Edit Track Names in TextMate](http://stdout.caiochassot.com/post/1175022452/script-itunes-edit-track-names-in-textmate) ⌃⌘E

* [Mail: Copy URLs for Selected Messages](http://stdout.caiochassot.com/post/1194688819/script-mail-copy-urls-for-selected-messages) ⇧⌘C

* [Open Application’s Scripting Dictionary](http://stdout.caiochassot.com/post/1182689653/script-open-applications-scripting-dictionary)

For a possibly more up-to-date list, see the [fastscripts tag][listing].

## Installation

### Ruby + rb-appscript

You need ruby 1.9 compiled as a universal binary, with [rb-appscript][] installed. To check how your ruby is compiled:

    $ file `which ruby`

If it doesn't say "universal binary", you need to build it yourself. Easiest is [Homebrew][]:

    $ brew install ruby --universal

To install rb-appscript:

    $ gem install rb-appscript

If gem compilation fails and mentions homebrew-installed libxml2 or libsqlite3, try `brew unlink sqlite libxml2` before gem installation. Afterwards, link them back with `brew link sqlite libxml2`.

### Install these scripts

    # preserve your old scripts, if any:
    $ mv ~/Library/Scripts/ OldScripts

    $ git clone git://github.com/kch/mac-user-scripts.git ~/Library/Scripts
    $ cd ~/Library/Scripts/
    $ rake

    # now proceed to copy your old scripts from "OldScripts" back here

### Configuring the script environment

Scripts ran through FastScripts won't inherit the environment set in "/etc/profile", "~/.bashrc" or similar scripts. If you need to set some environment variables, like "PATH", you should use "~/.MacOSX/environment.plist". Example:

    $ cat ~/.MacOSX/environment.plist
    {
    	PATH = "/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin";
    }

After editing the environment.plist file, you need to log out of your system account and log in again.


[FastScripts]: http://www.red-sweater.com/fastscripts/
[intro]: http://stdout.caiochassot.com/post/1158001754/scripts-mac-ruby
[listing]: http://stdout.caiochassot.com/tagged/fastscripts
[rb-appscript]: http://appscript.sourceforge.net/rb-appscript/index.html
[homebrew]: http://mxcl.github.com/homebrew/
