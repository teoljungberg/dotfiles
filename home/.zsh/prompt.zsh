#!/bin/sh

fish_prompt() {
  ## reverse tabbing, useful in the prompt
  ## Copyright (C) 2008 by Daniel Friesel <derf@xxxxxxxxxxxxxxxxxx>
  ## License: WTFPL <http://sam.zoy.org/wtfpl>

  zstyle :prompt:rtab fish yes
  setopt localoptions
  setopt rc_quotes null_glob

  typeset -i lastfull=0
  typeset -i short=0
  typeset -i tilde=0
  typeset -i named=0

  if zstyle -t ':prompt:rtab' fish; then
    lastfull=1
    short=1
    tilde=1
  fi
  if zstyle -t ':prompt:rtab' nameddirs; then
    tilde=1
    named=1
  fi
  zstyle -t ':prompt:rtab' last && lastfull=1
  zstyle -t ':prompt:rtab' short && short=1
  zstyle -t ':prompt:rtab' tilde && tilde=1

  while [[ $1 == -* ]]; do
    case $1 in
      -f|--fish)
        lastfull=1
        short=1
        tilde=1
        ;;
      -h|--help)
        print 'Usage: rtab [-f -l -s -t] [directory]'
        print ' -f, --fish      fish-simulation, like -l -s -t'
        print ' -l, --last      Print the last directory''s full name'
        print ' -s, --short     Truncate directory names to the first character'
        print ' -t, --tilde     Substitute ~ for the home directory'
        print ' -T, --nameddirs Substitute named directories as well'
        print 'The long options can also be set via zstyle, like'
        print '  zstyle :prompt:rtab fish yes'
        return 0
        ;;
      -l|--last) lastfull=1 ;;
    -s|--short) short=1 ;;
  -t|--tilde) tilde=1 ;;
-T|--nameddirs)
  tilde=1
  named=1
  ;;
  esac
  shift
done

typeset -a tree expn
typeset result part dir=${1-$PWD}
typeset -i i

[[ -d $dir ]] || return 0

if (( named )) {
  for part in ${(k)nameddirs}; {
    [[ $dir == ${nameddirs[$part]}(/*|) ]] && dir=${dir/${nameddirs[$part]}/\~$part}
  }
}
(( tilde )) && dir=${dir/$HOME/\~}
tree=(${(s:/:)dir})
(
unfunction chpwd 2> /dev/null
if [[ $tree[1] == \~* ]] {
  cd ${~tree[1]}
  result=$tree[1]
  shift tree
} else {
cd /
  }
  for dir in $tree; {
    if (( lastfull && $#tree == 1 )) {
      result+="/$tree"
      break
    }
    expn=(a b)
    part=''
    i=0
    until [[ (( ${#expn} == 1 )) || $dir = $expn || $i -gt 99 ]]  do
      (( i++ ))
      part+=$dir[$i]
      expn=($(echo ${part}*(/)))
      (( short )) && break
    done
    result+="/$part"
    cd $dir
    shift tree
  }
  echo ${result:-/}
  )
}

git_branch() {
  BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
  GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
  [ -n "$GIT_BRANCH" ] && echo "($GIT_BRANCH) "
}

function precmd {
  PROMPT="%{$fg[magenta]%} $(fish_prompt) %{$fg[yellow]%}$(git_branch)%{$reset_color%}%# "
}

# use solarized-like color for ls
export CLICOLOR=1
export LSCOLORS=gxfxbEaEcxxEhEhBaDaCaD

