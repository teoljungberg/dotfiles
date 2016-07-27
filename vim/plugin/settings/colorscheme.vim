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

hi! StatusLineNC
      \ term=reverse
      \ cterm=reverse
      \ ctermfg=7
      \ ctermbg=14
      \ gui=bold,reverse

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
      \ ctermfg=7
      \ ctermbg=10
      \ guifg=bg
      \ guibg=LightGray
