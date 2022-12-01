#!/bin/bash
if [ $# -ne 2  ]
then 
	echo "dame dos parametros fulana "
	exit 0
	fi
n1=$1
n2=$2

echo "LA suma de $n1 y $n2 es:" `echo $n1 + $n2 | bc`
