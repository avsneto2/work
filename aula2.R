
### <- - comando implica. Usado para inicializar uma variável. 

num1 <- 3
num2 <- 4 

### =  - comando de atribuição. Usado para funções, etc...
paste("a",3,sep=" ")

### -  identifica o tipo de variável, ou ainda definir classe. 

### Operadores 

num3 <- 1 + 9 
num3

soma <- num1 + num2
soma 

subtracao <- num2 - num1 
subtracao

multiplicacao <- num1 * num2 
multiplicacao

divisao <- num2 / num1
divisao

exponenciacao <- num1^3
exponenciacao

### raiz quadrada de 2 formar 

raiz  <- soma^(1/2) ## raiz de 0,5 ou 1/2 
raiz
raiz2 <- sqrt(soma)
raiz2

raiz3 <- soma^(1/3)
raiz3

### extração de resto 

resto<-10%%7
resto 

## Operadores matemáticos relacionais 

3 <= 3 

## Operadores lógicos
(3==3) 

municipios <- c("rio de janeiro","caxias", "niteroi")
!(municipios=="rio de janeiro")
municipios[which(municipios!="rio de janeiro")]

### para concatenar variaveis 

text1 <- "mares"
text1 <- "montanha"
text3
paste(num1,text1,sep=" ")
paste(num2,text2,sep=" ")

###### instalação de 2 pacotes

library(tidyverse)



