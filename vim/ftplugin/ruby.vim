setlocal iskeyword+=?,!,=

" abbreviations
iabbrev <buffer> dinit def initialize
iabbrev <buffer> ddebug require 'irb'; binding.irb

let b:start = "irb -r '%:p'"

if expand("%") =~# "_test\.rb$"
  let b:dispatch = "ruby -Itest %"
elseif expand("%") =~# "_spec\.rb$"
  let b:dispatch = "rspec %"
elseif !exists("b:dispatch")
  let b:dispatch = "ruby -wc %"
endif
