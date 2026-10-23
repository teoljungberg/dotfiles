# Global login files such as /etc/profile reorder PATH after ~/.zshenv, so
# apply it again when they ran.
if [[ -o global_rcs ]]; then
  source "$HOME/.zshenv"
fi
