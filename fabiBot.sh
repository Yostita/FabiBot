#!/bin/bash

clear

echo "Iniciando FabiBot..."
echo "Comprobando permisos..."

chmod +x ./Librerias/comprobar_permisos.sh
./Librerias/./comprobar_permisos.sh

echo "Arrancando el sistema..."
echo "Iniciando variables globales..."

#Al no tener autoaprendizaje ni un registro de logs no veia necesario cargar las variables con ficheros
COMMAND_NOMBRE=("Como te llamas?" "Cual es tu nombre?")
COMMAND_FECHA=("Que dia es hoy?" "A que dia estamos?")
COMMAND_CALCULADORA=("Quiero usar la calculadora" "Abre la calculadora" "Abrir calculadora")
COMMAND_MOROSOS=("Abrir app no mas morosos")
COMMAND_MANTENIMIENTO=("Mantenimiento" "Activar mantenimiento")
COMMAND_FICHERO=("Modificar un fichero" "Enviar fichero" "Descargar fichero" "Trabajar con ficheros" "Ficheros")
COMMAND_INTERNET=("Internet" "Haz un analisis del internet")
COMMAND_INFORMACION=("Que sabes hacer?")
COMMAND_JUEGO=("Vamos a jugar a un juego" "Quiero jugar")
COMMAND_EXIT=("Adios" "Hasta luego" "Nada" "Me voy")
COMMAND_RECORDATORIO=("Enviame un recordatorio al movil" "Recordatorio")
MESSAGE_DESPEDIDA=("Hasta la proxima" "Como siempre, es un placer señor" "Que tenga un buen dia" "Hasta luego, señor" "Con su permiso me desconectare un rato")
exit=0

echo "Autorizando librerias..."

#Da permiso a todos los scripts
chmod +x ./Librerias/*.sh

echo -e "Listo.\n"
echo "Bienvenido señor, ¿En que puedo ayudarle hoy?"

until [ $exit = "1" ]
do
    read user_command

    case "$user_command" in
        #El bot se presenta
        "${COMMAND_NOMBRE[0]}"|"${COMMAND_NOMBRE[1]}" )
            cat ./Librerias/nombre.txt
            ;;
        #El bot te dice que dia es hoy
        "${COMMAND_FECHA[0]}"|"${COMMAND_FECHA[1]}" )
            DIA=`date +"%d/%m/%Y"`
            HORA=`date +"%H:%M"`

            echo "Hoy es el $DIA y la hora actual es $HORA"
            ;;
        #El bot abre la app calculadora
        "${COMMAND_CALCULADORA[0]}"|"${COMMAND_CALCULADORA[1]}"|"${COMMAND_CALCULADORA[2]}" )
            echo -e "\nAbriendo calculadora...\n"
            ./Librerias/./calculadora.sh
            echo -e "\nCerrando calculadora..."
            ;;
        #El bot abre la app No Más Morosos
        "$COMMAND_MOROSOS" )
            echo -e "\nAbriendo app No Más Morosos...\n"
            ./Librerias/./morosos.sh
            ;;
        #El bot ejecuta un script de mantenimiento del sistema
        "${COMMAND_MANTENIMIENTO[0]}"|"${COMMAND_MANTENIMIENTO[1]}")
            ./Librerias/./mantenimiento.sh
            ;;
        #El bot ofrece un menu de opciones a realizar con ficheros
        "${COMMAND_FICHERO[0]}"|"${COMMAND_FICHERO[1]}"|"${COMMAND_FICHERO[2]}"|"${COMMAND_FICHERO[3]}"|"${COMMAND_FICHERO[4]}" )
            echo  -e "\n¿Qué desea hacer con el fichero?: "
			echo  -e "  1.Enviarlo a mi movil"
			echo  -e "  2.Descargar archivo del movil"
            echo  -e "  3.Quitar lineas duplicadas"
			read user_command
            
            case "$user_command" in
                "1" )
                    ./Librerias/./send_archivo.sh
                    ;;
                "2" )
                    ./Librerias/./download_archivo.sh
                    ;;
                "3" )
                    ./Librerias/./duplicados.sh
                    ;;
                * )
                    echo "El comando "$user_command" no es una opcion valida"
                    ;;
            esac
            ;;
        #El bot muestra un menu para crear scripts
        "${COMMAND_SCRIPT[0]}"|"${COMMAND_SCRIPT[1]}")
            echo  -e "\n¿Qué tipo de script desea crear?: "
            echo  -e "  1.Instalacion"
            echo  -e "  2."
            read user_command

            case "$user_command" in
            "1" )
                ./Librerias/./crear_script_instalacion.sh
                ;;
            "2" )
                ;;
            * )
                echo "El comando "$user_command" no es una opcion valida"
                ;;
            esac
            ;;
        #El bot juega contigo a adivinar un numero
        "${COMMAND_JUEGO[0]}"|"${COMMAND_JUEGO[1]}")
            echo -e "Vamos a jugar a un juego. Yo voy a pensar un numero del 1 al 10 y tienes que advinirlo en menos de 3 intentos."
            read -p "¿Te apetece jugar(s/n)?" user_command
            case "$user_command" in
            "s"|"S")
                echo -e "\nIniciando juego...\n"
                
                #Por algun motivo me da error al meterlo en un script
                #por lo que lo he puesto aqui directamente
                numero=$(($RANDOM%10))
                respuesta=11
                cont=0
                
                while [ $numero -ne $respuesta ]
                do
                    let cont=cont+1
                   
                    if [ $cont -gt 3 ]
                    then
                        echo Intentos agotados
                        echo -e "\Cerrando juego...\n"
                        exit
                    else

                    read -p "¿Cual es el numero? 1-10: " respuesta
                    echo Numero de intentos $cont de 3.

                    if [ $numero -lt $respuesta ]
                    then
                        echo El numero es menor a $respuesta
                    elif [ $numero -gt $respuesta ]
                    then
                        echo EL numero es mayor a $respuesta
                    fi 
                    fi
                done
                echo Correcto, el numero es $numero.

                echo -e "\nCerrando juego...\n"
                ;;
            "n"|"N")
                echo "Por el momento no conozco mas juegos. Otra vez sera."
                ;;
            * )
                echo "El comando "$user_command" no es una opcion valida"
                ;;
            esac
                ;;
        #El bot te envia un mensaje a tu Telegram como recordatorio
        "${COMMAND_RECORDATORIO[0]}"|"${COMMAND_RECORDATORIO[1]}")
            ./Librerias/./recordatorio.sh
            echo -e "\nMensaje enviado.\n"
            ;;
        #El bot te muestra que es capaz de hacer
        "$COMMAND_INFORMACION" )
            cat ./Librerias/info.txt
            ;;
        #Cierra el programa
        "${COMMAND_EXIT[0]}"|"${COMMAND_EXIT[1]}"|"${COMMAND_EXIT[2]}"|"${COMMAND_EXIT[3]}" )
            echo "${MESSAGE_DESPEDIDA[$RANDOM%4]}"
            break;
            ;;
        * )
            echo "No conozco la instruccion: "$user_command""
            ;;
    esac

    echo -e "\n¿En que más puedo ayudarle?"
done