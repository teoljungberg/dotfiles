colo solarized
set background=light
set anti
set guifont=Monaco:h12
set clipboard=unnamed
set lines=45 columns=120

" Command(forntidslämning) + t to :CommandT
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif

" Open Command+T in a new tab
let g:CommandTAcceptSelectionTabMap='<CR>'

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
noremap <c-tab> :tabnext<cr>
imap <c-tab> <c-o>:tabnext<cr>
vmap <c-tab> <c-o>:tabnext<cr>
noremap <c-s-tab> :tabprevious<cr>
imap <c-s-tab> <c-o>:tabprevious<cr>
vmap <c-s-tab> <c-o>:tabprevious<cr>

" C-# switches to tab
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
