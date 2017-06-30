cabbrev rg gr
nnoremap <space>gr :grep<space><C-R>=expand("<cword>")<CR>
nnoremap <space>gl :lgrep<space><C-R>=expand("<cword>")<CR>

if executable("rg")
  set grepprg=rg\ --hidden\ --glob\ '!.git'\ --vimgrep\ --with-filename
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif
