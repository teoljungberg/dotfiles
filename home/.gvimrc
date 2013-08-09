colo solarized
set background=light
set anti
set guifont=Source\ Code\ Pro:h13
set laststatus=2
set lines=45 columns=120
set go-=T
set go-=l
set go-=L
set go-=r
set go-=R
set go-=e
set autoread
autocmd FocusLost * silent! wall
set shell=/usr/local/bin/zsh
set guicursor=a:blinkon0

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif
