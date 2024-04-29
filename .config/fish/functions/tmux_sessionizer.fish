# from theprimeagen -> fish
function tmux_sessionizer
	if test (count $argv) -eq 1
		set selected $argv[1]
	else 
		set selected (find  ~/work ~/work/Srpdv8/ ~/personal ~/personal/plugin ~/personal/projects -mindepth 1 -maxdepth 1 -type d | fzf)
	end
	if test -z "$selected"
		echo "exiting"
    	return 0
	end
	set selected_name (basename "$selected" | tr . _)
	set tmux_running (pgrep tmux)
	if test -z "$TMUX" && test -z "$tmux_running"
	    tmux new-session -s $selected_name -c $selected
   		return 0
	end
	if test -z "$TMUX" && test "$tmux_running"
		if ! tmux has-session -t=$selected_name 2> /dev/null
			tmux new-session -ds $selected_name -c $selected
		else	
			tmux a -t $selected_name
			return 0
		end
	end
	if ! tmux has-session -t=$selected_name 2> /dev/null
    	tmux new-session -ds $selected_name -c $selected
	end	
	tmux switch-client -t $selected_name
end
