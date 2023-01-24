[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

#!/bin/sh
picom &
redshift &
nitrogen --restore &
dwm & 
xset -r rate 300 50 

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi




