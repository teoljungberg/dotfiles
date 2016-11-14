nnoremap <silent> <expr> d<cr> ":Dispatch<cr>"
nnoremap <silent> <expr> d! ":Dispatch!<cr>"
nnoremap d<space> :Dispatch<space>
nnoremap d<bs> :FocusDispatch<space>
nnoremap dc :Console<cr>

if !exists(":Console")
  command! -bang Console Start
endif
