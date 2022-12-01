#!/bin/bash 
fecha=`date +%d%m%y`
if !([ -d  adrian  ])
then 
	mkdir adrian
fi

for file in `ls /etc/ | grep .conf$`
do
	tf=`stat /etc/$file | tail -3| head -1| cut -d" " -f2`
	th=`date --date "-27 days" +%Y-%m-%d`
	if [ $tf \< $th  ]
	then
		cp /etc/$file  /root/scripts/repaso/adrian/${file}_${fecha}
	fi
	if [ $? -eq 1  ]
	then
		echo "Error, el fichero $file no se ha pododo copiar  " >> /root/scripts/repaso/$fecha
	fi
done
