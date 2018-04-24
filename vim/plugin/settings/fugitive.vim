augroup Fugitive
  autocmd!

  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd FileType git setlocal nolist

  autocmd FileType gitcommit let b:sleuth_automatic = 0
  autocmd FileType gitcommit setlocal
        \ shiftwidth=2
        \ nolist
        \ spell

  autocmd VimEnter .git/PULLREQ_EDITMSG set filetype=gitcommit
augroup END
