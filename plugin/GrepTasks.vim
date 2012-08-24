" GrepTasks.vim: Grep for tasks and TODO markers.
"
" DEPENDENCIES:
"   - ingogrep.vim plugin for :GrepHere command
"   - GrepCommands.vim plugin for :ArgGrep, :BufGrep, :WinGrep, :TabGrep
"     commands
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	003	04-May-2012	Rename :GrepTasks to :VimGrepTasks to make it
"				clear which syntax for {file} is used.
"	002	20-Mar-2012	Support optional /{pattern}/ for :GrepTasks.
"	001	19-Mar-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_GrepTasks') || (v:version < 700)
    finish
endif
let g:loaded_GrepTasks = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:GrepTasks_PatternTemplate')
    let g:GrepTasks_PatternTemplate =  '\C\<\%(FIXME\|TODO\|XXX\)\>:\?.*\&.*%s'
endif
if ! exists('g:GrepTasks_JumpToFirst')
    let g:GrepTasks_JumpToFirst = 0
endif


"- functions -------------------------------------------------------------------

function! GrepTasks#Grep( count, grepCommand, pattern, ... )
    let l:pattern = printf(g:GrepTasks_PatternTemplate, a:pattern)
    try
	execute (a:count ? a:count : '') . a:grepCommand '/' . escape(l:pattern, '/') . '/' . (g:GrepTasks_JumpToFirst ? '' : 'j') (a:0 ? a:1 : '')
    catch /^Vim\%((\a\+)\)\=:E/
	" v:exception contains what is normally in v:errmsg, but with extra
	" exception source info prepended, which we cut away.
	let v:errmsg = substitute(v:exception, '^Vim\%((\a\+)\)\=:', '', '')
	echohl ErrorMsg
	echomsg v:errmsg
	echohl None
    endtry
endfunction

function! GrepTasks#FileGrep( count, grepCommand, ... )
    let l:pattern = ''
    let l:filespecs = a:000

    if a:1 =~# '^\%(\i\@!\S\).*\%(\i\@!\S\)$'
	let l:pattern = substitute(a:1, '^\%(\i\@!\S\)\(.*\)\%(\i\@!\S\)$', '\1', '')
	let l:filespecs = a:000[1:]
    endif

    call call('GrepTasks#Grep', [a:count, a:grepCommand, l:pattern] + l:filespecs)
endfunction


"- commands --------------------------------------------------------------------

command! -bang -count -nargs=? -complete=expression GrepHereTasks call GrepTasks#Grep(<count>, 'GrepHere', <q-args>)
command! -bang -count -nargs=? -complete=expression ArgGrepTasks  call GrepTasks#Grep(<count>, 'ArgGrep', <q-args>)
command! -bang -count -nargs=? -complete=expression BufGrepTasks  call GrepTasks#Grep(<count>, 'BufGrep', <q-args>)
command! -bang -count -nargs=? -complete=expression WinGrepTasks  call GrepTasks#Grep(<count>, 'WinGrep', <q-args>)
command! -bang -count -nargs=? -complete=expression TabGrepTasks  call GrepTasks#Grep(<count>, 'TabGrep', <q-args>)
command! -bang -count -nargs=+ -complete=file       VimGrepTasks  call GrepTasks#FileGrep(<count>, 'vimgrep', <f-args>)

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
