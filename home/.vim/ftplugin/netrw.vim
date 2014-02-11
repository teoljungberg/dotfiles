map <buffer> § ~
map <buffer> f /

map <buffer> gr :grep <C-R>=shellescape(fnamemodify(expand('%:p:h').'/'.getline('.'),':.'),1)<CR><Home><C-Right> -r<Space>
