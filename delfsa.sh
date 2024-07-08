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
echo ""
sleep 0.4
sleep 0.1
echo "
█▀▀ █▀ ▄▀█ ▄▄ █░█ █▀▀ █▄░█ █▀█ █▀▀ █▀▀ ▀▄▀
█▀░ ▄█ █▀█ ░░ █▀█ ██▄ █░▀█ █▀▀ ██▄ ██▄ █░█"
sleep 0.4
printer "- Developer : Henpee@FSA ( Remover Tools )"
sleep 0.2
printer "- Version : 1.0 Online "
sleep 0.6
echo ""
echo ""
sleep 1
printer " FSA@Henpeex telah berhasil di hapus "
echo 
sleep 0.3
 remove() {
    settings delete global game_driver_all_apps
    settings delete global game_driver_opt_out_apps
    settings delete global game_driver_opt_in_apps
    settings delete global updatable_driver_all_apps
    settings delete global updatable_driver_production_opt_out_apps
    settings delete global updatable_driver_production_opt_in_apps
    cmd game downscale 1.0 com.dts.freefiremax
    cmd game downscale 1.0 com.dts.freefireth
 }
 remove > /dev/null 2>&1