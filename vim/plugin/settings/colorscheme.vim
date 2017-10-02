hi! Comment cterm=italic gui=italic
hi! Constant cterm=italic gui=italic
hi! link rubyCapitalizedMethod rubyConstant
hi! link rubyTestMacro rubyFunction
hi! link rubyAssertion rubyFunction
hi! link rubyBlockParameter rubyIdentifier
hi! link gitCommitComment Comment
hi! link gitCommitHeader Comment

" 33 = blue
hi! MatchParen cterm=bold ctermbg=none ctermfg=33

hi! StatusLineTerm
      \ term=bold,reverse
      \ cterm=bold
      \ ctermfg=7
      \ ctermbg=10
      \ gui=bold
      \ guifg=bg
      \ guibg=DarkGray
hi! StatusLineTermNC
      \ term=reverse
      \ cterm=reverse
      \ ctermfg=12
      \ ctermbg=7
      \ guifg=bg
      \ guibg=LightGray
