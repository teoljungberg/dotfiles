" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! PickCommand(choice_command, pick_args, vim_command)
  try
    let selection = system(a:choice_command . " | pick " . a:pick_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from pick on the screen
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
let is_git_repo = system("git rev-parse --is-inside-work-tree &> /dev/null ; echo $?") == 0

if is_git_repo
  let find_cmd = "git ls-files . -co --exclude-standard"
else
  let find_cmd = "find * -type f"
endif

let tag_cmd = "awk '{print $1}' .git/tags | sort -u | grep -v '^!'"

if executable("pick")
  if ! has("gui_running")
    nnoremap <leader><leader> :call PickCommand(find_cmd, "", ":e")<cr>
    nnoremap <leader>b :call PickCommand(ListActiveBuffers(), "", ":e")<cr>
    nnoremap <leader>7 :call PickCommand(tag_cmd, "", ":tag")<cr>
  endif
endif
