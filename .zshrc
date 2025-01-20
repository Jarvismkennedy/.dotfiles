name=$(uname)
case $name in
 Linux)
	colorscript random
	if	[[ -f /usr/share/autojump/autojump.zsh ]]; then
		source "/usr/share/autojump/autojump.zsh"
	fi
	if 	[[ -f /opt/asdf-vm/asdf.sh ]]; then
		source "/opt/asdf-vm/asdf.sh"
	fi
	export PATH="$HOME/azure-functions-cli:$PATH"
		;;
Darwin)
	export DOTNET_ROOT="$HOME/.dotnet"
	export PATH="$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH"

	fastfetch
	if [[ -f /opt/homebrew/etc/profile.d/autojump.sh ]]; then 
		. /opt/homebrew/etc/profile.d/autojump.sh 
	fi

	if [[ -f "/usr/local/opt/asdf/libexec/asdf.sh" ]]; then
		source "/usr/local/opt/asdf/libexec/asdf.sh"
	fi
	export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-22.jdk/Contents/Home"
	
	eval "$(/opt/homebrew/bin/brew shellenv)"
	;;
	'*')
		echo "Hi, stranger!"
esac
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTNET_CLI_TELEMETRY_OPTOUT=true
export PATH="$HOME/.cargo/bin/:$PATH"


# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -a | egrep "^\."'
alias fzp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias vim='nvim'
alias kbd='xset r rate 200 27'

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

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

eval "$(fzf --zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
