library(shiny)
library(tidyverse)

ui <- fluidPage(
  textInput("name", " ", placeholder = "Your Name"),
  textOutput("greeting"),
  actionButton("load", "Load Data", icon = icon("beer"), class = "btn-primary active"),
  hr(),
  fluidRow(verbatimTextOutput("value")),
  dataTableOutput("table"),
  plotOutput("IBUhist", height = "500px", width = "600px"),
  plotOutput("ABVhist", height = "500px", width = "600px")
)

server <- function(input, output, session) {
  
  output$greeting <- renderText({paste0("Hello ", input$name, "!")})
  
  beers <- read_csv("https://raw.githubusercontent.com/BivinSadler/MSDS_6306_Doing-Data-Science/Master/Unit%208%20and%209%20Case%20Study%201/Beers.csv")
  output$value <- renderPrint(glimpse(beers))
  
  output$table <- renderDataTable(beers, options = list(pageLength = 5))
  
  output$IBUhist <- renderPlot(hist(beers$IBU), res = 96)
  output$ABVhist <- renderPlot(hist(beers$ABV), res = 96)
}

shinyApp(ui, server)
