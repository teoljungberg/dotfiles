" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

function! ListActiveBuffers()
  let bufferlist = []
  for l:bni in range(bufnr("$"), 1, -1)
    if buflisted(l:bni)
      call add(bufferlist, bufname(l:bni))
    endif
  endfor
  return "echo ".join(bufferlist, ' ')." | tr ' ' '\\n' "
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
if filereadable(".git/config")
  let find_cmd = "git ls-files . -co --exclude-standard"
else
  let find_cmd = "find * -type f"
endif

nnoremap <leader><leader> :call SelectaCommand(find_cmd, "", ":e")<cr>
nnoremap <leader>b :call SelectaCommand(ListActiveBuffers(), "", ":e")<cr>
