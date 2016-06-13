function! vbnet#switch() abort
    let l:file = expand('%:p')
    let l:ext = substitute(expand('%:t'), '[^.]*\.\ze', '', '')
    if l:ext =~? 'designer\.vb'
        let l:newext = 'vb'
    else
        let l:newext = 'Designer.vb'
    endif
    return substitute(l:file, l:ext, l:newext, '')
endfunction
