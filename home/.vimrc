set nocompatible " IMproved
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
syntax on
set clipboard=unnamed
set history=1000
set encoding=utf-8
let mapleader=","
set backspace=indent,eol,start
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" plugins
Bundle 'gmarik/vundle'
Bundle 'mileszs/ack.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-commentary'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-ruby/vim-ruby'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'

set t_Co=256 " visuals
colo solarized
set background=dark
set scrolloff=3
set ttyfast
filetype plugin indent on
set statusline=%<%f\ %y\ %m%r\ %{fugitive#statusline()}%=%-8.(%l:%c%V%)

set nowritebackup " no backups
set nobackup
set noswapfile

set shiftwidth=2 " intendation
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set wrap
set linebreak

set incsearch " search
set hlsearch
set ignorecase
set smartcase
set gdefault
nnoremap n nzzzv
nnoremap N Nzzzv

" NERDTree
noremap <leader>n :NERDTreeToggle<cr>
let NERDTreeChDirMode = 1
let NERDTreeMinimalUI = 1
let NERDTreeWinPos = 'right'

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 0

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_map = '<leader>,'
let g:ctrlp_working_path_mode = 'cr'
let g:ctrlp_clear_cache_on_exit = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
noremap <leader>. :CtrlPTag<cr>
noremap <leader>b :CtrlPBuffer<cr>

" Ack
noremap <leader>a :Ack 
let g:ackprg = 'ag -S --nogroup --nocolor --column'

" NERDcommenter
map cc <leader>c<space>

" Solarized
call togglebg#map("<F5>")

" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v<CR>

"LEADER bindings
noremap <leader>s :%s//<left>
noremap <leader>ev :vsplit ~/.vimrc<cr>
noremap <LEADER><space> :nohls<cr>
noremap <leader>v V`]
    
" sudo to write
cmap w!! w !sudo tee % >/dev/null<cr>

" my fingers sometimes slip
nnoremap ; :
command! W w

" easier to type
noremap H ^
noremap L g_

" unbind
noremap K <nop>
noremap J <nop>

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
  
" emacs movement in insert/command mode
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>
