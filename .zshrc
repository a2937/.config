# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EMSDK_QUIET=1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="candy"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source "/home/nerdynerd/Tools/emsdk/emsdk_env.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
 alias zshconfig="code ~/.zshrc"
 alias ohmyzsh="code ~/.oh-my-zsh"
#
alias ll="ls -ltra"
alias gd="git diff"
alias gcmsg="git commit -m"
alias gitc="git checkout"
alias gitm="git checkout master"

# GO
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# SQL MAP
export PATH=$PATH:/home/nerdynerd/Tools/sqlmap-dev


# VS CODE
export PATH=$PATH:"/mnt/d/Program Files/Microsoft VS Code/bin"



# Ubuntu Desktop setup

export DISPLAY=:0
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
export XDG_SESSION_DESKTOP=ubuntu
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_SESSION_CLASS=user
export XDG_DATA_DIRS=/usr/share/ubuntu:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_RUNTIME_DIR="/run/user/1000"

export LIBGL_ALWAYS_INDIRECT=1


# Node 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Jump to project by fuzzy name
proj() {
  local dir
  dir=$(find ~/projects -maxdepth 2 -type d -name ".git" 2>/dev/null |     sed 's|/.git||' | fzf --height 40% --reverse)
  [[ -n "$dir" ]] && cd "$dir"
}

# Create branch with type prefix
gbr() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: gbr <type> <description>"
    echo "Types: feat, fix, chore, refactor, docs, test"
    return 1
  fi
  local type="$1"
  shift
  local desc="${(j:-:)@:l}"  # Join args with hyphens, lowercase
  git checkout -b "${type}/${desc}"
}
# Usage: gbr feat user avatar upload
# Creates: feat/user-avatar-upload

# Find and optionally kill process on a port
port() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: port <number> [kill]"
    return 1
  fi
  local pid
  pid=$(lsof -ti ":$1" 2>/dev/null)
  if [[ -z "$pid" ]]; then
    echo "No process on port $1"
    return 0
  fi
  echo "Port $1: PID $pid ($(ps -p $pid -o comm= 2>/dev/null))"
  if [[ "$2" == "kill" ]]; then
    kill -9 "$pid" && echo "Killed PID $pid"
  fi
}
# Usage: port 3000        → shows process
#        port 3000 kill   → kills it


# Unified extract command
extract() {
  if [[ ! -f "$1" ]]; then
    echo "File not found: $1"
    return 1
  fi
  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz)  tar xzf "$1" ;;
    *.tar.xz)  tar xJf "$1" ;;
    *.bz2)     bunzip2 "$1" ;;
    *.gz)      gunzip "$1" ;;
    *.tar)     tar xf "$1" ;;
    *.tbz2)    tar xjf "$1" ;;
    *.tgz)     tar xzf "$1" ;;
    *.zip)     unzip "$1" ;;
    *.7z)      7z x "$1" ;;
    *.rar)     unrar x "$1" ;;
    *) echo "Unknown format: $1"; return 1 ;;
  esac
}

# Copies a folder and initializes a new Git repository
gitCopy(){
  emulate -L zsh              # Consistent Zsh behavior
  local usage="Usage: gitCopy <sourceFolder> <destFolder>"
  if [ -d "$1" ]; then
    echo "$1 does exist."
    return 1
  fi

  cp -R $1 $2 
  cd $2
  echo "Successfully created directory $2" 
  git init -y
  echo "Initialized new Git repository"
  touch .gitignore 
  echo "Created empty gitignore" 
}

# NVM and Python Venv Auto switch

cd() {
  builtin cd "$@"
  if [[ -f .nvmrc ]]; then
    nvm use > /dev/null
  fi
  if [[ -d .venv ]] then 
    source .venv/bin/activate
  fi
  if [[ -d .git ]] then 
    echo "Updating repo..." 
    git fetch
    git pull
  fi
  if [[ -f .gitmodules ]]; then
     echo "Updating submodules..." 
     git fetch upstream
     git submodule update --init
  fi
}
cd .
