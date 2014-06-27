nnoremap <silent> d<cr> :Dispatch!<cr>
nnoremap <silent> du :Dispatch!<space><up><cr>
nnoremap d<space> :Dispatch!<space>

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

