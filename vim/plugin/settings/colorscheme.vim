function! s:ColorschemeChanges()
  if g:colors_name != "solarized"
    return
  endif

  hi! Comment term=italic cterm=italic gui=italic
  hi! Constant term=italic cterm=italic gui=italic
  hi! PmenuSBar term=reverse cterm=reverse ctermfg=11 ctermbg=15 guibg=Black
  hi! PmenuThumb term=reverse cterm=reverse ctermfg=0 ctermbg=11 guibg=Grey

  hi! link rubyAssertion rubyFunction
  hi! link rubyCapitalizedMethod rubyConstant
  hi! link rubyTestMacro rubyFunction
  hi! link rubyTesthelper rubyFunction

  hi! MatchParen cterm=bold ctermbg=none ctermfg=33

  if &background == "light"
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
  else
    hi! StatusLineNC
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=10
          \ ctermbg=14
          \ gui=reverse
          \ guifg=#657b83
          \ guibg=#073642
    hi! StatusLineTerm
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=14
          \ ctermbg=0
          \ gui=reverse
          \ guifg=#93a1a1
          \ guibg=#073642
    hi! StatusLineTermNC
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=10
          \ ctermbg=14
          \ gui=reverse
          \ guifg=#657b83
          \ guibg=#073642
  endif
endfunction

augroup Colorscheme
  autocmd!

  autocmd VimEnter * call <SID>ColorschemeChanges()
  " Run these settings whenever colorscheme changes, in order to re-overwrite
  " whatever the colorscheme sets
  autocmd ColorScheme * call <SID>ColorschemeChanges()
augroup END
