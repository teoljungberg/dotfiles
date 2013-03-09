set nocompatible " IMproved
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
set clipboard=unnamed
set history=1000
set encoding=utf-8
let mapleader=","
set backspace=indent,eol,start
set showcmd
set wildmenu

" plugins
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-sleuth'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'epmatsw/ag.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'ervandew/supertab'
Bundle 'metamorfos/vim-unimpaired'
Bundle 'Sirupsen/vim-execrus'
runtime macros/matchit.vim

set t_Co=256 " visuals
colo solarized
set background=dark
set scrolloff=3
set ttyfast
syntax on
filetype plugin indent on
set statusline=%<%F\ %y\ %m%r\ %{fugitive#statusline()}%=%-8.(%l:%c%V%)
set list
set listchars=tab:>-,trail:.,extends:❯,precedes:❮

set directory=~/.cache/vim/swap
set backupdir=~/.cache/vim/backup
set undodir=~/.cache/vim/undo

set autoindent
set smartindent
set nowrap
set linebreak

set incsearch " search
set hlsearch
set ignorecase
set smartcase
set gdefault
noremap n nzzzv
noremap N Nzzzv
noremap * *<c-o>

" Run current spec file
nnoremap <leader>tt :!bundle exec rspec %<cr>
" Run spec under current line
nnoremap <leader>tl :!bundle exec rspec %:<c-r>=line('.')<cr><cr>

" NERDTree
noremap <silent> <leader>n :NERDTreeToggle<cr>
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
let g:ctrlp_max_files = 10000
let g:ctrlp_custom_ignore = {
                  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                  \ }
noremap <leader>. :CtrlPTag<cr>
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>m :CtrlPMRUFiles<cr>
let g:ctrlp_user_command = {
                  \ 'types': { 1: ['.git/', 'cd %s && git ls-files'] },
                  \ 'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
                  \ }

" Ag
noremap <leader>a :Ag<space>
let g:agprg="ag -S --nocolor --nogroup --column"

" Commentary
map cc gcc

" Solarized
call togglebg#map("<F5>")

" Fugitive
noremap <leader>gs :Gstatus<CR>
noremap <leader>gc :Gcommit -v<CR>
noremap <leader>gp :Git! push<CR>

"LEADER bindings
noremap <leader>s :%s//<left>
noremap <leader>ev :vsplit ~/.vimrc<cr>
noremap <leader>v V`]

" sudo to write
cmap w!! w !sudo tee % >/dev/null<cr>

" my fingers sometimes slip
command! W w

" easier to move
noremap H ^
noremap L g_

" Split lines
noremap K r<cr>

" Let's be reasonable, shall we?
" noremap k gk
" noremap j gj

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

