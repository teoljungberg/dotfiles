source ~/.vimrc

if has('nvim-0.5')
  if filereadable($HOME . '/.config/nvim/local.lua')
    source ~/.config/nvim/local.lua
  endif

  if filereadable($HOME . '/.config/nvim/localest.lua')
    source ~/.config/nvim/localest.lua
  endif
endif
