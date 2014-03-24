function! SwitchAssertion()
  let b:opposites = {'assert': 'refute', 'refute': 'assert' }
  :silent! s/\(assert\|refute\)/\="" . get(b:opposites, submatch(1))
endfunction
command! SwitchAssertion :call SwitchAssertion()

function! ToggleTest()
  let b:opposites = {'def test_': 'def ', 'def ': 'def test_' }
  :silent! s/\(def test_\|def \)/\="" . get(b:opposites, submatch(1))
endfunction
command! ToggleTest :call ToggleTest()
