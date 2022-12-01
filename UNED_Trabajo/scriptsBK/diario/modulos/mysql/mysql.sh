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

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

#######################################################################################

######################## Bloque conf de BBDD diario########################

dirPaquete="/backups/diario/mysql/conf/"

mkdir -p ${dirPaquete} &>> $archivoLog

remoto="cloud:"

#fecha=`date +%Y_%m_%d_%H_%M`

nombrePaquete="bk_mysql_conf"

extension=".tar.gz"

nombrePaqueteCompleto=${dirPaquete}${nombrePaquete}${extension}

dirDatos="/tmp/mysqlConf/"

mkdir -p $dirDatos

cp -r /etc/my.cnf $dirDatos

cp -r /etc/my.cnf.d/ $dirDatos

cp -r /etc/my.cnf.rpmsave $dirDatos

tar -vcz -f ${nombrePaqueteCompleto} ${dirDatos} &>> $archivoLog


rclone copy ${nombrePaqueteCompleto} ${remoto}${dirPaquete} &>> $archivoLog

#######################################################################################                                                           
