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
set number
set numberwidth=5
set showcmd
set wildmode=list:longest,list:full
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

set mouse=nvi
if $TERM =~ "^screen"
  if exists("+mouse")
    set ttymouse=xterm2
  endif
endif

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
  for b in term_list()
    exec ":bd " . b
  endfor
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
cnoremap %t <C-R>=substitute(expand("%:r"), "^[^/]*.", "", "")<CR>

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

" emacs movement
" stolen from tpope/vim-rsi
inoremap <expr> <c-e> col('.')>strlen(getline('.'))?"\<lt>c-e>":"\<lt>end>"
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

if has("terminal")
  tnoremap <ESC> <C-\><C-N>
endif

augroup vimrcEx
  autocmd!

  autocmd WinEnter,BufWinEnter,CursorHold * silent! checktime
augroup END

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
