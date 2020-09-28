" GrepTasks.vim: Grep for tasks and TODO markers.
"
" DEPENDENCIES:
"   - GrepHere plugin for :GrepHere command
"   - GrepCommands plugin for :ArgGrep, :BufGrep, :WinGrep, :TabGrep commands
"
" Copyright: (C) 2012-2020 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_GrepTasks') || (v:version < 700)
    finish
endif
let g:loaded_GrepTasks = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:GrepTasks_PatternTemplate')
    let g:GrepTasks_PatternTemplate =  '\C\<\%(FIXME\|TODO\|XXX\)\>:\?.*\&.*%s'
endif
if ! exists('g:GrepTasks_GrepFlags')
    let g:GrepTasks_GrepFlags = 'gj'
endif


"- commands --------------------------------------------------------------------

command! -bang -count -nargs=?                GrepHereTasks call GrepTasks#Grep(<count>, 'GrepHere', <q-args>)
command! -bang -count -nargs=?                ArgGrepTasks  call GrepTasks#Grep(<count>, 'ArgGrep', <q-args>)
command! -bang -count -nargs=?                BufGrepTasks  call GrepTasks#Grep(<count>, 'BufGrep', <q-args>)
command! -bang -count -nargs=?                WinGrepTasks  call GrepTasks#Grep(<count>, 'WinGrep', <q-args>)
command! -bang -count -nargs=?                TabGrepTasks  call GrepTasks#Grep(<count>, 'TabGrep', <q-args>)
command! -bang -count -nargs=+ -complete=file VimGrepTasks  call GrepTasks#FileGrep(<count>, 'vimgrep', <q-args>)

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
