set nocompatible " IMproved
filetype off
set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))
set clipboard=unnamed
set history=1000
let mapleader=" "
set backspace=indent,eol,start
set wildmenu
set hidden
set ttimeout ttimeoutlen=50
set t_te= t_ti=
set splitright
set tags=.git/tags
set shiftround
set autoread
set updatetime=2000

" plugins
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build' : { 'mac' : 'make -f make_mac.mak' } }
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'teoljungberg/vim-grep'
NeoBundle 'teoljungberg/vim-test'
NeoBundle 'teoljungberg/vim-visual-star-search'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-liquid'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-projectionist'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-tbone'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'wincent/Command-T', { 'build' : { 'mac' : 'ruby ruby/command-t/extconf.rb && make -f ruby/command-t/Makefile' } }
runtime macros/matchit.vim

silent! colorscheme solarized " visuals
set background=light
set t_Co=256
set scrolljump=-50
set laststatus=2
syntax on
filetype plugin indent on
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set winwidth=100

set noswapfile
set nobackup
set backupskip=/tmp/*,/private/tmp/*
set undodir=~/.cache/vim/undo//

set smartindent
set nowrap

set ignorecase " search
set incsearch
set smartcase
set gdefault
noremap n nzzzv
noremap N Nzzzv
noremap * *zzzv
noremap # #zzzv

" command-t
noremap <leader><leader> :CommandT<cr>
noremap <leader>f :CommandTFlush<cr>:CommandT<cr>
noremap <leader>7 :CommandTTag<cr>
let g:CommandTMaxHeight=30
let g:CommandTMatchWindowReverse=1
let g:CommandTAlwaysShowDotFiles=1
let g:CommandTScanDotDirectories=1
let g:CommandTCancelMap=['<esc>', '<C-c>']
let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']
set wildignore+=.git/**
set wildignore+=**/public/assets/**,**/app/assets/images/**,**/*.keep,**/vendor/cache/**,**/tmp/**,**/pkg/**,**/log/**
set wildignore+=**/Cellar/**,**/home/.vim/bundle/**,**/_site/**
set wildignore+=**/*.netrw*,**/*.DS_Store

" fugitive
fun! s:gm(short, cmd, ...)
  let silent = a:cmd =~ '\w$' ? '<silent>' : ''
  let cr = a:cmd =~ '\w$' ? '<cr>' : ''
  let extra = a:0 ? a:1 : ''
  exec "nmap" silent a:short ":" . a:cmd . cr . extra
endfunction

call s:gm('gs', 'Gstatus', '<c-n>')
call s:gm('gd', 'Gdiff')
call s:gm('gb', 'Gblame')

" vim-grep
noremap <leader>gg :Grep!<space>
noremap <leader>ga :GrepAdd!<space>

" vim-test
noremap <leader>t :RunTestFile<cr>
noremap <leader>l :RunNearestTest<cr>

" unimpaired
exec "nmap ( ["
exec "nmap ) ]"

" bubbling text
vmap <up> [egv
vmap <down> ]egv

" surround
let g:surround_{char2nr('%')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('#')} = "#{\r}"

" dispatch
noremap <leader>d :Dispatch <up><cr>

" netrw
let g:netrw_localrmdir = "rm -rf"

" tbone
command! Autotest             :Tmux split-window -h 'autotest'
command! AutotestWithWarnings :Tmux split-window -h 'RUBYOPT=-w autotest'
command! Guard                :Tmux split-window -h 'bundle exec guard'

" projections
noremap <c-w>a :A<cr>

" leader bindings
noremap <leader>sr :%s//<left>
noremap <silent> <leader>o :only<cr>

" convenience mappings
command! -bang W w
command! -bang Q q
command! -bang Wq wq
command! -bang Wqa wqa
noremap Y y$
noremap ö :
noremap Ö :
noremap K <nop>
cnoremap <c-g> <c-f>
noremap 0 ^

" re-select the last pasted text
noremap gV V`]

" search for what is in the clipboard
noremap g" /\v<<C-r>*><cr>

" swap ` and '
noremap ' `
noremap `  '

" autocomplete Tag to tag
command! -complete=tag -nargs=1 Tag tag <args>

" open files in directory of current file
cnoremap %% <c-r>=expand('%:p:h').'/'<cr>
map <leader>e :edit %%

" open tag in splits
noremap <leader>] <c-w>v<c-]>
noremap <leader>[ <c-w>s<c-]>

" emacs movement
inoremap <c-e> <esc>A
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

augroup vimrcEx
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd FileType help,gitcommit,qf map <silent> <buffer> q :q<CR>

  autocmd FileType gitcommit,qf,git setlocal nolist
  autocmd FileType gitcommit setlocal spell

  autocmd WinEnter,BufWinEnter,CursorHold * silent! checktime
augroup END
