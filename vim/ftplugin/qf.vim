nnoremap <silent> <buffer> q :q<CR>
nnoremap <silent> <buffer> go <CR><Bar>:copen<CR>

function! IsLocationList()
  return getwininfo(win_getid())[0].loclist
endfunction

if IsLocationList()
  nnoremap <buffer> [f :lolder<CR>
  nnoremap <buffer> ]f :lnewer<CR>
else
  nnoremap <buffer> [f :colder<CR>
  nnoremap <buffer> ]f :cnewer<CR>
endif

setlocal nolist
setlocal norelativenumber
