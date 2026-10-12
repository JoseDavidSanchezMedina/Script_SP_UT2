#!/bin/bash

echo "Seleccione el nivel de severidad con el menu siguiente."

# Empezamos creando las opciones para que el usuario eliga la opción que quiera.

option=0

while [ "$option" -ne 9 ]; do


	echo "MENU"
 	echo "1. Emergente"
 	echo "2. Alerta"
 	echo "3. Critico"
 	echo "4. Error"
	echo "5. Advertencia"
	echo "6. Noticia"
	echo "7. Informacion"
	echo "8. Depuracion"
	echo "9. Salir"

	read -p "Elige una opción: " option
	
	case $option in

# Creamos dos variables, una guardará la abreviatura que journalctl entiende y la otra variable para que cuando guardemos el archivo sea legible (Ej. logs_emergente)
	
		1) nivel="emerg"; nombre="emergente" ;;	
		2) nivel="alert"; nombre="alerta" ;;
		3) nivel="crit"; nombre="critico" ;;	
		4) nivel="err"; nombre="error" ;;	
		5) nivel="warning"; nombre="advertencia" ;;	
		6) nivel="notice"; nombre="noticia" ;;	
		7) nivel="info"; nombre="informacion" ;;	
		8) nivel="debug"; nombre="depuracion" ;;	
		9) 
			echo "Saliendo del script"
			break
		;;
	
		*) 
			echo "Opcion no valida, elige un numero valido"
		;;

	esac

# Creamos la variable que guardará la ruta del archivo así como su nombre.

	archivo="$HOME/logs_${nombre}.txt"

# Consultamos los logs con el siguiente comando donde el -p le preguntará al journal el nivel de severidad. Y luego meterá la información en el archivo y ruta que creamos con la anterior variable.

	journalctl --since "$(date +%Y-%m-01)" -p "$nivel" > "$archivo"

# Por último el ejercicio nos pide que contemos los registros de dicho nivel y validar que se haya generado el archivo.

	echo "Registros de nivel '$nombre' este mes: $(wc -l < "$archivo")"
	echo "Registros guardados en $archivo"

done

	
	
			