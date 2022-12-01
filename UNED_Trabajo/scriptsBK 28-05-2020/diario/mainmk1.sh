#!/bin/bash
dirOrigen="/backups/diario/"
mkdir -p /backups/diario/
fecha=`date +%Y_%m_%d_%H_%M`
archivoLog="${dirOrigen}${fecha}.log"
touch $archivoLog

source /etc/scriptsBK/diario/modulos/apache2/apache2.sh
source /etc/scriptsBK/diario/modulos/home/home.sh
source /etc/scriptsBK/diario/modulos/mysql/mysql.sh
rclone copy $archivoLog ${remoto}${dirOrigen}
exit 0

