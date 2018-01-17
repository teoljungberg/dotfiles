function! ToggleQuickfixList()
  let buffer_list = 0
  redir =>buffer_list
  silent! ls
  redir END

  for buffer_number in map(
        \ filter(
        \   split(buffer_list, '\n'),
        \   'v:val =~ "Quickfix List"'
        \ ),
        \ 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(buffer_number) != -1
      echo ':cclose'
      cclose
      return
    endif
  endfor

  echo ':copen'
  copen
endfunction

nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap =oq :call ToggleQuickfixList()<CR>
