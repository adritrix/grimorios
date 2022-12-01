#!/bin/bash

######################## Bloque datos de BBDD diario########################

##Direccion donde se va a crear el paquete
dirPaquete="/backups/diario/mysql/data/"

mkdir -p ${dirPaquete} &>> $archivoLog

##Nombre del la ruta que apunta al directorio en la nube
remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

##Nombre del paquete
nombrePaquete="mysqldump_diario"

##Extension del paquete, que en este caso tiene extension .tar.gz
extension=".tar.gz"

##Direccion completa del paquete que queremos generar; con su ruta, su nombre, la fecha de creacion y su extension
nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

##Direccion de donde se va e empaquetar la informacion
dirDatos="/tmp/mysqldump/diario/"

mkdir -p ${dirDatos}

##Volcados de las bases de datos en el directorio de donde se va a crear el paquete 
mysqldump -uroot -pEspan@241280 information_schema > ${dirDatos}full_information_schema.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 mysql > ${dirDatos}full_mysql.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 performance_schema > ${dirDatos}full_performance_schema.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress > ${dirDatos}full_wordpress.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_commentmeta > ${dirDatos}wordpress_wp_commentmeta.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_comments > ${dirDatos}wordpress_wp_comments.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_links  > ${dirDatos}wordpress_wp_links.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_options  > ${dirDatos}wordpress_wp_options.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_postmeta  > ${dirDatos}wordpress_wp_postmeta.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_posts  > ${dirDatos}wordpress_wp_posts.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_term_relationships  > ${dirDatos}wordpress_wp_term_relationships.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_term_taxonomy  > ${dirDatos}wordpress_wp_term_taxonomy.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_termmeta  > ${dirDatos}wordpress_wp_termmeta.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_terms  > ${dirDatos}wordpress_wp_terms.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_usermeta  > ${dirDatos}wordpress_wp_usermeta.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_users  > ${dirDatos}wordpress_wp_users.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress wp_yoast_seo_links  > ${dirDatos}wordpress_wp_yoast_seo_links.sql 2>> $archivoLog

mysqldump -uroot -pEspan@241280 wordpress  wp_yoast_seo_meta > ${dirDatos}wordpress_wp_yoast_seo_meta.sql 2>> $archivoLog

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
dirPaquete="/backups/diario/mysql/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

##Nombre del la ruta que apunta al directorio en la nube
remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

##Nombre del paquete
nombrePaquete="bk_mysql_conf"

##Extension del paquete, que en este caso tiene extension .tar.gz
extension=".tar.gz"

##Direccion completa del paquete que queremos generar; con su ruta, su nombre, la fecha de creacion y su extension
nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

##Direccion de donde se va e empaquetar la informacion
dirDatos="/tmp/mysqlConf/"

mkdir -p $dirDatos

cp -r -p /etc/my.cnf $dirDatos

cp -r -p /etc/my.cnf.d/ $dirDatos

cp -r -p /etc/my.cnf.rpmsave $dirDatos

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
