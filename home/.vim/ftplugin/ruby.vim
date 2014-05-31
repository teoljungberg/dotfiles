setlocal iskeyword+=?,!,=

" abbreviations
iabbrev init def initialize

" dispatch
if expand('%') =~# '_test\.rb$'
  let b:dispatch = 'ruby -w -I test:lib %'
elseif expand('%') =~# '_spec\.rb$'
  if filereadable("Gemfile")
    let b:dispatch = 'bundle exec rspec %'
  else
    let b:dispatch = 'rspec %'
  endif
else
  let b:dispatch = 'ruby -wc %'
endif

let b:start = executable('pry') ? 'pry -r "%:p"' : 'irb -r "%:p"'
