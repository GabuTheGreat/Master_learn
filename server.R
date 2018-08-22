library(shiny)
library(shinydashboard)
library(RCurl)
library(ggplot2)
library(ggcorrplot)
library(dplyr)
library(plotly)

#Read data from GitHub
all_data <-
  read.csv(
    text = getURL(
      "https://raw.githubusercontent.com/GabuTheGreat/learn/master/dsw_data.csv"
    ),
    header = T
  )

corr_data <-
  read.csv(
    text = getURL(
      "https://raw.githubusercontent.com/GabuTheGreat/learn/master/corr_data.csv"
    ),
    header = T
  )

graph_data <- all_data %>% filter(Country == "Kenya", Year == 2017) %>% 
  select(Period, TC_Adoption,Region,dispensers_with_issues,functionality)

cleaned_data <- corr_data %>% na.omit() %>% select(functionality,TC_Adoption,promoter_rating,dispensers_with_issues)
corr <- round(cor(cleaned_data), 1)

shinyServer(function(input,output){
  
   output$plot1 <- renderPlotly({
    graph_data$Region <- factor(graph_data$Region, levels = c("Awendo", "Busia", "Chavakali", "Matunda","Ugunja","Overall"))
    p = ggplot(data = graph_data, aes(x = Region, y = TC_Adoption, fill = Period))+
      geom_bar(stat = "identity", position = position_dodge())
    ggplotly(p) %>% config(displayModeBar = F)
  
  })
  
  output$plot2 <- renderPlotly({
    p = ggplot(data = graph_data, aes(x = Period, y = TC_Adoption, group = Region))+
      geom_line(aes(color = Region))+
      geom_point(aes(color = Region))
    ggplotly(p) %>% config(displayModeBar = F)
  })

  output$plot3 <- renderPlot({
    ggcorrplot(corr, hc.order = TRUE, 
               type = "lower", 
               lab = TRUE, 
               lab_size = 3, 
               method="circle", 
               colors = c("tomato2", "white", "springgreen3"), 
               title="Correlogram of All Data", 
               ggtheme=theme_bw)
  })
  
  output$plot4 <- renderPlotly({
    p = ggplot(cleaned_data, aes(functionality, TC_Adoption)) +
      geom_point() +
      geom_smooth(method='lm',formula=y~x) +
      scale_size_area()
    ggplotly(p) %>% config(displayModeBar = T)
  })
  
  output$event <- renderPrint({
    d <- event_data("plotly_hover")
    if (is.null(d)) "Hover on a point!" else d
  })
})