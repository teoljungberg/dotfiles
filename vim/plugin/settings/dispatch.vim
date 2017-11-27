command! -range=-1 DispatchWithCount :call DispatchWithCount(v:count)
function! DispatchWithCount(count)
  if a:count == 1
    exec ":.Dispatch"
  elseif a:count == 2
    exec ":0Dispatch"
  elseif a:count == 3
    if expand("$TMUX")
      exec ":Dispatch"
      call system("tmux select-pane -t :.+")
    else
      let l:dispatch_cmd = DispatchFocusCommand()
      let l:cmd = substitute(l:dispatch_cmd, ":ProjectDo ", "", "")
      let l:cmd = substitute(l:cmd, "Dispatch ", "", "")

      call dispatch#autowrite()

      exec ":botright terminal ++rows=10 " . l:cmd
    endif
  else
    exec ":Dispatch"
  endif
endfunction

function! DispatchFocusCommand()
  if has_key(b:, "rails_root")
    return dispatch#focus(line("."))[0]
  else
    return dispatch#focus(".")[0]
  endif
endfunction

function! DispatchFocusOnCurrentTest()
  let g:dispatch = DispatchFocusCommand()
  echo g:dispatch
endfunction

nnoremap <silent> <expr> d<cr> ":DispatchWithCount<cr>"
nnoremap <silent> <expr> d! ":Dispatch!<cr>"
nnoremap d<space> :Dispatch<space>
nnoremap d<bs> :Focus<space>
nnoremap dc :Console<cr>

if !exists(":Console")
  command! -bang Console Start
endif
