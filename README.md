[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/sEFmt2_p)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=21093361&assignment_repo_type=AssignmentRepo)
# Lab02 - Unidad Aritmético-Lógica.

# Integrantes
- Santiago Alejandro campos Mora
- Santiago Herrera Acuña
- Juan Pablo Prieto Vergara
# Informe

Indice:

1. [Diseño implementado](#diseño-implementado)
2. [Simulaciones](#simulaciones)
3. [Implementación](#implementación)
4. [Conclusiones](#conclusiones)
5. [Referencias](#referencias)

## Diseño implementado

### Descripción
### Descripción
La Unidad Aritmético-Lógica (ALU, por sus siglas en inglés Arithmetic Logic Unit) es un circuito digital fundamental que actúa como el "corazón computacional" de un sistema de procesamiento, como una Unidad Central de Procesamiento (CPU). Su función principal es realizar operaciones aritméticas y lógicas con datos binarios.

Las ALU basicas suelen incluir operaciones aritmeticas y operaciones logicas, dos entradas, una salida y un selector de operacion llamado opCode, asi como banderas que indican condiciones especiales y una salida llamada zero para indicar un resultado nulo o igual a 0.

Para la creacion de nuestra ALU, se decidio tener un archivo Top llamado [ALU_4bits](/scr/ALU_4bits.v) el cual se encarga de instanciar cada uno de los modulos que corresponden a cada operacion, ya sea aritmetica o logica. La ALU implementada cuenta con las siguientes caracteristicas:

- Dos entradas A y B de 4 bits cada una.
- Una entrada selectora de 3 bits.
- Una salida Y de 8 bits.
- Una salida Overflow y una salida zero (flags).
- Operaciones aritmeticas: Suma, resta, multiplicacion.
- Operaciones logicas: NOR
- Una operacion de corrimiento hacia la izquierda.

####Principio de funcionamiento
El funcionamiento de la ALU es secuencial en el contexto de una instrucción, pero su núcleo es combinacional. Primero, se instancian cada uno de los modulos para posteriormente hacer uso de un **Case** que tomará la entrada del selector para escoger la operacion que se desea realizar. La ALU determinara las condiciones de la operacion y arrojara un resultado, teniendo en cuenta el resultado y evaluando las flags existentes.

####Modulos

####Modulo sumador de 1 bit
Se parte de un modulo base, el cual sera instanciado varias veces en esta ALU por otros modulos

[Codigo  sumador 1bit](/scr/sumador_1bit.v)

####Modulo sumador de 8 bits
Se actuializa el sumador de laboratorios previos y se hace mas grande. La razon por la cual se opta por un sumador de 8 bits es por que en la operacion de multiplicacion el resultado es de 8 bits, ya que el algoritmo usado es el de suma de productos parciales. Esto denota una gran ventaja ya que el codigo se hace mas eficiente y corto.

[Codigo  sumador 8bits](/scr/sumador_8bits_1.v)

####Modulo restador 8 bits
El funcionamiento de este restador se basa completamente en el uso del sumador de 8 bits. Particularmente este restador tiene la capacidad de incluso abarcar resultados de restas negativas, solo que las mostrara a la salida como su complemento a 2.

[Codigo  restador 8bits](/scr/restador_8bits_1.v)

####Modulo multiplicador 4 bits
Como se menciono antes, este multiplicador tambien funciona en base al sumador de 8 bits y en la suma de productos parciales, permitiendo recibir como maximo dos numeros de 4 bits para dar una respuesta de 8 bits.

[Codigo  multilplicador 4bits](/scr/multiplicador_4bits.v)

####Modulo NOR 1 bit
El proposito de la ALU es que pueda instanciar cada uno de los modulos, de modo que si algo falla se pueda revisar cada modulo por separado y sea mas facil depurar codigo. Por esta razon, se opto por incluir un modulo NOR de 1 bit, que sera instanciado mas adelante y servira como base de la operacion NOR de 4 bits.

[Codigo  NOR 1bit](/scr/nor_1bit.v)

####Modulo NOR 4 bits
Este modulo instanciara al de 1 bit para operar bit a bit cada una de las entradas A y B, es decir, operar el bit 0 de A con el bit 0 de B y asi sucesivamente, para dar una respuesta total reflejada en Y.

[Codigo  NOR 4bits](/scr/nor_4bits.v)

####Corrimiento a la izquierda
Este corrimiento no cuenta con un modulo debido a la simpleza de la operacion. Se opta por aplicarla dentro del propio **Case** para que se desarrolle una vez seleccionada la combinacion correspondiente del selector. 
### Diagrama

## Simulaciones 

## Implementación

## Conclusiones

## Referencias
