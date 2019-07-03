#!/bin/bash
gettime() {
time=$(date +'%a %b %d %H:%M:%S')
}

getpower() {
power=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | tail -1 | awk '{print $2 }')
}
getvolume() {
volume=$(pamixer --get-volume-human)
}

getbrightness() {
	bright=$(light -G)
}

getmem() {
memused=$(free -m | grep Mem: | tail -1 | awk '{print $3 }')
memtotal=$(free -m | grep Mem: | tail -1 | awk '{print $2 }')
}

getupdates() {
updates=$(checkupdates | wc -l)
aur=$(aur repo -S -u -d revenge_repo | wc -l)
}
wmcheck() {
top=$(wmctrl -m | grep Name: | awk '{ print $2 }')
if [ "$top" = "Openbox" ]
then openboxworkspace
else getworkspace
fi
}
openboxworkspace() {
	space=$(wmctrl -ld | grep "*" | tail -1 | awk '{print $10 }')
}
getworkspace() {
space=$(wmctrl -ld | grep "*" | tail -1 | awk '{print $9 }')
}

updatecheck() {
while true;
      do getupdates
      sleep 5
      done
}
      
getnetwork() {
	wifi=$(iwgetid -r)
}
output() {
	while true;
	do
	gettime
	getpower
	getvolume
	getmem
	wmcheck
	getnetwork
	getbrightness
echo " $space   |   $time | $power | $volume | $bright | $memused / $memtotal | $wifi"	
	sleep 1
	done
}
bar() {
while true;
do output | dzen2
sleep 1
done
}
#updatecheck
bar