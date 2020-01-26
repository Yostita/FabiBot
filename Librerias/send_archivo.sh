#!/bin/bash

TOKEN="1024267596:AAE0iVDK0PIL23Lfr09mBc2TZ-mBEcjA8Xs"
ID="721440022"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

ls PanelInteraccion
read -p "Nombre del fichero que desea enviar: " filename

if [ -f ./PanelInteraccion/$filename.txt ]; 
then
    MESSAGE=$(cat ./PanelInteraccion/$filename.txt)
    curl -s -X POST $URL -d chat_id=$ID -d text="$MESSAGE"
    echo "Se ha enviado correctamente el archivo $filename"
else
    echo "No existe $filename en $pwd...Prueba otra vez"
fi

exit 0