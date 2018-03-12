" jumps to the last known position in a file,
" except in 'gitcommit' and 'gitrebase'
let blacklist = ['gitcommit', 'gitrebase']
augroup JumpToLastKnownPosition
  autocmd!
  autocmd BufReadPost *
        \ if index(blacklist, &ft) < 0 && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END
