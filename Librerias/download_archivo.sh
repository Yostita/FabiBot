#!/bin/bash

TOKEN="1024267596:AAE0iVDK0PIL23Lfr09mBc2TZ-mBEcjA8Xs"
ID="721440022"
UPDATE="https://api.telegram.org/bot$TOKEN/getUpdates"

ls PanelInteraccion
read -p "Como desea llamar al archivo: " filename

if [ -f ./PanelInteraccion/$filename.txt ]; 
then
    echo "Ya existe $filename en $pwd...Prueba otra vez"
else
    read -p "Pulse cualquier tecla cuando quiera empezar a descargar el archivo.Compruebe que es el ultimo mensaje que ha enviado a fabiBot"
    curl $UPDATE > tmplog.txt
    MESSAGE=$(tail -n 1 tmplog.txt|awk -F ":" '{print $14}'|awk -F '"' '{print $2}')
    echo $MESSAGE
    echo $MESSAGE >> ./PanelInteraccion/$filename.txt
    echo "Descargando..."
    echo "Descarga completa. Se ha guardado con el nombre $filename en el directorio PanelInteraccion"
    rm tmplog.txt
fi