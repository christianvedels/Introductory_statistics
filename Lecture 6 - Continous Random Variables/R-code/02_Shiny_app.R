library(shiny)
library(tidyverse)
source("R-code/01_Make_plot_function.R")

# Shiny app UI and Server
ui <- fluidPage(
  titlePanel("Continous Distributions"),
  sidebarLayout(
    sidebarPanel(
      numericInput("a", "Lower limit (a):", value = -1),
      numericInput("b", "Upper limit (b):", value = 2),
      selectInput("density", "Select density function:",
                  choices = list("Two normals" = "d1", "Uniform" = "d2", "Standard normal" = "d3", "Galton" = "galton_d"),
                  selected = "d1"),
      numericInput("zoom", "Larger text:", value = 1),
      checkboxInput("cumulative", "Cumulative distribution", value = FALSE),
      numericInput("domain1", "Domain lower", value = -10),
      numericInput("domain2", "Domain upper", value = 10)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    # Select the appropriate density function based on user input
    densityFunction <- switch(input$density,
                              "d1" = d1,
                              "d2" = d2,
                              "d3" = d3,
                              "galton_d" = galton_d)
    make_plot(a = input$a, 
              b = input$b, 
              d = densityFunction, 
              text_zoom = input$zoom, 
              cumulative = input$cumulative,
              domain = c(input$domain1, input$domain2))
  })
}

shinyApp(ui = ui, server = server)
