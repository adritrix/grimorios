#!/bin/bash
read -p "Tu blanquito dame un numero " n1
read -p "Tu blanquito dame un segundo libro" n2
while [ $n1 -le $n2 ]
do
	echo $n1
	n1=$[ $n1 + 1 ]
done
