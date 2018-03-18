# ~/.profile

alias ls='ls -F'

export PS1='\$ '
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.cargo/bin:$PATH
export ERL_LIBS=$HOME/.local/erllib

[ -z $(pidof ssh-agent) ] && eval "$(ssh-agent -s)"

