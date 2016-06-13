if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

let s:keepcpo = &cpo
set cpo&vim

setlocal et
setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal suffixesadd=.vb
setlocal com=:REM,:'
setlocal cms='%s

" NOTE the double escaping \\|
nnoremap <buffer> <silent> <expr> [[ search('^\s*\%(\<\%(private\\|\public\\|\friend\\|\property\)\>\)\?\s\+\zs\%(function\\|sub\\|property\).*', 'bW').'G'
vnoremap <buffer> <silent> <expr> [[ search('^\s*\%(\<\%(private\\|\public\\|\friend\\|\property\)\>\)\?\s\+\zs\%(function\\|sub\\|property\).*', 'bW').'G'
nnoremap <buffer> <silent> <expr> ]] search('^\s*\%(\<\%(private\\|\public\\|\friend\\|\property\)\>\)\?\s\+\%(function\\|sub\\|property\).*', 'W').'G'
vnoremap <buffer> <silent> <expr> ]] search('^\s*\%(\<\%(private\\|\public\\|\friend\\|\property\)\>\)\?\s\+\%(function\\|sub\\|property\).*', 'W').'G'

nnoremap <buffer> <silent> <expr> [] search('^\s*\<end\>\s\+\zs\%(function\\|sub\\|property\)', 'bW').'G'
vnoremap <buffer> <silent> <expr> [] search('^\s*\<end\>\s\+\zs\%(function\\|sub\\|property\)', 'bW').'G'
nnoremap <buffer> <silent> <expr> ][ search('^\s*\<end\>\s\+\%(function\\|sub\\|property\)', 'W').'G'
vnoremap <buffer> <silent> <expr> ][ search('^\s*\<end\>\s\+\%(function\\|sub\\|property\)', 'W').'G'

nnoremap <buffer> <silent> - :execute 'e ' . vbnet#switch()<CR>

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
