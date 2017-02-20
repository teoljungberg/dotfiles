# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# load up the configs inside ~/.zsh/*
for config_file ($HOME/.zsh/**/*.zsh) source $config_file

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
