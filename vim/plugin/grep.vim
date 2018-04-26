cabbrev rg <c-r>=(getcmdtype()==":" && getcmdpos()==1 ? "gr" : "rg")<CR>

if executable("rg")
  set grepprg=rg\ --hidden\ --glob\ '!.git'\ --glob\ '!tags'\ --vimgrep\ --with-filename
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif
