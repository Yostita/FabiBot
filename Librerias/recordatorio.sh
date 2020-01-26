#!/bin/bash

TOKEN="1024267596:AAE0iVDK0PIL23Lfr09mBc2TZ-mBEcjA8Xs"
ID="721440022"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

read -p "¿Qué desea que le envie al movil?: " MESSAGE

echo -e "\n Enviando mensaje...\n"

curl -s -X POST $URL -d chat_id=$ID -d text="$MESSAGE"
