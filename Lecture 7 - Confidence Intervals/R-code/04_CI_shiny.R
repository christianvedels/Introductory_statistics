library(shiny)
library(tidyverse)
source("R-code/03_CI.R")

ui = fluidPage(
  titlePanel("Normal Distribution & Confidence Interval"),
  sidebarLayout(
    sidebarPanel(
      wellPanel(
        h3("Parameters"),
        numericInput("mu", "Mean (mu):", value = 0),
        numericInput("sigma", "Standard Deviation (sigma):", value = 1, min = 0.1),
        numericInput("num_sd", "Number of Standard Deviations:", value = 2, min = 0)
      ),
      wellPanel(
        style = "background-color: #f7f7f7; border: 1px solid #ccc;",
        h4("Visual Parameters (not important)"),
        numericInput("domain1", "Domain lower:", value = -5),
        numericInput("domain2", "Domain upper:", value = 5),
        numericInput("zoom", "Text Zoom:", value = 1),
        numericInput("axis_text_size", "X-axis Text Size:", value = 14),
        numericInput("label_offset1", "Label offset", value = -0.01)
      )
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server = function(input, output) {
  output$plot = renderPlot({
    plot_distribution_with_sd(mu = input$mu, 
                              sigma = input$sigma, 
                              num_sd = input$num_sd, 
                              domain = c(input$domain1, input$domain2),
                              text_zoom = input$zoom,
                              label_offset1 = input$label_offset1) +
      theme(axis.text.x = element_text(size = input$axis_text_size))
  })
}

shinyApp(ui = ui, server = server)
