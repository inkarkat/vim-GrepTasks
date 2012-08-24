" GrepTasks.vim: Grep for tasks and TODO markers.
"
" DEPENDENCIES:
"   - escapings.vim autoload script
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	002	25-Aug-2012	FIX: Pattern delimiters must be identical
"				characters; otherwise, stuff like \# is
"				interpreted as an (empty) pattern.
"				FIX: Must pass _all_ (joined) arguments, not
"				just a:0.
"	001	25-Aug-2012	file creation; split off autoload script

function! GrepTasks#Grep( count, grepCommand, pattern, ... )
    let l:pattern = printf(g:GrepTasks_PatternTemplate, a:pattern)
    try
	echomsg (a:count ? a:count : '') . a:grepCommand '/' . escape(l:pattern, '/') . '/' . g:GrepTasks_GrepFlags join(map(copy(a:000), 'escapings#fnameescape(v:val)'))
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
    let l:fileglobs = a:000

    if a:1 =~# '^\(\i\@!\S\).*\1$'
	let l:pattern = substitute(a:1, '^\(\i\@!\S\)\(.*\)\1$', '\2', '')
	let l:fileglobs = a:000[1:]
    endif

    " Note: Due to -complete=file, the arguments have been automatically
    " unescaped (e.g. \# -> #). We cannot simply re-fnameescape() them, because
    " they may contain wildcards, and these would then be escaped, too. Instead,
    " we must resolve the file globs here (unless it is a special Vim variable
    " like #, which glob() also processes), and then pass them on to have them
    " escaped by GrepTasks#Grep().
    let l:filespecs = []
    for l:fileglob in l:fileglobs
	if l:fileglob ==# expand(l:fileglob)
	    " Filter out directories to avoid a corresponding :vimgrep warning.
	    call extend(l:filespecs, filter(split(glob(l:fileglob), "\n"), '! isdirectory(v:val)'))
	else
	    call add(l:filespecs, l:fileglob)
	endif
    endfor

    call call('GrepTasks#Grep', [a:count, a:grepCommand, l:pattern] + l:filespecs)
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
