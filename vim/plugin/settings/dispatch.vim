nmap <script> <SID>:    :<C-R>=getcmdline() =~ "," ? "\0250" : ""<CR>
nmap <script> d<CR>     <SID>:Dispatch<CR>
nmap <script> d<Space>  <SID>:Dispatch<Space>
nmap <script> d!        <SID>:Dispatch!
nmap <script> d<BS>     <SID>:Focus

nmap <script> =<CR>     :<C-R>=exists(":Start") > 1 ? "Start" : "shell"<CR><CR>
nmap <script> =<Space>  :<C-R>=exists(":Start") > 1 ? "Start " : "!"<CR>
nmap <script> =!        :<C-R>=exists(":Start") > 1 ? "Start!" : "!"<CR>
nmap <script> =c        :<C-R>=exists(":Console") > 1 ? "Console" : "Start"<CR><CR>

augroup Dispatch
  autocmd!
  autocmd BufReadPost *
        \ if getline(1) =~# "^#!" |
        \   let b:dispatch = getline(1)[2:-1] . " %" |
        \   let b:start = b:dispatch |
        \ endif
  autocmd BufReadPost *
        \ if &filetype == "ruby" && filereadable(".rubocop.yml") |
        \   compiler rubocop |
        \ endif
  autocmd BufReadPost *
        \ if index(["bash", "sh"], &filetype) >= 0 |
        \   compiler shellcheck |
        \ endif
augroup END
