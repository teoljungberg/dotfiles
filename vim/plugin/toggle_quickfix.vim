nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap =oq :<C-R>=BufferOpen("Quickfix List") ? "cclose" : "copen"<CR><CR>
