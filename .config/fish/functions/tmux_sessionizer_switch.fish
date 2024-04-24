function tmux_sessionizer_switch 
	if test (count $argv) -eq 1
		set selected $argv[1]
	else 
		set sessions_arr (tmux list-sessions -F '#{session_name}')
		set selected (printf '%s\n' $sessions_arr | fzf)
		if test -z "$selected"
			echo "exiting"
			return 0
		end
	end
	if test -z "$TMUX"
		tmux a -t $selected
		return 0
	end
	tmux switch-client -t $selected
end
