switch (uname)
    case Linux
		[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
		[ -f /opt/asdf-vm/asdf.fish ]; and source /opt/asdf-vm/asdf.fish
    case Darwin
		[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
		[ -f /usr/local/opt/asdf/libexec/asdf.fish ]; and source /usr/local/opt/asdf/libexec/asdf.fish

		set -x DOTNET_ROOT "$HOME/.dotnet"
		set -x JAVA_HOME "/Library/Java/JavaVirtualMachines/temurin-22.jdk/Contents/Home"
		fish_add_path "$DOTNET_ROOT"
		fish_add_path "$DOTNET_ROOT/tools"
		set -x DOTNET_CLI_TELEMETRY_OPTOUT true
		eval "$(/opt/homebrew/bin/brew shellenv)"
    case '*'
            echo Hi, stranger!
end

# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'

alias fzp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

function fish_greeting
	switch (uname)
		case Linux
			colorscript random
		case Darwin
			fastfetch
		case '*'
			echo Hi, stranger!
	end
end

bind \cf tmux_sessionizer
bind \cj tmux_sessionizer_switch

