nnoremap <buffer> o  <cr>
nnoremap <buffer> go <cr><c-w>p

augroup Quickfix
  autocmd FileType qf nmap <silent> <buffer> q :q<CR>
  autocmd FileType qf setlocal nolist
augroup END
