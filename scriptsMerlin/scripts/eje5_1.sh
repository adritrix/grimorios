#!/bin/bash
if [ $# -ne 2  ]
then
	echo "dame dos parametros fulana"
	exit 0
fi

d1=$1
d2=$2

if [ -d $d1  ]
then
	if [ -d $d2  ]
	then
		echo "los dos directorias existen"
		p1=`du $d1 -m  | tail -1 | cut -f1`
		p2=`du $d2 -m  | tail -1 | cut -f1`
		echo "El directorio $d1 pesa $p1 y el directorio $d2 pesa $p2"
	else
		echo "El directorio $d2 no existe"	
	fi
else
	echo "El directorio $d1 no existe"
	exit 0
fi
if [ $p1 -gt $p2  ]
then
	echo "El directorio $d1 pesa mas que el directorio $d2"
else
	echo "El directorio $d2 pesa mas que el directorio $d1"
fi
