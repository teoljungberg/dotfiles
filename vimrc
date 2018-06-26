set nocompatible

set autoread
set autowrite
set backspace=indent,eol,start
set backupskip=/tmp/*,/private/tmp/*
set cmdheight=2
set complete+=kspell
set complete-=i
set display=lastline
set hidden
set history=1000
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:+
set nobackup
set nofoldenable
set nojoinspaces
set noswapfile
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
set synmaxcol=200
set tags=.git/tags,tags
set textwidth=80
set ttimeout ttimeoutlen=50
set updatetime=1000
set wildmode=list:longest,list:full
syntax enable

" Enforce italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

if v:version > 703
  set nofileignorecase
  set nowildignorecase
end

" When the type of shell script is /bin/sh, assume a POSIX-compatible shell for
" syntax highlighting purposes.
" More on why: https://github.com/thoughtbot/dotfiles/pull/471
let g:is_posix = 1

set mouse=nvi
if $TERM =~ "^xterm"
  if exists("+mouse")
    set ttymouse=xterm2
  endif
endif

filetype plugin indent on

if has("packages")
  packadd matchit
else
  runtime macros/matchit.vim
endif

silent! colorscheme solarized
set background=light

" automatically create undodir if it doesn't exist
set undodir=~/.cache/vim/undo//
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

cabbrev rg <c-r>=(getcmdtype()==":" && getcmdpos()==1 ? "gr" : "rg")<CR>

if executable("rg")
  set grepprg=rg\
        \ --hidden\
        \ --glob\ '!.git'\
        \ --glob\ '!tags'\
        \ --vimgrep\
        \ --with-filename
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH
endif

" close current buffer
noremap <leader>d :bd<cr>

" convenience mappings
noremap Y y$
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" Record macro with `qq`, replay with `Q`
nnoremap Q @q

" close everything
function! s:CloseTerminalBuffers()
  if has("terminal")
    for term in term_list() | exec ":bd! " . term | endfor
  endif
endfunction
nnoremap <silent> <c-w>z :
      \ wincmd z<Bar>
      \ cclose<Bar>
      \ lclose<Bar>
      \ pclose<Bar>
      \ helpclose<Bar>
      \ silent call <SID>CloseTerminalBuffers()
      \ <CR>

" re-select the last pasted text
noremap gV V`]

" duplicate the visually selected block
vmap D y'>p

" pre-fill the visual selection in command mode
vmap <Space> ygv:<C-U><Space><C-R>"<Home>

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
cabbrev vtag vertical stag
cabbrev vt   vertical stag
cabbrev ttag tab stag
cabbrev tt   tab stag

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

" system clipboard integration
nnoremap gy "*y
nnoremap gY "*y$
nnoremap gp "*p
nnoremap gP "*P

vnoremap gy "*y
vnoremap gp "*p
vnoremap gP "*P

if has("terminal")
  tnoremap <ESC> <C-\><C-N>
endif

nnoremap <silent> <C-L>
      \ :nohlsearch <C-R>=has("diff") ? "<Bar>diffupdate" : ""<CR><CR><C-L>

function! BufferOpen(buffer_name)
  let buffer_list = 0
  redir =>buffer_list
  silent! ls
  redir END

  for buffer_number in map(
        \ filter(split(buffer_list, "\n"), "v:val =~ '" . a:buffer_name . "'"),
        \ "str2nr(matchstr(v:val, '\\d\\+'))")
    if bufwinnr(buffer_number) != -1
      return 1
    endif
  endfor

  return 0
endfunction!

nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap yoq :<C-R>=BufferOpen("Quickfix List") ? "cclose" : "copen"<CR><CR>

nnoremap [ot :setlocal cc=&textwidth<CR>
nnoremap ]ot :setlocal cc=0<CR>
nnoremap yot :setlocal cc=<C-R>=&cc == 0 ? &textwidth : 0<CR><CR>

function! s:ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call <SID>ExecuteMacroOverVisualRange()<CR>

" Strip trailing whitespace, and save last search, and cursor position.
function! s:PreservePositionAfterCommand(command)
  let l:save = winsaveview()
  execute a:command
  call winrestview(l:save)
endfunction

command! StripTrailingWhitespace :
      \ call <SID>PreservePositionAfterCommand(':%s/\s\+$//e')

" Jumps to the last known position in a file, except in the filetypes that are
" blacklisted.
augroup JumpToLastKnownPosition
  autocmd!
  autocmd BufReadPost *
        \ if (
        \   index(["gitcommit", "gitrebase"], &ft) < 0
        \ ) && (
        \   line("'\"") > 0 && line("'\"") <= line("$")
        \ ) |
        \   exe "normal g`\"" |
        \ endif
augroup END

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

  autocmd SourcePre */macros/less.vim set laststatus=0 cmdheight=1
augroup END

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
