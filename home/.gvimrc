colo solarized
set background=light
set anti
set guifont=Monaco:h12
set clipboard=unnamed
set lines=45 columns=120

" Command + t to :CommandT
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif

" Open Command+T in a new tab
let g:CommandTAcceptSelectionTabMap='<CR>'

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
noremap <d-tab> :tabnext<cr>
imap <d-tab> <c-o>:tabnext<cr>
vmap <d-tab> <c-o>:tabnext<cr>
noremap <d-s-tab> :tabprevious<cr>
imap <d-s-tab> <c-o>:tabprevious<cr>
vmap <d-s-tab> <c-o>:tabprevious<cr>

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
set go-=l
set go-=L
set go-=r
set go-=R
