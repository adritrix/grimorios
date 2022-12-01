#!/bin/bash
##Directorio raiz donde se guardaran los archivos 
dirOrigen="/backups/semanal/"
mkdir -p ${dirOrigen}
fecha=`date +%d_%m_%Y_%H_%M`
##Archivo donde se guardan los logs
archivoLog="${dirOrigen}log.log"
touch $archivoLog

echo @@@@@@@@@@@@@@@@@@@@@@@@@@${fecha}@@@@@@@@@@@@@@@@@@@@@@@@@@@ >> $archivoLog
##Los distintos modulos en que se ejecutan a partir de este main 
source /etc/scriptsBK/semanal/modulos/apache2/apache2.sh
source /etc/scriptsBK/semanal/modulos/home/home.sh
source /etc/scriptsBK/semanal/modulos/mysql/mysql.sh
source /etc/scriptsBK/semanal/modulos/postgresql/postgresql.sh
##Copia del archivo log a la nube  
rclone copy $archivoLog ${remoto}${dirOrigen}
exit 0

