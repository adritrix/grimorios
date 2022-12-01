#!/bin/bash
if !([ -d ./dir_eje  ])
then
	mkdir ./dir_eje
fi

while read pt
do
	if (![])
	nombre=`echo pt | cut -d " " -f1 `
	extension=`echo pt | cut -d "  "-f2 `
	touch ./dir_eje/${nombre}${extension}
done < fichero_lee.txt
