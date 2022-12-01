#!/bin/bash
#tar  -cf eje1.sh.tar eje1.sh 

fecha=`date "+%d%m%Y"`
fecha2=`date "+%d%m%Y%H"`
if [ -d ./copia_seguridad  ]
then
	echo "paso uno"
else
	mkdir copia_seguridad

fi


if [ -d ./copia_seguridad/${fecha} ]
then
	echo "paso dos "
else
	mkdir ./copia_seguridad/${fecha}
fi

if [ -a ./copia_seguridad/seguridad${fecha2}.tar ]
then
	echo "paso tres"
else
	tar -cf ./copia_seguridad/seguridad${fecha2}.tar ./copia_seguridad/${fecha} 
fi
