setglobal autoread
setglobal autowrite
setglobal backspace=indent,eol,start
setglobal backupskip=/tmp/*,/private/tmp/*
setglobal cmdheight=2
setglobal display=lastline
setglobal encoding=utf-8
setglobal guifont=JetBrains\ Mono:h14
setglobal history=200
setglobal incsearch
setglobal laststatus=2
setglobal lazyredraw
setglobal listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
setglobal modelines=0
setglobal mouse=nvi
setglobal nojoinspaces
setglobal nowrap
setglobal path=.,,
setglobal scrolloff=1
setglobal shiftround
setglobal showcmd
setglobal sidescrolloff=5
setglobal smartcase
setglobal statusline=[%n]\ %<%f\ %h%m%r%w%=%-14.(%l,%c%V%)\ %P
setglobal tags^=./.git/tags;tags
setglobal ttimeout
setglobal ttimeoutlen=50
setglobal viminfo=!,'20,<50,s10,h
setglobal wildmenu
setglobal wildmode=full
syntax enable

if has('+macmeta')
  setglobal macmeta
endif

if exists('+linebreak')
  setglobal showbreak=\ +
endif

if has('vim_starting')
  set commentstring=#\ %s
  set complete+=kspell
  set complete-=i
  set completefunc=syntaxcomplete#Complete
  set list
  set nofoldenable
  set nohidden
  set omnifunc=syntaxcomplete#Complete
  set synmaxcol=500

  if exists('+breakindent')
    set breakindent
  endif

  if exists('+undofile')
    set undofile
  endif
endif

" Set different cursors for insert, replace, and normal mode.
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" When the type of shell script is /bin/sh, assume a POSIX-compatible shell
" for syntax highlighting purposes.
" More on why: https://github.com/thoughtbot/dotfiles/pull/471
let g:is_posix = 1

if $TERM =~# '^xterm'
  if exists('+mouse') && !has('nvim')
    setglobal ttymouse=xterm2
  endif
endif

if exists('+undodir') && !has('nvim')
  let s:data_home = expand('~/.cache/vim/')

  let &undodir = s:data_home . 'undo//'
  let &directory = s:data_home . 'swap//'
  let &backupdir = s:data_home . 'backup//'

  if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif
  if !isdirectory(&directory) | call mkdir(&directory, 'p') | endif
  if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p') | endif
endif

if has('nvim') || !has('packages')
  setglobal runtimepath^=~/.vim/pack/*/start/*
  setglobal runtimepath+=~/.vim/pack/*/start/*/after
endif

if has('packages')
  packadd! cfilter
  packadd! matchit
else
  runtime macros/matchit.vim
endif

filetype plugin indent on

silent! colorscheme whitescale
if $THEME ==# 'light'
  set background=light
elseif $THEME ==# 'dark'
  set background=dark
else
  set background=light
end

setglobal grepformat=%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f\ \ %l%m
if executable('rg')
  setglobal grepprg=rg\
        \ --hidden\
        \ --glob\ '!.git'\
        \ --glob\ '!tags'\
        \ --vimgrep\
        \ --with-filename
else
  setglobal grepprg=grep\ -rnH\ --exclude-dir\ .git\ $*\ /dev/null
endif

" Close current buffer
noremap <Leader>d :bdelete<CR>

" Yank to the end of the line, for consistency with `C` and `D`.
noremap Y y$

" Move Up and Down with `<C-P>` and `<C-N>` in command mode, for consitency
" with `<C-P>` and `<C-N>` in normal mode.
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Record macro with `qq`, replay with `Q`
noremap Q @q

" Close everything
noremap <silent> <C-W>z
      \ :wincmd z<Bar>cclose<Bar>lclose<Bar>pclose<Bar>helpclose<Bar><CR>

" Re-select the last pasted text
noremap gV V`]

" Duplicate the visually selected block
vnoremap D y'>p

" open files in directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<CR>
nmap <Leader>e :edit %%
nmap <Leader>s :split %%
nmap <Leader>v :vsplit %%
nmap <Leader>t :tabedit %%
nmap <Leader>r :read %%
nmap <Leader>w :write %%

" In the following file `app/services/foo_bar.rb`, `%t` is expanded to
" `services/foo_bar`. Which useful for creating tests by i.e `:Vspec %t!`
" (which is expanded to `:Vspec services/foo_bar!`.
" This is only done for files under `app`.
cnoremap %t <C-R>=substitute(expand('%:r'), '^app[^/]*.', '', '')<CR>

" Only have the current split and tab open
command! O :silent only<Bar>silent tabonly

" Given this situation:
"     user.fo|o!
" When I press <C-]> to go to the `foo!` tag, for some reason it acts as if
" the cursor is on `user` and goes to the `user` tag.
"
" To fix this, use `<cword>` to select the word under the cursor and go to it
" directly.
noremap <C-]> :tag <C-R>=expand('<cword>')<CR><CR>
noremap <C-W><C-]> :stag <C-R>=expand('<cword>')<CR><CR>
noremap <C-W>] :stag <C-R>=expand('<cword>')<CR><CR>

" Call `:ptag` the word under the cursor. Navigate between the matches with
" `:ptnext` or `:ptprevious`. Or using unimpaired.vim's `]<C-T>` and `[<C-T>`.
noremap g<C-T> :ptag <C-R>=expand('<cword>')<CR><CR>

" Get the current line
cnoremap <C-R><C-L> <C-R>=substitute(getline('.'), '^\s*', '', '')<CR>

" Add the current `WORD` (rather than `word`) under the cursor
cnoremap <C-R>W <C-R><C-A>

" Emacs movement
" Originally from: https://github.com/tpope/vim-rsi
inoremap <expr> <C-E> col(".") > strlen(getline(".")) ? "<C-E>" : "<End>"
inoremap <C-A> <Esc>I
cnoremap <C-A> <Home>

" Global yank and paste
noremap gy "*y
noremap gY "*y$
noremap gp "*p
noremap gP "*P
vnoremap gy "*y
vnoremap gp "*p
vnoremap gP "*P

" Enhanced <C-L>
noremap <silent> <C-L>
      \ :nohlsearch <C-R>=has('diff') ? "<Bar>diffupdate" : ''<CR><CR><C-L>

" :lcd into the current git, project, or local directory.
noremap <silent> <C-w>.
      \ :if exists('*FugitiveGitDir') && !empty(FugitiveGitDir())<Bar>
      \   execute 'Glcd'<Bar>
      \ elseif exists(':Plcd')<Bar>
      \   execute 'Plcd'<Bar>
      \ else<Bar>
      \   lcd %:h<Bar>
      \ endif<Bar>
      \ <CR>
nmap cd <C-W>.

augroup t_gui
  autocmd!

  autocmd GUIEnter * let g:markdown_fenced_languages =
          \ [
          \   'bash=sh',
          \   'diff',
          \   'json',
          \   'nix',
          \   'ruby',
          \   'sh',
          \ ]
  autocmd GUIEnter * setglobal
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
augroup END

augroup t_textwidth
  autocmd!

  autocmd FileType *
        \ if !&textwidth |
        \   setlocal textwidth=80 |
        \ endif
augroup END

let s:filetypes_with_nonumber = [
      \ 'ale-preview.message',
      \ 'fugitive',
      \ 'fzf',
      \ 'git',
      \ 'gitcommit',
      \ 'gitrebase',
      \ 'help',
      \ 'man',
      \ 'markdown',
      \ 'text',
      \ ]
augroup t_number
  autocmd!

  autocmd FileType * setlocal number
  autocmd FileType *
        \ if index(s:filetypes_with_nonumber, &filetype) >= 0 |
        \   setlocal nonumber |
        \ endif
augroup END

augroup t_filetypes
  autocmd!

  autocmd BufReadPost *.conf set filetype=conf
  autocmd BufReadPost */gitconfig,*/.gitconfig,*/.gitconfig.local
        \ set filetype=gitconfig
  autocmd BufReadPost */vintrc,*/.vintrc set filetype=yaml
augroup END

augroup t_filetype_options
  autocmd!

  autocmd FileType bash setlocal iskeyword+=-
  autocmd FileType c setlocal
        \ cinoptions=:0,t0,+4,(4
        \ noexpandtab
        \ shiftwidth=8
        \ tabstop=8
augroup END

" Make gvim on macOS follow the appearance for light- and dark-mode.
if exists('##OSAppearanceChanged')
  augroup t_follow_os_appearance
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
let g:ale_fixers_explicit = 1
let g:ale_hover_cursor = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 0
let g:ale_linters_explicit = 1
let g:ale_open_list = 1
let g:ale_set_signs = 0

let g:ale_sh_shfmt_options = '-i 2 -ci'
let g:ale_sql_pgformatter_options = '--spaces 2 --comma-break'

let g:ale_fixers = { '*': ['trim_whitespace'] }
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.json = ['jq']
let g:ale_fixers.nix = ['nixpkgs-fmt']
let g:ale_fixers.ruby = ['rubocop', 'sorbet']
let g:ale_fixers.sh = ['shfmt']
let g:ale_fixers.sql = ['pgformatter']
let g:ale_fixers.typescriptreact = g:ale_fixers.javascript
let g:ale_linters = {}
let g:ale_linters.markdown = ['mdl']
let g:ale_linters.ruby = ['rubocop', 'sorbet']
let g:ale_linters.sh = ['shellcheck']
let g:ale_linters.vim = ['vint']

nmap `=<CR> <Plug>(ale_fix)
nmap `== <Plug>(ale_lint)
nmap `=? <Plug>(ale_hover)

" dispatch.vim
" ------------
augroup t_dispatch
  autocmd!

  autocmd BufReadPost *
        \ if getline(1) =~# '^#!' |
        \   let b:dispatch = matchstr(
        \     getline(1),
        \     '#!\%(/usr/bin/env \+\)\=\zs.*'
        \    ) . ' %:S' |
        \   let b:start = '-wait=always ' . b:dispatch |
        \ endif

  autocmd BufReadPost *.nix
        \ let b:dispatch = 'nix-build %:S --no-link' |
        \ let b:start = "nix repl -I %:p:h:S '<%:t>'" |
        \ setlocal makeprg=nix-build\ %:S
  if has('mac')
    autocmd BufReadPost */darwin-configuration.nix
          \ let b:dispatch = 'darwin-rebuild check' |
          \ setlocal makeprg=darwin-rebuild\ switch
  endif
  if has('linux')
    autocmd BufReadPost */nixos-configuration.nix
          \ let b:dispatch = 'nixos-rebuild dry-run' |
          \ setlocal makeprg=sudo\ nixos-rebuild\ switch
  endif
  autocmd BufReadPost */home.nix
        \ let b:dispatch = 'home-manager --file %:S --no-out-link build' |
        \ setlocal makeprg=home-manager\ switch\ --file\ %:S

  autocmd FileType ruby let b:start = 'irb -r %:S:p'
  autocmd FileType ruby
        \ if expand('%') =~# '_test\.rb$' |
        \   let b:dispatch = 'ruby -Itest %:S' |
        \ elseif expand('%') =~# '_spec\.rb$' |
        \   let b:dispatch = get(
        \     b:,
        \     'dispatch',
        \     "rspec %:S`=v:lnum ? ':'.v:lnum : ''`",
        \   ) |
        \ elseif !exists('b:dispatch') |
        \   let b:dispatch = 'ruby -wc %:S' |
        \ endif

  autocmd BufReadPost *.test.tsx
        \ let b:dispatch = 'jest %' |
        \ let b:start = 'jest'
augroup END

" fugitive.vim
" ------------
let g:fugitive_dynamic_colors = 0
let g:fugitive_legacy_commands = 0

noremap g<CR> :Git<CR>
noremap g<Space> :Git<Space>
vnoremap g<Space> :Git<Space>

augroup t_fugitive
  autocmd!

  autocmd BufReadPost *.git/PULLREQ_EDITMSG set filetype=gitcommit
  autocmd FileType git setlocal nolist
  autocmd FileType gitcommit setlocal
        \ shiftwidth=2
        \ nolist
        \ spell
augroup END

" fzf.vim
" -------
if executable('fzf')
  if isdirectory(expand('$HOME/.fzf'))
    setglobal runtimepath+=$HOME/.fzf
  endif
  if isdirectory(expand('$HOME/.nix-profile/share/vim-plugins/fzf/'))
    setglobal runtimepath+=$HOME/.nix-profile/share/vim-plugins/fzf/
  endif

  noremap <Space><Space> :FZF<CR>
  noremap <Space>] :FZFTags<CR>
else
  noremap <Space><Space> :find<Space>
  noremap <Space>] :tjump /
endif

let g:fzf_command_prefix = 'FZF'
let g:fzf_action =
      \ {
      \   'ctrl-s': 'split',
      \   'ctrl-t': 'tab split',
      \   'ctrl-v': 'vsplit',
      \ }
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ''

augroup t_fzf
  autocmd!

  autocmd FileType help
        \ if executable('fzf') |
        \   noremap <buffer> <Space>] :FZFHelptags<CR> |
        \ else |
        \   noremap <buffer> <Space>] :tag<Space> |
        \ endif
  autocmd FileType fzf
        \ setlocal laststatus=0 noshowmode noruler
        \ |
        \ autocmd BufLeave <buffer> setlocal laststatus=2 showmode ruler
augroup END

" rails.vim
" ---------
let g:rails_vim_enter = 0
let g:rails_projections =
      \ {
      \   'app/controllers/*_controller.rb': {
      \     'test': [
      \       'spec/requests/{}_spec.rb',
      \       'spec/controllers/{}_controller_spec.rb',
      \       'test/controllers/{}_controller_test.rb'
      \     ],
      \     'alternate': [
      \       'spec/requests/{}_spec.rb',
      \       'spec/controllers/{}_controller_spec.rb',
      \       'test/controllers/{}_controller_test.rb'
      \     ],
      \   },
      \   'app/services/*.rb': {
      \     'command': 'service',
      \     'test': [
      \       'spec/services/{}_spec.rb',
      \       'test/services/{}_test.rb'
      \     ],
      \   },
      \   'app/graphql/*.rb': {
      \     'command': 'graphql',
      \     'test': [
      \       'spec/graphql/{}_spec.rb',
      \       'test/graphql/{}_test.rb'
      \     ],
      \   },
      \   'config/routes.rb': { 'command': 'routes' },
      \   'lib/tasks/*.rake': {
      \     'command': 'task',
      \     'test': [
      \       'spec/lib/tasks/{}_spec.rb',
      \       'test/lib/tasks/{}_test.rb',
      \     ],
      \   },
      \   'spec/*_spec.rb': {
      \     'dispatch': "rspec spec/{}_spec.rb`=v:lnum ? ':'.v:lnum : ''`",
      \   },
      \   'spec/lib/tasks/*_spec.rb': {
      \     'alternate': 'lib/tasks/{}.rake',
      \   },
      \   'spec/requests/*_spec.rb': {
      \     'command': 'request',
      \     'alternate': 'app/controllers/{}_controller.rb'
      \   },
      \   'spec/factories/*.rb': {
      \     'command': 'factory',
      \     'related': [
      \       'app/models/{singular}.rb'
      \     ],
      \   },
      \ }


" projectionist.vim
" -----------------
let g:projectionist_vim_enter = 0
let g:projectionist_heuristics =
      \ {
      \   '.git/': {
      \     'TODO.md': { 'command': 'todo' },
      \     'shell.nix': { 'command': 'shell' },
      \     'test/*.rb': { 'command': 'test' },
      \   },
      \ }

" splitjoin.vim
" -------------
let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_options_as_arguments = 1

function! s:try(cmd, default)
  if exists(':' . a:cmd) && !v:count
    let tick = b:changedtick
    execute a:cmd
    if tick == b:changedtick
      execute 'normal! '. a:default
    endif
  else
    execute 'normal! '. v:count . a:default
  endif
endfunction

noremap <silent> gJ :<C-U>call <SID>try('SplitjoinJoin', 'gJ')<CR>
noremap <silent> J :<C-U>call <SID>try('SplitjoinJoin', 'J')<CR>
noremap <silent> gS :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
noremap <silent> S :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
" r    => Enter replace mode
" \015 => <CR>
noremap <silent> r<CR> :<C-U>call <SID>try('SplitjoinSplit', "r\015")<CR>

" surround.vim
" ------------
let g:surround_{char2nr('#')} = "#{\<CR>}"
let g:surround_{char2nr('s')} = " \<CR>"
let g:surround_{char2nr('S')} = "\<CR> "

" vinegar.vim
" -----------
if exists('<Plug>VinegarUp')
  noremap <silent> <Plug>Up <Plug>VinegarUp
else
  noremap <silent> <Plug>Up :Explore<CR>
endif
nmap <expr> - line('.') == 1 ? '<Plug>Up' : '-'

" direnv.vim
" ----------
if has('gui_running')
  let g:direnv_auto = 1
else
  let g:direnv_auto = 0
endif

let g:direnv_silent_load = 1

" ruby
" ----
let g:ruby_indent_block_style = 'do'

augroup t_ruby
  autocmd!

  autocmd FileType ruby iabbrev <buffer> ddebug require 'pry'; binding.pry
  autocmd FileType ruby iabbrev <buffer> dinit def initialize
  autocmd FileType ruby setlocal comments=:#\<Space> iskeyword+=?,!,=
  autocmd Syntax ruby syntax region rubySorbetSig start='sig {' end='}'
  autocmd Syntax ruby syntax region rubySorbetSig start='sig do' end="\<end\>"
  autocmd Syntax ruby hi def link rubySorbetSig Comment
augroup END

" quickfix
" --------
function! s:QuickfixTitle()
  let title = get(w:, 'quickfix_title', '')

  if title =~# '^:' . &grepprg || title =~# '^:grep'
    let w:quickfix_title = substitute(title, &grepprg, 'grep', '')
  endif
endfunction

augroup t_qf
  autocmd!

  autocmd FileType qf setlocal
        \ nobuflisted
        \ nolist
        \ nonumber
        \ norelativenumber
  autocmd FileType qf call <SID>QuickfixTitle()
  autocmd FileType qf noremap <buffer> - -
augroup END

" markdown
" --------
augroup t_markdown
  autocmd!

  autocmd FileType markdown,gitcommit iabbrev <buffer> -. - [ ]
  autocmd FileType markdown,gitcommit iabbrev <buffer> -x - [X]
  autocmd FileType markdown setlocal
        \ expandtab
        \ linebreak
        \ shiftwidth=2
        \ spell
        \ wrap
augroup END

" obsession.vim
" ---------
setglobal sessionoptions-=buffers,curdir sessionoptions+=sesdir,globals

augroup t_obsession
  autocmd!

  autocmd VimEnter * nested
        \ if (
        \   !argc() &&
        \   empty(v:this_session) &&
        \   filereadable('Session.vim') &&
        \   !&modified
        \ ) |
        \   source Session.vim |
        \ endif
augroup END

" Make list-like commands more intuitive.
" Originally from:
"
" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
function! s:CCR()
  if getcmdtype() !=# ':'
    return "\<CR>"
  end
  let cmdline = getcmdline()
  let filter_stub = '\v\C^((filt|filte|filter) .+ )*'
  command! -bar Z silent set more|delcommand Z

  if cmdline =~# filter_stub . '(ls|files|buffers)'
    return "\<CR>:buffer "
  elseif cmdline =~# '\v\C/(#|nu|num|numb|numbe|number)$'
    return "\<CR>:"
  elseif cmdline =~# filter_stub . '(old|oldfiles)'
    setlocal nomore
    return "\<CR>:Z|edit #<"
  elseif cmdline =~# '\C^changes'
    setlocal nomore
    return "\<CR>:Z|normal! g;\<S-Left>"
  elseif cmdline =~# filter_stub . '(ju|jumps)'
    setlocal nomore
    return "\<CR>:Z|normal! \<C-O>\<S-Left>"
  elseif cmdline =~# filter_stub . 'marks'
    return "\<CR>:normal! `"
  elseif cmdline =~# '\v\C^(undol|undolist)'
    return "\<CR>:undo "
  elseif cmdline =~# filter_stub . '(cli|clist|lli|llist)'
    return
          \ "\<CR>" .
          \ ':silent ' .
          \ repeat(matchlist(cmdline, '\v(cli|clist|lli|llist)')[0][0], 2) .
          \ "\<Space>"
    elseif cmdline =~# '\v\C(dli|dlist|il|ilist)\s.*'
      return
            \ "\<CR>:" .
            \ cmdline[0] .
            \ 'jump  ' . split(cmdline, ' ')[1] .
            \ "\<S-Left>\<Left>"
  else
    return "\<CR>"
  endif
endfunction

cnoremap <script> <expr> <CR> <SID>CCR()

" Leverage CCR for built-in :ilist and :dlist
nmap [I :ilist /<C-R>=expand('<cword>')<CR><CR>
nmap ]I :ilist /<C-R>=expand('<cword>')<CR><CR>
nmap [D :dlist /<C-R>=expand('<cword>')<CR><CR>
nmap ]D :dlist /<C-R>=expand('<cword>')<CR><CR>

nmap <Space>b :ls<CR>

" Make <CR> more intuitive.
" Originally from:
"
" https://github.com/tpope/dotfiles/blob/c31d6515e126ce2e52dbb11a7b01f4ac4cc2bd0c/.vimrc#L214
function! s:NCR()
  if len(getcmdwintype())
    return "\<CR>"
  endif

  if &buftype ==# 'quickfix'
    return "\<CR>"
  else
    if &buftype !=# 'terminal'
      return ":\025confirm " . (v:count ? 'write' : 'update') . "\<CR>"
    elseif exists('*jobwait') && jobwait([&channel], 0)[0] == -1
      return ':normal! i' . "\<CR>"
    elseif &modified
      return ':normal! i' . "\<CR>"
    else
      return "\<CR>"
    endif
  endif
endfunction
nmap <silent> <script> <expr> <CR> <SID>NCR()

" Setup common mapping to access command-mode from a running :terminal
if exists('&termwinkey')
  tmap <script> <SID>: <C-W>:
  tmap <script> <C-\>: <C-W>:
elseif exists(':tmap')
  tmap <script> <SID>: <C-\><C-N>:
  tmap <script> <C-\>: <C-\><C-N>:
endif

" Setup <M-{1,9}> to their supposed escape sequence
for s:i in range(1, 9)
  silent! execute 'set <M-' . s:i . ">=\<Esc>" . s:i
endfor

" Switch :tab's with <{D,M}-{1,9}>
"
" D is for a running MacVim.
" M is for everywhere else.
let s:mod = (has('mac') && has('gui_running')) ? 'D' : 'M'
for s:i in range(1, 9)
  execute 'noremap <' . s:mod . '-' . s:i . '> <C-\><C-N>' . s:i . 'gt'
  execute 'noremap! <' . s:mod . '-' . s:i . '> <C-\><C-N>' . s:i . 'gt'
  if exists(':tmap')
    execute 'tmap <' . s:mod . '-' . s:i . '> <SID>:' . s:i . 'tabnext<CR>'
  endif
endfor

if !has('nvim')
  silent! runtime ftplugin/man.vim
endif

augroup t_man
  autocmd!

  autocmd FileType man setlocal nolist
augroup END

augroup t_release_swapfiles
  autocmd!

  autocmd BufWritePost,BufReadPost,BufLeave *
        \ if isdirectory(expand('<amatch>:h')) |
        \   let &swapfile = &modified |
        \ endif
augroup END

augroup t_write_on_focus_lost
  autocmd!

  autocmd FocusLost * silent! wall
augroup END

augroup t_pager
  autocmd!

  autocmd SourcePost */macros/less.vim nunmap <Space><Space>
  autocmd SourcePre */macros/less.vim setglobal laststatus=0 showtabline=0
augroup END

if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

if filereadable('.git/safe/../../.vimrc.local')
  source .vimrc.local
endif
