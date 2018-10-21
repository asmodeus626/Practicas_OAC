
#Programa que separa la entrada por espacios.
.data
input:   .space 150 #Espacio donde se guarda el input.
comando: .space 100 #Primera palabra
arg0:    .space 100 #Segunda palabra
arg1:    .space 100 #tercera palabra
salto:   .asciiz "\n"

.text
main:
    li $v0, 8 #Código para leer texto
    la $a0, input #Cargo la dirección del input en a0
    li $a1, 150
    syscall #Al final input tendrá el valor ingresado por el usuario
    la $s0, input #Ponemos el valor de input en el registro fijo s0
    la $a0, input #Pasamos el parámetro
    jal borraSalto #Borra el salto de línea de la entrada
    jal split #En esta parte separamos los parámetros de input por espacios
    
    la $a0, input
    jal imprimeCadena
    jal imprime_salto
    
    la $a0, comando
    jal imprimeCadena
    jal imprime_salto
    
    la $a0, arg0
    jal imprimeCadena
    jal imprime_salto
    
    la $a0, arg1
    jal imprimeCadena
    jal imprime_salto
b finmain
    
imprime_salto:
    li $v0, 4 #Código para imprimir un string
    la $a0, salto #Cargo la dirección del prompt en a0
    syscall
    jr $ra
    
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

split:
    move $v1, $zero #Al final, s1 tendrá el número de parámetros pasados.
    la $t0, input #t0 tendrá el apuntador al input
    la $t1, comando #Apuntador a comando
    la $t2, arg0 #Apuntador a arg0
    la $t3, arg1 #Apuntador a arg1
    subi $t0, $t0, 1
    subi $t1, $t1, 1
    addi $v1, $v1, 1 #incrementa en 1 el contador de parámetros.
loopsplit1: #Pasamos el primer parámetro de input a comando
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    lb $t4, ($t0)
    sb $t4, ($t1) #Copiamos t0 a t1
    beq $t4, '\0', finsplit #Si es 0 terminamos el split.
    bne $t4, ' ' , loopsplit1 #Mientras no sea espacio, regresamos.
    li $t4, '\0'
    sb $t4, ($t1) #Cambiamos el espacio por \0
    
    addi $v1, $v1, 1 #incrementa en 1 el contador de parámetros.
    subi $t2, $t2, 1
loopsplit2: #Pasamos el segundo parámetro de input a 
    addi $t0, $t0, 1
    addi $t2, $t2, 1
    lb $t4, ($t0)
    sb $t4, ($t2) #Copiamos t0 a t2
    beq $t4, '\0', finsplit #Si es 0 terminamos el split.
    bne $t4, ' ' , loopsplit2 #Mientras no sea espacio, regresamos.
    li $t4, '\0'
    sb $t4, ($t2) #Cambiamos el espacio por \0
    
    addi $v1, $v1, 1 #incrementa en 1 el contador de parámetros.
    subi $t3, $t3, 1
loopsplit3:
    addi $t0, $t0, 1
    addi $t3, $t3, 1
    lb $t4, ($t0)
    sb $t4, ($t3) #Copiamos t0 a t2
    beq $t4, '\0', finsplit #Si es 0 terminamos el split.
    bne $t4, ' ' , loopsplit3 #Mientras no sea espacio, regresamos.
    li $t4, '\0'
    sb $t4, ($t3) #Cambiamos el espacio por \0
    
finsplit: jr $ra

imprimeCadena: #Imprime la cadena que se pase en el parámetro a0
    li $v0, 4 #Código para imprimir un string
    syscall
    jr $ra
    
finmain:
    li $v0, 10 #Código para terminar una ejecución
    syscall