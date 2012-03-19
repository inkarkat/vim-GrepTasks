" GrepTasks.vim: summary
"
" DEPENDENCIES:
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	19-Mar-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_GrepTasks') || (v:version < 700)
    finish
endif
let g:loaded_GrepTasks = 1

if ! exists('g:GrepTasks_Pattern')
    let g:GrepTasks_PatternTemplate =  '\C\<\%(FIXME\|TODO\|XXX\)\>:\?.*\&.*%s'
endif

function! GrepTasks#Grep( count, grepCommand, pattern, ... )
    let l:pattern = printf(g:GrepTasks_PatternTemplate, a:pattern)
    try
	execute (a:count ? a:count : '') . a:grepCommand '/' . escape(l:pattern, '/') . '/' (a:0 ? a:1 : '')
    catch /^Vim\%((\a\+)\)\=:E/
	" v:exception contains what is normally in v:errmsg, but with extra
	" exception source info prepended, which we cut away.
	let v:errmsg = substitute(v:exception, '^Vim\%((\a\+)\)\=:', '', '')
	echohl ErrorMsg
	echomsg v:errmsg
	echohl None
    endtry
endfunction

command! -bang -count -nargs=? -complete=expression GrepHereTasks call GrepTasks#Grep(<count>, 'GrepHere', <q-args>)
command! -bang -count -nargs=? -complete=expression ArgGrepTasks  call GrepTasks#Grep(<count>, 'ArgGrep', <q-args>)
command! -bang -count -nargs=? -complete=expression BufGrepTasks  call GrepTasks#Grep(<count>, 'BufGrep', <q-args>)
command! -bang -count -nargs=? -complete=expression WinGrepTasks  call GrepTasks#Grep(<count>, 'WinGrep', <q-args>)
command! -bang -count -nargs=? -complete=expression TabGrepTasks  call GrepTasks#Grep(<count>, 'TabGrep', <q-args>)
command! -bang -count -nargs=+ -complete=file       GrepTasks     call GrepTasks#Grep(<count>, 'vimgrep', '', <q-args>)

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
