#!/bin/bash

######################## Bloque de configuracion de apache diario########################

dirPaquete="/backups/diario/apache/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="apacheConf_"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

dirDatos="/etc/apache2/"

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

#######################################################################################

######################## Bloque de datos de apache diario########################

dirPaquete="/backups/diario/apache/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

##fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="apacheData_"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension} 

dirDatos="/var/www/"

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

####################################################################################### 
