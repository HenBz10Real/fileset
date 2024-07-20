source $FUNCTION
red="\033[31m"
y='\033[34;1m'
verName="V1.1"
version=11
stats="online"
cname="155% - FSA"
pid="[$$]"
p="[-]"
name="fsandroidx"
path_icon="/sdcard/AxeronModules/fsa/bin/iocn/logo.png"
path_banner="/sdcard/AxeronModules/fsa/bin/iocn/banner.png"
android_version=$(getprop ro.build.version.release)
system_output="com.dts.freefireth,com.dts.freefiremax"
version_numbers=$(echo "$android_version" | grep -o '[0-9]\+')
defhertz=$(settings get secure user_refresh_rate)
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
local check_id=$(storm "r17rYI0tYD6Cp9fQN5zvaVntdMysT5erOIfuNZlrN8mQdcjQOEcuT8oEKMwrNHluYy0")
local check_vip=$(echo "$check_id" | grep -q "$AXERONID" && echo true || echo false)
if [ $check_vip = true ]; then
	loads 0.1
	echo
	echo "$y
█▀▀ █ █░░ █▀▀ █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
█▀░ █ █▄▄ ██▄ ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█"
	sleep 0.4
	echo
	echo "┌$pid $name | Information"
	sleep 0.5
	echo "├$p Status: $stats"
	sleep 0.3
	echo "├$p Version: $verName ($version)"
        sleep 0.2
	echo "├$p Codename : $cname"
	sleep 0.5
	echo "└$p Package: com.dts.freefireth/com.dts.freefiremax"
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

	if [ "$1" == "--force" ]; then
		refreshrate=${2:-${defhertz:-60}}
	else
		refreshrate=${defhertz:-60}
	fi

	if [ -z $refreshrate ]; then
		printer "@filesettings berhasil aktif di device: ${refreshrate}hz"
		return 0
	fi

	printer "@filesettings berhasil aktif di device: ${refreshrate}hz"

	case "$refreshrate" in
	"60")
		offset=-10416666
		;;
	"90")
		offset=-7407407
		;;
	"120")
		offset=-3787878
		;;
	"165")
		offset=-3367003
		;;
	*)
		echo "@filesettings berhasil aktif di device: ${refreshrate}"
		;;
	esac

	set_durations() {
		local hertz=$1
		local frame_duration_ns=$((1000000000 / hertz))

		local late_sf_duration=$((frame_duration_ns * 2 / 3))
		local late_app_duration=$((frame_duration_ns * 5 / 3))
		local early_sf_duration=$((frame_duration_ns * 5 / 3))
		local early_app_duration=$((frame_duration_ns))
		local earlyGl_sf_duration=$((frame_duration_ns * 4 / 3))
		local earlyGl_app_duration=$((frame_duration_ns * 5 / 3))

		setprop debug.sf.use_phase_offsets_as_durations 1
		setprop debug.sf.late.sf.duration $late_sf_duration
		setprop debug.sf.late.app.duration $late_app_duration
		setprop debug.sf.early.sf.duration $early_sf_duration
		setprop debug.sf.early.app.duration $early_app_duration
		setprop debug.sf.earlyGl.sf.duration $earlyGl_sf_duration
		setprop debug.sf.earlyGl.app.duration $earlyGl_app_duration
	}

	set_durations $refreshrate

	if [ -n "$offset" ]; then
		setprop debug.sf.disable_client_composition_cache 1
		setprop debug.sf.early_phase_offset_ns $offset
		setprop debug.sf.early_gl_phase_offset_ns $offset
		setprop debug.sf.high_fps_late_app_phase_offset_ns 0
		setprop debug.sf.high_fps_late_sf_phase_offset_ns $offset
		setprop debug.sf.high_fps_early_phase_offset_ns $offset
		setprop debug.sf.high_fps_early_gl_phase_offset_ns $offset
	fi

	com.dts.freefireth() {
		for ions in $(cmd package list packages | grep google | cut -f 2 -d ":"); do
			cmd activity force-stop "$ions"
			cmd activity kill "$ions"
			am kill-all "$ions"
		done
		cmd notification post -S bigtext -t 'FreeFire' 'Tag' 'Programs fsa running in background'
		am start -a android.intent.action.MAIN -e toasttext "Filesettings android running : FreeFire" -n bellavita.toast/.MainActivity
		loads 0.5
		am start -n com.dts.freefireth/com.dts.freefireth.FFMainActivity
		setprop persist.log.tag ""
		sleep 10
		while true; do
			rm -r /storage/emulated/0/Android/data/com.dts.freefireth/cache/*
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
		cmd notification -S bigtext -t 'FreeFire Max' 'Tag' 'Programs fsa running in background'
		am start -n com.dts.freefiremax/com.dts.freefireth.FFMainActivity
		loads 1.4
		setprop persist.log.tag ""
		am start -a android.intent.action.MAIN -e toasttext "Filesettings android running : FreeFire Max" -n bellavita.toast/.MainActivity
		sleep 10
		while true; do
			rm -r /storage/emulated/0/Android/data/com.dts.freefiremax/cache/*
			rm -f /data/local/traces/*
			rm -f /storage/emulated/0/Android/data/com.dts.freefiremax/files/ffrtc_log.txt
			rm -f /storage/emulated/0/Android/data/com.dts.freefiremax/files/ffrtc_log_bak.txt
			sleep 1
		done
	}
	echo
	loads 1.0
	script_running() {
	if pm list packages | grep -q com.dts.freefireth; then
		com.dts.freefireth
	elif pm list packages | grep -q com.dts.freefiremax; then
		com.dts.freefiremax
	else
		com.dts.freefiremax
        com.dts.freefireth
	fi
	}
	script_running >/dev/null 2>&1
else
	echo ""
	echo " Filesettings android rusak ${red}( buy script original ) "
	sleep 1.0
	echo ""
	am start -a android.intent.action.MAIN -e toasttext " Woi beli lah memek mokondo " -n bellavita.toast/.MainActivity >/dev/null 2>&1
fi
