cabbrev rg gr

function! SetGrepPrg()
  if executable("rg")
    set grepprg=rg\ --hidden\ --glob\ '!.git'\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
  else
    set grepprg=grep\ -rnH
  endif
endfunction

autocmd VimEnter,BufReadPre,FileReadPre * :call SetGrepPrg()
