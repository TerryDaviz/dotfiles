#!/bin/sh

# set default programs
export EDITOR="nvim"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="$HOME/.local/share:/usr/local/share/:/usr/share/"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPATH="$XDG_DATA_HOME"/go
export PATH=$PATH/usr/local/go/bin
export GOPATH="$GOPATH":"$HOME"/development/go

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/pythonstartup.py
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export WORKON_HOME="$XDG_DATA_HOME"/environments

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

export INPUTRC="$XDG_CONFIG_HOME"/shell/inputrc
export LESSHISTFILE="$XDG_DATA_HOME"/less/history
export LESSKEY="$XDG_CONFIG_HOME"/lesskey
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store
export SUDO_ASKPASS="$HOME"/.local/scripts/dmenupass
export ZDOTDIR="$XDG_CONFIG_HOME"/shell/zsh

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude '.git'"
export FZF_DEFAULT_OPTS="--bind=ctrl-n:down,ctrl-e:up,ctrl-k:end-of-line,ctrl-j:kill-line --cycle"

export QT_QPA_PLATFORMTHEME="qt5ct"
export NLS_LANG=AMERICAN_CIS.UTF8

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# setup PATH
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/scripts" ]; then
    PATH="$HOME/.local/scripts:$PATH"
fi

# add colors to man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# start ssh-agent
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent -t 1h >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! "$SSH_AUTH_SOCK" ]; then
    . "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$XDG_CONFIG_HOME/shell/bash/.bashrc" ]; then
        . "$XDG_CONFIG_HOME/shell/bash/.bashrc"
    else
        . "$HOME/.bashrc"
    fi
    # if running zsh
elif [ -n "$ZSH_NAME" ]; then
    if [ -f "$XDG_CONFIG_HOME/shell/zsh/.zshrc" ]; then
        . "$XDG_CONFIG_HOME/shell/zsh/.zshrc"
    fi
fi
