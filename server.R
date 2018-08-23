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

cleaned_data <-
  corr_data %>% na.omit() %>% select(Functionality,
                                     Total.Chlorine.Adoption,
                                     Promoter.Rating,
                                     Dispensers.with.Hardware.Issues)
corr <- round(cor(cleaned_data), 1)

shinyServer(function(input, output) {
  
  filter_data <- reactive({
    plot_data <-
      all_data %>% filter(Country == "Kenya", Year == input$select_year) %>%
      select(Period,
             TC_Adoption,
             Region,
             dispensers_with_issues,
             functionality)
    return(plot_data)
    
  })
  output$plot1 <- renderPlotly({
   graph_data <- filter_data()
    graph_data$Region <-
      factor(
        graph_data$Region,
        levels = c(
          "Awendo",
          "Busia",
          "Chavakali",
          "Matunda",
          "Ugunja",
          "Overall"
        )
      )
    p = ggplot(data = graph_data, aes(x = Region, y = TC_Adoption, fill = Period)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      ylab("Total Chlorine Adoption") +
      theme_igray() +
      theme(
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(
          colour = "#7F7F7F",
          size = 8,
          face = "bold.italic"
        ),
        axis.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.text = element_text(
          colour = "#7F7F7F",
          size = 9,
          face = "bold"
        )
      )
    
    ggplotly(p) %>% config(displayModeBar = F)
    
  })
  
  output$plot2 <- renderPlotly({
    graph_data <- filter_data()
    p = ggplot(data = graph_data, aes(x = Period, y = TC_Adoption, group = Region)) +
      geom_line(aes(color = Region)) +
      geom_point(aes(color = Region)) +
      ylab("Total Chlorine Adoption") +
      theme_igray() +
      theme(
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(
          colour = "#7F7F7F",
          size = 8,
          face = "bold.italic"
        ),
        axis.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.text = element_text(
          colour = "#7F7F7F",
          size = 9,
          face = "bold"
        )
      )
    ggplotly(p) %>% config(displayModeBar = F)
  })
  
  output$plot3 <- renderPlot({
    ggcorrplot(
      corr,
      hc.order = TRUE,
      type = "lower",
      lab = TRUE,
      method = "circle",
      colors = c("tomato2", "white", "springgreen3"),
      title = "Correlogram of All Data",
      ggtheme = theme_igray
    ) +
      theme(
        axis.text = element_text(
          colour = "#FE6F88",
          size = 8,
          face = "bold"
        ),
        legend.title = element_text(
          colour = "#FE6F88",
          size = 12,
          face = "bold"
        ),
        legend.text = element_text(
          colour = "#7F7F7F",
          size = 9,
          face = "bold"
        ),
        plot.title = element_text(
          colour = "#7F7F7F",
          size = 12,
          face = "bold",
          hjust = 0.5
        )
      )
    
  })
  
  output$plot4 <- renderPlotly({
    p = ggplot(cleaned_data, aes_string(as.name(input$select_variable), "Total.Chlorine.Adoption")) +
      geom_point() +
      geom_smooth(method = 'lm', formula = y ~ x) +
      scale_size_area() +
      theme_igray() +
      theme(
        axis.text = element_text(
          colour = "#7F7F7F",
          size = 8,
          face = "bold"
        ),
        axis.title = element_text(
          colour = "#FE6F88",
          size = 12,
          face = "bold"
        )
      )
    ggplotly(p) %>% config(displayModeBar = T)
  })
  
  fetch_data <- reactive({
    graph_data2 <- all_data %>% filter(Country == input$select_country, Year == input$select_year) %>%
      select(Period,
             TC_Adoption,
             Region,
             dispensers_with_issues,
             functionality)
    return(graph_data2)
  })
  
  output$plot5 <- renderPlotly({
    graph_data2 <- fetch_data()
    p = ggplot(data = graph_data2, aes(x = Region, y = TC_Adoption, fill = Period)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      ylab("Total Chlorine Adoption") +
      theme_igray() +
      theme(
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(
          colour = "#7F7F7F",
          size = 8,
          face = "bold.italic"
        ),
        axis.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.text = element_text(
          colour = "#7F7F7F",
          size = 9,
          face = "bold"
        )
      )
    
    ggplotly(p) %>% config(displayModeBar = F)
    
  })
  
  output$plot6 <- renderPlotly({
    graph_data2 <- fetch_data()
    p = ggplot(data = graph_data2, aes(x = Period, y = TC_Adoption, group = Region)) +
      geom_line(aes(color = Region)) +
      geom_point(aes(color = Region)) +
      ylab("Total Chlorine Adoption") +
      theme_igray() +
      theme(
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(
          colour = "#7F7F7F",
          size = 8,
          face = "bold.italic"
        ),
        axis.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.title = element_text(
          colour = "#FE6F88",
          size = 10,
          face = "bold"
        ),
        legend.text = element_text(
          colour = "#7F7F7F",
          size = 9,
          face = "bold"
        )
      )
    ggplotly(p) %>% config(displayModeBar = F)
  })
  
  
})