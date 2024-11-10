" GrepTasks.vim: Grep for tasks and TODO markers.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2012-2020 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! GrepTasks#Grep( count, grepCommand, pattern, ... )
    let l:pattern = printf(g:GrepTasks_PatternTemplate, a:pattern)
    try
	execute (a:count ? a:count : '') . a:grepCommand '/' . escape(l:pattern, '/') . '/' . g:GrepTasks_GrepFlags a:0 ? a:1 : ''
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#msg#VimExceptionMsg()
    endtry
endfunction

function! GrepTasks#FileGrep( count, grepCommand, arguments )
    let [l:pattern, l:fileglobs] = ['', a:arguments]

    let l:optionalPatternMatch = matchlist(a:arguments, '^\([[:alnum:]\\"|]\@![\x00-\xFF]\)\(.\{-}\)\%(\%(^\|[^\\]\)\%(\\\\\)*\\\)\@<!\1\%(\%(^\|[^\\]\)\%(\\\\\)*\\\)\@<! \(.*\)$')
    if ! empty(l:optionalPatternMatch)
	let [l:pattern, l:fileglobs] = l:optionalPatternMatch[2:3]

	" Unescape the regexp delimiter.
	let l:pattern = substitute(l:pattern, '\%(\%(^\|[^\\]\)\%(\\\\\)*\\\)\@<!\\' . l:optionalPatternMatch[1], l:optionalPatternMatch[1], 'g')
    endif

    call GrepTasks#Grep(a:count, a:grepCommand, l:pattern, ingo#escape#file#CmdlineSpecialEscape(l:fileglobs))
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
