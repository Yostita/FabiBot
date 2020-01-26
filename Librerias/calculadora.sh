#!/bin/bash

sum=0
i="y"

echo "Introduce la primera cifra"
read n1
echo "Ahora la segunda"
read n2
while [ $i = "y" ]
do
echo "1.Sumar"
echo "2.Restar"
echo "3.Multiplicar"
echo "4.Dividir"
echo "Introduce el numero de operación seleccionada [1-4]"
read ch

case $ch in
    1)
    sum=`expr $n1 + $n2`
    echo "Resultado = "$sum
    ;;
    2)
    sum=`expr $n1 - $n2`
    echo "Resultado = "$sum
    ;;
    3)
    sum=`expr $n1 \* $n2`
    echo "Resultado = "$sum
    ;;
    4)
    sum=`expr $n1 / $n2`
    echo "Resultado = "$sum;;
    *)
    echo "Tu selección es incorrecta"
    ;;
esac

echo "Quieres continuar (y/n)) ?"
read i

if [ $i != "y" ]
then
    exit
fi
done
