library(tidyverse)
library(dlookr)
library(summarytools)
library(readxl)
library(knitr)
library(stargazer)
library(mice)
library(rmarkdown)
library(tinytex)
library(sandwich)
library(magrittr)
library(data.table)


#Funções de binarizacao de histograma
fd <- function(x) {
  n <-length(x)
  return((2*IQR(x))/n^(1/3))
}


sr <- function(x) {
  n <-length(x)
  return((3.49*sd(x))/n^(1/3))
}

## setwd("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Estatistica_Ciencia_Dados/Analise Exploratoria de Dados/analises/")

setwd("E:/DADOS/VIEIRA/POS GRADUACAO/INFINET/CURSO/WORK_TRABALHO_2")

income <- readxl::read_excel("income_democracy.xlsx")

names(income)[c(1:2, 4:length(names(income)))] <- c("pais", "ano", "Log.pib.real", "Log.populacao", "fracao.pop.0_14", "fracao.pop.15_19", "fracao.pop.30_44", "fracao.pop.45_59","fracao.pop.60_mais", "educ.adultos", "idade.mediana", "pais.idx")

income.arq1 <- income %>% dplyr::select(pais,ano,Log.pib.real,educ.adultos, fracao.pop.0_14,fracao.pop.15_19,fracao.pop.30_44,fracao.pop.45_59,fracao.pop.60_mais)

income.arq2 <- income.arq1  %>% dplyr::filter (ano =='1990'| ano =='1995' | ano =='2000')

income.arq3 <- income.arq2  %>% dplyr::filter (pais =='Italy'| pais =='France' | pais =='Germany' | pais =='Brazil' | pais == 'Argentina' | pais == 'Bolivia')

income.arq3.eur <- income.arq2  %>% dplyr::filter (pais =='Italy'| pais =='France' | pais =='Germany')

income.arq3.amsul <- income.arq2  %>% dplyr::filter (pais =='Brazil' | pais == 'Argentina' | pais == 'Bolivia')


#Importando dados mais explorados na disciplina Análise Exploratórioa de Dados

## salarios <- readxl::read_excel("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Estatistica para Ciência de Dados/dados_utilizados/dados_bussab_m.xlsx")

## crimes <- readr::read_csv2("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Análise Exploratoria de Dados/dados_utilizados/BaseDPEvolucaoMensalCisp.csv")

## crimes.aisp <- crimes %>% dplyr::select(CISP, mes, ano,  AISP,  RISP, roubo_transeunte, roubo_celular) %>% dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y")) %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% dplyr::group_by(AISP, mes.ano) %>% dplyr::summarise(roubo_transeunte = sum(roubo_transeunte), roubo_celular = sum(roubo_celular))

## crimes.aisp <- crimes.aisp %>% dplyr::left_join(crimes %>% dplyr::select(AISP, Regiao, mes, ano) %>% 
##                                                   dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y")) %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% dplyr::distinct(AISP, mes.ano, Regiao), by = c("AISP" = "AISP", "mes.ano"="mes.ano"))

## crimes <- crimes %>% dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y"))



