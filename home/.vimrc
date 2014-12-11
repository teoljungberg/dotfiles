set nocompatible
filetype off
set rtp+=~/.vim/bundle/neobundle.vim
set history=1000
let mapleader=" "
set backspace=indent,eol,start
set wildmenu
set hidden
set ttimeout ttimeoutlen=50
set t_te= t_ti=
set splitright
set tags=.git/tags,tags
set shiftround
set autoread
set autowrite
set updatetime=2000
set nofoldenable
set relativenumber

" plugins
call neobundle#begin(expand("~/.vim/bundle/"))
NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "Shougo/vimproc", { "build" : { "mac" : "make -f make_mac.mak" } }
NeoBundle "altercation/vim-colors-solarized"
NeoBundle "kana/vim-textobj-user"
NeoBundle "kchmck/vim-coffee-script"
NeoBundle "nelstrom/vim-textobj-rubyblock"
NeoBundle "teoljungberg/vim-grep"
NeoBundle "teoljungberg/vim-visual-star-search"
NeoBundle "tommcdo/vim-exchange"
NeoBundle "tpope/vim-abolish"
NeoBundle "tpope/vim-bundler"
NeoBundle "tpope/vim-commentary"
NeoBundle "tpope/vim-dispatch"
NeoBundle "tpope/vim-endwise"
NeoBundle "tpope/vim-fugitive"
NeoBundle "tpope/vim-git"
NeoBundle "tpope/vim-liquid"
NeoBundle "tpope/vim-markdown"
NeoBundle "tpope/vim-projectionist"
NeoBundle "tpope/vim-rails"
NeoBundle "tpope/vim-rake"
NeoBundle "tpope/vim-repeat"
NeoBundle "tpope/vim-sleuth"
NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-unimpaired"
NeoBundle "tpope/vim-vinegar"
NeoBundle "vim-ruby/vim-ruby"
call neobundle#end()
call neobundle#local(expand("~/.vim/vendor/"))

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
set statusline=[%n]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set noswapfile
set nobackup
set backupskip=/tmp/*,/private/tmp/*

" automatically create undodir if it doesn't exist
set undodir=~/.cache/vim/undo//
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

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

" leader bindings
noremap <leader>sr :%s//<left>

" convenience mappings
command! -bang W w
command! -bang Q q
command! -bang Qa qa
command! -bang Wq wq
command! -bang Wqa wqa
noremap Y y$
noremap ö :
noremap Ö :
noremap Q <nop>
noremap K <nop>
cnoremap <c-g> <c-f>
noremap 0 ^
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" system clipboard integration
nnoremap gy "*y
nnoremap gY "*Y
nnoremap gp "*p
nnoremap gP "*P

vnoremap gy "*y
vnoremap gp "*p
vnoremap gP "*P

" close everything
nnoremap <silent> <c-w>z :wincmd z<Bar>cclose<Bar>lclose<CR>

" re-select the last pasted text
noremap gV V`]

" swap ` and '
noremap ' `
noremap `  '

" autocomplete Tag to tag
command! -complete=tag -nargs=1 Tag tag <args>

" open files in directory of current file
cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" emacs movement
" stolen from tpope/vim-rsi
inoremap <expr> <c-e> col('.')>strlen(getline('.'))?"\<lt>c-e>":"\<lt>end>"
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

augroup vimrcEx
  autocmd!

  autocmd WinEnter,BufWinEnter,CursorHold * silent! checktime
  autocmd FileType help map <silent> <buffer> q :q<cr>
augroup END
