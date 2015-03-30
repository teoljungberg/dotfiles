nnoremap gs :Gstatus<cr>

augroup Fugitive
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd FileType git setlocal nolist
  autocmd FileType gitcommit setlocal
        \ nolist
        \ spell
        \ complete+=kspell

augroup END
