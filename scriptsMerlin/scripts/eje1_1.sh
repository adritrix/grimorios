#!/bin/bash
for (( ip=1; ip<13; ip++  ))
do
	ping 172.21.0.${ip} -c3
	if [ $? -eq 0  ]
	then
		echo "La ip 172.21.0.${ip} tiene ip  " >> tryip.txt
	fi
done
