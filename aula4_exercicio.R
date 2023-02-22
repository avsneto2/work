library(tidyverse)
library(rvest)
library(data.table)
library(robotstxt)


txt = "Um texto que contém muita COISA"
txt<-gsub("m","M",txt)
txt<-gsub("que","o qual",txt) 
print(txt)


#Importando os dados de Ranking da populacao mundial a partir do wikipedia

populacao.mundial.web <- read_html("https://en.wikipedia.org/wiki/World_population")
lpop <- populacao.mundial.web %>% rvest::html_nodes("table") %>% html_table()
pop.mundial <- lpop[[4]]
pop.mundial

#Implementação utilizando pipe

limpeza.nomes.pipe <- function(nomes)
## {
##  nomes.limpos <- nomes %>% stringr::str_replace_all("/", "") %>% stringr::str_replace_all("\\s", "_") %>% stringr::str_replace_all("__", "_")
##  return(nomes.limpos)  
## }

{
  nomes.limpos <- nomes %>% stringr::str_replace_all("/", "") 
  return(nomes.limpos)  
}



names(pop.mundial) <- limpeza.nomes.pipe(names(pop.mundial))
pop.mundial

##

limpeza.nomes.pipe2 <- function(nomes2)
  
{
  nomes.limpos2 <- nomes2 %>% stringr::str_replace_all("\\s", "_") 
  return(nomes.limpos2)  
 }
  
names(pop.mundial) <- limpeza.nomes.pipe2(names(pop.mundial))
pop.mundial

## 

limpeza.nomes.pipe3 <- function(nomes3)
  
{
  nomes.limpos3 <- nomes3 %>% stringr::str_replace_all("__", "_")
  return(nomes.limpos3)  
}

names(pop.mundial) <- limpeza.nomes.pipe3(names(pop.mundial))
pop.mundial

## 

#Selecionando as colunas úteis para analise

pop.mundial <- pop.mundial %>% dplyr::select(Rank:Date)
#pop.mundial <- pop.mundial %>% dplyr::select(!c("Source_(official_or_from_the_United_Nations)")
pop.mundial

#Limpando a variável Population para se tornar uma variável numérica

pop.mundial <- pop.mundial %>% dplyr::mutate(Population = as.numeric(stringr::str_replace_all(Population, "\\,", "")))
pop.mundial

#Limpando a variável Percentage_of_the_world and converting to proportions in classe numeric

pop.mundial <- pop.mundial %>% dplyr::mutate(Percentage_of_the_world = as.numeric(stringr::str_replace_all(Percentage_of_the_world, "%", ""))/100)
pop.mundial

#Limpando a variável Date e convertendo de character para classe Date 

### 
Sys.setlocale(category = "LC_TIME","English")
pop.mundial <- pop.mundial %>% dplyr::mutate(Date = as.IDate(gsub(" ", "-", Date), format = "%d-%b-%Y"))
pop.mundial
Sys.setlocale(category = "LC_TIME", locale = "pt_BR")


Sys.setlocale(category = "LC_TIME","English")
pop.mundial <- pop.mundial %>% dplyr::mutate(Date = as.IDate(gsub(" ", "-", Date), format = "%d-%b-%Y"))
Sys.setlocale(category = "LC_TIME", locale = "pt_BR")

#Vamos criar uma variável continente ?

### criando arquivo continente
## write.csv(pop.mundial, file = "continents-according-to-our-world-in-data.csv")


#Importando uma base de dados que tenha a informacao de paises por continente
##continentes <- readr::read_csv("continents-according-to-our-world-in-data.csv")

continentes <- read.csv("continents-according-to-our-world-in-data.csv",header = TRUE, sep=";")
continentes
#Vinculando esta base à nossa base limpa com os dados de populacao por pais no top-10

pop.mundial <- pop.mundial %>% dplyr::left_join(continentes, by = c("Country_Dependency" = "Entity"))

#Vamos agrupar os dados de populacao por continente e criar uma nova variavel ?

pop.mundial <- pop.mundial %>% dplyr::group_by(Continent) %>% dplyr::mutate(Population_Continent = sum(Population))
pop.mundial %>% dplyr::group_by(Continent) %>% dplyr::summarise(Population_Continent = sum(Population))

