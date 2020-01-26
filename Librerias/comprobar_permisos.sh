#!/bin/bash
ROOT_UID=0

if [ "$UID" -eq "$ROOT_UID" ]
then
    echo -e "\nAcceso concedido\n"
else
    echo "No tienes permisos suficientes para ejecutar todos los servicios de Fabibot"
    exit 0
fi
