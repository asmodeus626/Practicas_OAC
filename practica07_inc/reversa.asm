
#Devuelve la reversa de una cadena de caracteres.

.data
input:   .space 150 #Espacio donde se guarda el input.
res_rev: .space 150 #Espacio para guardar el resultado de la reversa.

.text
main:
    li $v0, 8 #Código para leer texto
    la $a0, input #Cargo la dirección del input en a0
    li $a1, 150
    syscall #Al final input tendrá el valor ingresado por el usuario
    la $a0, input #Pasamos el parámetro
    jal borraSalto #Borra el salto de línea de la entrada
    la $a0, input
    jal str_len #Calculamos el tamaño de la cadena.
    move $s0, $v0 #Guardamos el resultado en el registro fijo s0
    la $a0, input #Parámetro 1
    move $a1, $s0 #Parámetro 2
    jal reversa #Función que calcula la reversa de la palabra pasada en a0, con el tamaño pasado en a1.
    la $a0, res_rev
    li $v0, 4
    syscall
finmain:
    li $v0, 10 #Código para terminar una ejecución
    syscall
    
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

str_len: #Función que calcula el tamaño de una cadena cargada en a0
    move $v0, $zero # Inicializar el contador en cero
loopsl:
    lb $t0, ($a0) # Cargar caracter
    beq	$t0, '\0', endsl # Si es el caracter nulo, fin
    addi $v0, $v0, 1 # Aumentar contador 1
    addi $a0, $a0, 1 # Aumentar apuntador 1
    j loopsl # Revisar siguiente carcater
endsl:	jr $ra # Regresa a donde fue llamado.
#Aquí termina str_len

reversa: #Funcion que calcula la reversa de una cadena pasada en a0.
    la $t0, res_rev #Cargamos la dirección de res_rev en t0
loopreversa:
    subi $a1, $a1, 1 #Le restamos 1 a a1
    add $t1, $a0, $a1
    lb $t2, ($t1)
    sb $t2, ($t0)
    addi $t0, $t0, 1 #Le sumamos 1 a t0
    bnez $a1, loopreversa #Si a1 no es 0, regresamos.
    li $t3, '\0'
    sb $t3, ($t0)
    jr $ra #Termina la función
    
    
    
    
    
    
    
    