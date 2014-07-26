let g:quickfix_is_open = 0

function! QuickfixToggle(...)
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
  else
    if a:0 > 0
      Copen
    else
      copen
    endif
    let g:quickfix_is_open = 1
  endif
endfunction
nnoremap <silent> fq :call QuickfixToggle()<cr>
nnoremap <silent> dq :call QuickfixToggle(1)<cr>
