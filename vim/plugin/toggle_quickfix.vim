function! ToggleQuickfixList()
  if BufferOpen("Quickfix List")
    echo ":cclose"
    cclose
  else
    echo ":copen"
    copen
  endif
endfunction

nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap =oq :call ToggleQuickfixList()<CR>
