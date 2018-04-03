cabbrev rg <c-r>=(getcmdtype()==":" && getcmdpos()==1 ? "gr" : "rg")<CR>

if executable("rg")
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif
