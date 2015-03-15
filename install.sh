#!/bin/sh

fetch_bundle() {
  git clone "git://github.com/$bundle" $vim_bundle
  echo
}

update_bundle() {
  cd $vim_bundle
  echo "updating $bundle_name"
  git pull --rebase origin master
  echo
}

setup_pathogen() {
  if [ ! -d $vim_bundle_base_path ]; then
    mkdir -p $vim_bundle_base_path
  fi
}

bundles=(
  "altercation/vim-colors-solarized"
  "beloglazov/vim-textobj-quotes"
  "kana/vim-textobj-user"
  "kchmck/vim-coffee-script"
  "nelstrom/vim-textobj-rubyblock"
  "teoljungberg/vim-grep"
  "teoljungberg/vim-visual-star-search"
  "thoughtbot/pick.vim"
  "tommcdo/vim-exchange"
  "tpope/vim-abolish"
  "tpope/vim-bundler"
  "tpope/vim-commentary"
  "tpope/vim-dispatch"
  "tpope/vim-endwise"
  "tpope/vim-fugitive"
  "tpope/vim-git"
  "tpope/vim-liquid"
  "tpope/vim-markdown"
  "tpope/vim-pathogen"
  "tpope/vim-projectionist"
  "tpope/vim-rails"
  "tpope/vim-rake"
  "tpope/vim-repeat"
  "tpope/vim-sleuth"
  "tpope/vim-surround"
  "tpope/vim-unimpaired"
  "tpope/vim-vinegar"
  "vim-ruby/vim-ruby"
)

main() {
  for bundle in "${bundles[@]}"; do
    bundle_name=$(echo $bundle | tr "/" "\n" | tail -1)
    vim_bundle=~/.vim/bundle/$bundle_name

    if [ ! -d $vim_bundle ]; then
      fetch_bundle
    else
      update_bundle
    fi
  done

  for bundle in $(ls ~/.vim/vendor); do
    vim_bundle=~/.vim/vendor/$bundle
    bundle_name=$bundle

    update_bundle
  done
}

main
