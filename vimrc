setglobal autoread
setglobal autowrite
setglobal backspace=indent,eol,start
setglobal backupskip=/tmp/*,/private/tmp/*
setglobal cmdheight=2
setglobal display=lastline
setglobal encoding=utf-8
setglobal guifont=JetBrains\ Mono:h15
setglobal history=200
setglobal incsearch
setglobal laststatus=2
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
  setglobal runtimepath^=~/.vim/pack/*/start/*
  setglobal runtimepath+=~/.vim/pack/*/start/*/after
endif

if has('packages')
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

noremap <Leader>d :bdelete<CR>

noremap Y y$

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

noremap Q @q

noremap <silent> <C-W>z
      \ :wincmd z<Bar>cclose<Bar>lclose<Bar>pclose<Bar>helpclose<Bar><CR>

noremap gV V`]

vnoremap D y'>p

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

command! Only :silent only<Bar>silent tabonly

" Given this situation:
"     user.fo|o!
" When entering <C-]> to go to the `foo!` tag, for some reason it acts as if
" the cursor is on `user` and goes to the `user` tag.
"
" To fix this, use `<cword>` to select the word under the cursor and go to it
" directly.
noremap <C-]> :tag <C-R>=expand('<cword>')<CR><CR>
noremap <C-W><C-]> :stag <C-R>=expand('<cword>')<CR><CR>
noremap <C-W>] :stag <C-R>=expand('<cword>')<CR><CR>
noremap g<C-T> :ptag <C-R>=expand('<cword>')<CR><CR>

cnoremap <C-R><C-L> <C-R>=substitute(getline('.'), '^\s*', '', '')<CR>

cnoremap <C-R>W <C-R><C-A>

" Originally from: https://github.com/tpope/vim-rsi
inoremap <expr> <C-E> col(".") > strlen(getline(".")) ? "<C-E>" : "<End>"
inoremap <C-A> <Esc>I
cnoremap <C-A> <Home>

noremap gy "*y
noremap gY "*y$
noremap gp "*p
noremap gP "*P
vnoremap gy "*y
vnoremap gp "*p
vnoremap gP "*P

noremap <silent> <C-L>
      \ :nohlsearch <C-R>=has('diff') ? "<Bar>diffupdate" : ''<CR><CR><C-L>

noremap <silent> <C-w>.
      \ :if exists(':Plcd')<Bar>
      \   execute 'Plcd'<Bar>
      \ elseif exists('*FugitiveGitDir') && !empty(FugitiveGitDir())<Bar>
      \   execute 'Glcd'<Bar>
      \ else<Bar>
      \   lcd %:h<Bar>
      \ endif<Bar>
      \ <CR>
nmap cd <C-W>.

augroup t_gui
  autocmd!

  autocmd GUIEnter * let g:markdown_fenced_languages = [
          \ 'bash=sh',
          \ 'diff',
          \ 'json',
          \ 'nix',
          \ 'ruby',
          \ 'sh',
          \ ]
  autocmd GUIEnter * setglobal
        \ title
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
      \ 'netrw',
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

let s:filetypes_with_nolist = [
      \ 'fugitive',
      \ 'fzf',
      \ 'git',
      \ 'gitcommit',
      \ 'help',
      \ 'man',
      \ 'qf',
      \ ]
augroup t_list
  autocmd!

  autocmd FileType * setlocal list
  autocmd FileType *
        \ if index(s:filetypes_with_nolist, &filetype) >= 0 |
        \   setlocal nolist |
        \ endif
augroup END

augroup t_filetypes
  autocmd!

  autocmd BufReadPost */gitconfig,*/.gitconfig,*/.gitconfig.local
        \ setfiletype gitconfig
  autocmd BufReadPost */vintrc,*/.vintrc setfiletype yaml
  autocmd BufReadPost patch-* setfiletype diff
augroup END

augroup t_openbsd
  autocmd!

  autocmd FileType c setlocal
        \ cindent
        \ cinoptions=:0,t0,+4,(4
        \ indentkeys=0{,0},0),:,0#,!^F,o,O,e
        \ listchars=tab:\ \ ,trail:-,extends:>,precedes:<,nbsp:+
        \ noexpandtab
        \ shiftwidth=8
        \ tabstop=8
augroup END

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

let g:ale_sh_shfmt_options = '-i 2 -ci'
let g:ale_sql_pgformatter_options = '--spaces 2 --comma-break'

let g:ale_fixers = { '*': ['trim_whitespace'] }
let g:ale_fixers.json = ['jq']
let g:ale_fixers.nix = ['alejandra']
let g:ale_fixers.ruby = ['rubocop', 'sorbet']
let g:ale_fixers.sh = ['shfmt']
let g:ale_fixers.sql = ['pgformatter']
let g:ale_linters = {}
let g:ale_linters.markdown = ['mdl']
let g:ale_linters.ruby = ['rubocop', 'sorbet']
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
  if has('mac')
    autocmd BufReadPost */darwin-configuration.nix
          \ let b:dispatch = 'darwin-rebuild check' |
          \ setlocal makeprg=darwin-rebuild\ build
  endif
  if has('linux')
    autocmd BufReadPost */nixos-configuration.nix,/etc/nixos/configuration.nix
          \ let b:dispatch = 'nixos-rebuild dry-run' |
          \ setlocal makeprg=nixos-rebuild\ build
  endif
  autocmd BufReadPost */home.nix
        \ let b:dispatch = 'home-manager build --file %:S --no-out-link' |
        \ setlocal makeprg=home-manager\ build\ --file\ %:S
  autocmd BufReadPost flake.nix
        \ let b:dispatch = 'nix build --no-link' |
        \ setlocal makeprg=nix\ build

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
augroup END

let g:fugitive_dynamic_colors = 0
let g:fugitive_legacy_commands = 0

noremap g<CR> :Git<CR>
noremap g<Space> :Git<Space>
vnoremap g<Space> :Git<Space>

augroup t_fugitive
  autocmd!

  autocmd FileType gitcommit setlocal shiftwidth=2 spell
augroup END

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
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-v': 'vsplit',
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

let g:rails_vim_enter = 0
let g:rails_projections = {
      \ 'spec/*_spec.rb': {
      \   'dispatch': "rspec spec/{}_spec.rb`=v:lnum ? ':'.v:lnum : ''`",
      \ }}

let g:projectionist_vim_enter = 0
let g:projectionist_heuristics = {
      \ '.git/': {
      \   'TODO.md': { 'command': 'todo' },
      \   '*.gemspec': { 'command': 'gemspec' },
      \   'shell.nix': { 'command': 'shell' },
      \   'test/*.rb': { 'command': 'test' },
      \ }}

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

noremap <silent> gJ :<C-U>call <SID>try('SplitjoinJoin', 'gJ')<CR>
noremap <silent> J :<C-U>call <SID>try('SplitjoinJoin', 'J')<CR>
noremap <silent> gS :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
noremap <silent> S :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
noremap <silent> r<CR> :<C-U>call <SID>try('SplitjoinSplit', "r\015")<CR>

let g:surround_{char2nr('#')} = "#{\<CR>}"

if exists('<Plug>VinegarUp')
  noremap <silent> <Plug>Up <Plug>VinegarUp
else
  noremap <silent> <Plug>Up :Explore<CR>
endif
nmap <expr> - line('.') == 1 ? '<Plug>Up' : '-'

command! -nargs=* -complete=dir E Explore <args>

if has('gui_running')
  let g:direnv_auto = 1
else
  let g:direnv_auto = 0
endif

let g:direnv_silent_load = 1

setglobal sessionoptions-=buffers,curdir sessionoptions+=sesdir,globals

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

let g:bundler_edit_commands = 0
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

function! s:quickfix_title()
  let title = get(w:, 'quickfix_title', '')

  if title =~# '^:' . &grepprg || title =~# '^:grep'
    let w:quickfix_title = substitute(title, &grepprg, 'grep', '')
  endif
endfunction

augroup t_qf
  autocmd!

  autocmd FileType qf setlocal
        \ nobuflisted
        \ nonumber
        \ norelativenumber
  autocmd FileType qf call <SID>quickfix_title()
  autocmd FileType qf noremap <buffer> - -
augroup END

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

" Originally from:
" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
function! s:ccr()
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

cnoremap <script> <expr> <CR> <SID>ccr()

nmap [I :ilist /<C-R>=expand('<cword>')<CR><CR>
nmap ]I :ilist /<C-R>=expand('<cword>')<CR><CR>
nmap [D :dlist /<C-R>=expand('<cword>')<CR><CR>
nmap ]D :dlist /<C-R>=expand('<cword>')<CR><CR>

nmap <Space>b :ls<CR>

" Originally from:
" https://github.com/tpope/dotfiles/blob/c31d6515e126ce2e52dbb11a7b01f4ac4cc2bd0c/.vimrc#L214
function! s:ncr()
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
nmap <silent> <script> <expr> <CR> <SID>ncr()

if exists('&termwinkey')
  tmap <script> <SID>: <C-W>:
  tmap <script> <C-\>: <C-W>:
elseif exists(':tmap')
  tmap <script> <SID>: <C-\><C-N>:
  tmap <script> <C-\>: <C-\><C-N>:
endif

for s:i in range(1, 9)
  silent! execute 'set <M-' . s:i . ">=\<Esc>" . s:i
endfor

let s:mod = (has('mac') && has('gui_running')) ? 'D' : 'M'
for s:i in range(1, 9)
  execute 'noremap <' . s:mod . '-' . s:i . '> <C-\><C-N>' . s:i . 'gt'
  execute 'noremap! <' . s:mod . '-' . s:i . '> <C-\><C-N>' . s:i . 'gt'
  if exists(':tmap')
    execute 'tmap <' . s:mod . '-' . s:i . '> <SID>:' . s:i . 'tabnext<CR>'
  endif
endfor

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
  autocmd SourcePre */macros/less.vim setglobal laststatus=0
augroup END

" :cd, :lcd, and :tcd with tab-completion that supports the &cdpath.
"
" Inspired by Tim Pope's scriptease.vim[1] and its' :Vedit.
"
" [1]: https://github.com/tpope/vim-scriptease
function! s:cd_complete(A, L, P) abort
  let pattern = substitute(a:A, '/\|\/', '*/', 'g').'*'
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

if has('terminal')
  tnoremap <S-Space> <Space>
endif

if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

if filereadable('.git/safe/../../.vimrc.local')
  source .vimrc.local
endif
