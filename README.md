# teoljungberg/dotfiles

## rcrc(5)

```
DOTFILES_DIRS="$HOME/src/github.com/teoljungberg/dotfiles"
COPY_ALWAYS="git_template/info/projections.json"
EXCLUDES="README.md ./CLAUDE.md ./AGENTS.md *.local.md result rcrc Session.vim"
HOSTNAME="A_HOST"
```

## crontab(5)

```
LANG="en_US.UTF-8"
PATH="/opt/homebrew/opt/node@24/bin:/usr/bin:/bin"

00 10 * * *	$HOME/src/github.com/teoljungberg/dotfiles/bin/update-vim-plugins
```
