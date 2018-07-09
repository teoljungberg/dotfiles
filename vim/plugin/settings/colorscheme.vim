function! s:ColorschemeChanges()
  hi! Comment term=italic cterm=italic gui=italic
  hi! Constant term=italic cterm=italic gui=italic
  hi! PmenuSBar term=reverse cterm=reverse ctermfg=11 ctermbg=15 guibg=Black
  hi! PmenuThumb term=reverse cterm=reverse ctermfg=0 ctermbg=11 guibg=Grey

  hi! link rubyAssertion rubyFunction
  hi! link rubyCapitalizedMethod rubyConstant
  hi! link rubyTestMacro rubyFunction
  hi! link rubyTesthelper rubyFunction

  hi! MatchParen cterm=bold ctermbg=none ctermfg=33

  hi! StatusLineNC
        \ term=reverse
        \ cterm=reverse
        \ ctermfg=7
        \ ctermbg=14
        \ gui=reverse
        \ guifg=#839496
        \ guibg=#eee8d5

  hi! StatusLineTerm
        \ term=reverse
        \ cterm=reverse
        \ ctermfg=10
        \ ctermbg=7
        \ gui=reverse
        \ guifg=#586e75
        \ guibg=#eee8d5
  hi! StatusLineTermNC
        \ term=reverse
        \ cterm=reverse
        \ ctermfg=7
        \ ctermbg=14
        \ gui=reverse
        \ guifg=#839496
        \ guibg=#eee8d5
endfunction

augroup Colorscheme
  autocmd!

  autocmd VimEnter * call <SID>ColorschemeChanges()
  " Run these settings whenever colorscheme changes, in order to re-overwrite
  " whatever the colorscheme sets
  autocmd ColorScheme * call <SID>ColorschemeChanges()
augroup END
