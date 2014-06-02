noremap <leader><leader> :CommandT<cr>
noremap <leader>f :CommandTFlush<cr>:CommandT<cr>
noremap <leader>7 :CommandTTag<cr>
let g:CommandTMaxHeight=30
let g:CommandTMatchWindowReverse=1
let g:CommandTAlwaysShowDotFiles=1
let g:CommandTScanDotDirectories=1
let g:CommandTCancelMap=['<esc>', '<C-c>']
let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']
set wildignore+=.git/**
set wildignore+=**/public/assets/**,**/app/assets/images/**,**/*.keep,**/vendor/cache/**,**/tmp/**,**/pkg/**,**/log/**
set wildignore+=**/Cellar/**,**/home/.vim/bundle/**,**/_site/**
set wildignore+=**/*.netrw*,**/*.DS_Store
