
#!/bin/bash -x

read -p "Dame un numero " n1
if !([ -d ./ficheros  ])
then
	mkdir ./ficheros
fi
cont=0
while  [ $cont -le $n1  ]
do
	touch ./ficheros/${cont}_Adrian
	cont=$[ $cont + 1 ]
done
