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
  au VimResized * exe

"Visual thingys 
  set t_Co=256
  colo solarized
  set background=dark
  set number
  set scrolloff=3
  
"Plugins
  "NERDTree
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

"Keybindings
  "LEADER bindings
    noremap <LEADER>q :q!<CR>
    noremap <LEADER>l :set nu!<CR>
    noremap <LEADER>n :NERDTreeToggle<CR>
    noremap <LEADER>s :%s/
    noremap <LEADER>f /
      
  " sudo to write
  cmap w!! w !sudo tee % >/dev/null<CR>
  
  "Movement
    " buffers/panes
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h
      
    " bashery 
    inoremap <c-a> <esc>I
    inoremap <c-e> <esc>A
    cnoremap <c-a> <home>
    cnoremap <c-e> <end>

    " bashery removal in commandmode
    cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>

    " same as above, just with H and L
    noremap H ^
    noremap L g_

    " matching brackets and such
    noremap <tab> %

    " make D behave
    nnoremap D d$

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
  set textwidth=80

" search 
  set incsearch 
  set hlsearch 
  set showmatch
  set ignorecase
  set smartcase                                
  set gdefault
  nnoremap <LEADER><space> :noh<CR>  

  " keep search matches in the middle
  nnoremap n nzzzv
  nnoremap N Nzzzv
