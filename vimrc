setglobal autoread
setglobal autowrite
setglobal backspace=indent,eol,start
setglobal backupskip=/tmp/*,/private/tmp/*
setglobal cmdheight=2
setglobal display=lastline
setglobal encoding=utf-8
setglobal guifont=JetBrains\ Mono\ NL:h15
setglobal history=200
setglobal incsearch
setglobal laststatus=2
setglobal listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
setglobal modelines=0
setglobal mouse=nvi
setglobal nojoinspaces
setglobal path=.,,
setglobal scrolloff=1
setglobal sessionoptions-=buffers,curdir sessionoptions+=sesdir,globals
setglobal shiftround
setglobal showcmd
setglobal sidescrolloff=5
setglobal smartcase
setglobal statusline=[%n]\ %<%f\ %h%m%r%w%=%-14.(%l,%c%V%)\ %P
setglobal tags-=./tags tags-=./tags; tags^=./tags;
setglobal title
setglobal ttimeout
setglobal ttimeoutlen=50
setglobal viminfo=!,'20,<50,s10,h
setglobal wildmenu
setglobal wildmode=full
syntax enable

let s:user_and_hostname_if_ssh = exists('$SSH_TTY') ? system('logname') . '@' . hostname() . ':' : ''
let &g:titlestring = s:user_and_hostname_if_ssh . '%{v:progname} %{fnamemodify(getcwd(), ":~")}'

if has('gui_macvim')
  setglobal macmeta

  let macvim_skip_cmd_opt_movement = 1
  let macvim_skip_colorscheme = 1
end

if exists('+linebreak')
  setglobal showbreak=\ +
endif

if $TERM =~# '^screen\|^tmux' && empty($SSH_TTY) && len($TMUX) && exists('+ttymouse')
  setglobal ttymouse=xterm2
endif

if has('vim_starting')
  set commentstring=#\ %s
  set complete+=kspell
  set complete-=i
  set completefunc=syntaxcomplete#Complete
  set nofoldenable
  set nohidden
  set omnifunc=syntaxcomplete#Complete
  set spellfile=~/.vim/spell/en.utf-8.add
  set synmaxcol=500
  set nowrap

  if exists('+breakindent')
    set breakindent
  endif

  if exists('+undofile')
    set undofile
  endif

  if $TERM =~# '^screen\|^tmux' && len($TMUX)
    if exists('&termguicolors')
      set notermguicolors
    endif
  endif
endif

let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

let g:is_posix = 1

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
  setglobal runtimepath^=~/.vim/
  setglobal runtimepath^=~/.vim/pack/*/start/*
  setglobal runtimepath+=~/.vim/pack/*/start/*/after
endif

if has('packages')
  let &g:packpath = &runtimepath

  packadd! cfilter
  if !has('nvim')
    packadd! matchit
  endif
else
  runtime macros/matchit.vim
endif

if !has('nvim')
  silent! runtime ftplugin/man.vim
endif

filetype plugin indent on

setglobal grepformat=%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f\ \ %l%m
if executable('rg')
  setglobal grepprg=rg\ --hidden\ --vimgrep
else
  setglobal grepprg=grep\ -rnH\ --exclude-dir\ .git\ $*\ /dev/null
endif

cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-R><C-L> <C-R>=substitute(getline('.'), '^\s*', '', '')<CR>
cnoremap <C-R>W <C-R><C-A>
nnoremap <Leader>d :bdelete<CR>
nnoremap <C-J> <C-w>w
nnoremap <C-K> <C-w>W
nnoremap <silent> <C-L>
      \ :nohlsearch <C-R>=has('diff') ? "\<Bar>diffupdate" : ''<CR><CR><C-L>
nnoremap <silent> <C-W>z
      \ :wincmd z
      \ <Bar>cclose
      \ <Bar>lclose
      \ <Bar>pclose
      \ <Bar>helpclose
      \ <CR>
nnoremap Q @q
nnoremap Y y$
nnoremap gV V`]
vnoremap D y'>p

noremap gy "*y
noremap gY "*y$
noremap gp "*p
noremap gP "*P

nnoremap <expr> j (&wrap && v:count == 0) ? 'gj' : 'j'
nnoremap <expr> k (&wrap && v:count == 0) ? 'gk' : 'k'

nnoremap <silent> <C-w>.
      \ :if exists(':Plcd')<Bar>
      \   execute 'Plcd'<Bar>
      \ elseif exists('*FugitiveGitDir') && len(FugitiveGitDir())<Bar>
      \   execute 'Glcd'<Bar>
      \ else<Bar>
      \   lcd %:h<Bar>
      \ endif<Bar>
      \ <CR>
nmap cd <C-W>.

cnoremap %% <C-R>=expand('%:h').'/'<CR>
nmap <Leader>e :edit %%
nmap <Leader>s :split %%
nmap <Leader>v :vsplit %%
nmap <Leader>t :tabedit %%
nmap <Leader>r :read %%
nmap <Leader>w :write %%

nmap <expr> - line('.') == 1 ? ':edit %%<CR>' : '-'

" Given this situation:
"     user.fo|o!
" When entering <C-]> to go to the `foo!` tag, for some reason it acts as if
" the cursor is on `user` and goes to the `user` tag.
"
" To fix this, use `<cword>` to select the word under the cursor and go to it
" directly.
nnoremap <C-]> :tag <C-R>=expand('<cword>')<CR><CR>
nnoremap <C-W><C-]> :stag <C-R>=expand('<cword>')<CR><CR>
nnoremap <C-W>] :stag <C-R>=expand('<cword>')<CR><CR>
nnoremap <C-W>} :ptag <C-R>=expand('<cword>')<CR><CR>

" Originally from: https://github.com/tpope/vim-rsi
inoremap <expr> <C-E> col('.') > strlen(getline('.')) ? "\<C-E>" : "\<End>"
inoremap <C-A> <Esc>I
cnoremap <C-A> <Home>

augroup t_gui
  autocmd!
  autocmd GUIEnter * setglobal
        \ icon
        \ lines=45
        \ columns=86
        \ guioptions=
        \ visualbell
        \ t_vb=
augroup END

augroup t_textwidth
  autocmd!
  autocmd FileType * if !&textwidth | setlocal textwidth=80 | endif
augroup END

augroup t_list_number
  autocmd!
  autocmd FileType * setlocal list number
  autocmd FileType * if !&modifiable | setlocal nolist nonumber | endif
  autocmd FileType * if &readonly | setlocal nolist nonumber | endif
  autocmd FileType * if &previewwindow | setlocal nolist nonumber | endif
augroup END

augroup t_filetypes
  autocmd!
  autocmd BufReadPost *.mdc setfiletype markdown
  autocmd BufReadPost gitconfig,.gitconfig.local setfiletype gitconfig
  autocmd BufReadPost patch-* setfiletype diff
  autocmd BufReadPost psqlrc,.psqlrc setfiletype sql
  autocmd BufReadPost vintrc,.vintrc setfiletype yaml
augroup END

augroup t_openbsd
  autocmd!
  autocmd FileType c,cpp setlocal
        \ cindent
        \ cinoptions=:0,t0,+4,(4
        \ complete+=i
        \ indentkeys=0{,0},0),:,0#,!^F,o,O,e
        \ listchars=tab:\ \ ,trail:-,extends:>,precedes:<,nbsp:+
        \ noexpandtab
        \ shiftwidth=8
        \ tabstop=8
augroup END

let g:bundler_edit_commands = 0
let g:ruby_indent_block_style = 'do'

augroup t_ruby
  autocmd!
  autocmd FileType ruby setlocal comments=:#\<Space> iskeyword+=?,!,=
  autocmd Syntax ruby syntax region rubySorbetSig start='sig {' end='}'
  autocmd Syntax ruby syntax region rubySorbetSig start='sig do' end="\<end\>"
  autocmd Syntax ruby hi def link rubySorbetSig Comment
augroup END

augroup t_qf
  autocmd!
  autocmd FileType qf setlocal nobuflisted nolist nonumber
  autocmd FileType qf nnoremap <buffer> - -
augroup END

let g:markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'diff',
      \ 'json',
      \ 'nix',
      \ 'ruby',
      \ 'sh',
      \ ]

augroup t_markdown
  autocmd!
  autocmd FileType markdown setlocal
        \ expandtab
        \ linebreak
        \ shiftwidth=2
        \ spell
        \ wrap
augroup END

" Originally from:
" https://gist.github.com/romainl/5b2cfb2b81f02d44e1d90b74ef555e31
function! s:ccr()
  if getcmdtype() !=# ':'
    return "\<CR>"
  end
  let cmdline = getcmdline()
  let filter_stub = '\v\C^((filt|filte|filter) .+ )*'
  let range_stub = '\v\C^((\d+|\.|\%)?,?(\$|\d+|\.)?)*'
  command! -bar Z silent set more|delcommand Z

  if cmdline =~# filter_stub . '(ls|files|buffers)'
    return "\<CR>:buffer\<Space>"
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
    return "\<CR>:undo\<Space>"
  elseif cmdline =~# filter_stub . '(cli|clist)'
    return "\<CR>:silent cc\<Space>"
  elseif cmdline =~# filter_stub . '(lli|llist)'
    return "\<CR>:silent ll\<Space>"
  elseif cmdline =~# range_stub . '(il|ilist)\s.*'
    return "\<CR>:" .
          \ matchlist(cmdline, range_stub)[0] .
          \ "ijump\<Space>" .
          \ split(cmdline, ' ')[1] .
          \ "\<S-Left>\<Left>\<Space>"
  elseif cmdline =~# range_stub . '(dli|dlist)\s.*'
    return "\<CR>:" .
          \ matchlist(cmdline, range_stub)[0] .
          \ "djump\<Space>" .
          \ split(cmdline, ' ')[1] .
          \ "\<S-Left>\<Left>\<Space>"
  else
    return "\<CR>"
  endif
endfunction

cnoremap <script> <expr> <CR> <SID>ccr()

nmap [I :ilist /<C-R>=expand('<cword>')<CR><CR>
nmap ]I :.,$ilist /<C-R>=expand('<cword>')<CR><CR>
nmap [D :dlist /<C-R>=expand('<cword>')<CR><CR>
nmap ]D :.,$dlist /<C-R>=expand('<cword>')<CR><CR>

nmap <Space>b :ls<CR>

" Originally from:
" https://github.com/tpope/dotfiles/blob/c31d6515e126ce2e52dbb11a7b01f4ac4cc2bd0c/.vimrc#L214
function! s:ncr()
  if len(getcmdwintype())
    return "\<CR>"
  endif

  if &buftype ==# 'quickfix'
    return "\<CR>"
  endif

  if &buftype !=# 'terminal'
    return ":\025confirm\<Space>" . (v:count ? 'write' : 'update') . "\<CR>"
  endif

  if exists('*jobwait') && jobwait([&channel], 0)[0] == -1
    return ":normal! i\<CR>"
  endif

  if &modified
    return ":normal! i\<CR>"
  endif

  return "\<CR>"
endfunction
nmap <silent> <script> <expr> <CR> <SID>ncr()

if exists('&termwinkey')
  tmap <script> <SID>: <C-W>:
  tmap <script> <C-\>: <C-W>:
elseif exists(':tmap')
  tmap <script> <SID>: <C-\><C-N>:
  tmap <script> <C-\>: <C-\><C-N>:
endif

let s:mod = (has('mac') && has('gui_running')) ? 'D' : 'M'
for s:i in range(1, 9)
  execute 'noremap <' . s:mod . '-' . s:i . '> <C-\><C-N>' . s:i . 'gt'
  execute 'noremap! <' . s:mod . '-' . s:i . '> <C-\><C-N>' . s:i . 'gt'
  if exists(':tmap')
    execute 'tmap <' . s:mod . '-' . s:i . '> <SID>:' . s:i . 'tabnext<CR>'
  endif
endfor
unlet! s:i

for s:i in range(1, 9)
  silent! execute 'set <M-' . s:i . ">=\<Esc>" . s:i
endfor
unlet! s:i

if exists(':tnoremap')
  tnoremap <S-Space> <Space>
endif

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

augroup t_resize
  autocmd!
  autocmd VimResized * if &equalalways | wincmd = | endif
augroup END

" :cd, :lcd, and :tcd with tab-completion that supports the &cdpath.
"
" Inspired by Tim Pope's scriptease.vim[1] and its' scriptease#complete
"
" [1]: https://github.com/tpope/vim-scriptease
function! s:cd_complete(A, L, P) abort
  let pattern = substitute(a:A, '/\|\/', '*/', 'g') . '*'
  if &cdpath =~# '^,,'
    let cdpaths = getcwd() . ',' . &cdpath
  else
    let cdpaths = &cdpath
  endif
  let found = {}
  for glob in split(cdpaths, ',')
    for path in map(split(glob(glob), "\n"), 'fnamemodify(v:val, ":p")')
      let matches = split(glob(path . '/' . pattern), "\n")
      call filter(matches, 'isdirectory(v:val)')
      call map(matches, 'fnamemodify(v:val, ":p")[strlen(path)+1:-1]')
      for match in matches
        let found[match] = 1
      endfor
    endfor
  endfor
  return sort(keys(found))
endfunction

command! -bar -nargs=1 -complete=customlist,s:cd_complete Cd cd <args>
command! -bar -nargs=1 -complete=customlist,s:cd_complete Lcd lcd <args>
command! -bar -nargs=1 -complete=customlist,s:cd_complete Tcd tcd <args>

function! TKnfmt(...) abort
  return { 'command': 'knfmt -s' }
endfunction

silent! call ale#fix#registry#Add('knfmt', 'TKnfmt', ['c'], 'knfmt for c')

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
let g:ale_virtualtext_cursor = 0

let g:ale_lua_stylua_options = '--config-path ~/.stylua.toml'
let g:ale_sh_shfmt_options = '--indent 2 --case-indent'
let g:ale_sql_pgformatter_options = '--spaces 2 --comma-break --wrap-limit 80'

let g:ale_fixers = { '*': ['trim_whitespace'] }
let g:ale_fixers.c = ['knfmt']
let g:ale_fixers.json = ['jq']
let g:ale_fixers.lua = ['stylua']
let g:ale_fixers.nix = ['nixfmt']
let g:ale_fixers.ruby = ['standardrb', 'rubocop', 'sorbet']
let g:ale_fixers.sh = ['shfmt']
let g:ale_fixers.sql = ['pgformatter']
let g:ale_linters = {}
let g:ale_linters.markdown = ['mdl']
let g:ale_linters.ruby = ['standardrb', 'rubocop', 'sorbet']
let g:ale_linters.sh = ['shellcheck']
let g:ale_linters.vim = ['vint']

nmap `=<CR> <Plug>(ale_fix)
nmap `== <Plug>(ale_lint)
nmap `=? <Plug>(ale_hover)

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

  autocmd BufReadPost *
        \ if filereadable('bin/console') |
        \   let b:start = 'bin/console' |
        \ endif

  autocmd FileType nix
        \ let b:dispatch = 'nix-build %:S --no-link' |
        \ let b:start = 'nix repl --file %:S' |
        \ setlocal makeprg=nix-build\ %:S
  autocmd BufReadPost */nixos-configuration.nix,/etc/nixos/configuration.nix
        \ let b:dispatch = 'nixos-rebuild dry-run' |
        \ setlocal makeprg=nixos-rebuild\ build
  autocmd BufReadPost home.nix
        \ let b:dispatch = 'home-manager build --file %:S --no-out-link' |
        \ setlocal makeprg=home-manager\ build\ --file\ %:S
  autocmd BufReadPost flake.nix
        \ let b:dispatch = '-dir=%:p:h nix flake check --impure' |
        \ setlocal makeprg=nix\ build\ --file\ %:S

  autocmd FileType ruby let b:start = 'irb -r %:p:S'
  autocmd FileType ruby
        \ if expand('%') =~# '_test\.rb$' || expand('%') =~# 'test_.*\.rb$' |
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

  autocmd BufReadPost *hammerspoon/*.lua
        \ let b:dispatch = 'hs -q %:p:S' |
        \ let b:start = 'hs'
augroup END

let g:fugitive_dynamic_colors = 0
let g:fugitive_legacy_commands = 0

noremap g<CR> :Git<CR>
noremap g<Space> :Git<Space>

nnoremap <C-p> <C-p>
nnoremap <C-n> <C-n>

augroup t_git
  autocmd!
  autocmd FileType gitcommit setlocal shiftwidth=2 spell
augroup END

if executable('fzf')
  if isdirectory($HOME . '/.fzf/')
    setglobal runtimepath+=$HOME/.fzf/
  elseif isdirectory($HOME . '/.nix-profile/share/vim-plugins/fzf/')
     setglobal runtimepath+=$HOME/.nix-profile/share/vim-plugins/fzf/
  endif

  nnoremap <Space><Space> :FZFFiles<CR>
  nnoremap <Space>] :FZFTags<CR>
endif

let g:fzf_vim = {}
let g:fzf_vim.command_prefix = 'FZF'
let g:fzf_vim.preview_window = []
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-v': 'vsplit',
      \ }
let g:fzf_layout = { 'down': '40%' }

augroup t_fzf
  autocmd!
  autocmd FileType help
        \ if executable('fzf') |
        \   nnoremap <buffer> <Space>] :FZFHelptags<CR> |
        \ endif
  autocmd FileType fzf
        \ setlocal laststatus=0 noshowmode noruler nonumber nolist
        \ |
        \ autocmd BufLeave <buffer> setlocal laststatus=2 showmode ruler
augroup END

let g:rails_vim_enter = 0
let g:rails_projections = {}
let g:rails_projections['spec/*_spec.rb'] = {
      \ 'dispatch': "rspec spec/{}_spec.rb`=v:lnum ? ':' . v:lnum : ''`",
      \ }

let g:projectionist_vim_enter = 0
let g:projectionist_heuristics = {}
let g:projectionist_heuristics['.git/'] = {
      \ 'TODO.md': { 'command': 'todo' },
      \ '*.gemspec': { 'command': 'gemspec' },
      \ 'shell.nix': { 'command': 'shell' },
      \ 'test/*.rb': { 'command': 'test' },
      \ '*.c': { 'alternate': '{}.h' },
      \ '*.h': { 'alternate': '{}.c' },
      \ }

let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_options_as_arguments = 1

function! s:try(cmd, default)
  if exists(':' . a:cmd) && !v:count
    let tick = b:changedtick
    execute a:cmd
    if tick == b:changedtick
      execute 'normal! ' . a:default
    endif
  else
    execute 'normal! ' . v:count . a:default
  endif
endfunction

nnoremap <silent> gJ :<C-U>call <SID>try('SplitjoinJoin', 'gJ')<CR>
nnoremap <silent> J :<C-U>call <SID>try('SplitjoinJoin', 'J')<CR>
nnoremap <silent> gS :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
nnoremap <silent> S :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
nnoremap <silent> r<CR> :<C-U>call <SID>try('SplitjoinSplit', "r\015")<CR>

let g:surround_{char2nr('#')} = "#{\<CR>}"

if exists(':E') != 2
  command! -nargs=* -complete=dir E Explore <args>
end

let g:direnv_silent_load = 1

augroup t_obsession
  autocmd!
  autocmd VimEnter * nested
        \ if (
        \   !argc() &&
        \   empty(v:this_session) &&
        \   !&modified &&
        \   filereadable('Session.vim')
        \ ) |
        \   source Session.vim |
        \ endif
augroup END

nnoremap <Space>r :source $MYVIMRC
      \ <Bar>filetype detect
      \ <Bar>doautocmd VimEnter -<CR>

nnoremap <Space>e :confirm edit<CR>

if executable('doas')
  command! DoasWrite :execute 'silent! write !doas tee % > /dev/null'
endif

augroup t_signs
  autocmd!
  autocmd BufWinEnter,FileType *
        \ if &tagfunc =~# '^v:lua' |
        \   setlocal signcolumn=yes |
        \ else |
        \   setlocal signcolumn=no |
        \ endif
augroup END

function! s:colorscheme()
  if len(get(g:, 'colors_name', ''))
    hi Todo cterm=underline gui=underline term=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  endif
endfunction

augroup t_colorscheme
  autocmd!
  autocmd ColorScheme * call <SID>colorscheme()
augroup END

" ecru.vim
" Copyright 2025 Teo Ljungberg
" ISC license
"
" We do not set g:colors_name to the name of the colorscheme - 'ecru', as that
" will make vim(1), and mvim(1) specifically, to try to lookup colors/ecru.vim
" in vim's &runtimepath.

highlight clear

if exists('g:colors_name')
  let g:colors_name = ''
endif

hi ColorColumn term=NONE cterm=NONE gui=NONE ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi Comment term=italic cterm=italic gui=italic ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi Conceal term=italic cterm=italic gui=italic ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Constant term=italic cterm=italic gui=italic ctermfg=NONE guifg=NONE
hi CurSearch term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi CursorColumn term=NONE cterm=NONE gui=NONE ctermfg=15 ctermbg=0 guifg=#444444 guibg=#F2F0DD
hi CursorLine term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi CursorLineNr term=italic,bold cterm=italic,bold gui=italic,bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Delimiter term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi DiffAdd term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi DiffChange term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi DiffDelete term=NONE cterm=NONE gui=NONE ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi DiffText term=italic cterm=italic gui=italic ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi Directory term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi EndOfBuffer term=italic cterm=italic gui=italic ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi Error term=underline,bold cterm=underline,bold gui=underline,bold ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
hi ErrorMsg term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi FoldColumn term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Folded term=italic cterm=italic gui=italic ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Function term=bold,italic cterm=bold,italic gui=bold,italic ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Identifier term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Ignore term=NONE cterm=NONE gui=NONE ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi LineNr term=italic cterm=italic gui=italic ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi MatchParen term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi ModeMsg term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi MoreMsg term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi NonText term=italic cterm=italic gui=italic ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi Normal term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=#444444 guibg=#F2F0DD
hi NormalFloat term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=#F2F0DD
hi Operator term=bold cterm=bold gui=bold ctermfg=NONE guifg=NONE
hi Pmenu term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=#444444 guibg=#F2F0DD
hi PmenuSbar term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=#444444 guibg=#F2F0DD
hi PmenuSel term=NONE cterm=NONE gui=NONE ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi PmenuThumb term=NONE cterm=NONE gui=NONE ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi PreProc term=bold cterm=bold gui=bold ctermfg=NONE guifg=NONE
hi Question term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi QuickFixLine term=bold,underline cterm=bold,underline gui=bold,underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Repeat term=bold cterm=bold gui=bold ctermfg=NONE guifg=NONE
hi Search term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi SignColumn term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Special term=NONE cterm=NONE gui=NONE ctermfg=NONE guifg=NONE
hi SpecialKey term=italic cterm=italic gui=italic ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi SpellBad term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE
hi SpellCap term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE
hi SpellLocal term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE
hi SpellRare term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE
hi Statement term=bold cterm=bold gui=bold ctermfg=NONE guifg=NONE
hi StatusLine term=bold cterm=bold gui=bold ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi StatusLineNC term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi StatusLineTerm term=bold cterm=bold gui=bold ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi StatusLineTermNC term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi String term=italic cterm=italic gui=italic ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi TabLine term=underline cterm=underline gui=underline ctermfg=0 ctermbg=NONE guifg=#444444 guibg=#F2F0DD
hi TabLineFill term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=#F2F0DD
hi TabLineSel term=bold,underline cterm=bold,underline gui=bold,underline ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi Terminal term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=#444444 guibg=#F2F0DD
hi Title term=bold cterm=bold gui=bold ctermfg=NONE guifg=NONE
hi Todo term=underline cterm=underline gui=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Type term=bold,italic cterm=bold,italic gui=bold,italic ctermfg=NONE guifg=NONE
hi Underlined term=underline cterm=underline gui=underline ctermfg=NONE guifg=NONE
hi VertSplit term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Visual term=NONE cterm=NONE gui=NONE ctermfg=15 ctermbg=0 guifg=#F2F0DD guibg=#444444
hi WarningMsg term=reverse cterm=reverse gui=reverse ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi Whitespace term=italic cterm=italic gui=italic ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE
hi WildMenu term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi diffAdded term=bold cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi diffChanged term=NONE cterm=NONE gui=NONE ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi diffRemoved term=NONE cterm=NONE gui=NONE ctermfg=14 ctermbg=NONE guifg=#969692 guibg=NONE

if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

if filereadable('.git/safe/../../.vimrc.local')
  source .vimrc.local
endif
