function! Jump(target)
  execute "cd " . a:target
  edit .
endfunction

function! CdPaths()
  let paths = split(globpath(&cdpath, '*'), '\n')
  let result = []
  for path in paths
    if isdirectory(path)
      let result += [path]
    endif
  endfor
  return paths
endfunction

function! CompleteDirInCdPath(ArgLead, CmdLine, CursorPos)
  let result = []
  for path in CdPaths()
    let result += [fnamemodify(path, ':t')]
  endfor
  return join(result, "\n")
endfunction

command! -nargs=1 -complete=custom,CompleteDirInCdPath Jump call Jump(<q-args>)
cabbr j Jump
