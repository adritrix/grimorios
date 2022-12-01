#!/bin/bash
n1=0
while [ $n1 -lt 10 ]
do
	echo "hola mundo" ${n1}
	n1=`echo $n1 + 1 | bc`
done
