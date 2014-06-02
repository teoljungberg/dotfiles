let g:netrw_localrmdir = "rm -rf"

map <buffer> § ~
map <buffer> f /

map <buffer> gr :grep! --exclude-dir=".git" <C-R>=shellescape(fnamemodify(expand('%:p:h').'/'.getline('.'),':.'),1)<CR><Home><C-Right> -r<Space>
