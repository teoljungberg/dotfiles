# Prepend `./git/safe../../bin` to the `$PATH` after invoking `chruby`, don't
# prepend it if it's already in the `$PATH`
save_function() {
  local original_function="$(declare -f $1)"
  local new_function="$2${original_function#$1}"
  eval "$new_function"
}

save_function "chruby" "original_chruby"

prepend_to_path_without_duplication() {
  path=($1 ${(@)path:#$1})
}

chruby() {
  original_chruby "$@"
  prepend_to_path_without_duplication ".git/safe/../../bin"
}
