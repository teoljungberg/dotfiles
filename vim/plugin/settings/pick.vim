if executable("pick")
  if ! has("gui_running")
    nnoremap <leader><leader> :call PickFile()<cr>
    nnoremap <leader>s :call PickFileSplit()<cr>
    nnoremap <leader>v :call PickFileVerticalSplit()<cr>
    nnoremap <leader>b :call PickBuffer()<cr>
    nnoremap <leader>7 :call PickTag()<cr>
    nnoremap <leader>] :split<cr>:call PickTag()<cr>
  endif
endif
