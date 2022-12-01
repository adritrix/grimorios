#!/bin/bash

######################## Bloque datos de BBDD diario########################

##Direccion donde se va a crear el paquete
dirPaquete="/backups/diario/postgresql/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

##Nombre del la ruta que apunta al directorio en la nube
remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

##Nombre del paquete
nombrePaquete="postgresDump_diario"


##Extension del paquete, que en este caso tiene extension .tar.gz
extension=".tar.gz"

##Direccion completa del paquete que queremos generar; con su ruta, su nombre, la fecha de creacion y su extension
nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}


##Direccion de donde se va e empaquetar la informacion
dirDatos="/tmp/postgresdump/diario/"

mkdir -p ${dirDatos}

##Volcados de las bases de datos en el directorio de donde se va a crear el paquete 
sudo -u postgres pg_dump shakespeare  >  ${dirDatos}shakespeare.sql 2>> $archivoLog

sudo -u postgres pg_dump shakespeare -t chapter  >  ${dirDatos}shakespeare.sql 2>> $archivoLog

sudo -u postgres pg_dump shakespeare -t work  >  ${dirDatos}shakespeare_work.sql 2>> $archivoLog

sudo -u postgres pg_dump shakespeare -t wordform  >  ${dirDatos}shakespeare_wordform.sql 2>> $archivoLog

sudo -u postgres pg_dump shakespeare -t paragraph  >  ${dirDatos}shakespeare_paragraph.sql 2>> $archivoLog

sudo -u postgres pg_dump shakespeare -t character_work  >  ${dirDatos}shakespeare_character_work.sql 2>> $archivoLog

sudo -u postgres pg_dump shakespeare -t character  >  ${dirDatos}shakespeare_character.sql 2>> $archivoLog


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

#######################################################################################

######################## Bloque conf de BBDD diario########################

##Direccion donde se va a crear el paquete
dirPaquete="/backups/diario/postgresql/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

##Nombre del la ruta que apunta al directorio en la nube
remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

##Nombre del paquete
nombrePaquete="postgresqlConf"

##Extension del paquete, que en este caso tiene extension .tar.gz
extension=".tar.gz"

##Direccion completa del paquete que queremos generar; con su ruta, su nombre, la fecha de creacion y su extension
nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

##Direccion de donde se va e empaquetar la informacion
dirDatos="/tmp/postgresqlConf/"

mkdir -p $dirDatos

cp -r -p /var/lib/pgsql/data $dirDatos

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


#####################################################################################
