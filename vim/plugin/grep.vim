cabbrev rg gr
nnoremap <space>gr :grep<space><C-R>=expand("<cword>")<CR>

if executable("rg")
  set grepprg=rg\ --hidden\ --glob\ '!.git'\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif
