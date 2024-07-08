#!/system/bin/sh
source $FUNCTION
RED="\033[31m"
DATE=$(date +"%T")
android_version=$(getprop ro.build.version.release)
system_output="com.dts.freefireth,com.dts.freefiremax"
version_numbers=$(echo "$android_version" | grep -o '[0-9]\+')
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
EXPIRED="20240711"
EX=$(date +'%Y%m%d')
if [ "$EX" -ge "$EXPIRED" ]; then
  echo
  sleep 1
  echo "Script telah expired, ${READ}buy script permanent "
  sleep 0.3
  echo
else
  echo ""
  sleep 0.4
  sleep 0.1
  echo "
█▀▀ █▀ ▄▀█ ▄▄ █░█ █▀▀ █▄░█ █▀█ █▀▀ █▀▀ ▀▄▀
█▀░ ▄█ █▀█ ░░ █▀█ ██▄ █░▀█ █▀▀ ██▄ ██▄ █░█"
  echo
  sleep 0.4
  printer "- Developer : Henpee@FSA "
  sleep 0.2
  printer "- Version : 1.0 Online "
  sleep 0.6
  echo ""
  echo ""
  sleep 1
  printer "proses inject script FSA@Henpeex... "
  sleep 3
  function fsa {
    am broadcast -a com.android.intent.CLEAR_APP_CACHE
    am kill-all com.google.android.gms/com.google.android.gms.mdm.receivers.MdmDeviceAdminReceiver
    am kill-all com.miui.powerkeeper/.powerchecker.PowerCheckerService
    am kill-all com.google.android.gms/.chimera.GmsIntentOperationService
    am kill-all com.qualcoom.wfd.service
    am kill-all com.quicinc.voice.activation
    am kill-all com.qualcomm.qti.devicestatisticsservice
    rm -r /sdcard/Android/data/com.dts.freefireth/cache/*
    rm -r /sdcard/Android/data/com.dts.freefiremax/cache/*
    rm -r /sdcard/Android/data/com.dts.freefireth/cache/*
    rm -r /sdcard/Android/data/com.dts.freefireth/files/il2cpp/*
    rm -r /sdcard/Android/data/com.dts.freefiremax/files/il2cpp/*
    rm -f /data/local/traces/*> /dev/null 2>&1
    rm -f /sdcard/Android/data/com.dts.freefireth/files/ffrtc_log.txt*
    rm -f /sdcard/Android/data/com.dts.freefireth/files/ffrtc_log_bak.txt*
    rm -f /sdcard/Android/data/com.dts.freefiremax/files/ffrtc_log.txt*
    rm -f /sdcard/Android/data/com.dts.freefiremax/files/ffrtc_log_bak.txt*
  }
  fsa > /dev/null 2>&1
  function unity {
  if pm list packages | grep -q com.dts.freefireth; then
    com.dts.freefireth
  elif pm list packages | grep -q com.dts.freefiremax; then
    com.dts.freefiremax
  else
   SurfaceFlinger=1
  fi
  }
  com.dts.freefireth() {
  {
    cmd game downscale 0.9 com.dts.freefireth
    cmd package compile -m speed --secondary-dex com.dts.freefireth
    cmd appops set com.dts.freefireth RUN_IN_BACKGROUND
    dumpsys deviceidle force-idle
    cmd looper_stats disable
  }
  com.dts.freefireth() }
  com.dts.freefiremax() {
  {
    cmd game downscale 0.9 com.dts.freefiremax
    cmd package compile -m speed --secondary-dex com.dts.freefiremax
    cmd appops set com.dts.freefiretmax RUN_IN_BACKGROUND
    dumpsys deviceidle force-idle
    cmd looper_stats disable
  }
  com.dts.freefiremax() }
  unity > /dev/null 2>&1
  printer "mode fsa : HEADTRICK "
  sleep 1
  if [ "$version_numbers" -lt 12 ]; then
    settings put global game_driver_all_apps 1
    settings put global game_driver_opt_out_apps 1
    settings put global game_driver_opt_in_apps $system_output
  elif [ "$version_numbers" -ge 12 ]; then
    settings put global updatable_driver_all_apps 1
    settings put global updatable_driver_production_opt_out_apps
    settings put global updatable_driver_production_opt_in_apps $system_output
  else
    settings delete global game_driver_all_apps
    settings delete global game_driver_opt_out_apps
    settings delete global game_driver_opt_in_apps
    settings delete global updatable_driver_all_apps
    settings delete global updatable_driver_production_opt_out_apps
    settings delete global updatable_driver_production_opt_in_apps
  fi
  sleep 0.2
  for fsa in `pm list packages -s | sort | uniq`; do
    cmd otadexopt next $fsa > /dev/null 2>&1
    cmd otadexopt done $fsa > /dev/null 2>&1
  done
  echo "FSA@Henpeex berhasil terpasang :${READ} $DATE "
  sleep 1 
  echo
fi
