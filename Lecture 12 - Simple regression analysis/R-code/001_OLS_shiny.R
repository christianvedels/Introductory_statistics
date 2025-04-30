library(shiny)
library(tidyverse)

# Sample data: mtcars dataset (x = weight, y = Child_height)
data = read_csv("Examples/Galton_data/Galton_Family_Heights.csv")

data = data %>% 
  mutate_all(function(x){x*2.54}) %>% 
  mutate(gender = ifelse(gender > 0, "male", "female"))

ui <- fluidPage(
  titlePanel("Scatterplot with Trend Line and Squared Deviations"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("beta0", "Intercept (β₀)",
                  min = 100, max = 150,
                  value = coef(lm(Child_height ~ Father_height, data))[1], step = 0.1),
      sliderInput("beta1", "Slope (β₁)",
                  min = -2, max = 2,
                  value = coef(lm(Child_height ~ Father_height, data))[2], step = 0.1),
      actionButton("ols", "Compute OLS Line")
    ),
    mainPanel(
      plotOutput("scatterPlot", height = "600px")
    )
  )
)

server <- function(input, output, session) {
  
  # When OLS button is clicked, compute and update coefficients & sliders
  observeEvent(input$ols, {
    fit <- lm(Child_height ~ Father_height, data)
    b <- coef(fit)
    input$beta0 = b[1]
    input$beta1 = b[2]
  })
  
  output$scatterPlot <- renderPlot({
    # Choose coefficients: sliders initially, then reactive after OLS click
    b0 <- input$beta0
    b1 <- input$beta1
    
    df <- data
    df$yhat <- b0 + b1 * df$Father_height
    df$resid <- df$Child_height - df$yhat
    
    ggplot(df, aes(x = Father_height, y = Child_height)) +
      geom_point(size = 3) +
      geom_abline(intercept = b0, slope = b1, color = "blue", size = 1) +
      # Draw squares representing squared deviations
      # geom_rect(aes(
      #   xmin = Father_height,
      #   xmax = Father_height + abs(resid),
      #   ymin = yhat,
      #   ymax = yhat + abs(resid)
      # ), fill = "lightgrey", color = "red", alpha = 0.1) +
      labs(
        x = "Weight (1000 lbs)",
        y = "Miles/(US) gallon",
        title = "Scatterplot with Trend Line and Squared Deviations"
      ) +
      theme_minimal(base_size = 15)
  })
}

shinyApp(ui, server)

