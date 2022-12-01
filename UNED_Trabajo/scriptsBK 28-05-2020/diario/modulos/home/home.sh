#!/bin/bash

######################## Bloque de home de usuarios  diario########################

dirPaquete="/backups/diario/home/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="homeData_"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

dirDatos="/home/"

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

####################################################################################### 
