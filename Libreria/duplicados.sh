#! /bin/sh

if [ -f $1.txt ]; 
then
    sort $1.txt | uniq | tee $1Copia.txt
     echo "Ya se han quitado las lineas duplicadas del fichero $1 y almacenadas en $1Copia.txt"
else
    echo "No existe $1 en $pwd...Prueba otra vez"
fi

exit 0