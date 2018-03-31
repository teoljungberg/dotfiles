set nocompatible

set autoread
set autowrite
set backspace=indent,eol,start
set backupskip=/tmp/*,/private/tmp/*
set cmdheight=2
set hidden
set history=1000
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:•
set nobackup
set nofileignorecase
set nofoldenable
set nojoinspaces
set noswapfile
set nowildignorecase
set nowrap
set number
set numberwidth=5
set scrolloff=1
set shiftround
set shortmess=aoOtsT
set showcmd
set sidescrolloff=5
set smartindent
set splitright
set statusline=[%n]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set tags=.git/tags,tags
set textwidth=80
set ttimeout ttimeoutlen=50
set wildmode=list:longest,list:full
syntax enable

if v:version > 703
  set nofileignorecase
  set nowildignorecase
end

" When the type of shell script is /bin/sh, assume a POSIX-compatible shell for
" syntax highlighting purposes.
" More on why: https://github.com/thoughtbot/dotfiles/pull/471
let g:is_posix = 1

set mouse=nvi
if $TERM =~ "^screen"
  if exists("+mouse")
    set ttymouse=xterm2
  endif
endif

filetype plugin indent on

" plugins
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
function! CloseTerminalBuffers()
  if has("terminal")
    for term in term_list() | exec ":bd " . term | endfor
  endif
endfunction
nnoremap <silent> <c-w>z :
      \ wincmd z<Bar>
      \ cclose<Bar>
      \ lclose<Bar>
      \ pclose<Bar>
      \ helpclose<Bar>
      \ silent call CloseTerminalBuffers()
      \ <CR>

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

" In the following file `app/services/foo_bar.rb`, `%t` is expanded to
" `services/foo_bar`. Which useful for creating tests by i.e `:Vspec %t!` (which
" is expanded to `:Vspec services/foo_bar!`.
" This is only done for files under `app`.
cnoremap %t <C-R>=substitute(expand("%:r"), "^app[^/]*.", "", "")<CR>

" toggle between the two most recent files
noremap <leader><leader> :edit #<cr>

" open the tag under the cursor using `:ltag`
noremap <c-w>\ :ltag <c-r>=expand("<cword>")<cr><cr>

" Only have the current split and tab open
command! O :silent only<bar>silent tabonly

" open `:tag` in splits, and tabs
cabbrev vtag vertial stag
cabbrev vt   vertial stag
cabbrev ttag tab stag
cabbrev tt   tab stag
"
" open `:buffer` in splits, and tabs
cabbrev vbuffer vertical sbuffer
cabbrev vb      vertical sbuffer
cabbrev tbuffer tab sbuffer
cabbrev tb      tab sbuffer

" Given this situation:
"     user.fo|o!
" When I press <C-]> to go to the `foo!` tag, for some reason it acts as if the
" cursor is on `user` and goes to the `user` tag.
"
" To fix this, use `<cword>` to select the word under the cursor and go to it
" directly.
nnoremap <C-]>      :tag <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-W><C-]> :stag <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-W>]     :stag <C-R>=expand("<cword>")<CR><CR>

" Get the current line number
cnoremap <C-R><C-L> <C-R>=line(".")<CR>

" Add the current `WORD` (rather than `word`) under the cursor
cnoremap <C-R>W <C-R><C-A>

" emacs movement
" stolen from tpope/vim-rsi
inoremap <expr> <c-e> col('.')>strlen(getline('.'))?"\<lt>c-e>":"\<lt>end>"
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

if has("terminal")
  tnoremap <ESC> <C-\><C-N>
endif

nnoremap <silent> <C-L>
      \ :nohlsearch <C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-L>

augroup vimrcEx
  autocmd!

  autocmd FileType *
        \ if exists("+completefunc") && &completefunc == "" |
        \   setlocal completefunc=syntaxcomplete#Complete |
        \ endif
  autocmd FileType *
        \ if exists("+omnifunc") && &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup END

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
