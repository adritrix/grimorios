#!/bin/bash
dirOrigen="/backups/diario/"
mkdir -p $dirOrigen
fecha=`date +%Y_%m_%d_%H_%M`
archivoLog="${dirOrigen}log.log"
touch $archivoLog

echo @@@@@@@@@@@@@@@@@@@@@@@@@@${fecha}@@@@@@@@@@@@@@@@@@@@@@@@@@@ >> $archivoLog

source /etc/scriptsBK/diario/modulos/apache2/apache2.sh
source /etc/scriptsBK/diario/modulos/home/home.sh
source /etc/scriptsBK/diario/modulos/mysql/mysql.sh
rclone copy $archivoLog ${remoto}${dirOrigen}
exit 0

