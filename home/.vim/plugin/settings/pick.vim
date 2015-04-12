" Run a given vim command on the results of fuzzy selecting from a given shell
let tag_cmd = "awk -F$'\t' '{print $1}' .git/tags | sort -u | grep -v '^!'"

if executable("pick")
  if ! has("gui_running")
    nnoremap <leader><leader> :call PickFile()<cr>
    nnoremap <leader>s :call PickFileSplit()<cr>
    nnoremap <leader>v :call PickFileVerticalSplit()<cr>
    nnoremap <leader>b :call PickBuffer()<cr>
    nnoremap <leader>7 :call PickCommand(tag_cmd, "", ":tag")<cr>
  endif
endif
