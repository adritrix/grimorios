#!/bin/bash

######################## Bloque de configuracion de apache diario########################

dirPaquete="/backups/semanal/apache/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="apacheConf_"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${fecha}${extension}

dirDatos="/etc/httpd/"

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

######################## Bloque de datos de apache diario########################

dirPaquete="/backups/semanal/apache/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

##fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="apacheData_"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${fecha}${extension} 

dirDatos="/var/www/html/"

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
