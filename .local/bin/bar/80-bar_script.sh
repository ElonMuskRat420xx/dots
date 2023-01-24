#!/bin/bash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors!
. ~/.dwm/bar/themes/onedark

cpu() {
	cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "^c$black^ ^b$green^ CPU"
	printf "^c$white^ ^b$grey^ $cpu_val"
}

cputemp() {
	
 f=$(cat /sys/class/thermal/thermal_zone0/temp)
    t=$(echo $f | cut -b -2).$(echo $f | cut -b 5-)°C

printf "$t"
}

disk() {
hdd="$(df -h | awk 'NR==4{print $3, $5}')"
icon="󰋊"
printf " %s %s \\n" "$icon" "$hdd"

}

pkg_updates() {

	updates=$(checkupdates | wc -l) 
	
	if [ -z "$updates" ]; then
		printf "^c$green^󰏔"
	else
		printf "^c$green^󰏔$updates"
	fi
}


battery() {
	get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
	printf "^c$red^ $get_capacity"
}


volume() {

info="$(pactl list sinks)"
vol="$(printf "%s\n" "$info" | sed -n '/\tVolume: /{p;q}' | grep -o "[0-9]\+%" | head -n1)"
mute="$(printf "%s\n" "$info" | sed -n '/\tMute: /{p;q}' | cut -d' ' -f2)"

if [ "$mute" = "yes" ]; then
    echo "^c$blue^󰖁$vol"
else
    if [ "${vol%%%}" -ge 30 ]; then
        echo "^c$blue^󰕾$vol"
    else
        echo "^c$blue^󰕾$vol"
    fi
fi

}

mem() {
	printf "^c$blue^^b$black^  "
	printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

netstat() {
	
	update() {
	    sum=0
	    for arg; do
	        read -r i < "$arg"
	        sum=$(( sum + i ))
	    done
	    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
	    [ -f "$cache" ] && read -r old < "$cache" || old=0
	    printf %d\\n "$sum" > "$cache"
	    printf %d\\n $(( sum - old ))
	}
	
	rx=$(update /sys/class/net/[ew]*/statistics/rx_bytes)
	tx=$(update /sys/class/net/[ew]*/statistics/tx_bytes)
	
	printf "^c$blue^󰬦%4sB 󰬬%4sB\\n" $(numfmt --to=iec $rx) $(numfmt --to=iec $tx)
}

wlan() {
	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Connected" ;;
	down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

clock() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$black^^b$blue^ $(date '+%a %d %b %I:%M %p') "
}

while true; do

	[ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
	
 interval=$((interval + 1))

	sleep 1 && xsetroot -name "$updates $(volume)$(cpu) $(cputemp) $(mem) $(disk) $(netstat) $(wlan) $(clock)"
done

 
 
