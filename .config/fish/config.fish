[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'

alias fzp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

function fish_greeting
	colorscript random
end

bind \cf tmux_sessionizer
bind \cj tmux_sessionizer_switch
