# append history instead of rewriting it
shopt -s histappend

# plenty big history for searching backwards and doing analysis
export HISTFILESIZE=100000

export PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
