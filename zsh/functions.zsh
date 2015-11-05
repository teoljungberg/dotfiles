git_branch() {
  BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
  GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
  [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH "
}

git_origin_or_fork() {
  if git remote 2>/dev/null | grep -iq teoljungberg; then
    echo "teoljungberg"
  else
    echo "origin"
  fi
}

# No arguments: `git push teoljungberg/origin CURRENT_BRANCH`
# With arguments: acts like `git push`
gp() {
  if [[ $# > 0 ]]; then
    git push $@
  else
    git push `git_origin_or_fork` -u `git_branch`
  fi
}

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status -sb
  fi
}
compdef g=git
