#!/bin/bash
##Directorio raiz donde se guardaran los archivos 
dirOrigen="/backups/diario/"
mkdir -p $dirOrigen
fecha=`date +%d_%m_%Y_%H_%M`
##Archivo donde se guardan los logs 
archivoLog="${dirOrigen}log.log"
touch $archivoLog

echo @@@@@@@@@@@@@@@@@@@@@@@@@@${fecha}@@@@@@@@@@@@@@@@@@@@@@@@@@@ >> $archivoLog
##Los distintos modulos en que se ejecutan a partir de este main 
source /etc/scriptsBK/diario/modulos/apache2/apache2.sh
source /etc/scriptsBK/diario/modulos/home/home.sh
source /etc/scriptsBK/diario/modulos/mysql/mysql.sh
source /etc/scriptsBK/diario/modulos/postgresql/postgresql.sh
##Copia del archivo log a la nube  
rclone copy $archivoLog ${remoto}${dirOrigen}
exit 0
