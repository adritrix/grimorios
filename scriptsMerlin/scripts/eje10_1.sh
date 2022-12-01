#! /bin/bash 

. eje10_1_funciones.sh

ck=0
while [ 1 -ne 5  ]
do
	echo "--------------------------------------------------------------"
	echo "1)- Nº de procesos que estan corriendo"
	echo "2)- Memoria libre"
	echo "3)- Nº de usuarios conectados"
	echo "4)- Espacio libre"
	echo "5)- Salir"
	echo "--------------------------------------------------------------"
	read sl
	case $sl in
		"1")
			procesos
			;;
		"2")
			memoria
			;;
		"3")
			usuarios
			;;
		"4")
			espacio_libre
			;;
		"5")
			exit 0
			;;
		*)
			echo "Fulana dame valores contemplados"
			;;
	esac
done
exit 0
