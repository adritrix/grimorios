#!/bin/bash
IFS=:

fecha=`date +%Y%m%d`
while read nombre c d e r home z
do 2> /dev/null
  	if [ -d $home  ]
	then
		peso=`du $home -m 2> /dev/null | tail -1| cut -f1`
		echo "El directprio $home pesa $peso" >> ${fecha}_ocupacion.txt
		echo "El usuario $nombre tiene el directorio $home como carpeta personal y pesa $peso"

	else
		echo "El usuario $nombre con directorio $home es un sintecho"
	fi
done < /etc/passwd
mkdir /root/scripts/INFORME_OCUPACION
mv ${fecha}_ocupacion.txt /root/scripts/INFORME_OCUPACION/${fecha}_ocupacion.txt
