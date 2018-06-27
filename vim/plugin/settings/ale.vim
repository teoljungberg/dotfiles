augroup Ale
  autocmd!

  " I prefer invoking `ALELint` at my leisure rather than having it run
  " automatically when a file is saved, changed, or touched.
  let g:ale_lint_on_text_changed = "never"
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 0

  " Disable the gutter by not allowing any signs.
  let g:ale_set_signs = 0
  " Open the location list when `:ALELint` produces any errors.
  let g:ale_open_list = 1

  " Only run linters listed in `g:ale_linters`.
  let g:ale_linters_explicit = 1

  let g:ale_linters = {}
  let g:ale_linters.elixir = ["credo"]
  let g:ale_linters.javascript = ["eslint"]
  let g:ale_linters.ruby = ["rubocop"]
  let g:ale_linters.sh = ["shellcheck"]
  let g:ale_linters.vim = ["vint"]
augroup END

nnoremap d= :ALELint<CR>
