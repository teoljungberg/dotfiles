let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_curly_braces = 0

function! s:try(cmd, default)
  if exists(":" . a:cmd) && !v:count
    let tick = b:changedtick
    exe a:cmd
    if tick == b:changedtick
      execute "normal! ".a:default
    endif
  else
    execute "normal! ".v:count.a:default
  endif
endfunction

nnoremap <silent> gJ    :<C-U>call <SID>try("SplitjoinJoin", "gJ")<CR>
nnoremap <silent>  J    :<C-U>call <SID>try("SplitjoinJoin", "J")<CR>
nnoremap <silent> gS    :<C-U>call <SID>try("SplitjoinSplit", "S")<CR>
nnoremap <silent>  S    :<C-U>call <SID>try("SplitjoinSplit", "S")<CR>
nnoremap <silent> r<CR> :<C-U>call <SID>try("SplitjoinSplit", "r\015")<CR>
