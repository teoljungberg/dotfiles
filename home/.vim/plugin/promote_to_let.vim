function! PromoteToLet()
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
endfunction
command! PromoteToLet :call PromoteToLet()
