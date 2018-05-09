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

nmap <script> =<CR>    :<C-R>=exists(":Start") > 1 ? "Start" : "shell"<CR><CR>
nmap <script> =<Space> :<C-R>=exists(":Start") > 1 ? "Start " : "!"<CR>
nmap <script> =!       :<C-R>=exists(":Start") > 1 ? "Start!" : "!"<CR>
nmap <script> =s       :<C-R>=exists(":Server") > 1 ? "Server" : "Start"<CR><CR>
nmap <script> =c       :<C-R>=exists(":Console") > 1 ? "Console" : "Start"<CR><CR>

nmap <script> <SID>:   :<C-R>=getcmdline() =~ "," ? "\0250" : ""<CR>
nmap <script> d<BS>    <SID>:Focus

nmap <script> `<CR>    <SID>:<C-R>=
      \ len(<SID>Linter()) ?
      \ "Dispatch " . <SID>Linter() . " " . expand("%") :
      \ "Dispatch"<CR><CR>

augroup Dispatch
  autocmd!
  autocmd BufReadPost *
        \ if getline(1) =~# "^#!" |
        \   let b:dispatch = getline(1)[2:-1] . " %" |
        \   let b:start = b:dispatch |
        \ endif
augroup END
