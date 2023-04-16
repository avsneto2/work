library(dplyr)
library(tidyr)
library(data.table)
library(scales)
library(markdown)
library(shiny)
library(htmlwidgets)
library(shinyWidgets)
library(RColorBrewer)
library(knitr)
#library(gganimate)


shinyUI(
	fluidPage(
	tags$head(tags$style(
	      "body { word-wrap: break-word; }"
			)),
	tags$head(
      tags$link(rel = "shortcut icon", href = "img/logo_infnet"),
      #-- biblio js ----
      tags$link(rel="stylesheet", type = "text/css",
                href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"),
      tags$link(rel="stylesheet", type = "text/css",
                href = "https://fonts.googleapis.com/css?family=Open+Sans|Source+Sans+Pro")
			),
	includeCSS("www/styles.css"),
	navbarPage("Análise exploratória de dados",
     tabPanel("Referências e Introdução", 
              
              #Introduzindo a primeira página com sugestões de leitura 
              flowLayout(img(src='logo_infnet.png', align = "left", height = '100px', width = '100px'),
               includeMarkdown("introducao.Rmd"))),
		 tabPanel("Renda e Democracia - 1995/2000 - Europa/America Sul",
		          p("Gráfico de linhas sob seleção de variáveis"),
		          
		          #Painel principa com plot de income.arq3.eur por linha
		          mainPanel(plotOutput("arq3_linha")),
		          
		          #Layout em flow para melhor justaposicao das opcoes
		          flowLayout(
		            
		          #Selecao das variaveis na base income.arq3.eur
		          varSelectInput("variaveis_arq3", "Variáveis Europa", income.arq3, multiple = FALSE),
		          
		          #Selecao de cores
		          selectInput('cor', label = 'Escolha uma cor:',
		            choices = c("lightblue", "lightgreen", "red"), selected = "red"),
		          
		          ),
		          
		          #Definindo o range do eixo x
		          numericRangeInput(inputId = "x_lim", label = "Insira valor mínimo e máximo para eixo x:",
		                            value = c(min(income.arq3$pais.idx), max(income.arq3$pais.idx))
		          ),
		          
		          #Definindo o range do eixo y
		          numericRangeInput(inputId = "y_lim", label = "Insira valor mínimo e máximo para eixo y:",
		                            value = c(min(income.arq3$pais.idx), max(income.arq3$pais.idx))
		          ),
		          

        ),
		
    )
	)
)
