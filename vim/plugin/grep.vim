function! SetGrepPrg()
  let l:output = system("git ls-files " . expand("%") . " -co --exclude-standard --error-unmatch 2> /dev/null; echo $?")

  if l:output == 0
    set grepprg=git\ grep\ -n
  else
    if executable("ag")
      set grepprg=ag\ --nogroup\ --nocolor
    else
      set grepprg=grep\ -rnH
    endif
  endif
endfunction

autocmd VimEnter,BufReadPre,FileReadPre * :call SetGrepPrg()
