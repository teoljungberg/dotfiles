nnoremap <silent> <buffer> q :q<CR>

function! s:IsLocationList()
  return getwininfo(win_getid())[0].loclist
endfunction

if <SID>IsLocationList()
  nnoremap <buffer> [f :lolder<CR>
  nnoremap <buffer> ]f :lnewer<CR>
  nnoremap <buffer> [F :<C-R>=getloclist("$", {"nr": "$"}).nr - 1<CR>lolder<CR>
  nnoremap <buffer> ]F :<C-R>=getloclist("$", {"nr": "$"}).nr - 1<CR>lnewer<CR>
else
  nnoremap <buffer> [f :colder<CR>
  nnoremap <buffer> ]f :cnewer<CR>
  nnoremap <buffer> [F :<C-R>=getqflist({"nr": "$"}).nr - 1<CR>colder<CR>
  nnoremap <buffer> ]F :<C-R>=getqflist({"nr": "$"}).nr - 1<CR>cnewer<CR>
endif

setlocal nolist
setlocal nonumber
setlocal norelativenumber
