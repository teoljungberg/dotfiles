setlocal iskeyword+=?,!,=

" includes can be slow
set complete-=i

" abbreviations
iabbrev dinit def initialize

" dispatch
if expand('%') =~# '_test\.rb$'
  let b:dispatch = 'ruby -I test:lib %'
elseif expand('%') =~# '_spec\.rb$'
  if filereadable("Gemfile")
    let b:dispatch = 'bundle exec rspec %'
  else
    let b:dispatch = 'rspec %'
  endif
else
  let b:dispatch = 'ruby -w %'
endif

let b:start = executable('pry') ? 'pry -r "%:p"' : 'irb -r "%:p"'

" minitest
function! SwitchAssertion()
  let b:opposites = {'assert': 'refute', 'refute': 'assert' }
  setlocal nogdefault
  :silent! s/\(assert\|refute\)/\="" . get(b:opposites, submatch(1))
endfunction
command! SwitchAssertion :call SwitchAssertion()

function! ToggleTest()
  if expand('%') =~# '_test\.rb$'
    let b:opposites = {'def test_': 'def ', 'def ': 'def test_' }
    :silent! s/\(def test_\|def \)/\="" . get(b:opposites, submatch(1))
  elseif expand('%') =~# '_spec\.rb$'
    let b:opposites = {'it': 'xit', 'xit': 'it' }
    :silent! s/\(it\|xit\)/\="" . get(b:opposites, submatch(1))
  endif
endfunction
command! ToggleTest :call ToggleTest()
