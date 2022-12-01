#!/bin/bash
fecha=`date +%Y%m%d%H%M`
if !([ -d backup_etc ])
then
	mkdir /root/scripts/backup_etc
fi

for file in `ls -l /etc | grep "^-" | tr -s " " | cut -d " " -f9`
do
	cp /etc/$file  /root/scripts/backup_etc/${file}_${fecha}
	if [ $? -eq 0 ]
	then
		echo "El fichero $file se ha copiado satisfactoriamente" >> try_copia_etc.log
	else
		echo "El ficher $file no se ha copiado por errores" >> try_copia_etc.log
	fi
done

