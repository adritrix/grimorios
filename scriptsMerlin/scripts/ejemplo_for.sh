#!/bin/bash
for file in `ls ~/scripts`
do
	mv ~/scripts/${file} ~/scripts/adri/${file}.bk
done

