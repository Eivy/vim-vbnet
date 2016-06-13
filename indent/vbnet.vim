" Vim indent file
" Language   : VisualBasic.NET
" Author: OGURA Daiki
" Maintainers: Eivy <modern.times.rock.and.roll+git@gmail.com>

if exists("b:did_indent") | finish | endif
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=VbNetGetIndent(v:lnum)
setlocal indentkeys+==~else,=~elseif,=~if,=~try,=~end\ ,=~wend,=~case,=~next,=~select,=~loop,=~catch,=~finally,=~next,<:>,{:},(:)

let s:keepcpo= &cpo
set cpo&vim

fun! VbNetGetIndent(lnum)
    if a:lnum == 0 | return 0 | endif
    let plnum = prevnonblank(a:lnum - 1)
    let ind = indent(plnum)

    let this_line = getline(a:lnum)
    let keyword =  '^\s*\%(<.*>\s*\)*\%(\<\%(Public\|Protected\|Private\|Friend\|Overrides\|Overridable\|Overloads\|NotOverridable\|MustOverride\|Shadows\|Shared\|ReadOnly\|WriteOnly\)\>\s*\)*\<\%(Sub\|Function\|Module\|Class\|Enum\|Interface\|Operator\|Namespace\|Property\|Get\|Set\|Structure\)\>'

    " labels and preprocessor get zero indent immediately
    let LABELS_OR_PREPROC = '^\s*\<\k\+\>:\s*$\|^\s*#'
    if this_line =~? LABELS_OR_PREPROC | return 0 | endif

    let previous_line = getline(plnum)
    while previous_line =~# LABELS_OR_PREPROC || previous_line =~ '^\s*'''
        let plnum = prevnonblank(plnum - 1)
        let previous_line = getline(plnum)
    endwhile
    let ind = indent(plnum)

    if previous_line =~# '^\s*[^'']\%(And\|Or\|AndAlso\|OrElse\)\s*$\| _$\|^[^'']\+[+-/\\&*,{(]\s*$\|^\s*\.$'
        if getline(prevnonblank(plnum-1)) =~# '\%(And\|Or\|AndAlso\|OrElse\)\s*$\| _$\|^[^'']\+[+-/\\&*,{(]\s*$\|^\s*\.' || previous_line =~ '^\s*'''
            return ind
        else
            return indent(a:lnum)
        endif
    endif

    while getline(plnum-1) =~# LABELS_OR_PREPROC . '\|\%(And\|Or\|AndAlso\|OrElse\)\s*$\| _$\|^[^'']\+[+-/\\&*,{(]\s*$\|^\s*\.$'
        let plnum = plnum-1
    endwhile
    if getline(plnum) =~? LABELS_OR_PREPROC
        let plnum = nextnonblank(plnum+1)
    endif
    let previous_line = getline(plnum)
    let ind = indent(plnum)

    if this_line =~# '^\s*End\s\+Select'
        if previous_line =~# '^\s*<Select\>'
            return ind
        elseif previous_line =~# '^\s*\<Case\>'
            return ind - &sw
        else
            return ind - 2 * &sw
        endif
    elseif this_line =~# '^\s*\<\%(Catch\|Finally\)\>'
        if previous_line =~# '^\s*\<\%(Catch\|Try\)\>'
            return ind
        else
            return ind - &sw
        endif
    elseif this_line =~# '^\s*End\s\+Try'
        if previous_line =~# '^\s*\(\<Try\>\|\<Catch\>\)'
            return ind
        else
            return ind - &sw
        endif
    elseif this_line =~# '^\s*\<End\s.\+\|^\s*\<\%(Next\|Else\|ElseIf\)\>\|^\s*[)}]'
        if previous_line =~# keyword . '\|^\s*\<\%(If\|Else\|ElseIf\|Case\|For\|While\|Do\|Using\|Try\|Catch\|Finally\|With\|SyncLock\)\>' && previous_line !~# '^\s*\<Set\>.*='
            if previous_line !~# '\<Then\>\s*[^''     _]'
                return ind
            else
                return ind - &sw
            endif
        else
            return ind - &sw
        endif
    elseif this_line =~# '^\s*\<Case\>'
        if previous_line =~# '^\s*Select\s\+\%(\<Case\>\)\?'
            return ind + &sw
        elseif previous_line =~# '^\s*Case'
            return ind
        else
            return ind - &sw
        endif
    elseif this_line =~# '^\s*\<\(Option\|Imports\)\>'
        return 0
    elseif this_line =~# '^\s*\<Loop\>'
        return ind - &sw
    endif

    if previous_line =~# '^\s*\%(If\>\|ElseIf\>\)'
        if previous_line !~# '\<Then\>\s*[^''     _]'
            return ind + &sw
        else
            return ind
        endif
    elseif previous_line =~# '\<Then\>\s*\%(''.*\)*$'
        if previous_line !~ '^\s*'''
            return ind + &sw
        endif
    elseif previous_line =~# '^\s*\%(Case\|Else\|For\|While\|Do\|Using\|Try\|Catch\|Finally\|With\|SyncLock\)\>'
        return ind + &sw
    elseif previous_line =~# '^\s*\<Do\>\s*$'
        return ind + &sw
    elseif previous_line =~# '^\s*\<Select\>\s*\%(\<Case\>\)\?'
        return ind +  &sw
    elseif previous_line =~# keyword && previous_line !~# '^\s*\<Set\>.*='
        return ind + &sw
    elseif previous_line =~# '[{(=]\s*$'
        return ind + &sw
    endif

    return ind
endfunction

let &cpo = s:keepcpo
unlet s:keepcpo

let b:undo_indent = 'setlocal '.join(['autoindent<', 'indentexpr<', 'indentkeys<'])

" vim:sw=2
