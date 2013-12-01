" save last search, and cursor position.
function! Preserve(command)
  let _s=@/
  let l = line('.')
  let c = col('.')
  execute a:command
  " restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
command! StripTrailingWhitespace :call Preserve(':%s/\s\+$//e')

