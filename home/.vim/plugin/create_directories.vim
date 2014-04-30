augroup dir_create
  au!
  au BufWritePre,FileWritePre * call Cdir()
augroup END

function! Cdir()
  let dir = expand('<afile>:p:h')
  if !isdirectory(dir)
    call mkdir(dir, 'p')
  endif
endfunction
