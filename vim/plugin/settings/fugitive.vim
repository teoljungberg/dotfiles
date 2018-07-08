augroup Fugitive
  autocmd!

  autocmd FileType git setlocal nolist
  autocmd FileType gitcommit let b:sleuth_automatic = 0
  autocmd FileType gitcommit setlocal
        \ shiftwidth=2
        \ nolist
        \ spell
augroup END
