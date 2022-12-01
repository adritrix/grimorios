#!/bin/bash
n1=20
n2=49
n3=193
echo $n1+$n3 | bc 
echo $n3+$n2 | bc
echo $n3*$n3 | bc
#echo {$n2-$n3+$n3}/$n1 | bc

oper4=`echo "scale=2; ($n2-$n3+$n3)/$n1" | bc`
echo $oper4
