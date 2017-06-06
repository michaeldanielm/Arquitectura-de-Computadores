
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h    
mov Color,01h
mov letra,01h
mov dx,offset NOMBRES
mov ah,09h
int 21h 

mov ah,00h
int 16h 

Menu:;------------------Menu----------------- 

mov ah, 00h
mov al, 03h
int 10h   

mov ah,07h 
mov al,00h
mov bh,letra 
add bh,Color 
add Color,16d  
inc letra
mov cx,0000h
mov dx,184fh
int 10h  


mov dx,offset MM
mov ah,09h
int 21h  

MOV AH,1
INT 21H
mov opc,al
jmp Numeros

cmp al,31h
je Numeros
cmp al,32h
je Resta
cmp al,33h
je Multi
cmp al,34h
je Division
jmp Salir 
           
Opcion:;------------------Ruta de Opcion-----------------
mov al,opc
cmp al,31h
je Suma
cmp al,32h
je Resta
cmp al,33h
je Multi
cmp al,34h
je Division  
jmp Menu 

Error:;------------------Opcion Error--------------------
mov dx,offset OpcEr
mov ah,09h
int 21h
jmp Menu

Numeros:;------------------Pedir Numeros----------------- 

cmp opc,35h
je Salir
ja Error
 
mov ah,02h
mov dl,0ah ;salto de línea
int 21h   
mov ah,02h
mov dl,0dh ;retorno de carro
int 21h 

mov dx,offset MNum1
mov ah,09h
int 21h  

MOV AH,1
INT 21H
mov bl,10d
sub al,30h
mul bl
mov num1,al
MOV AH,1
INT 21H  
sub al,30h
add num1,al 
 
mov ah,02h
mov dl,0ah ;salto de línea
int 21h    
mov ah,02h
mov dl,0dh ;retorno de carro
int 21h 


mov dx,offset MNum2
mov ah,09h
int 21h  

MOV AH,1
INT 21H
mov bl,10d
sub al,30h
mul bl
mov num2,al
MOV AH,1
INT 21H   
sub al,30h
add num2,al 

mov ah,02h
mov dl,0ah ;salto de línea
int 21h    
mov ah,02h
mov dl,0dh ;retorno de carro
int 21h   

jmp Opcion

Suma:;------------------------Suma-----------------      
Mov al,num1
add al,num2

cmp al,64h
jb ImprimirD
jmp ImprimirT

Resta:;----------------------Resta-----------------
Mov al,num1
sub al,num2

cmp al,64h
jb ImprimirD
jmp ImprimirT 

Multi:;------------------Multiplicacion------------
Mov al,num1
mul num2

cmp ax,0064h
jb ImprimirD
cmp ax,0100h
jb ImprimirT
cmp ax,3e8h
jb ImprimirTG
jmp ImprimirC
        
Division:;------------------Division---------------
mov ah,00h
Mov al,num1
div num2 
cmp ah,00h
jmp ImprimirD


ImprimirD:; imprimir numeros de 2 cifras

mov ah,00h
mov bl,10d
div bl 
mov Dece,al
mov Uni,ah  

mov dx,offset msres
mov ah,09h
int 21h 

mov dl,Dece
add dl,30h
mov ah,02h
int 21h 

mov dl,Uni
add dl,30h
mov ah,02h
int 21h   

mov ah,02h
mov dl,0ah ;salto de línea
int 21h    
mov ah,02h
mov dl,0dh ;retorno de carro
int 21h   

mov ah,00h
int 16h 

jmp Menu

 ImprimirT:;Imprimir numeros de 3 cifras por debajo de 100h

mov ah,00h
mov bl,100d
div bl 
mov Cen,al
mov al,ah 
mov ah,00h
mov bl,10d
div bl
mov Dece,al
mov Uni,ah 

mov dx,offset msres
mov ah,09h
int 21h 

mov dl,Cen
add dl,30h
mov ah,02h
int 21h

mov dl,Dece
add dl,30h
mov ah,02h
int 21h 

mov dl,Uni
add dl,30h
mov ah,02h
int 21h    

mov ah,02h
mov dl,0ah ;salto de línea
int 21h    
mov ah,02h
mov dl,0dh ;retorno de carro
int 21h   

mov ah,00h
int 16h 

jmp Menu  

ImprimirTG: ;imprimir numeros de 3 cifras por encima de 100h 

mov BX,0100d
div Bl 
mov Cen,al
mov al,ah 
mov ah,00h
mov bl,10d
div bl
mov Dece,al
mov Uni,ah 

mov dx,offset msres
mov ah,09h
int 21h 

mov dl,Cen
add dl,30h
mov ah,02h
int 21h

mov dl,Dece
add dl,30h
mov ah,02h
int 21h 

mov dl,Uni
add dl,30h
mov ah,02h
int 21h    

mov ah,02h
mov dl,0ah ;salto de línea
int 21h    
mov ah,02h
mov dl,0dh ;retorno de carro
int 21h   

mov ah,00h
int 16h 

jmp Menu

ImprimirC:;Imprimir numeros de 4 cifras  

mov dx,0000h
mov BX,1000d
div bx 
mov Mil,al
mov ax,dx   

mov BX,0100d
div Bl 
mov Cen,al
mov al,ah 
mov ah,00h
mov bl,10d
div bl
mov Dece,al
mov Uni,ah 

mov dx,offset msres
mov ah,09h
int 21h 

mov dl,Mil
add dl,30h
mov ah,02h
int 21h

mov dl,Cen
add dl,30h
mov ah,02h
int 21h

mov dl,Dece
add dl,30h
mov ah,02h
int 21h 

mov dl,Uni
add dl,30h
mov ah,02h
int 21h    

mov ah,02h
mov dl,0ah ;salto de línea
int 21h    
mov ah,02h
mov dl,0dh ;retorno de carro
int 21h   

mov ah,00h
int 16h 

jmp Menu 
 
 

Salir:
ret




ret
NOMBRES DB "Jhonathan Jhair Guzman Ramirez",0Dh,0Ah,"Michael Daniel Murillo Lopez",0Dh,0Ah,0Dh,0Ah,"Proyecto: Calculadora de dos cifras",0Dh,0Ah,"Arquietectura$"
MM db "       Menu",0Dh,0Ah,"1. Suma",0Dh,0Ah,"2. Resta",0Dh,0Ah,"3. Multiplicacion",0Dh,0Ah,"4. Division",0Dh,0Ah,"5. Salir",0Dh,0Ah,0Dh,0Ah,"->$"
MNUM1 DB "Digite el primer numero a operar: $"
MNUM2 DB "Digite el segundo numero a operar: $"
OpcEr db 0Dh,0Ah,"Opcion Erronea$"   
msres db "El resultado de la operacion es: $"
coma db ",$"
opc db ?
Color db ?  
letra db ? 
num1 db ?
num2 db ?
nump dw ?
Res db ?
Uni db ?
Dece db ?
Cen db ? 
Mil db ?

;64h          

