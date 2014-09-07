for file in ~/.bash.d/*.bash; do
  source $file
done

export PROMPT_COMMAND="rename_tmux_window_to_current_dir; history -a; $PROMPT_COMMAND"
