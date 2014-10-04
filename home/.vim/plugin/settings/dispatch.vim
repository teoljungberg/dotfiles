nnoremap <silent> d<cr>    :Dispatch<cr>
nnoremap <silent> d!       :Dispatch!<cr>
nnoremap          d<space> :Dispatch<space>
nnoremap          d<bs>    :Focus<space>
nnoremap <silent> dc       :Console<cr>

if !exists(":Console")
  command! -bang Console Start
endif
