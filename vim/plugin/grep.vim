cabbrev rg <c-r>=(getcmdtype()==":" && getcmdpos()==1 ? "gr" : "rg")<CR>

nnoremap <leader>gr :grep<space><C-R>=expand("<cword>")<CR>
nnoremap <leader>gl :lgrep<space><C-R>=expand("<cword>")<CR>

if executable("rg")
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif
