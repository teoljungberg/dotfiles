iabbrev <buffer> -. - [ ]
iabbrev <buffer> -x - [X]

setlocal spell
setlocal textwidth=80
setlocal shiftwidth=4
setlocal expandtab

setlocal wrap
setlocal nolist
setlocal linebreak

nnoremap <buffer> <expr> k (v:count == 0 ? "gk" : "k")
nnoremap <buffer> <expr> j (v:count == 0 ? "gj" : "j")
nnoremap <buffer>        $ g$
nnoremap <buffer>        0 g0
nnoremap <buffer>        ^ g^
