"General settings
  call pathogen#infect()
  call pathogen#helptags()
  filetype plugin indent on
  syntax on
  set nocompatible " IMproved
  set clipboard=unnamed
  set hidden
  set t_Co=256
  set autoread
  set history=1000
  set encoding=utf-8
  let mapleader=","
  set backspace=indent,eol,start
  au VimResized * exe

"Visual thingys 
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

"Keybindings
  "LEADER bindings
    "LEADER + w to save
    noremap <LEADER>w :update<CR>
    "LEADER + q quits the open pane
    noremap <LEADER>q :q!<CR>
    "LEADER + l shows/hides linenumbers
    noremap <LEADER>l :set nu!<CR>
    "LEADER + n Toggles NERDTree
    noremap <LEADER>n :NERDTreeToggle<CR>
    "LEADER + s opens up search and replace
    noremap <LEADER>s :%s/
    "LEADER + f opens up search
    noremap <LEADER>f /
      
  " sudo to write
  cmap w!! w !sudo tee % >/dev/null<CR>
  
  "Movement
    " moving between buffers/panes
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h
      
    " bashery movements
    inoremap <c-a> <esc>I
    inoremap <c-e> <esc>A

    " same as above, just with H and L
    noremap H ^
    noremap L g_

    " Moving between tabs
    noremap J :tabprevious<CR>
    noremap K :tabnext<CR>

  " my fingers sometimes slip
  nnoremap ; :
   
" disables the creating of the swap and tmp files
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
  nnoremap <LEADER><space> :noh<CR>  
  set smartcase                                
  set ignorecase
  set gdefault

  " Keep search matches in the middle of the window and pulse the line when
  " moving to them.
  nnoremap n nzzzv
  nnoremap N Nzzzv
