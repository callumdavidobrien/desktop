# ~/.xinitrc

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources # load Xresources
start-pulseaudio-x11                              # start pulseaudio
redshift -l"50:-5" -t"6500:3000" &                # start redshift
setxkbmap gb                                      # set keyboard layout
[ -f ~/.fehbg ] && sh ~/.fehbg                    # set wallpaper

exec xmonad                                       # start window manager
