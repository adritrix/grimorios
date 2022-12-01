#!/bin/bash

while read nombre edad aellido
do
	echo "Hola soy $nombre $aellido y tengo $edad años"
done < fichero_lee2.txt
