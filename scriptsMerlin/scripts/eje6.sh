#! /bin/bash
echo "dame un nombre de  un proceso "
read n1
ps -aux | grep bash | grep -v grep | tail -1 | tr -s " " | cut -d " " -f1,2,11

