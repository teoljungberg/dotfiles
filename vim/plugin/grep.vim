nnoremap <leader>gr :grep<space><C-R>=expand("<cword>")<CR>
nnoremap <leader>gl :lgrep<space><C-R>=expand("<cword>")<CR>

if executable("rg")
  set grepprg=rg\ --hidden\ --glob\ '!.git'\ --vimgrep\ --with-filename
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif
