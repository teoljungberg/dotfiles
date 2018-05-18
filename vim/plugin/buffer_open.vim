function! BufferOpen(buffer_name)
  let buffer_list = 0
  redir =>buffer_list
  silent! ls
  redir END

  for buffer_number in map(
        \ filter(split(buffer_list, "\n"), "v:val =~ '" . a:buffer_name . "'"),
        \ "str2nr(matchstr(v:val, '\\d\\+'))")
    if bufwinnr(buffer_number) != -1
      return 1
    endif
  endfor

  return 0
endfunction!
