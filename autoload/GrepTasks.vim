" GrepTasks.vim: Grep for tasks and TODO markers.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	25-Aug-2012	file creation

function! GrepTasks#Grep( count, grepCommand, pattern, ... )
    let l:pattern = printf(g:GrepTasks_PatternTemplate, a:pattern)
    try
	execute (a:count ? a:count : '') . a:grepCommand '/' . escape(l:pattern, '/') . '/' . g:GrepTasks_GrepFlags . (a:0 ? ' ' . a:1 : '')
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

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
