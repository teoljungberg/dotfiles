set nocompatible " IMproved
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
set clipboard=unnamed
set encoding=utf-8
let mapleader=","
set textwidth=80
set ttimeout
set ttimeoutlen=50

" plugins
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'epmatsw/ag.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'kongo2002/vim-space'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'metamorfos/vim-unimpaired'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'

colo solarized " visuals
set background=light
syntax on
filetype plugin indent on
set list
set listchars=tab:>-,trail:.,extends:❯,precedes:❮
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" for writing in vim
au FileType markdown,text set fo=crotqaw

set backupskip=/tmp/*,/private/tmp/*

set smartindent
set nowrap

set ignorecase " search
set smartcase
set gdefault
noremap n nzzzv
noremap N Nzzzv
noremap * *zzzv
noremap # #zzzv

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
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>m :CtrlPMRUFiles<cr>
let g:ctrlp_map = '<leader><leader>'
let g:ctrlp_show_hidden = 1
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

" Fugitive
noremap <leader>gs :Gstatus<CR>
au BufWinEnter */index if &ft == 'gitcommit' | wincmd H | endif
au FileType gitcommit set textwidth=50
au BufReadPost fugitive://* set bufhidden=delete

" Dispatch
noremap <leader>t :Dispatch <up><cr>
noremap <leader>l :Dispatch <up>:<c-r>=line('.')<cr><cr>

" Rails
noremap <leader>em :Emodel<space>
noremap <leader>vm :Vmodel<space>
noremap <leader>ec :Econtroller<space>
noremap <leader>vc :Econtroller<space>

" Markdown
au FileType markdown,text set textwidth=71

"LEADER bindings
noremap <leader>sr :%s//<left>
noremap <leader>v V`]

" sudo to write
cmap w!! w !sudo tee % >/dev/null<cr>

" my fingers sometimes slip
command! W w
command! Q q
command! Wqa wqa

" convenience mappings
noremap H ^
noremap L g_
inoremap <tab> <c-n>

" emacs movement
inoremap <c-e> <esc>A
inoremap <c-a> <esc>I
cnoremap <c-e> <end>
cnoremap <c-a> <home>

" find backwards
noremap - ,

" Unmappings
noremap Q <Nop>
noremap K <Nop>

" Let's be reasonable, shall we?
noremap k gk
noremap j gj

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

