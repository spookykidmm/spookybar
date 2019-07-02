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
getmem() {
memused=$(free -m | grep Mem: | tail -1 | awk '{print $3 }')
memtotal=$(free -m | grep Mem: | tail -1 | awk '{print $2 }')
}
getupdates() {
updates=$(checkupdates | wc -l)
aur=$(aur repo -S -u -d revenge_repo | wc -l)
}
workspace() {
top=$XDG_CURRENT_DESKTOP
	if [ "$top" = "i3" ]
	then
space=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
fi
}
output() {
	while true;
	do
	gettime
	getpower
	getvolume
	getmem
#	getupdates
	workspace
echo " $space   |   $time | $power | $volume | $memused / $memtotal"	
	sleep 1
	done
}
frick() {
	while true;
	do gettime
	echo $time
	sleep 1
	done
}
bar() {
while true;
do output | dzen2
sleep 1
done
}
datebar() {
	while true;
	do frick | dzen2
	done
}
#output
#bar
bar