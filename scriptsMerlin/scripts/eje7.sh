#!/bin/bash -x

read -p "Que directorio quieres peaser?" n1
peso=`du -k $n1 | tail -1 | cut -f1`
echo "El directorio $n1 pesa $peso megas"
if [ n1 -gt 100000 ]
then
echo "Esta muy gordo"
elif [ n1 -gt 2000000 ]
then
echo "Esta mucho mas gordo"
fi
