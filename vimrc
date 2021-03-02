set autoread
set autowrite
set backspace=indent,eol,start
set backupskip=/tmp/*,/private/tmp/*
set cmdheight=2
set commentstring=#\ %s
set complete+=kspell
set complete-=i
set display=lastline
set encoding=utf-8
set guifont=IBM\ Plex\ Mono:h14
set hidden
set history=200
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set mouse=nvi
set nofoldenable
set nojoinspaces
set nowrap
set number
set numberwidth=5
set path=.,,
set scrolloff=1
set shiftround
set shortmess=aoOtsT
set showcmd
set sidescrolloff=5
set smartcase
set splitright
set statusline=[%n]\ %<%f\ %h%m%r%w%=%-14.(%l,%c%V%)\ %P
set synmaxcol=200
set t_RV=
set tags^=./.git/tags;tags
set textwidth=80
set ttimeout
set ttimeoutlen=50
set viminfo=!,'20,<50,s10,h
set wildmode=list,full
syntax enable

" Enforce italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Set different cursors for insert, replace, and normal mode.
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" When the type of shell script is /bin/sh, assume a POSIX-compatible shell for
" syntax highlighting purposes.
" More on why: https://github.com/thoughtbot/dotfiles/pull/471
let g:is_posix = 1

if $TERM =~# "^xterm"
  if exists("+mouse")
    set ttymouse=xterm2
  endif
endif

if exists("+breakindent")
  set breakindent
  set showbreak=\ +
endif

if exists("+undofile")
  set undodir=~/.cache/vim/undo//
  set undofile

  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
endif

filetype plugin indent on

if !has("packages")
  set runtimepath^=~/.vim/pack/*/start/*
        \ runtimepath+=~/.vim/pack/*/start/*/after
endif

if has("packages")
  packadd matchit
else
  runtime macros/matchit.vim
endif

silent! colorscheme whitescale
if $THEME ==# "light"
  set background=light
elseif $THEME ==# "dark"
  set background=dark
else
  set background=light
end

if executable("rg")
  set grepprg=rg\
        \ --hidden\
        \ --glob\ '!.git'\
        \ --glob\ '!tags'\
        \ --vimgrep\
        \ --with-filename
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH\ $*\ /dev/null
endif

" For easy `:lgrep` and `:grep`.
nnoremap gl<Space> :lgrep<Space>
nnoremap gr<Space> :grep<Space>

" Close current buffer
noremap <Leader>d :bdelete<CR>

" Yank to the end of the line, for consistency with `C` and `D`.
noremap Y y$

" Move Up and Down with `<C-P>` and `<C-N>` in command mode, for consitency with
" `<C-P>` and `<C-N>` in normal mode.
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Record macro with `qq`, replay with `Q`
nnoremap Q @q

" Close everything
nnoremap <silent> <C-W>z
      \ :wincmd z<Bar>cclose<Bar>lclose<Bar>pclose<Bar>helpclose<Bar><CR>

" Re-select the last pasted text
noremap gV V`]

" Duplicate the visually selected block
vmap D y'>p

" open files in directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <Leader>e :edit %%
map <Leader>s :split %%
map <Leader>v :vsplit %%
map <Leader>t :tabedit %%
map <Leader>r :read %%
map <Leader>w :write %%

" In the following file `app/services/foo_bar.rb`, `%t` is expanded to
" `services/foo_bar`. Which useful for creating tests by i.e `:Vspec %t!` (which
" is expanded to `:Vspec services/foo_bar!`.
" This is only done for files under `app`.
cnoremap %t <C-R>=substitute(expand("%:r"), "^app[^/]*.", "", "")<CR>

" Only have the current split and tab open
command! O :silent only<Bar>silent tabonly

function! s:ExpandWhenStartOfCmdLine(command, expanded_command)
  if getcmdtype() ==# ":" && getcmdpos() == 1
    return a:expanded_command
  else
    return a:command
  endif
endfunction

" Open `:tag` in splits, and tabs
cabbrev vtag <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("vtag", "vertical stag")<CR>
cabbrev vt <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("vt", "vertical stag")<CR>
cabbrev ttag <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("ttag", "tab stag")<CR>
cabbrev tt <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("tt", "tab stag")<CR>

" Open `:buffer` in splits, and tabs
cabbrev vbuffer <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("vbuffer", "vertical sbuffer")<CR>
cabbrev vb <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("vb", "vertical sbuffer")<CR>
cabbrev tbuffer <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("tbuffer", "tab sbuffer")<CR>
cabbrev tb <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("tb", "tab sbuffer")<CR>

" Open `:find` in splits, and tabs
cabbrev vfind <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("vfind", "vertical sfind")<CR>
cabbrev vf <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("vf", "vertical sfind")<CR>
cabbrev tfind <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("tfind", "tab sfind")<CR>
cabbrev tf <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("tf", "tab sfind")<CR>

" Correct `:rg` to `:grep`
cabbrev rg <C-R>=
      \ <SID>ExpandWhenStartOfCmdLine("rg", "grep")<CR>

" Given this situation:
"     user.fo|o!
" When I press <C-]> to go to the `foo!` tag, for some reason it acts as if the
" cursor is on `user` and goes to the `user` tag.
"
" To fix this, use `<cword>` to select the word under the cursor and go to it
" directly.
nnoremap <C-]> :tag <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-W><C-]> :stag <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-W>] :stag <C-R>=expand("<cword>")<CR><CR>

" Call `:ptag` the word under the cursor. Navigate between the matches with
" `:ptnext` or `:ptprevious`. Or using unimpaired.vim's `]<C-T>` and `[<C-T>`.
nnoremap g<C-T> :ptag <C-R>=expand("<cword>")<CR><CR>

" Get the current line
cnoremap <C-R><C-L> <C-R>=substitute(getline("."), '^\s*', "", "")<CR>

" Add the current `WORD` (rather than `word`) under the cursor
cnoremap <C-R>W <C-R><C-A>

" Emacs movement
" Stolen from tpope/vim-rsi
inoremap <expr> <C-E> col(".") > strlen(getline(".")) ? "<C-E>" : "<End>"
inoremap <C-A> <Esc>I
cnoremap <C-A> <Home>

" System clipboard integration
nnoremap gy "*y
nnoremap gY "*y$
nnoremap gp "*p
nnoremap gP "*P

vnoremap gy "*y
vnoremap gp "*p
vnoremap gP "*P

nnoremap <silent> <C-L>
      \ :nohlsearch <C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-L>

nnoremap [ot :setlocal colorcolumn=<C-R>=&textwidth + 1<CR><CR>
nnoremap ]ot :setlocal colorcolumn=0<CR>
nnoremap yot :setlocal colorcolumn=<C-R>=&cc == 0 ? &textwidth + 1 : 0<CR><CR>

nnoremap <silent> <C-w>.
      \ :if exists("b:git_dir")<Bar>
      \   execute "Glcd"<Bar>
      \ elseif exists(":Plcd")<Bar>
      \   execute "Plcd"<Bar>
      \ else<Bar>
      \   lcd %:h<Bar>
      \ endif<Bar>
      \ <CR>
nmap cd <C-W>.

nnoremap <Space>b :ls<CR>:buffer<Space>

augroup vimrcEx
  autocmd!

  autocmd GUIEnter * set
        \ title
        \ icon
        \ lines=45
        \ columns=86
        \ guioptions-=T
        \ guioptions-=m
        \ guioptions-=e
        \ guioptions-=r
        \ guioptions-=L
        \ visualbell
        \ t_vb=
  autocmd FileType *
        \ if exists("+completefunc") && &completefunc == "" |
        \   setlocal completefunc=syntaxcomplete#Complete |
        \ endif
  autocmd FileType *
        \ if exists("+omnifunc") && &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup END

if exists("##OSAppearanceChanged")
  augroup FollowOSAppearance
    autocmd!

    autocmd OSAppearanceChanged *
          \ if v:os_appearance == 1 |
          \   set background=dark |
          \ else |
          \   set background=light |
          \ endif
  augroup END
endif

" ale.vim
" -------
" I prefer invoking `ALELint` at my leisure rather than having it run
" automatically when a file is saved, changed, or touched.
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_filetype_changed = 0

" Disable the gutter by not allowing any signs.
let g:ale_set_signs = 0
" Open the location list when `:ALELint` produces any errors.
let g:ale_open_list = 1

let g:ale_markdown_mdl_executable = "bin/mdl"
let g:ale_nix_nixpkgsfmt_executable = "nixfmt"
let g:ale_ruby_rubocop_executable = "bin/rubocop"
let g:ale_sql_pgformatter_options = "--spaces 2"

" Only run linters listed in `g:ale_linters`.
let g:ale_linters_explicit = 1

let g:ale_linters = {}
let g:ale_linters.javascript = ["eslint"]
let g:ale_linters.markdown = ["mdl"]
let g:ale_linters.nix = ["nixpkgs-fmt"]
let g:ale_linters.ruby = ["rubocop"]
let g:ale_linters.sh = ["shellcheck"]
let g:ale_linters.vim = ["vint"]

" Only run fixers listed in `g:ale_fixers`.
let g:ale_fixers_explicit = 1

let g:ale_fixers = { "*": ["trim_whitespace"] }
let g:ale_fixers.javascript = ["eslint"]
let g:ale_fixers.json = ["jq"]
let g:ale_fixers.ruby = ["rubocop"]
let g:ale_fixers.nix = ["nixpkgs-fmt"]
let g:ale_fixers.sql = ["pgformatter"]

nmap `=<CR> <Plug>(ale_fix)
nmap `== <Plug>(ale_lint)

" dispatch.vim
" ------------
nnoremap 'c :Console<CR>

augroup Dispatch
  autocmd!

  autocmd BufReadPost *
        \ if getline(1) =~# "^#!" |
        \   let b:dispatch =
        \       matchstr(getline(1), '#!\%(/usr/bin/env \+\)\=\zs.*') . " %" |
        \   let b:start = "-wait=always " . b:dispatch |
        \ endif
  autocmd BufReadPost *.nix
        \ let b:dispatch = "nix-build --check % --out-link /tmp/%:t:r" |
  autocmd BufReadPost */darwin-configuration.nix
        \ let b:dispatch = "darwin-rebuild check" |
        \ let b:start = "-wait=always darwin-rebuild switch"
  autocmd BufReadPost */home.nix
        \ let b:dispatch = "home-manager -n switch" |
        \ let b:start = "-wait=always home-manager switch"
  autocmd FileType ruby let b:start = "irb -r '%:p'"
  autocmd FileType ruby
        \ if expand("%") =~# "_test\.rb$" |
        \   let b:dispatch = "ruby -Itest %" |
        \ elseif expand("%") =~# "_spec\.rb$" |
        \   let b:dispatch = get(
        \     b:,
        \     "dispatch",
        \     "rspec %`=v:lnum ? ':'.v:lnum : ''`",
        \   ) |
        \ elseif !exists("b:dispatch") |
        \   let b:dispatch = "ruby -wc %" |
        \ endif
  autocmd VimEnter *
        \ if empty($TMUX) || has("gui_running") |
        \   let g:dispatch_experimental = 1 |
        \ else |
        \   let g:dispatch_experimental = 0 |
        \ end
augroup END

" fugitive.vim
" ------------
nmap <script> <SID>:. :<C-R>=getcmdline() =~ "," ? "\0250" : ""<CR>
nmap g<CR> <SID>:.Git<CR>
nmap g<Space> <SID>:.Git<Space>
vnoremap g<Space> :Git<Space>

augroup Fugitive
  autocmd!

  autocmd User FugitiveIndex
        \ nnoremap <buffer> rM :Git rebase --interactive origin/master<CR>
  autocmd User Fugitive
        \ nnoremap <buffer> q <Nop>
  autocmd BufReadPost *.git/PULLREQ_EDITMSG set filetype=gitcommit
  autocmd FileType git setlocal nolist
  autocmd FileType gitcommit let b:sleuth_automatic = 0
  autocmd FileType gitcommit setlocal
        \ shiftwidth=2
        \ nolist
        \ spell
augroup END

" fzf.vim
" --------
if executable("fzf")
  set runtimepath+=$HOME/.nix-profile/share/vim-plugins/fzf/

  nnoremap <Space><Space> :FZF<CR>
  nnoremap <Space>] :FZFTags<CR>
else
  nnoremap <Space><Space> :find<Space>
  nnoremap <Space>] :tjump /
endif

let g:fzf_command_prefix = "FZF"
let g:fzf_action = {
      \   "ctrl-s": "split",
      \   "ctrl-t": "tab split",
      \   "ctrl-v": "vsplit",
      \ }
let g:fzf_layout = { "down": "40%" }
let g:fzf_preview_window = ""

augroup FZF
  autocmd!

  autocmd FileType help
        \ if executable("fzf") |
        \   nnoremap <buffer> <Space>] :FZFHelptags<CR> |
        \ else |
        \   nnoremap <buffer> <Space>] :tag<Space> |
        \ endif
  autocmd FileType fzf
        \ set laststatus=0 noshowmode noruler
        \ |
        \ autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" projectionist.vim
" -----------------
let g:rails_projections =
      \ {
      \   "app/controllers/*_controller.rb": {
      \     "test": [
      \       "spec/requests/{}_spec.rb",
      \       "spec/controllers/{}_controller_spec.rb",
      \       "test/controllers/{}_controller_test.rb"
      \     ],
      \     "alternate": [
      \       "spec/requests/{}_spec.rb",
      \       "spec/controllers/{}_controller_spec.rb",
      \       "test/controllers/{}_controller_test.rb"
      \     ],
      \   },
      \   "app/services/*.rb": {
      \     "command": "service",
      \     "test": [
      \       "spec/services/%s_spec.rb",
      \       "test/services/%s_test.rb"
      \     ],
      \   },
      \   "app/graphql/*.rb": {
      \     "command": "graphql",
      \     "test": [
      \       "spec/graphql/{}_spec.rb",
      \       "test/graphql/{}_test.rb"
      \     ],
      \   },
      \   "config/routes.rb": { "command": "routes" },
      \   "spec/*_spec.rb": {
      \     "dispatch": "bin/rspec spec/{}_spec.rb`=v:lnum ? ':'.v:lnum : ''`",
      \   },
      \   "spec/requests/*_spec.rb": {
      \     "command": "request",
      \     "alternate": "app/controllers/{}_controller.rb"
      \   },
      \   "spec/factories/*.rb": {
      \     "command": "factory",
      \     "related": [
      \       "app/models/{singular}.rb"
      \     ],
      \   },
      \ }

let g:projectionist_heuristics =
      \ {
      \   ".git\/": {
      \     "TODO.md": { "command": "todo" },
      \   },
      \ }

" splitjoin.vim
" -------------
let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_options_as_arguments = 1

function! s:try(cmd, default)
  if exists(":" . a:cmd) && !v:count
    let tick = b:changedtick
    execute a:cmd
    if tick == b:changedtick
      execute "normal! ". a:default
    endif
  else
    execute "normal! ". v:count . a:default
  endif
endfunction

nnoremap <silent> gJ :<C-U>call <SID>try("SplitjoinJoin", "gJ")<CR>
nnoremap <silent> J :<C-U>call <SID>try("SplitjoinJoin", "J")<CR>
nnoremap <silent> gS :<C-U>call <SID>try("SplitjoinSplit", "S")<CR>
nnoremap <silent> S :<C-U>call <SID>try("SplitjoinSplit", "S")<CR>
" r    => Enter replace mode
" \015 => <CR>
nnoremap <silent> r<CR> :<C-U>call <SID>try("SplitjoinSplit", "r\015")<CR>

" surround.vim
" ------------
let g:surround_{char2nr("#")} = "#{\r}"
let g:surround_{char2nr("s")} = " \r"
let g:surround_{char2nr("S")} = "\r "

" vinegar.vim
" -----------
if exists("<Plug>VinegarUp")
  nnoremap <silent> <Plug>Up <Plug>VinegarUp
else
  nnoremap <silent> <Plug>Up :Explore<CR>
endif
nmap <expr> - line(".") == 1 ? "<Plug>Up" : "-"

" ruby
" ----
let g:ruby_indent_block_style = "do"

function! s:QuickfixMappings()
  if getwininfo(win_getid())[0].loclist
    nnoremap <buffer> [f :lolder<CR>
    nnoremap <buffer> ]f :lnewer<CR>
    nnoremap <buffer> [F :
          \ <C-R>=getloclist("$", {"nr": "$"}).nr - 1<CR>lolder<CR>
    nnoremap <buffer> ]F :
          \ <C-R>=getloclist("$", {"nr": "$"}).nr - 1<CR>lnewer<CR>
  else
    nnoremap <buffer> [f :colder<CR>
    nnoremap <buffer> ]f :cnewer<CR>
    nnoremap <buffer> [F :<C-R>=getqflist({"nr": "$"}).nr - 1<CR>colder<CR>
    nnoremap <buffer> ]F :<C-R>=getqflist({"nr": "$"}).nr - 1<CR>cnewer<CR>
  endif
endfunction

function! s:QuickfixTitle()
  let title = get(w:, "quickfix_title", "")

  if title =~# "^:" . &grepprg || title =~# "^:grep"
    let w:quickfix_title = substitute(title, &grepprg, "grep", "")
  endif
endfunction

augroup HideNewBuffers
  autocmd!

  autocmd BufNew setlocal nobuflisted
augroup END

augroup CursorlineForPreviewWindows
  autocmd!

  autocmd BufWinEnter * if &previewwindow | setlocal cursorline | endif
augroup END

nmap [I :ilist /<C-R>=expand("<cword>")<CR><CR>
nmap ]I :ilist /<C-R>=expand("<cword>")<CR><CR>
nmap [D :dlist /<C-R>=expand("<cword>")<CR><CR>
nmap ]D :dlist /<C-R>=expand("<cword>")<CR><CR>

nnoremap <expr> j v:count ? "j" : "gj"
nnoremap <expr> k v:count ? "k" : "gk"

" Make list-like commands more intuitive.
" Originally from:
"
" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
function! s:CCR()
  if getcmdtype() !=# ":"
    return "\<CR>"
  end
  let cmdline = getcmdline()
  let filter_stub = '\v\C^((filt|filte|filter) .+ )*'
  command! -bar Z silent set more|delcommand Z

  if cmdline =~# filter_stub . '(ls|files|buffers)'
    return "\<CR>:buffer "
  elseif cmdline =~# '\v\C^(g|global).*(#|nu|num|numb|numbe|number)$'
    return "\<CR>:"
  elseif cmdline =~# filter_stub . '(old|oldfiles)'
    set nomore
    return "\<CR>:Z|edit #<"
  elseif cmdline =~# '\C^changes'
    set nomore
    return "\<CR>:Z|normal! g;\<S-Left>"
  elseif cmdline =~# filter_stub . '(ju|jumps)'
    set nomore
    return "\<CR>:Z|normal! \<C-O>\<S-Left>"
  elseif cmdline =~# filter_stub . 'marks'
    return "\<CR>:normal! `"
  elseif cmdline =~# '\v\C^(undol|undolist)'
    return "\<CR>:undo "
  elseif cmdline =~# filter_stub . '(cli|clist|lli|llist)'
    return
          \ "\<CR>" .
          \ ":silent " .
          \ repeat(matchlist(cmdline, '\v(cli|clist|lli|llist)')[0][0], 2) .
          \ "\<Space>"
    elseif cmdline =~# '\v\C^(dli|dlist|il|ilist)\s.*'
      return
            \ "\<CR>:" .
            \ cmdline[0] .
            \ "jump  " . split(cmdline, " ")[1] .
            \ "\<S-Left>\<Left>"
  else
    return "\<CR>"
  endif
endfunction

cnoremap <script> <expr> <CR> <SID>CCR()

augroup ReleaseSwapfiles
  autocmd!

  autocmd BufWritePost,BufReadPost,BufLeave *
        \ if isdirectory(expand("<amatch>:h")) |
        \   let &swapfile = &modified |
        \ endif
augroup END

augroup ft_options
  autocmd!

  autocmd FileType bash setlocal iskeyword+=-
  autocmd FileType c setlocal
        \ cinoptions=:0,t0,+4,(4
        \ noexpandtab
        \ shiftwidth=8
        \ tabstop=8
  autocmd FileType markdown,gitcommit iabbrev <buffer> -. - [ ]
  autocmd FileType markdown,gitcommit iabbrev <buffer> -x - [X]
  autocmd FileType markdown iabbrev <buffer> set_spelllang
        \ <!-- vim:set spelllang=TODO : -->
  autocmd FileType markdown setlocal
        \ expandtab
        \ linebreak
        \ shiftwidth=2
        \ spell
        \ wrap
  autocmd FileType qf setlocal
        \ nobuflisted
        \ nolist
        \ nonumber
        \ norelativenumber
  autocmd FileType qf call <SID>QuickfixMappings()
  autocmd FileType qf call <SID>QuickfixTitle()
  autocmd FileType ruby iabbrev <buffer> ddebug require 'irb'; binding.irb
  autocmd FileType ruby iabbrev <buffer> dinit def initialize
  autocmd FileType ruby setlocal iskeyword+=?,!,=
augroup END

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

if filereadable(".git/safe/../../.vimrc.local")
  source .vimrc.local
endif
