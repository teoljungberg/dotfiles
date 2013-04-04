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
set hidden
set textwidth=80

" plugins
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'epmatsw/ag.vim'
Bundle 'ervandew/supertab'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'metamorfos/vim-unimpaired'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-capslock'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rsi'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
runtime macros/matchit.vim

set t_Co=256 " visuals
colo solarized
set background=light
set scrolloff=3
set ttyfast
syntax on
filetype plugin indent on
set list
set listchars=tab:>-,trail:.,extends:❯,precedes:❮

" rspec syntax
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let around
highlight def link rubyRspec Function

set directory=~/.cache/vim/swap
set backupdir=~/.cache/vim/backup
set undodir=~/.cache/vim/undo

set autoindent
set smartindent
set nowrap
set linebreak

" foldings
nnoremap za <space>
vnoremap za <space>
nnoremap zO zCzO

set incsearch " search
set hlsearch
set ignorecase
set smartcase
set gdefault
noremap n nzzzv
noremap N Nzzzv

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
noremap <leader>. :CtrlPTag<cr>
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>m :CtrlPMRUFiles<cr>
let g:ctrlp_map = '<leader><leader>'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'cr'
let g:ctrlp_max_files = 10000
let g:ctrlp_custom_ignore = {
                  \ 'dir':  '\v[\/]\.(git|hg|svn)$\|tmp\|log',
                  \ }
let g:ctrlp_user_command = {
                  \ 'types': { 1: ['.git/', 'cd %s && git ls-files'] },
                  \ 'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
                  \ }

" Ag
noremap <leader>a :Ag<space>
let g:agprg="ag -S --nocolor --nogroup --column"

" Solarized
call togglebg#map("<F5>")

" Fugitive
noremap <leader>gs :Gstatus<CR>
au BufWinEnter */index if &ft == 'gitcommit' | wincmd H | endif
autocmd BufReadPost fugitive://* set bufhidden=delete


" Powerline
let g:Powerline_colorscheme = 'solarized'
let g:Powerline_theme = 'solarized16'

"LEADER bindings
noremap <leader>sr :%s//<left>
noremap <leader>ev :vsplit ~/.vimrc<cr>
noremap <leader>v V`]

" sudo to write
cmap w!! w !sudo tee % >/dev/null<cr>

" my fingers sometimes slip
command! W w
command! Q q
command! Qa qa
command! Wq wq
command! Wqa wqa

" easier to move
noremap H ^
noremap L g_

" jump to tag
noremap <leader>j <C-]>

" Yank 'til end of line
noremap Y yg_

" Split lines
noremap K r<cr>

" Unmappings
noremap Q <Nop>

" Let's be reasonable, shall we?
noremap k gk
noremap j gj

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" macros
let @l='^xilet(:ea)f=xxvg_S{^'

