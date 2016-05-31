let g:ruby_indent_block_style = "do"
setlocal iskeyword+=?,!,=

" includes can be slow
set complete-=i

" abbreviations
iabbrev dinit def initialize

" dispatch
let b:start = executable('pry') ? 'pry -I lib -r "%:p"' : 'irb -I lib -r "%:p"'

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
