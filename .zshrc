name=$(uname)
case $name in
 Linux)
	colorscript random
	if	[[ -f /usr/share/autojump/autojump.sh ]]; then
		source "/usr/share/autojump/autojump.sh"
	fi
	if 	[[ -f /opt/asdf-vm/asdf.sh ]]; then
		source "/opt/asdf-vm/asdf.sh"
	fi
		;;
Darwin)
	fastfetch
	[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh

	if [[ -f "/usr/local/opt/asdf/libexec/asdf.sh" ]]; then
		source "/usr/local/opt/asdf/libexec/asdf.sh"
	fi
	export DOTNET_ROOT="$HOME/.dotnet"
	export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-22.jdk/Contents/Home"
	
	export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"
	export DOTNET_CLI_TELEMETRY_OPTOUT=true
	eval "$(/opt/homebrew/bin/brew shellenv)"
	;;
	'*')
		echo "Hi, stranger!"
esac

# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'
alias fzp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

eval "$(starship init zsh)"
