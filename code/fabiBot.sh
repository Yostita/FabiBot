#!/bin/bash

clear

echo "Iniciando FabiBot..."
echo "Arrancando el sistema..."
echo "Iniciando variables globales..."

COMMAND_MANTENIMIENTO="Mantenimiento"
COMMAND_DUPLICADO="Modificar fichero"
COMMAND_EXIT="Adios"
exit=0

echo "Cargando librerias..."

#mkdir Librerias
#Cargar librerias desde Github
#mkdir PanelInteraccion

chmod +x ./Librerias/mantenimiento.sh
chmod +x ./Librerias/duplicados.sh

echo -e "Listo...\n"
echo "Bienvenido señor, ¿En que puedo ayudarle hoy?"

until [ $exit = "1" ]
do
    read user_command

    case "$user_command" in
        "$COMMAND_MANTENIMIENTO" )
            ./Librerias/./mantenimiento.sh
            ;;
        "$COMMAND_DUPLICADO")
            ls PanelInteraccion
            read -p "Nombre del fichero:" filename
            ./Librerias/./duplicados.sh "./PanelInteraccion/$filename"
            ;;
        "$COMMAND_EXIT" )
            echo Hasta luego
            break;
            ;;
        "$COMMAND_HELP" )

            ;;
        * )
            echo "No conozco el comando: "$user_command""
            ;;
    esac

    echo -e "Operacion realizada con existo\n\n"
    echo "¿En que mas puedo ayudarle?"
done