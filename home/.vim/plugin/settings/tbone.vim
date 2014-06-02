command! Autotest             :Tmux split-window -h 'autotest'
command! AutotestWithWarnings :Tmux split-window -h 'RUBYOPT=-w autotest'
command! Guard                :Tmux split-window -h 'bundle exec guard'
