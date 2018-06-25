" save last search, and cursor position.
function! s:Preserve(command)
  let l:save = winsaveview()
  execute a:command
  call winrestview(l:save)
endfunction

command! StripTrailingWhitespace :call <SID>Preserve(':%s/\s\+$//e')
