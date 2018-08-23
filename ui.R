library(shiny)
library(shinydashboard)
library(plotly)

shinyUI(dashboardPage(
  dashboardHeader(title = "Sample R plots"),
  dashboardSidebar(sidebarMenu(
    menuItem("Dashboard",tabName = "dashboard",icon = icon("dashboard")),
    menuItem("Other Plots", tabName = "other_plots", icon = icon("th")),
    selectInput("select_country", label = "Select Country", 
                choices = list("Kenya" = "Kenya",
                               "Uganda" = "Uganda",
                               "Malawi" = "Malawi"
                               ), 
                selected = "Kenya"),
    
    selectInput("select_year", label = "Select Year", 
                choices = list("2017" = 2017,
                               "2018" = 2018
                ), 
                selected = "2017"),
    
    selectInput("select_variable", label = "TC Adoption Against",
                choices = list("Functionality" = "Functionality",
                               "Dispensers With Hardware Issues" = "Dispensers.with.Hardware.Issues",
                               "Promoter Rating" = "Promoter.Rating"
                ),
                selected = "Functionality")
    
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
        )
      )
    ),
    #other tab name
      tabItem(tabName = "other_plots",
        fluidRow(
          box(
            width = 12,
            title = "Bar Plot",
            status = "primary",
            solidHeader = TRUE,
            plotlyOutput("plot5", height = 400)
          )
        ),
        
        fluidRow(
          box(
            width = 12,
            title = "Line Plot",
            status = "primary",
            solidHeader = TRUE,
            plotlyOutput("plot6", height = 500)
          )
        )
      )
  ))
))