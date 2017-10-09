function! TextwidthValue() abort
  return &textwidth
endfunction

nnoremap ]oq :setlocal cc=<C-R>=TextwidthValue()<CR><CR>
nnoremap [oq :setlocal cc=0<CR>
nnoremap =oq :setlocal cc=<C-R>=&cc == 0 ? TextwidthValue() : 0<CR><CR>
