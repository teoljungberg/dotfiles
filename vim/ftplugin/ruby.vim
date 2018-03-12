setlocal iskeyword+=?,!,=

" includes can be slow
setlocal complete-=i

" abbreviations
iabbrev dinit def initialize
iabbrev ddebug require 'irb'; binding.irb

let b:start = "irb -r '%:p'"

if expand("%") =~# "_test\.rb$"
  let b:dispatch = "testrb %"
elseif expand("%") =~# "_spec\.rb$"
  let b:dispatch = "rspec %"
elseif !exists("b:dispatch")
  let b:dispatch = "ruby -wc %"
endif
