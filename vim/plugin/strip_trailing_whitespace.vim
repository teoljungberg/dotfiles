" save last search, and cursor position.
function! Preserve(command)
  let l:save = winsaveview()
  execute a:command
  call winrestview(l:save)
endfunction

command! StripTrailingWhitespace :call Preserve(':%s/\s\+$//e')
