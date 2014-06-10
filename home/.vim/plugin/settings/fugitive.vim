fun! s:gm(short, cmd, ...)
  let silent = a:cmd =~ '\w$' ? '<silent>' : ''
  let cr = a:cmd =~ '\w$' ? '<cr>' : ''
  let extra = a:0 ? a:1 : ''
  exec "nmap" silent a:short ":" . a:cmd . cr . extra
endfunction

call s:gm('gs', 'Gstatus', '<c-n>')
call s:gm('gd', 'Gdiff')
call s:gm('gb', 'Gblame')
call s:gm('gA', 'Gcommit --amend --no-edit')
vnoremap <silent> gb :Gbrowse<cr>

cabbrev G Git
