
#Función que lee un archivo.

.data

buffer:   .space 16
archivo1: .space 500

.text
main:
    li $v0, 8 #Código para leer texto
    la $a0, buffer #Cargo la dirección del input en a0
    li $a1, 16
    syscall #Al final input tendrá el texto ingresado por el usuario

    la $a0, buffer
    jal borraSalto #Borramos el salto del buffer
    #Abrir archivo
    la $a0, buffer		# Cargar direccion de cadena con nombre del archivo
    li $a1, 0			# Cargar bandera 0, solo lectura
    li $v0, 13			# Cargar codigo de llamada para abrir archivo
    syscall			# Llamada al sistema
    beq	$v0, -1, finmain        # El descriptor es 0, no existe el archivo
    move $s0, $v0               #Movemos el descriptor de archivo.
    
    #Leer archivo
    li $v0, 14 #Comando para leer archivo
    move $a0, $s0 #pasamos el descriptor de archivo
    la $a1, archivo1 #Donde voy a guardar el contenido del archivo.
    li $a2, 500 #Máximo número de caracteres leídos
    syscall #Lee
    move $t0, $v0 #Movemos el número de caracteres leidos a t0
    la $t1, archivo1
    add $t2, $t1, $t0
    sb $zero, ($t2)
    
    #Imprimir contenido del archivo
    la $a0, archivo1
    li $v0, 4
    syscall
    
    #Cierra el archivo
    move $a0, $s0	# Cargar descritor
    li $v0, 16		# Cargar codigo de llamada para cerrar archivo
    syscall	
    
b finmain
    
borraSalto: #Función que borra un salto de línea al final de una cadena
    move $t0, $a0 #cargamos la dirección de la cadena en t0
    subi $t0, $t0, 1 #Le restamos 1 a t0
    forSalto:
    addi $t0, $t0, 1
    lb $t1, ($t0)
    beq $t1, '\0', borraSaltoFin #Si ya es 0 no cambiamos nada.
    bne $t1, '\n', forSalto
    sb $zero, ($t0) #Cambiamos el salto por \0
borraSaltoFin: jr $ra #Se regresa a donde fue llamada la función

finmain:
    li $v0, 10 #Código para terminar una ejecución
    syscall
    