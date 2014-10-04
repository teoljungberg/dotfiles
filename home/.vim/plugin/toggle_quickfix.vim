" Pinched from @garybernhardt
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! BufferIsOpen(bufname)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      return 1
    endif
  endfor
  return 0
endfunction

function! ToggleQuickfix(dispatch_eh)
  if BufferIsOpen("Quickfix List")
    cclose
  else
    call OpenQuickfix(a:dispatch_eh)
  endif
endfunction

function! OpenQuickfix(dispatch_eh)
  if a:dispatch_eh
    Copen
  else
    copen
  endif
endfunction

nnoremap <silent> dq :call ToggleQuickfix(0)<cr>
nnoremap <silent> dQ :call ToggleQuickfix(1)<cr>
