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

Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
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

" Mouse scrolling in normal mode
set mouse=n

" Explore
let g:netrw_browse_split=0
let g:netrw_liststyle=3
let g:netrw_banner=0

" for writing in vim
au FileType markdown,text,liquid set fo=crotqaw nolist

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
au BufReadPost fugitive://* set bufhidden=delete
noremap <leader>gg :Ggrep<space>

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

" emacs movement
inoremap <c-e> <esc>A
inoremap <c-a> <esc>I
cnoremap <c-e> <end>
cnoremap <c-a> <home>

" remove trailing whitespace
command! StripTrailingWhitespace :call RemovePattern('%s/\\s\\+$//e')
function! RemovePattern(command)
  let _s=@/
  let l = line('.')
  let c = col('.')
  execute a:command
  " restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" jumps to the last known position in a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k' | return "\<tab>" | else | return "\<c-n>" | endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Unmappings
noremap Q <Nop>
noremap K <Nop>

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Running tests
command! RunTestFile :call RunTestFile()
command! RunNearestTest :call RunNearestTest()
map <leader>t :RunTestFile<CR>
map <leader>l :RunNearestTest<CR>

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.

  let in_test_file = match(expand("%"), '\(_test.rb\|_spec.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:test_file")
    return
  endif
  call RunTests(t:test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction

" Set the spec file that tests will be run for.
function! SetTestFile()
  let t:test_file=@%
endfunction

" Write the file and run tests for the given filename
function! RunTests(filename)
  write
  let base_cmd = ":Dispatch "

  if match(a:filename, '_test.rb$') != -1
    exec base_cmd . "ruby " . a:filename
  elseif match(a:filename, '_spec.rb$') != -1
    if filereadable("config/application.rb")
      exec base_cmd . "spring rspec " . a:filename
    elseif filereadable("Gemfile")
      exec base_cmd . "bundle exec rspec " . a:filename
    else
      exec base_cmd . "rspec " . a:filename
    endif
  endif
endfunction
