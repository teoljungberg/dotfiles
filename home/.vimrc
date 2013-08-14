set nocompatible " IMproved
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
set clipboard=unnamed
set history=1000
set encoding=utf-8
let mapleader=" "
set backspace=indent,eol,start
set wildmenu
set hidden
set ttyfast
set ttimeout
set ttimeoutlen=50
set t_te= t_ti=

" plugins
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'teoljungberg/vim-grep'
Bundle 'teoljungberg/vim-test'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-liquid'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wincent/Command-T'
runtime macros/matchit.vim

colo solarized " visuals
set t_Co=256
set background=light
set scrolloff=3
set scrolljump=-50
set laststatus=2
syntax on
filetype plugin indent on
set list
set listchars=tab:>-,trail:.,extends:❯,precedes:❮
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Explore
let g:netrw_browse_split=0
let g:netrw_liststyle=3
let g:netrw_banner=0

set backupskip=/tmp/*,/private/tmp/*
set directory=~/.cache/vim/swap//
set backupdir=~/.cache/vim/backup//
set undodir=~/.cache/vim/undo//

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
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

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 0

" Command-t
noremap <leader><leader> :CommandT<CR>
noremap <leader>f :CommandTFlush<CR>:CommandT<CR>
let g:CommandTMaxFiles=15000
let g:CommandTMaxHeight=30
let g:CommandTMatchWindowReverse=1
let g:CommandTAlwaysShowDotFiles=1
let g:CommandTCancelMap=['<ESC>', '<C-c>']
set wildignore+=public/assets/**,vendor/**,log/**,tmp/**,Cellar/**,app/assets/images/**,_site/**

" Fugitive
noremap <leader>gs :Gstatus<CR>
noremap <leader>gl :Dispatch git --no-pager log --oneline -15 <CR>
noremap <leader>ge 0wyaw<c-w>k:Gedit <c-r>"<CR>

" vim-grep
noremap <leader>gg :Grep!<space>

" vim-test
noremap <leader>t :RunTestFile<CR>
noremap <leader>l :RunNearestTest<CR>

" Unimpaired
map ( [
map ) ]

"LEADER bindings
noremap <leader>sr :%s//<left>
noremap <leader>v V`]
noremap <leader>p :s/\v([a-z_][a-zA-Z0-9_]*) \= (.+)/let(:\1) { \2 }<CR>

" sudo to write
cmap w!! w !sudo tee % >/dev/null<cr>

" convenience mappings
noremap H ^
noremap L g_
command! W w
command! Q q
noremap Y y$
noremap ö :

" open files in directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" emacs movement
inoremap <c-e> <esc>A
inoremap <c-a> <esc>I
cnoremap <c-e> <end>
cnoremap <c-a> <home>

" Unmappings
noremap Q <Nop>
noremap K <Nop>

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

augroup vimrcEx
  autocmd!
  " jumps to the last known position in a file
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  autocmd BufReadPost fugitive://* set bufhidden=delete

  " for writing in vim
  autocmd FileType markdown,text,liquid set fo=crotqaw nolist

  autocmd FileType html,javascript,css,markdown,liquid set ai sw=4 sts=4 et
augroup END

" save last search, and cursor position.
function! Preserve(command)
  let _s=@/
  let l = line('.')
  let c = col('.')
  execute a:command
  " restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
command! StripTrailingWhitespace :call Preserve(':%s/\s\+$//e')

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
