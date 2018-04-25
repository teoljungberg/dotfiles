function! s:TextwidthValue() abort
  return &textwidth
endfunction

nnoremap [ot :setlocal cc=<C-R>=<SID>TextwidthValue()<CR><CR>
nnoremap ]ot :setlocal cc=0<CR>
nnoremap =ot :setlocal cc=<C-R>=&cc == 0 ? <SID>TextwidthValue() : 0<CR><CR>
