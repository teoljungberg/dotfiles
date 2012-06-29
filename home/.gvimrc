colo solarized
set background=light
set anti
set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 14
"set guifont=Inconsolata:h14
set clipboard=unnamed
set lines=45 columns=120

" Command + t to :CommandT
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif

" M-# switches to tab
noremap <d-1> 1gt
noremap <d-2> 2gt
noremap <d-3> 3gt
noremap <d-4> 4gt
noremap <d-5> 5gt
noremap <d-6> 6gt
noremap <d-7> 7gt
noremap <d-8> 8gt
noremap <d-9> 9gt

" Remove all the UI cruft
set go-=T

