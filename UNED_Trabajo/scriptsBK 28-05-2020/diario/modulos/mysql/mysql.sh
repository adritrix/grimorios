#!/bin/bash

######################## Bloque datos de BBDD diario########################

dirPaquete="/backups/diario/mysql/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="mysqldump_diario"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

dirDatos="/tmp/mysqldump/"

mkdir -p ${dirDatos}

mysqldump -umimir -ppkr200 Chinook Artist > ${dirDatos}Chinook_Artist.sql 2>> $archivoLog

mysqldump -umimir -ppkr200 Chinook Album > ${dirDatos}chinook_album.sql 2>> $archivoLog

mysqldump -umimir -ppkr200 Chinook > ${dirDatos}chinook.sql 2>> $archivoLog

mysqldump -umimir -ppkr200 mysql > ${dirDatos}mysql.sql 2>> $archivoLog

mysqldump -umimir -ppkr200 phpmyadmin pma__users  > ${dirDatos}phpmyadmin_pma__users.sql 2>> $archivoLog

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

#######################################################################################

######################## Bloque conf de BBDD diario########################

dirPaquete="/backups/diario/mysql/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="bk_mysqlConf"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

dirDatos="/etc/mysql/"

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

#######################################################################################
