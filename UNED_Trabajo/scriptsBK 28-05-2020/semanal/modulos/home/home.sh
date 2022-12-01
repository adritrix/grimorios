#!/bin/bash

######################## Bloque de home de usuarios  diario########################

dirPaquete="/backups/semanal/home/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="homeData_"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${fecha}${extension}

dirDatos="/home/"

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
