if has('b:did_ftdetect') | finish | endif
let b:did_ftdetect=1
augroup filetypedetect
    au! BufNewFile,BufRead *.vb
    au BufNewFile,BufRead *.vb setf vbnet
augroup END
