GREP TASKS
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

This plugin defines commands to search for tasks and TODO markers embedded in
files, and populates the quickfix list with the resulting lines. Most IDEs
offer such a view, too.

### HOW IT WORKS

The :vimgrep command is used with a predefined pattern. Search targets for
the current buffer, all arguments, listed buffers, windows in the current tab
page or all tab pages can be used (leveraging the GrepHere.vim and
GrepCommands.vim plugins).

### SEE ALSO

- To move to individual tasks and TODO markers in the current buffer without
  building and going through the quickfix list, you can use the companion
  TaskMotions.vim plugin ([vimscript #3990](http://www.vim.org/scripts/script.php?script_id=3990)).

### RELATED WORKS

- TaskList.vim ([vimscript #2607](http://www.vim.org/scripts/script.php?script_id=2607)) searches only the current file triggered by a
  mapping, and displays in a scratch buffer.
- remaining-todos ([vimscript #5571](http://www.vim.org/scripts/script.php?script_id=5571)) warns the user that there are a certain
  number of TODO marks when leaving a file.

USAGE
------------------------------------------------------------------------------

    All commands search for case-sensitive occurrences of FIXME:, TODO:, and XXX:
    in the files. (This is customizable via g:GrepTasks_PatternTemplate).
    When the optional [{pattern}] is specified, only occurrences that contain the
    {pattern} after the marker keyword are included.

    :GrepHereTasks[!] [{pattern}]
                            Search for tasks and TODOs in the current buffer and
                            set the error list to the matches.

    :ArgGrepTasks[!] [{pattern}]
                            Search for tasks and TODOs in all files from the
                            argument-list and set the error list to the matches.

    :BufGrepTasks[!] [{pattern}]
                            Search for tasks and TODOs in all listed buffers and
                            set the error list to the matches.

    :WinGrepTasks[!] [{pattern}]
                            Search for tasks and TODOs in all buffers visible in
                            the current tab and set the error list to the matches.

    :TabGrepTasks[!] [{pattern}]
                            Search for tasks and TODOs in all buffers visible in
                            all tab pages and set the error list to the matches.

    :VimGrepTasks[!] [/{pattern}/] {file} ...
                            Search for tasks and TODOs in the files {file} ... and
                            set the error list to the matches.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-GrepTasks
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim GrepTasks*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.008 or
  higher.
- Requires the GrepCommands plugin ([vimscript #4173](http://www.vim.org/scripts/script.php?script_id=4173)).
- Requires the GrepHere plugin ([vimscript #4191](http://www.vim.org/scripts/script.php?script_id=4191)).

CONFIGURATION
------------------------------------------------------------------------------

For a permanent configuration, put the following commands into your vimrc:

Tasks and TODO markers are detected by a regular expression, which is built
from a |printf()|-style template, into which the optional filter pattern is
inserted at the %s keyword:

    let g:GrepTasks_PatternTemplate = '\<TODO:\s\?.*%s'

By default, the quickfix list is filled with all found tasks; the first found
task isn't jumped to. You can adapt that by changing the :vimgrep flags:

    let g:GrepTasks_GrepFlags = 'gj'

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-GrepTasks/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.01    14-Dec-2013
- FIX: Use the rules for the /pattern/ separator as stated in :help E146.
- Add dependency to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)).

__You need to separately
  install ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.008 (or higher)!__

##### 1.00    27-Aug-2012
- First published version.

##### 0.01    19-Mar-2012
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2012-2019 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat <ingo@karkat.de>
