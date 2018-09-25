set nocompatible

set autoread
set autowrite
set backspace=indent,eol,start
set backupskip=/tmp/*,/private/tmp/*
set cmdheight=2
set complete+=kspell
set complete-=i
set display=lastline
set guifont=IBM\ Plex\ Mono:h14
set hidden
set history=1000
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:+
set nobackup
set nofoldenable
set nojoinspaces
set noswapfile
set nowrap
set number
set numberwidth=5
set scrolloff=1
set shiftround
set shortmess=aoOtsT
set showcmd
set sidescrolloff=5
set smartindent
set splitright
set statusline=[%n]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set synmaxcol=200
set tags=.git/tags,tags
set textwidth=80
set ttimeout ttimeoutlen=50
set updatetime=1000
set wildmode=list:longest,list:full
syntax enable

" Enforce italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

if v:version > 703
  set nofileignorecase
  set nowildignorecase
end

" When the type of shell script is /bin/sh, assume a POSIX-compatible shell for
" syntax highlighting purposes.
" More on why: https://github.com/thoughtbot/dotfiles/pull/471
let g:is_posix = 1

set mouse=nvi
if $TERM =~# "^xterm"
  if exists("+mouse")
    set ttymouse=xterm2
  endif
endif

filetype plugin indent on

if has("packages")
  packadd matchit
else
  runtime macros/matchit.vim
endif

silent! colorscheme solarized
set background=light

if !has("gui_running") && $TERM == "xterm"
  colorscheme default
endif

" automatically create undodir if it doesn't exist
set undodir=~/.cache/vim/undo//
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

cabbrev rg <c-r>=(getcmdtype()==":" && getcmdpos()==1 ? "gr" : "rg")<CR>

if executable("rg")
  set grepprg=rg\
        \ --hidden\
        \ --glob\ '!.git'\
        \ --glob\ '!tags'\
        \ --vimgrep\
        \ --with-filename
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif

" close current buffer
noremap <leader>d :bd<cr>

" convenience mappings
noremap Y y$
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" Record macro with `qq`, replay with `Q`
nnoremap Q @q

" close everything
function! s:CloseTerminalBuffers()
  if has("terminal")
    for term in term_list() | exec ":bd! " . term | endfor
  endif
endfunction
nnoremap <silent> <c-w>z :
      \ wincmd z<Bar>
      \ cclose<Bar>
      \ lclose<Bar>
      \ pclose<Bar>
      \ helpclose<Bar>
      \ silent call <SID>CloseTerminalBuffers()
      \ <CR>

" re-select the last pasted text
noremap gV V`]

" duplicate the visually selected block
vmap D y'>p

" open files in directory of current file
cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>s :split %%
map <leader>v :vsplit %%
map <leader>t :tabedit %%
map <leader>r :read %%

" In the following file `app/services/foo_bar.rb`, `%t` is expanded to
" `services/foo_bar`. Which useful for creating tests by i.e `:Vspec %t!` (which
" is expanded to `:Vspec services/foo_bar!`.
" This is only done for files under `app`.
cnoremap %t <C-R>=substitute(expand("%:r"), "^app[^/]*.", "", "")<CR>

" toggle between the two most recent files
noremap <leader><leader> :edit #<cr>

" Only have the current split and tab open
command! O :silent only<bar>silent tabonly

" open `:tag` in splits, and tabs
cabbrev vtag vertical stag
cabbrev vt   vertical stag
cabbrev ttag tab stag
cabbrev tt   tab stag

" open `:buffer` in splits, and tabs
cabbrev vbuffer vertical sbuffer
cabbrev vb      vertical sbuffer
cabbrev tbuffer tab sbuffer
cabbrev tb      tab sbuffer

" Given this situation:
"     user.fo|o!
" When I press <C-]> to go to the `foo!` tag, for some reason it acts as if the
" cursor is on `user` and goes to the `user` tag.
"
" To fix this, use `<cword>` to select the word under the cursor and go to it
" directly.
nnoremap <C-]>      :tag <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-W><C-]> :stag <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-W>]     :stag <C-R>=expand("<cword>")<CR><CR>

" Call `:ptag` the word under the cursor. Navigate between the matches with
" `:ptnext` or `:ptprevious`. Or using unimpaired.vim's `]<C-T>` and `[<C-T>`.
nnoremap g<C-T> :ptag <C-R>=expand("<cword>")<CR><CR>

" Get the current line number
cnoremap <C-R><C-L> <C-R>=line(".")<CR>

" Add the current `WORD` (rather than `word`) under the cursor
cnoremap <C-R>W <C-R><C-A>

" emacs movement
" stolen from tpope/vim-rsi
inoremap <expr> <c-e> col('.')>strlen(getline('.'))?"\<lt>c-e>":"\<lt>end>"
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

" system clipboard integration
nnoremap gy "*y
nnoremap gY "*y$
nnoremap gp "*p
nnoremap gP "*P

vnoremap gy "*y
vnoremap gp "*p
vnoremap gP "*P

nnoremap <silent> <C-L>
      \ :nohlsearch <C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-L>

function! IsQuickfixOpen()
  let l:result = filter(
        \   getwininfo(),
        \   "v:val.quickfix && !v:val.loclist",
        \ )

  return !empty(l:result)
endfunction

nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap yoq :<C-R>=IsQuickfixOpen() ? "cclose" : "copen"<CR><CR>

nnoremap [ot :setlocal cc=<C-R>=&textwidth + 1<CR><CR>
nnoremap ]ot :setlocal cc=0<CR>
nnoremap yot :setlocal cc=<C-R>=&cc == 0 ? &textwidth + 1 : 0<CR><CR>

function! s:ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call <SID>ExecuteMacroOverVisualRange()<CR>

" Jumps to the last known position in a file, except in the filetypes that are
" blacklisted.
augroup JumpToLastKnownPosition
  autocmd!
  autocmd BufReadPost *
        \ if (
        \   index(["gitcommit", "gitrebase"], &ft) < 0
        \ ) && (
        \   line("'\"") > 0 && line("'\"") <= line("$")
        \ ) |
        \   exe "normal g`\"" |
        \ endif
augroup END

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

" Only run linters listed in `g:ale_linters`.
let g:ale_linters_explicit = 1

let g:ale_linters = {}
let g:ale_linters.elixir = ["credo"]
let g:ale_linters.javascript = ["eslint"]
let g:ale_linters.ruby = ["rubocop"]
let g:ale_linters.sh = ["shellcheck"]
let g:ale_linters.vim = ["vint"]

" Only run fixers listed in `g:ale_fixers`.
let g:ale_fixers_explicit = 1

let g:ale_fixers = {}
let g:ale_fixers.elixir = ["mix_format"]
let g:ale_fixers.javascript = ["eslint"]
let g:ale_fixers.ruby = ["rubocop"]
let g:ale_fixers.rust = ["rustfmt"]

nnoremap `=<CR> :ALEFix<CR>
nnoremap `== :ALELint<CR>

function! s:ColorschemeChanges()
  if !empty(get(g:, "colors_name")) && g:colors_name != "solarized"
    return
  endif

  hi! Comment term=italic cterm=italic gui=italic
  hi! Constant term=italic cterm=italic gui=italic
  hi! PmenuSBar term=reverse cterm=reverse ctermfg=11 ctermbg=15 guibg=Black
  hi! PmenuThumb term=reverse cterm=reverse ctermfg=0 ctermbg=11 guibg=Grey

  hi! link rubyAssertion rubyFunction
  hi! link rubyCapitalizedMethod rubyConstant
  hi! link rubyTestMacro rubyFunction
  hi! link rubyTesthelper rubyFunction

  hi! MatchParen cterm=bold ctermbg=none ctermfg=33

  if &background == "light"
    hi! StatusLineNC
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=7
          \ ctermbg=14
          \ gui=reverse
          \ guifg=#839496
          \ guibg=#eee8d5
    hi! StatusLineTerm
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=10
          \ ctermbg=7
          \ gui=reverse
          \ guifg=#586e75
          \ guibg=#eee8d5
    hi! StatusLineTermNC
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=7
          \ ctermbg=14
          \ gui=reverse
          \ guifg=#839496
          \ guibg=#eee8d5
  else
    hi! StatusLineNC
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=10
          \ ctermbg=14
          \ gui=reverse
          \ guifg=#657b83
          \ guibg=#073642
    hi! StatusLineTerm
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=14
          \ ctermbg=0
          \ gui=reverse
          \ guifg=#93a1a1
          \ guibg=#073642
    hi! StatusLineTermNC
          \ term=reverse
          \ cterm=reverse
          \ ctermfg=10
          \ ctermbg=14
          \ gui=reverse
          \ guifg=#657b83
          \ guibg=#073642
  endif
endfunction

function! s:CustomRubySyntax()

endfunction

augroup Colorscheme
  autocmd!

  autocmd VimEnter * call <SID>ColorschemeChanges()
  " Run these settings whenever colorscheme changes, in order to re-overwrite
  " whatever the colorscheme sets
  autocmd ColorScheme * call <SID>ColorschemeChanges()
augroup END

" dispatch.vim
" ------------
nnoremap 'c :Console<CR>

let g:dispatch_compilers = {
      \   "rubocop": "gcc",
      \ }

augroup Dispatch
  autocmd!

  autocmd BufReadPost *
        \ if getline(1) =~# "^#!" |
        \   let b:dispatch = getline(1)[2:-1] . " %" |
        \   let b:start = b:dispatch |
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
augroup Fugitive
  autocmd!

  autocmd FileType git setlocal nolist
  autocmd FileType gitcommit let b:sleuth_automatic = 0
  autocmd FileType gitcommit setlocal
        \ shiftwidth=2
        \ nolist
        \ spell
augroup END

" pick.vim
" --------
if executable("pick")
  let g:pick_height = 15

  if ! has("gui_running")
    nnoremap <space><space> :call PickFile()<cr>
    nnoremap <space>s :call PickFileSplit()<cr>
    nnoremap <space>v :call PickFileVerticalSplit()<cr>
    nnoremap <space>b :call PickBuffer()<cr>
    nnoremap <space>] :call PickTag()<cr>
    nnoremap <space>\ :call PickSplitTag()<cr>
    nnoremap <space>t :call PickFileTab()<cr>
  endif
endif

" projectionist.vim
" -----------------
let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb"
      \   },
      \   "spec/features/*_spec.rb": { "command": "feature" },
      \   "app/services/*.rb": {
      \     "command": "service",
      \     "test": [
      \       "spec/services/%s_spec.rb",
      \       "test/services/%s_test.rb"
      \     ]
      \   },
      \   "app/queries/*_query.rb": {
      \     "command": "query",
      \     "test": [
      \       "spec/queries/%s_spec.rb",
      \       "test/queries/%s_test.rb"
      \     ]
      \   },
      \   "app/graphql/*.rb": {
      \     "command": "graphql",
      \     "test": [
      \       "spec/graphql/%s_spec.rb",
      \       "test/graphql/%s_test.rb"
      \     ],
      \   },
      \   "config/routes.rb": {
      \     "command": "routes",
      \   },
      \ }

let g:projectionist_heuristics = {
      \  "&mix.exs": {
      \    "lib/*.ex": {
      \      "type": "lib",
      \      "alternate": [
      \        "spec/{}_spec.exs",
      \        "test/{}_test.exs",
      \      ],
      \    },
      \    "spec/*_spec.exs": {
      \      "type": "spec",
      \      "alternate": "lib/{}.ex",
      \      "dispatch": "mix espec {file}`=v:lnum ? ':'.v:lnum : ''`"
      \    },
      \    "spec/spec_helper.exs": { "type": "spec" },
      \    "test/*_test.exs": {
      \      "type": "test",
      \      "alternate": "lib/{}.ex",
      \      "dispatch": "mix test {file}`=v:lnum ? ':'.v:lnum : ''`"
      \    },
      \    "test/test_helper.exs": { "type": "test" },
      \    "mix.exs": {
      \      "type": "lib",
      \      "alternate": "mix.lock",
      \      "dispatch": "mix deps.get"
      \    },
      \    "mix.lock": { "alternate": "mix.exs" },
      \    "*": {
      \      "make": "mix",
      \      "console": "iex -S mix"
      \    }
      \  },
      \  "&Cargo.toml": {
      \    "src/*.rs": {
      \      "type": "src",
      \      "dispatch": "cargo test {basename}::tests"
      \    },
      \    "src/main.rs": {
      \      "type": "src",
      \      "dispatch": "cargo test"
      \    },
      \    "Cargo.toml": {
      \      "type": "cargo",
      \      "alternate": "Cargo.lock",
      \      "dispatch": "cargo check"
      \    },
      \    "Cargo.lock": {
      \      "alternate": "Cargo.toml",
      \      "dispatch": "cargo check"
      \    },
      \    "*": { "make": "cargo" }
      \  }
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
" mm   => Place a mark `m` under the cursor
" i    => Enter insert mode
" \015 => <CR>
" \003 => <ESC>
" `m   => Jump back to the mark `m`.
nnoremap <silent> r<CR> :<C-U>call <SID>try("SplitjoinSplit", "mmi\015\003`m")<CR>

" surround.vim
" ------------
let g:surround_{char2nr("#")} = "#{\r}"
let g:surround_{char2nr("s")} = " \r"
let g:surround_{char2nr("S")} = "\r "

" vinegar.vim
" -----------
nnoremap - -
let g:netrw_localrmdir = "rm -rf"

" markdown
" -------
let g:markdown_fenced_languages = [
      \ "ruby",
      \ "html",
      \ "javascript",
      \ "css",
      \ "erb=eruby.html",
      \ "bash=sh",
      \ "sh",
      \ ]

" rust
" ----
let g:ftplugin_rust_source_path =
      \ "$(rustc --print sysroot)/lib/rustlib/src/rust/src"
let g:racer_cmd = "$HOME/.cargo/bin/racer"

function! s:MarkdownMappings()
  nnoremap <buffer> <expr> k (v:count == 0 ? "gk" : "k")
  nnoremap <buffer> <expr> j (v:count == 0 ? "gj" : "j")
  nnoremap <buffer>        $ g$
  nnoremap <buffer>        0 g0
  nnoremap <buffer>        ^ g^
endfunction

function! s:QuickfixMappings()
  let is_location_list = getwininfo(win_getid())[0].loclist

  if is_location_list
    nnoremap <buffer> [f :lolder<CR>
    nnoremap <buffer> ]f :lnewer<CR>
    nnoremap <buffer> [F :<C-R>=getloclist("$", {"nr": "$"}).nr - 1<CR>lolder<CR>
    nnoremap <buffer> ]F :<C-R>=getloclist("$", {"nr": "$"}).nr - 1<CR>lnewer<CR>
  else
    nnoremap <buffer> [f :colder<CR>
    nnoremap <buffer> ]f :cnewer<CR>
    nnoremap <buffer> [F :<C-R>=getqflist({"nr": "$"}).nr - 1<CR>colder<CR>
    nnoremap <buffer> ]F :<C-R>=getqflist({"nr": "$"}).nr - 1<CR>cnewer<CR>
  endif
endfunction

function! s:CustomRubySyntax()
  if expand("%") =~# "_spec\.rb$"
    syn match rubyTestHelper "\<subject\>"
    syn match rubyTestMacro "\<let\>!\="
    syn keyword rubyTestMacro after around before
    syn keyword rubyTestMacro
          \ context
          \ describe
          \ feature
          \ containedin=rubyKeywordAsMethod
    syn keyword rubyTestMacro it it_behaves_like
    syn keyword rubyComment
          \ xcontext
          \ xdescribe
          \ xfeature
          \ containedin=rubyKeywordAsMethod
    syn keyword rubyComment xit
    syn keyword rubyAssertion
          \ allow
          \ expect
          \ is_expected
          \ skip
    syn keyword rubyTestHelper
          \ class_double
          \ described_class
          \ double
          \ instance_double
          \ instance_spy
          \ spy
  endif
endfunction

augroup ft_options
  autocmd!

  autocmd FileType bash setlocal iskeyword+=-
  autocmd FileType c setlocal
        \ noexpandtab
        \ shiftwidth=8
        \ tabstop=8
        \ cinoptions=:0,t0,+4,(4
  autocmd FileType elixir iabbrev <buffer> ddebug require IEx; IEx.pry
  autocmd FileType markdown iabbrev <buffer> -. - [ ]
  autocmd FileType markdown iabbrev <buffer> -x - [X]
  autocmd FileType markdown setlocal
        \ spell
        \ textwidth=80
        \ shiftwidth=4
        \ expandtab
        \ wrap
        \ nolist
        \ linebreak
  autocmd FileType markdown call <SID>MarkdownMappings()
  autocmd FileType qf setlocal
        \ nolist
        \ nonumber
        \ norelativenumber
  autocmd FileType qf call <SID>QuickfixMappings()
  autocmd FileType ruby call <SID>CustomRubySyntax()
  autocmd FileType ruby setlocal iskeyword+=?,!,=
  autocmd FileType ruby iabbrev <buffer> dinit def initialize
  autocmd FileType ruby iabbrev <buffer> ddebug require 'irb'; binding.irb
  autocmd FileType ruby let b:start = "irb -r '%:p'"
  autocmd FileType ruby
        \ if expand("%") =~# "_test\.rb$" |
        \   let b:dispatch = "ruby -Itest %" |
        \ elseif expand("%") =~# "_spec\.rb$" |
        \   let b:dispatch = "rspec %" |
        \ elseif !exists("b:dispatch") |
        \   let b:dispatch = "ruby -wc %" |
        \ endif
  autocmd FileType rust setlocal iskeyword+=!
  autocmd FileType rust nnoremap <buffer> K <Plug>(rust-doc)
  autocmd FileType rust nnoremap <buffer> gd <Plug>(rust-def)
augroup END

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

if filereadable(".git/safe/../../.vimrc.local")
  source .vimrc.local
endif
