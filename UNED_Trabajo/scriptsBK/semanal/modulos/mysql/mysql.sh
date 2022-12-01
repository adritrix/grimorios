#!/bin/bash

######################## Bloque datos de BBDD diario########################

dirPaquete="/backups/semanal/mysql/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="mysqldump_semanal"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${fecha}${extension}

dirDatos="/tmp/mysqldump/full/"

mkdir -p ${dirDatos}

mysqldump -uroot -pEspan@241280 --all-databases > ${dirDatos}full_databases.sql 2>> $archivoLog

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog


nArchivos=`ls $dirPaquete | wc -l`
while [ $nArchivos -gt 2 ]
do
        cd $dirPaquete
        rm "$(ls -t | tail -1)"
        nArchivos=`ls $dirPaquete | wc -l`
        rclone sync ${dirPaquete} ${remoto}${dirPaquete}
done

#######################################################################################

######################## Bloque conf de BBDD diario########################

dirPaquete="/backups/semanal/mysql/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="bk_mysqlConf"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${fecha}${extension}

dirDatos="/tmp/mysqlConf/"

mkdir -p $dirDatos

cp -r /etc/my.cnf $dirDatos

cp -r /etc/my.cnf.d/ $dirDatos

cp -r /etc/my.cnf.rpmsave $dirDatos

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog


nArchivos=`ls $dirPaquete | wc -l`
while [ $nArchivos -gt 2 ]
do
        cd $dirPaquete
        rm "$(ls -t | tail -1)"
        nArchivos=`ls $dirPaquete | wc -l`
        rclone sync ${dirPaquete} ${remoto}${dirPaquete}
done

#######################################################################################
