library(tidyverse)
library(rvest)
library(data.table)


## Leitura de um arquivo .txt 

arquivo.texto <-read.table("E:/DADOS/VIEIRA/POS GRADUACAO/INFINET/CURSO/WORK/BASES/emotion.txt",header=TRUE, sep="\t")
arquivo.texto
view(arquivo.texto)

## colocando header no arquivo sem cabeçalho.

arquivo.texto2 <-read.table("E:/DADOS/VIEIRA/POS GRADUACAO/INFINET/CURSO/WORK/BASES/emotionSH.txt",header=FALSE, sep="\t")
view(arquivo.texto2)

### traz o nome dos cabeçalhos do dataframe (header)
names(arquivo.texto2)

### altera o nome dos cabeçalhos do dataframe 
names(arquivo.texto2) <- c("campo1","campo2","campo3","campo4","campo5","campo6","campo7")


## excluindo o header do arquivo 

arquivo.texto2[1,3]
arquivo.texto2<-arquivo.texto2[-1,]

## selecionando (indexando) uma variavel pelo nome do campo. 

arquivo.texto2$campo4
view(arquivo.texto2$campo4)

## selecinado o conteudo de uma variavel pelo nome do campo 
arquivo.texto2$campo4[19]
arquivo.texto2$campo4[1:19]



## Leitura de uma arquivo .csv 
## usar read.csv , para arquivos separados por virgula; 
## usar read.csv2, para arquivos separados por ponto e virgula; 

arquivo.csv <- read.csv("E:/DADOS/VIEIRA/POS GRADUACAO/INFINET/CURSO/WORK/BASES/TomatoFirst.CSV",sep ="," )
arquivo.csv
view(arquivo.csv)

########################################################
### Utilizando as bibliotecas tydeverse e data.table ###
########################################################

#Lendo o mesmo dado csv com esses pacotes
tomato.tbl <- readr::read_csv("TomatoFirst.csv")
tomato.data.table <- data.table::fread("TomatoFirst.csv")


#######################################################
### Vamos ler uma base com milhares de observações ###
#######################################################

#Com o fread oriundo do data table
crimes.data.table <- fread("BaseDPEvolucaoMensalCisp.csv")

#Importando com read.csv da base do R sem tratatamento. O que há de errado?
crimes.base <- read.csv("BaseDPEvolucaoMensalCisp.csv")

#Vamos tentar um separador diferente? read.csv2 seria suficiente?
crimes.base <- read.csv("BaseDPEvolucaoMensalCisp.csv", sep = ";")
#crimes.base <- read.csv2("BaseDPEvolucaoMensalCisp.csv")


###############################################################
### Vamos escrever e contar o tempo levado para cada função ###
### e checar se a afirmação dos desenvolvedores do data table #
###    está correta.                                          #
###############################################################

#Base
ini.base <- Sys.time()
write.csv(crimes.base, file = "crimes_base_teste.csv")
fim.base <- Sys.time()
total.base <- fim.base - ini.base

print(paste('tempo para escrever um csv com função basica:', total.base, sep = ""))

#Data table - fwrite
ini.data.table <- Sys.time()
fwrite(crimes.base, "crimes_base_teste.csv")
fim.data.table <- Sys.time()
total.data.table <- fim.data.table - ini.data.table

print(paste('tempo para escrever um csv com função fwrite do data.table:', total.data.table, sep = ""))


### exportando dados 
write.table(arquivo.texto,file = "E:/DADOS/VIEIRA/POS GRADUACAO/INFINET/CURSO/WORK/BASES/emotion_write.txt",sep =",")
write.csv(crimes.base, file = "crimes_base_teste.csv")

###salvando area de trabalho 
save.image()
save.image(file="E:/DADOS/VIEIRA/POS GRADUACAO/INFINET/CURSO/WORK/BASES/X.rData")

### carregando area de trabalho  
load(file="E:/DADOS/VIEIRA/POS GRADUACAO/INFINET/CURSO/WORK/BASES/X.rData")


####definindo uma funcao 

multiplica <- function(numero1,numero2)
{ resultado <- numero1 * numero2
  return(resultado)
}

resultad=multiplica(6,2)
resultad



###############################################################
####                 Exemplo com dados WEB                 ####
###############################################################

library(rvest)
#Lendo dados da populacao mundial a partir do wikipedia
#Checando se o site permite extracao dos dados
paths_allowed(paths="https://en.wikipedia.org/wiki/World_population")

#Lendo os dados e identificando tabelas
populacao.mundial.web <- read_html("https://en.wikipedia.org/wiki/World_population")
lpop <- populacao.mundial.web %>% rvest::html_nodes("table") %>% html_table()
pop.mundial <- lpop[[4]]
