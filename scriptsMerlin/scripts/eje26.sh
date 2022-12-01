#!/bin/bash
IFS=:
while read nombre c d e r home z
do
  	if [ -d $home  ]
	then
		peso=`du $home -m | tail -1| cut -f1`
		echo "El usuario $nombre tiene el directorio $home como carpeta personal y pesa $peso"
	else
		echo "El usuario $nombre con directorio $home es un sintecho"
	fi
done < /etc/passwd

