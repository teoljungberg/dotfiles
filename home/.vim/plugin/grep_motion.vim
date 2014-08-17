" Grep motions

" Motions to Grep for things.  Works with pretty much everything, including:
"
"   w, W, e, E, b, B, t*, f*, i*, a*, and custom text objects
"

nnoremap <silent> gr :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> gr :<C-U>call <SID>AckMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
  if a:type ==# 'v'
    silent execute "normal! `<" . a:type . "`>y"
  elseif a:type ==# 'char'
    silent execute "normal! `[v`]y"
  endif
endfunction

function! s:AckMotion(type) abort
  let reg_save = @@

  call s:CopyMotionForType(a:type)

  execute ":Grep! " . shellescape(@@)

  let @@ = reg_save
endfunction
