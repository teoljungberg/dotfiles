" Use d, and = rather than `, and ' until the final mappings are finalized in
" dispatch.vim.
let g:nremap = {
      \   "`": "d",
      \   "'": "=",
      \ }

nmap =c :Console<CR>

augroup Dispatch
  autocmd!
  autocmd BufReadPost *
        \ if getline(1) =~# "^#!" |
        \   let b:dispatch = getline(1)[2:-1] . " %" |
        \   let b:start = b:dispatch |
        \ endif
augroup END
