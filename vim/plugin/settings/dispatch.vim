command! -range=-1 DispatchWithCount :call DispatchWithCount(v:count)
function! DispatchWithCount(count)
  if a:count == 1
    exec ":.Dispatch"
  elseif a:count == 2
    exec ":0Dispatch"
  else
    exec ":Dispatch"
  endif
endfunction

nnoremap <silent> <expr> d<cr> ":DispatchWithCount<cr>"
nnoremap <silent> <expr> d! ":Dispatch!<cr>"
nnoremap d<space> :Dispatch<space>
nnoremap d<bs> :FocusDispatch<space>
nnoremap dc :Console<cr>

if !exists(":Console")
  command! -bang Console Start
endif
