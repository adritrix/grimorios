#!/bin/bash
function procesos(){
	z=`ps -aux | wc -l`
	#echo "funcion de procesos aun no implementada"
	echo "Hay $z procesos dando por culo"
	read s
	return 0
}

function memoria(){
	echo "Funcion de memoria aun no esta implementada"
	return 0
}

function usuarios(){
	res=`who | wc -l`
	echo "Hay $res usuarios conectados"
	read s
	return 0
}

function espacio_libre(){
	echo "Funcion estapcio libre aun no esta implementada"
}
