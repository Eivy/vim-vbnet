function! textobj#function#vbnet#select(object_type)
	return s:select_{a:object_type}()
endf

function! s:select_a()
	if getline('.') =~? '^\s*end\s\+\(function\|sub\)\s*$'
		normal! k
	endif
	call search('^\s*end\s\+\(function\|sub\)\s*$', 'W')
	let e = getpos('.')
	call search('^\s*\(private\|public\|shared\|protected\|friend\)\?\s\+\(function\|sub\)', 'Wb')
	let b = getpos('.')
	if 1 < e[1] - b[1] " is there some code?
		return ['V', b, e]
	else
		return 0
	endif
endf

function! s:select_i()
	let range = s:select_a()
	if range is 0
		return 0
	endif
	let [_, ab, ae] = range

	call setpos('.', ab)
	normal! j0
	let ib = getpos('.')

	call setpos('.', ae)
	normal! k$
	let ie = getpos('.')

	if 0 <= ie[1] - ib[1] " is there some code?
		return ['V', ib, ie]
	else
		return 0
	endif
endf

