library(dplyr)
library(tidyr)
library(data.table)
library(scales)
library(markdown)
library(shiny)
library(zoo)
library(htmlwidgets)
library(shinyWidgets)
library(RColorBrewer)
library(knitr)
library(ggplot2)
#library(gganimate)


shinyServer(function(input, output){
  
  
  ######Painel de Salários
  
  #Criando um evento reativo que gera um plot quando uma das ações relacionadas 
  #ao gráfico de linhas muda, sendo elas, eixos, cores, e variáveis
  plot_eur_reativo <- eventReactive(c(input$variaveis_arq3, input$cor, input$x_lim, input$y_lim),{
    
    #Plotando o gráfico com as definições do eixo x, de cores, etc.
    ggplot(data = income.arq3, aes_string(x = "n", y = input$variaveis_arq3)) +
        geom_line(color = input$cor) + ggplot2::xlim(input$x_lim) + ggplot2::ylim(input$y_lim) + theme_classic()
  })
  
  #Atualizando o range do y quando uma variável é trocada
  update_ylim <- eventReactive(c(input$variaveis_arq3),{
    if(length(input$variaveis_arq3) == 0) return(numericRangeInput(inputId = "y_lim", label = "Insira valor mínimo e máximo para eixo y:", value = c(min(income.arq3$n), max(income.arq3$n))))
    updateNumericRangeInput(inputId = "y_lim", value = c(min(income.arq3[,input$variaveis_arq3], na.rm = T), max(income.arq3[,input$variaveis_arq3], na.rm = T))) 
  })
  
  #Renderizando o plot construído iterativamente 
  output$arq3_linha <- renderPlot({
    #Controlando para o caso de não selecionar nenhuma variável, ou de a variável não ser numérica
    #De modo a não introduzir limites ao eixo y, para uma variável que não é numérica
    if ((length(input$variaveis_arq3) == 0) | (!is.numeric(unlist(income.arq3[,input$variaveis_arq3][1]))))
      {
        if((!is.numeric(unlist(income.arq3[,input$variaveis_arq3][1]))) & (length(input$variaveis_arq3) != 0)) return(ggplot(income.arq3, aes_string(x="pais", y = input$variaveis_arq3)) + geom_line() + geom_line(color = input$cor)  + theme_classic())
        else return(ggplot(income.arq3, aes(x=n, y =n)) + geom_line() + geom_line(color = input$cor))
      }
      
    #Atualizando o eixo y
    update_ylim()
    #Plotando o gráfico de linhas reativamente
    plot_eur_reativo()
  })

  
  
  }
)
