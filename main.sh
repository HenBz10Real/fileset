source $FUNCTION
local red="\033[31m"
local verName="V1.1"
local version=11
local mode="prime"
local pid="[$$]"
local converted_time="permanen"
local p="[-]"
local name="fsandroidx"
local path_logo="/sdcard/AxeronModules/fsa/bin/iocn/logo.png"
local path_banner="/sdcard/AxeronModules/fsa/bin/iocn/banner.png"
local android_version=$(getprop ro.build.version.release)
local system_output="com.dts.freefireth,com.dts.freefiremax"
local version_numbers=$(echo "$android_version" | grep -o '[0-9]\+')
loads() {
	sleep $1
}
printer() {
	text="$1"
	color="$2"
	i=0
	while [ $i -lt ${#text} ]; do
		echo -en "\e[${color}m${text:$i:1}\e[0m"
		sleep 0.02
		i=$((i + 1))
	done
	echo
}
local check_id=$(storm "r17rYI0tYD6Cp9fQN5zvaVntdMysT5erOIfuNZlrN8mQdcjQOEcuT9gQT50vYH=")
local check_vip=$(echo "$check_id" | grep -q "$AXERONID" && echo true || echo false)
if [ $check_vip = true ]; then
	loads 0.1
	echo
	sleep 0.4
	echo
	sleep 0.3
	echo "┌$pid $name | Information"
	echo "├$p Mode: $mode"
	echo "└┬$p Version: $verName ($version)"
	echo " ├$p Cooldown: $converted_time"
	echo " └$p Package: ${runPackage:-null}"
	sleep 1
	echo
	echo
	if [ -f /sdcard/AxeronModules/fsa/bin/system.apk ]; then
		if ! pm list packages | cut -f 2 -d : | grep -q bellavita.toast; then
			pm install /sdcard/AxeronModules/fsa/bin/system.apk >/dev/null 2>&1
			if ! pm list packages | cut -f 2 -d : | grep -q bellavita.toast; then
				cp /sdcard/AxeronModules/fsa/bin/system.apk /data/local/tmp >/dev/null 2>&1
				pm install /data/local/tmp/system.apk >/dev/null 2>&1
				rm /data/local/tmp/system.apk
			fi
		fi
	else
		pm uninstall bellavita.toast >/dev/null 2>&1
	fi
	function optimize_app {
		for package in $(echo $PACKAGES | cut -d ":" -f 2); do
			if whitelist | grep -q "$package" >/dev/null 2>&1; then
				continue
			else
				cache_path="/sdcard/Android/data/${package}/cache"
				[ -e "$cache_path" ] && rm -rf "$cache_path" >/dev/null 2>&1
			fi
		done
	}
	optimize_app >/dev/null 2>&1
	sleep 2 && echo " otomatis masuk ke game freefire!! "
	com.dts.freefireth() {
		for ions in $(cmd package list packages | grep google | cut -f 2 -d ":"); do
			cmd activity force-stop "$ions"
			cmd activity kill "$ions"
			am kill-all "$ions"
		done
		cmd notification post -i $path_icon -I $path_banner -S bigtext -t 'FreeFire' 'Tag' 'Programs fsa running in background'
		am start -a android.intent.action.MAIN -e toasttext "Filesettings android running : FreeFire" -n bellavita.toast/.MainActivity
		loads 2
		am start -n com.dts.freefireth/com.dts.freefireth.FFMainActivity
		sleep 10
		while true; do
			rm -r /storage/emulated/0/Android/data/com.dts.freefireth/cache/*
			rm -r /storage/emulated/0/Android/data/com.dts.freefireth/files/il2cpp/*
			rm -f /data/local/traces/*
			rm -f /storage/emulated/0/Android/data/com.dts.freefireth/files/ffrtc_log.txt
			rm -f /storage/emulated/0/Android/data/com.dts.freefireth/files/ffrtc_log_bak.txt
			sleep 1
		done
	}

	com.dts.freefiremax() {
		for ions in $(cmd package list packages | grep google | cut -f 2 -d ":"); do
			cmd activity force-stop "$ions"
			cmd activity kill "$ions"
			am kill-all "$ions"
		done
		am start -n com.dts.freefiremax/com.dts.freefireth.FFMainActivity
		loads 1.4
		cmd notification post -i $path_icon -I $path_banner -S bigtext -t 'FreeFire Max' 'Tag' 'Programs fsa running in background'
		am start -a android.intent.action.MAIN -e toasttext "Filesettings android running : FreeFire Max" -n bellavita.toast/.MainActivity
		sleep 10
		while true; do
			rm -r /storage/emulated/0/Android/data/com.dts.freefiremax/cache/*
			rm -r /storage/emulated/0/Android/data/com.dts.freefiremax/files/il2cpp/*
			rm -f /data/local/traces/*
			rm -f /storage/emulated/0/Android/data/com.dts.freefiremax/files/ffrtc_log.txt
			rm -f /storage/emulated/0/Android/data/com.dts.freefiremax/files/ffrtc_log_bak.txt
			sleep 1
		done
	}

	function game_priority {
		if pm list packages | grep -q com.dts.freefireth; then
			com.dts.freefireth
		elif pm list packages | grep -q com.dts.freefiremax; then
			com.dts.freefiremax
		else
			cmd notification post -i $path_icon -I $path_banner -S bigtext -t 'FSA Peringatan!' 'tag' 'Freefire application tidak di temukan.'
		fi
	}
	echo
	loads 1.0
	game_priority >/dev/null 2>&1
else
	echo ""
	echo " Filesettings android rusak ${red}( buy script original ) "
	sleep 1.0
	echo ""
	am start -a android.intent.action.MAIN -e toasttext " Woi beli lah memek mokondo " -n bellavita.toast/.MainActivity >/dev/null 2>&1
fi
