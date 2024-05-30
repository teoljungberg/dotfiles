source ~/.vimrc

if has('nvim-0.5') && filereadable(expand('<sfile>:h') . '/local.lua')
  " ~/.config/nvim/local.lua
  source <sfile>:h/local.lua
endif
