#! /bin/sh

ls PanelInteraccion
read -p "Nombre del fichero:" filename

if [ ./PanelInteraccion/$filename.txt ]; 
then
    sort ./PanelInteraccion/$filename.txt | uniq | tee > ./PanelInteraccion/$1Copia.txt
     echo "Ya se han quitado las lineas duplicadas del fichero $filename y almacenadas en "$filename"Copia.txt"
else
    echo "No existe $filename en $pwd...Prueba otra vez"
fi