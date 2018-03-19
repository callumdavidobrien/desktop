# ~/.xinitrc

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources # load Xresources
start-pulseaudio-x11                              # start pulseaudio
setxkbmap gb                                      # set keyboard layout
[ -f ~/.fehbg ] && sh ~/.fehbg                    # set wallpaper

exec xmonad                                       # start window manager

