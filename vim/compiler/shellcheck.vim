if exists("current_compiler")
  finish
endif
let current_compiler = "shellcheck"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
CompilerSet errorformat=%f:%l:%c:\ %m
CompilerSet makeprg=shellcheck\ -f\ gcc
