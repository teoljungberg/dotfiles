"General settings
    filetype off
    call pathogen#infect()
    set nocompatible
    syntax on
    filetype plugin indent on
    set hidden
    set t_Co=256
    set autoread
    set history=1000
    set encoding=utf-8
    let mapleader=","
    au VimResized * exe

"Visual thingys 
    set background=dark
    colo solarized
    set guifont=Monaco:h12
    set number
    command Light :set background=light
    command Dark :set background=dark
    set scrolloff=3

"Plugins
    "NERDTree
    let NERDTreeChDirMode = 1
    let g:nerdtreewinsize = 20
    let NERDTreeHighlightCursorline=1
    
    "Gist
    let g:gist_clip_command = 'pbcopy'
    let g:gist_detect_filetype = 1
    let g:gist_open_browser_after_post = 0

"Keybindings
    "Leader bindings
        "LEADER + w to save
        noremap <Leader>w :update<CR>
        "LEADER + q quits all open panes
        noremap <Leader>q :qa!<CR>
        "LEADER + l shows/hides linenumbers
        noremap <Leader>l :set nu!<CR>
        "LEADER + n Toggles NERDTree
        noremap <LEADER>n :NERDTreeToggle<CR>
        "LEADER + s opens up search and replace
        noremap <LEADER>s :%s/

    "Sudo to write
    cmap w!! w !sudo tee % >/dev/null<CR>
    
    "Movement
        "nicer to the hands
        inoremap jk <esc>
        
        " moving between buffers/panes
        map <C-J> <C-W>j
        map <C-K> <C-W>k
        map <C-L> <C-W>l
        map <C-H> <C-W>h
        map <C-K> <C-W>k
        
        "disable arrow keys in normal and visualmode, but keeping them in insertmode
        nnoremap <up> <nop>
        nnoremap <down> <nop>
        nnoremap <left> <nop>
        nnoremap <right> <nop>
        
        " Bashery movements
        inoremap <c-a> <esc>I
        inoremap <c-e> <esc>A

        "Same as above, just with H and L
        noremap H ^
        noremap L g_
     
    "my fingers sometimes slip
    nnoremap ; :

    "easier to type
        " to comment out lines with tpope/vim-commentary, § is alot easier to hit than \ on a swedish
        " keyboard
        nnoremap § \

" swap and tmp files
"set backupdir=~/.vim/tmp/
"set directory=~/.vim/tmp/

" disables the creating of the swap and tmp files
set noswapfile
set nobackup
set nowritebackup

"Default intendation settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab 
set autoindent

"Foldsettings
set foldmethod=indent
set foldnestmax=3
set nofoldenable

set smartcase                                
set ignorecase
set gdefault

" Wraps
    set wrap "dont wraplines
    set linebreak "wrap lines at convenient places
    set textwidth=79

"Search settings
    set incsearch "find next match
    set hlsearch "highlight search result
    set showmatch
    set ignorecase
    nnoremap <leader><space> :noh<cr> 

    " Keep search matches in the middle of the window and pulse the line when
    " moving
    " " to them.
    nnoremap n nzzzv
    nnoremap N Nzzzv
