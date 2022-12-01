#!/bin/bash
PTH= "/root/scripts/basura"
while read nombre edad aellido
do
	mkdir ${PTH}/$nombre
	mkdir ${PTH}/$edad
	mkdir ${PTH}/$aellido
done < fichero_lee2.txt
