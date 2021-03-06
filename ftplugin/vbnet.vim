if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

let s:keepcpo = &cpo
set cpo&vim

try
	call textobj#user#plugin('vbnet', {
	\	'if-condition': {
	\		'pattern': ['If ', ' Then'],
	\		'select-a': 'ac',
	\		'select-i': 'ic',
	\	},
	\	'if': {
	\		'pattern': ['^\s*If .* Then\r\?\n', '^\s*End If'],
	\		'select-a': 'ai',
	\		'select-i': 'ii'
	\	},
	\	'try': {
	\		'pattern': ['^\s*\(Catch\|Finally\|Try\)\r\?\n', '^\s*\(Catch\|Finally\|End Try\)'],
	\		'select-a': 'aT',
	\		'select-i': 'iT'
	\	},
	\	'loop': {
	\		'pattern': ['^\s*\(For\s\+Each\|For\).*\r\?\n', '^\s*Next'],
	\		'select-a': 'al',
	\		'select-i': 'il'
	\	},
	\})
catch
endtry

setlocal et
setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal suffixesadd=.vb
setlocal com=:REM,:'
setlocal cms='%s

" NOTE the double escaping \\|
nnoremap <buffer> <silent> <expr> [[ <SID>VbSearch('^\s*\zs\%(\%(private\\|\public\\|\friend\\|\property\)\s\+\)\?\%(function\\|sub\\|property\\|type\).*', 'bW')
vnoremap <buffer> <silent> <expr> [[ <SID>VbSearch('^\s*\zs\%(\%(private\\|\public\\|\friend\\|\property\)\s\+\)\?\%(function\\|sub\\|property\\|type\).*', 'bW')
nnoremap <buffer> <silent> <expr> ]] <SID>VbSearch('^\s*\zs\%(\%(private\\|\public\\|\friend\\|\property\)\s\+\)\?\%(function\\|sub\\|property\\|type\).*', 'W')
vnoremap <buffer> <silent> <expr> ]] <SID>VbSearch('^\s*\zs\%(\%(private\\|\public\\|\friend\\|\property\)\s\+\)\?\%(function\\|sub\\|property\\|type\).*', 'W')

nnoremap <buffer> <silent> <expr> [] <SID>VbSearch('^\s*\zs\<end\>\s\+\%(function\\|sub\\|property\\|type\)', 'bW')
vnoremap <buffer> <silent> <expr> [] <SID>VbSearch('^\s*\zs\<end\>\s\+\%(function\\|sub\\|property\\|type\)', 'bW')
nnoremap <buffer> <silent> <expr> ][ <SID>VbSearch('^\s*\zs\<end\>\s\+\%(function\\|sub\\|property\\|type\)', 'W')
vnoremap <buffer> <silent> <expr> ][ <SID>VbSearch('^\s*\zs\<end\>\s\+\%(function\\|sub\\|property\\|type\)', 'W')

nnoremap <buffer> <silent> - :execute 'e ' . vbnet#switch()<CR>

fun! s:VbSearch(str, flg)
	let s:a = search(a:str, a:flg)
	if s:a != 0
		return s:a.'G'
	endif
	return  ''
endf

if exists("loaded_matchit")
    let b:match_ignorecase = 1
    let b:match_words = '\<Namespace\>:\<End Namespace\>'
    \. ',\<Module\>:^\s*\<End Module\>'
    \. ',\<Class\>:^\s*\<End Class\>'
    \. ',\<Interface\>:^\s*\<End Interface\>'
    \. ',\<Property\>:^\s*\<End Property\>'
    \. ',\%(^\s*\)\@<=\<Get\>:^\%(\s*\)\<End Get\>'
    \. ',\%(^\s*\)\@<=\<Set\>:^\%(\s*\)\<End Set\>'
    \. ',\%(^\s*\)\@<=\<Using\>:^\%(\s*\)\<End Using\>'
    \. ',\%(^\s*\)\@<=\<Try\>:^\%(\s*\)\<Catch\>:^\s\<End Try\>'
    \. ",\\%(^\\s*\\)\\@<=\\<If\\>.*\\<Then\\>\\s*\\%('.*\\)\\?$:\\%(^\\s*\\)\\@<=\\<Else\\>:\\%(^\\s*\\)\\@<=\\<ElseIf\\>:\\%(^\\s*\\)\\@<=\\<End\\>\\s\\+\\<If\\>"
    \. ',\%(^\s*\)\@<=\<For\>:\%(^\s*\)\@<=\<Next\>'
    \. ',\%(^\s*\)\@<=\<While\>:\%(^\s*\)\@<=\<\%(Wend\|End While\)\>'
    \. ',\%(^\s*\)\@<=\<Do\>\s*While:\%(^\s*\)\@<=\<Loop\>'
    \. ',\%(^\s*\)\@<=\<Do\>:\%(^\s*\)\@<=\<Loop\>\s\+\<While\>'
    \. ',\%(^\s*\)\@<=\<Select\>\s\+\<Case\>:\%(^\s*\)\@<=\<Case\>:\%(^\s*\)\@<=\<End\>\s\+\<Select\>'
    \. ',\%(^\s*\)\@<=\<Enum\>:\%(^\s*\)\@<=\<End\>\s\<Enum\>'
    \. ',\%(^\s*\)\@<=\<With\>:\%(^\s*\)\@<=\<End\>\s\<With\>'
    \. ',\<Function\>\s*\([^ \t(]\+\):\%(^\s*\)\@<=\<\1\>\s*=:\<Exit\>\s\+\<Function\>:\<End\>\s\+\<Function\>'
    \. ',^\s*\%(\%(Protected\|Friends\|Overrides\|Overridable\|Public\|Private\)\s\+\)*\<Sub\>:\<Exit\>\s\+\<Sub\>:\<End\>\s\+\<Sub\>'
    \. ',^\s*#If\>:^\s*#ElseIf\>:^\s*#Else\>:^\s*#End If\>'
    \. ',^\s*#Region\>:^\s*#End\s\+Region\>'
    \. ',▼\+:▲\+'
    \. ',▽\+:△\+'
    \. ',' . &matchpairs
endif

let &cpo = s:keepcpo
unlet s:keepcpo
