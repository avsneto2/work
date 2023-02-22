
df1<-data.frame(cores=c("vermelho","verde", "azul"),id=c(1,2,3), altura=c(5,10,15),largura=c(50,100,150))
df2=df1           ### atribui df1 a df2 
df2               ### display de df2 
df2$id            ### INdexei df1 por id. OUtra forma de fazer : df2 [linha, coluna]
df2

#### fazendo contas 

### atribuindo variavel 
cor1 <- df2[1,1]
altura1 <- df2[1,3] 
largura1 <- df2[1,4]

### OUtra forma de se referenciar a uma valor no frame. 
largura1b <- df2$largura[1]
print(largura1)
print(largura1b)

### operador aritmético 

## area da cozinha 
 texto1 <- "A area da cozinha é de"
 texto2 <- "metros quadrados"
 
 area1 <- df2[2,3] * df2[2,4]
 texto3<-paste(texto1,area1,texto2,sep=" ")
 texto3
 
 ## area da sala 
 texto1q <- "A area da sala é de"
 texto2q <- "metros quadrados"
 
 area1q <- df2[3,3] * df2[3,4]
 texto3q <-paste(texto1q,area1q,texto2q,sep=" ")
 texto3q
 
 ### operaradores lógicos 
if (area1>area1q) texto4<-"Cozinha é maior que o quarto" else texto4<-"Quarto maior que cozinha"
 texto4
area1
area1q
 
    