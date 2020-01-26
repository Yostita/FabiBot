#Version 1.1 Practica 3 José Luis Bellosta LRSO
#Cosas por añadir en la 1.2
#	1.Comprobador de input en la opcion "Añadir"
#   2.Concatenamiento automatico de morosos con el mismo nombre
#	3.Nuevas opciones
#!/bin/bash

#Variables globales
nombre=NULL			
cantidad=NULL
fecha=NULL

#Imprime todas las lineas del fichero
function toStringFichero(){
	count=1
	while read linea;do
		OUTP=$(echo $linea|awk -F ";" '{print $1" debe "$2"$ desde el dia "$3}')
		echo $count.$OUTP
		let count=count+1
	done < ./Librerias/morosos_data.txt
}

#Recibe como parametro el numero de linea al cual iniciar la variable nombre
function setNombre(){
	count=1
	while read linea; do
	if [ $1 = $count ];
	then
		nombre=$(echo $linea|awk -F ";" ' {print $1}')
	fi
	let count=count+1
	done < ./Librerias/morosos_data.txt
}

#Recibe como parametro el numero de linea al cual iniciar la variable cantidad
function setCantidad(){
	count=1
	while read linea; do
	if [ $1 = $count ];
	then
		cantidad=$(echo $linea|awk -F ";" ' {print $2}')
	fi
	let count=count+1
	done < ./Librerias/morosos_data.txt
}

#Recibe como parametro el numero de linea al cual iniciar la variable fecha
function setFecha(){
	count=1
	while read linea; do
	if [ $1 = $count ];
	then
		fecha=$(echo $linea|awk -F ";" ' {print $3}')
	fi
	let count=count+1
	done < ./Librerias/morosos_data.txt
}

#Main

echo "+-----------------------------+"
echo "| Bienvenido a No más morosos |"
echo "+-----------------------------+"

#El flag exit permite que el bucle se repita 
exit=false

while [ $exit ]
do
	echo -e "\nOpciones:"
	echo " -Listar"
	echo " -Editar"
	echo " -Añadir"
	echo " -Eliminar"
	echo " -Buscar"
	echo " -Exit"
	read -p "Que desea hacer: " opcion

	case "$opcion" in
		#Imprime por pantalla todas las lineas del archivo
		"listar" | "Listar" )
			echo -e "\nListado de morosos:"
			toStringFichero;;
		#Edita una variable a elegir de la linea asignada
		"editar" | "Editar" )
			exit2=false

			echo -e "\nListado de morosos:"
			toStringFichero

			read -p "A quien desea eliminar(numero): " indice

			#Asigna a las variables globales nombre,cantidad y fecha los parametros de la linea $indice del fichero
			setNombre $indice
			setCantidad $indice
			setFecha $indice

			#Pregunta en bucle que variable editar hasta que el usuario dice que no desea continuar 
			while [ $exit2 ]
			do

			echo  -e "\n-Nombre[\e[1;35m$nombre\e[0m]"
			echo  -e "-Cantidad[\e[1;35m$cantidad\e[0m]"
			echo  -e "-Fecha[\e[1;35m$fecha\e[0m]"
			read -p "Que desea editar:" edit

			#Usamos un switch para poder filtrar que variable de la linea editar
			case "$edit" in
				"nombre" | "Nombre" )
					read -p "Cual es el nuevo nombre: " getNombre
					sed -i ""$indice" s/"$nombre"/"$getNombre"/g" ./Librerias/morosos_data.txt
					echo Nombre actualizado;;
				"cantidad" | "Cantidad" )
					read -p "Cual es la nueva cantidad: " getCantidad
					sed -i ""$indice" s/"$cantidad"/"$getCantidad"/g" ./Librerias/morosos_data.txt
					echo Cantidad actualizada;;
				"fecha" | "Fecha" )
					read -p "Cual es la nueva fecha: " getFecha
					sed -i ""$indice" s/"$fecha"/"$getFecha"/g" ./Librerias/morosos_data.txt
					echo Fecha actualizada;;
				#Default
				*)
					echo No conozco ese comando;;
			esac

			#Comprueba si el usuario quiere seguir
			read -p "Desea continuar (Y/N): " salida
			
			if [ $salida = N ] || [ $salida = n ];
			then
				break;
			fi

			done
			
			echo Perfil actualizado;;
		#Añade a la ultima fila del fichero un nuevo moroso
		"añadir" | "Añadir" )
			read -p "Nombre del moroso: " nombre
			read -p "Cuanto dinero le debe: " deuda
			read -p "De que dia es la deuda(dd/mm/yyyy): " fecha

			echo $nombre";"$deuda";"$fecha >> ./Librerias/morosos_data.txt
			
			echo Se ha añadido $nombre a la lista de morosos;;
		#Elimina una linea en concreto del fichero
		"eliminar" | "Eliminar" )
			echo -e "\nListado de morosos:"
			toStringFichero

			read -p "A quien desea eliminar(Numero)?: " indice
			sed -i ""$indice"d" ./Librerias/morosos_data.txt

			echo Ha eliminado el registro $indice;;
		#Muestra por pantalla todas las deudas de un nombre en concreto
		"buscar" | "Buscar" )
			#Este flag indica si ha entrado en el if o no
			count=0
			
			read -p "A quien desea buscar?: " bnombre
			echo -e "\nSe han encontrado los siguientes registros"
			
			while read linea; do
				OUTP=$(echo $linea|awk -F ";" '{print $1" debe "$2"$ desde el "$3}')
				nombre=$(echo $linea|awk -F ";" '{print $1}')

				#Si el nombre que busca es igual que el nombre de la linea
				if [ $bnombre = $nombre ];
				then
					echo $OUTP
					let count=count+1
				fi
			done < ./Librerias/morosos_data.txt
			
			if [ $count = 0 ];
			then
				echo No se ha encontrado ningun registro de $bnombre. Comprueba que has introducido bien el nombre.
			fi;;
		#Sale del bucle cerrando asi la aplicacion
		"exit" | "Exit" )
			echo -e "\nCerrando la app No Más Morosos...\n"
			break;;
		#Default
		* )
			echo No conozco ese comando;;
	esac
done