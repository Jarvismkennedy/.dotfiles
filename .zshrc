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
	export DOTNET_ROOT="$HOME/.dotnet"
	export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"

	fastfetch
	[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh

	if [[ -f "/usr/local/opt/asdf/libexec/asdf.sh" ]]; then
		source "/usr/local/opt/asdf/libexec/asdf.sh"
	fi
	export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-22.jdk/Contents/Home"
	
	eval "$(/opt/homebrew/bin/brew shellenv)"
	;;
	'*')
		echo "Hi, stranger!"
esac

export DOTNET_CLI_TELEMETRY_OPTOUT=true


# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'
alias fzp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias vim='nvim'

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__autojump_z:*' fzf-preview 'ls --color $realpath'

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
