setlocal iskeyword+=?,!,=

" includes can be slow
setlocal complete-=i

" abbreviations
iabbrev dinit def initialize

" dispatch
let b:start = "irb -I lib -r '%:p'"

if empty("b:dispatch")
  if expand('%') =~# '_test\.rb$'
    let b:dispatch = 'ruby -I test:lib %'
  elseif expand('%') =~# '_spec\.rb$'
    if filereadable("Gemfile")
      let b:dispatch = 'bundle exec rspec %'
    else
      let b:dispatch = 'rspec %'
    endif
  endif
endif
