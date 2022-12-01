#!/bin/bash
my=0
mn=1000000
while [ -n "$1"  ]
do
	ch=`echo $1 % 2 | bc`
	if [ $ch -eq 0  ]
	then
		echo "El numero $1 es par"
	else
		echo "El numero $1 es impar"
	fi
	if [ $1 -lt $mn  ]
        then
        mn=$1
        fi

	if [ $1 -gt $my  ]
	then
	my=$1
	fi
shift
done
echo "El numero introdidido mayar es $my"
echo "El numero introducido menor es $mn"
