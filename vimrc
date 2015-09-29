set nocompatible
filetype off
set history=1000
let mapleader=" "
set backspace=indent,eol,start
set hidden
set ttimeout ttimeoutlen=50
set splitright
set tags=.git/tags,tags
set shiftround
set autoread
set autowrite
set updatetime=2000
set nofoldenable
set relativenumber
set showcmd
set wildmode=list:full
set tagbsearch
set textwidth=80

" plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', 'vendor/{}')
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

" leader bindings
noremap <leader>r :%s//<left>
noremap <leader>d :bd<cr>

" convenience mappings
command! -bang W w
command! -bang Q q
command! -bang Qa qa
command! -bang Wq wq
command! -bang Wqa wqa
noremap Y y$
noremap Q <nop>
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" close everything
nnoremap <silent> <c-w>z :wincmd z<Bar>cclose<Bar>lclose<CR>

" re-select the last pasted text
noremap gV V`]

" duplicate the visually selected block
vmap D y'>p

" open files in directory of current file
cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" toggle between the two most recent files
noremap <c-\> :edit #<cr>

" emacs movement
" stolen from tpope/vim-rsi
inoremap <expr> <c-e> col('.')>strlen(getline('.'))?"\<lt>c-e>":"\<lt>end>"
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

augroup vimrcEx
  autocmd!

  autocmd WinEnter,BufWinEnter,CursorHold * silent! checktime
augroup END
