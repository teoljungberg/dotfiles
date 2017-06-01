function! TextwidthValue() abort
  return &textwidth
endfunction

nnoremap ]oq :set cc=<C-R>=TextwidthValue()<CR><CR>
nnoremap [oq :set cc=0<CR>
nnoremap coq :set cc=<C-R>=&cc == 0 ? TextwidthValue() : 0<CR><CR>
