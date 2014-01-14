function! SwitchAssertion()
  let b:opposites = {'assert': 'refute', 'refute': 'assert' }
  :s/\(assert\|refute\)/\="" . get(b:opposites, submatch(1))
endfunction
command! SwitchAssertion :call SwitchAssertion()
