library(shiny)
library(shinydashboard)
library(plotly)

shinyUI(dashboardPage(
  dashboardHeader(title = "Sample R plots"),
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Dashboard",
      tabName = "dashboard",
      icon = icon("dashboard")
    )
  )),
  
  dashboardBody(tabItems(
    # First tab content
    tabItem(
      tabName = "dashboard",
      fluidRow(
        box(
          title = "Bar Plot",
          status = "primary",
          solidHeader = TRUE,
          plotlyOutput("plot1", height = 300)
        ),
        box(
          title = "Line Plot",
          status = "primary",
          solidHeader = TRUE,
          plotlyOutput("plot2", height = 300)
        )
      ),
      
      fluidRow(
        box(
          title = "Correlation Plot",
          status = "primary",
          solidHeader = TRUE,
          plotOutput("plot3", height = 300)
        ),
        box(
          title = "Scatter PLot",
          status = "primary",
          solidHeader = TRUE,
          plotlyOutput("plot4", height = 300)
        ),
        verbatimTextOutput("event")
      )
    ),
    
    # Second tab content
    tabItem(tabName = "widgets",
            h2("Widgets tab content"))
  ))
))