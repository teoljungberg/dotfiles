function! s:Linter()
  if &filetype == "ruby" && filereadable(".rubocop.yml") |
    return "rubocop"
  elseif index(["sh", "bash", "dash", "ksh"], &filetype) >= 0
    return "shellcheck -f gcc"
  elseif &filetype == "elixir" && filereadable(".credo.exs") |
    return "mix credo suggest --format=flycheck"
  else
    return ""
  endif
endfunction

nmap <script> d= :<C-R>=
      \ len(<SID>Linter()) ?
      \ "Dispatch " . <SID>Linter() . " " . expand("%") :
      \ "Dispatch"<CR><CR>

" Use _d_ rather than _`_ until the final mappings are finalized in
" dispatch.vim.
let g:nremap = {
      \   "`": "d",
      \   "'": "=",
      \ }

augroup Dispatch
  autocmd!
  autocmd BufReadPost *
        \ if getline(1) =~# "^#!" |
        \   let b:dispatch = getline(1)[2:-1] . " %" |
        \   let b:start = b:dispatch |
        \ endif
augroup END
