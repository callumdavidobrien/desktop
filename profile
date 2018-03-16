# .bash_profile

alias ls='ls -F'

export PS1='\$ '
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.cargo/bin:$PATH

eval "$(ssh-agent -s)"

