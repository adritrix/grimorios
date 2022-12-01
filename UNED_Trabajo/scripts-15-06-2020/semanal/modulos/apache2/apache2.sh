#!/bin/bash

######################## Bloque de configuracion de apache diario########################

##Direccion donde se va a crear el paquete
dirPaquete="/backups/semanal/apache/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

##Nombre del la ruta que apunta al directorio en la nube
remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

##Nombre del paquete
nombrePaquete="apacheConf_"

##Extension del paquete, que en este caso tiene extension .tar.gz
extension=".tar.gz"

##Direccion completa del paquete que queremos generar; con su ruta, su nombre, la fecha de creacion y su extension
nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${fecha}${extension}

##Direccion de donde se va e empaquetar la informacion
dirDatos="/etc/httpd/"

cd ${dirDatos}

##Comando de comprsion donde creamos el paquete en la ruta establecida de los datos del directorio con la informacion
tar -vcz -f ${nombrePaqueteCompleto} ./ &>> $archivoLog

##Comprobacion del tamaño del paquete generado ya que dependiendo del servicio en la nube se permite un maximo de tamaño de archvo
tamanoTar=`ls -l --block-size=G ${nombrePaqueteCompleto}  | cut -d " " -f 5 | sed s/.$//`
echo $tamanoTar

if [ $tamanoTar -ge 10 ]
##En caso de que el paquete pese 10GB o mas, se dividira dicho paquete en una carpeta que se llamara como se llamaria el paquete, posteriormente se eliminara el paquete original
then
        echo "el archivo ${nombrePaquete}${fecha}${extension}  es igual a 10GB o mayor de 10GB por lo que sera dividido"
        carpetaSplit=${nombrePaqueteCompleto}_split/
        mkdir -p $carpetaSplit
        split -b 5G ${nombrePaqueteCompleto} ${carpetaSplit}"parte_"
        rclone copy ${dirPaquete} ${remoto}${dirPaquete} &>> $archivoLog
        rm -rf ${nombrePaqueteCompleto}
##En caso de que el paquete pese menos de 10GB, simplemente se subira a la nube
else

        echo "el archivo ${nombrePaquete}  es menor de 10GB por lo que no sera dividido  "
        rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog
fi

#rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

##Comprueba el numero de elementos en el directorio de la copoa de seguridad y si es mayor a 2, eliminara el mas antiguo y lo sincronizara en la nube
nArchivos=`ls $dirPaquete | wc -l`
while [ $nArchivos -gt 2 ]
do
        cd $dirPaquete
        rm -rf "$(ls -t | tail -1)"
        nArchivos=`ls $dirPaquete | wc -l`
        rclone sync ${dirPaquete} ${remoto}${dirPaquete}
done


#######################################################################################

######################## Bloque de datos de apache diario########################

##Direccion donde se va a crear el paquete
dirPaquete="/backups/semanal/apache/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

##Nombre del la ruta que apunta al directorio en la nube
remoto="cloud:"

##fecha=`date +%Y_%m_%d_%H_%M`

##Nombre del paquete
nombrePaquete="apacheData_"

##Extension del paquete, que en este caso tiene extension .tar.gz
extension=".tar.gz"

##Direccion completa del paquete que queremos generar; con su ruta, su nombre, la fecha de creacion y su extension
nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${fecha}${extension} 

##Direccion de donde se va e empaquetar la informacion
dirDatos="/var/www/html/"

cd ${dirDatos}

##Comando de comprsion donde creamos el paquete en la ruta establecida de los datos del directorio con la informacion
tar -vcz -f ${nombrePaqueteCompleto} ./ &>> $archivoLog

##Comprobacion del tamaño del paquete generado ya que dependiendo del servicio en la nube se permite un maximo de tamaño de archvo
tamanoTar=`ls -l --block-size=G ${nombrePaqueteCompleto}  | cut -d " " -f 5 | sed s/.$//`
echo $tamanoTar

if [ $tamanoTar -ge 10 ]
##En caso de que el paquete pese 10GB o mas, se dividira dicho paquete en una carpeta que se llamara como se llamaria el paquete, posteriormente se eliminara el paquete original
then
        echo "el archivo ${nombrePaquete}${fecha}${extension}  es igual a 10GB o mayor de 10GB por lo que sera dividido"
        carpetaSplit=${nombrePaqueteCompleto}_split/
        mkdir -p $carpetaSplit
        split -b 5G ${nombrePaqueteCompleto} ${carpetaSplit}"parte_"
        rclone copy ${dirPaquete} ${remoto}${dirPaquete} &>> $archivoLog
        rm -rf ${nombrePaqueteCompleto}
##En caso de que el paquete pese menos de 10GB, simplemente se subira a la nube
else

        echo "el archivo ${nombrePaquete}  es menor de 10GB por lo que no sera dividido  "
        rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog
fi

#rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog


##Comprueba el numero de elementos en el directorio de la copoa de seguridad y si es mayor a 2, eliminara el mas antiguo y lo sincronizara en la nube
nArchivos=`ls $dirPaquete | wc -l`
while [ $nArchivos -gt 2 ]
do
        cd $dirPaquete
        rm -rf "$(ls -t | tail -1)"
        nArchivos=`ls $dirPaquete | wc -l`
        rclone sync ${dirPaquete} ${remoto}${dirPaquete}
done

####################################################################################### 
