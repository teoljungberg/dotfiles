"General settings
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on
set nocompatible " IMproved
set clipboard=unnamed
set hidden
set autoread
set history=1000
set encoding=utf-8
let mapleader=","
set backspace=indent,eol,start

"Visual thingys 
set t_Co=256
colo solarized
set background=dark
set number
set scrolloff=3

"Plugins
  "NERDTree
  noremap <leader>n :NERDTreeToggle<cr>
  let NERDTreeChDirMode = 1
  let g:nerdtreewinsize = 25
  let NERDTreeHighlightCursorline=1

  "Gist
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 0
  let g:gist_show_privates = 1

  " Command-T
  let g:CommandTAcceptSelectionTabMap = '<CR>'
  let g:CommandTMaxHeight = 15

  " NERDcommenter
  map cc <leader>c<space>

  " Solarized
  call togglebg#map("<F6>")

  " matchit
  runtime macros/matchit.vim

"Keybindings
  "LEADER bindings
  noremap <leader>q :q!<cr>
  noremap <leader>l :set nu!<cr>
  noremap <leader>s :%s/
  noremap <leader>f /
  noremap <leader>ev :tabe ~/.vimrc<cr>
  noremap <leader>sv :vsplit<cr>
  noremap <leader>sp :split<cr>
      
  " sudo to write
  cmap w!! w !sudo tee % >/dev/null<cr>

  " unbind
  noremap K <nop>

"movement
  " buffers/panes
  map <c-j> <c-w>j
  map <c-k> <c-w>k
  map <c-l> <c-w>l
  map <c-h> <c-w>h
    
  " bashery 
  inoremap <c-a> <esc>I
  inoremap <c-e> <esc>A
  cnoremap <c-a> <home>
  cnoremap <c-e> <end>
  vnoremap <c-a> ^
  vnoremap <c-e> g_
  
  " bashery removal in commandmode
  cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>

  " true-er vim movement
  noremap H ^
  noremap L g_

  " matching brackets
  noremap <tab> %

  " make d behave
  nnoremap D d$

  " typos
    " commandmode
    command! -bang Q q<bang>
    command! -bang Wq wq<bang>
    command! -bang WQ wq<bang>
    command! -bang W w<bang>
    cnoremap q1 q!
    
    " my fingers sometimes slip
    nnoremap ; :
 
" no swap or backup 
set noswapfile
set nobackup
set nowritebackup

" sane intendation 
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab 
set autoindent

" wraps
set wrap 
set linebreak 
set textwidth=79

" search 
set incsearch 
set hlsearch 
set showmatch
set ignorecase
set smartcase                                
set gdefault
nnoremap <LEADER><space> :nohlsearch<cr>  

" open a quickfix window for the last search.
nnoremap <silent> <LEADER>? :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

" keep search matches in the middle
nnoremap n nzzzv
nnoremap N Nzzzv

