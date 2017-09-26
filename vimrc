set nocompatible
filetype off
set history=1000
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
if v:version > 703
  set nofileignorecase
  set nowildignorecase
end
set noswapfile
set nobackup
set backupskip=/tmp/*,/private/tmp/*
set smartindent
set nowrap
set incsearch
set shortmess=aoOtsT
if exists("+completefunc") && &completefunc == ""
  set completefunc=syntaxcomplete#Complete
endif
set scrolljump=-50
set laststatus=2
syntax on
filetype plugin indent on
set list
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:•
set statusline=[%n]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set cmdheight=2
set lazyredraw
set nojoinspaces
" When the type of shell script is /bin/sh, assume a POSIX-compatible shell for
" syntax highlighting purposes.
" More on why: https://github.com/thoughtbot/dotfiles/pull/471
let g:is_posix = 1

" plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', 'vendor/{}')
runtime macros/matchit.vim

silent! colorscheme solarized
set background=light
set t_Co=256

" automatically create undodir if it doesn't exist
set undodir=~/.cache/vim/undo//
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

" close current buffer
noremap <leader>d :bd<cr>

" convenience mappings
noremap Y y$
noremap Q <nop>
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" close everything
nnoremap <silent> <c-w>z :wincmd z<Bar>cclose<Bar>lclose<Bar>helpclose<CR>

" re-select the last pasted text
noremap gV V`]

" duplicate the visually selected block
vmap D y'>p

" open files in directory of current file
cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>s :split %%
map <leader>v :vsplit %%
map <leader>t :tabedit %%
map <leader>r :read %%

" toggle between the two most recent files
noremap <c-\> :edit #<cr>

" open the tag under the cursor using `:ltag`
noremap <c-w>\ :ltag <c-r>=expand("<cword>")<cr><cr>

" Only have the current split and tab open
command! O :silent only<bar>silent tabonly

" open `:tag` in splits, and tabs
cabbrev vtag vsplit<bar>tag
cabbrev ttag tabnew<bar>tag
"
" open `:buffer` in splits, and tabs
cabbrev vbuffer vsplit<bar>buffer
cabbrev vb      vsplit<bar>buffer
cabbrev tbuffer tabnew<bar>buffer
cabbrev tb      tabnew<bar>buffer

" emacs movement
" stolen from tpope/vim-rsi
inoremap <expr> <c-e> col('.')>strlen(getline('.'))?"\<lt>c-e>":"\<lt>end>"
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

augroup vimrcEx
  autocmd!

  autocmd WinEnter,BufWinEnter,CursorHold * silent! checktime
augroup END
