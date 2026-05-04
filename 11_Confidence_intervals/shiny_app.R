library(shiny)
library(ggplot2)
library(DT)

# ----------------------------
# Settings
# ----------------------------

true_mean <- 0.1
max_draws <- 100

# ----------------------------
# Weird distribution
# ----------------------------
# Mixture:
# 65% N(-1.5, 0.7^2)
# 25% N( 2.5, 0.35^2)
# 10% Exponential(1) shifted by +3.5
#
# True mean:
# 0.65*(-1.5) + 0.25*(2.5) + 0.10*(1 + 3.5) = 0.1

r_weird <- function(n) {
  component <- sample(
    x = c("left_normal", "right_normal", "right_tail"),
    size = n,
    replace = TRUE,
    prob = c(0.65, 0.25, 0.10)
  )
  
  x <- numeric(n)
  
  x[component == "left_normal"] <- rnorm(
    sum(component == "left_normal"),
    mean = -1.5,
    sd = 0.7
  )
  
  x[component == "right_normal"] <- rnorm(
    sum(component == "right_normal"),
    mean = 2.5,
    sd = 0.35
  )
  
  x[component == "right_tail"] <- rexp(
    sum(component == "right_tail"),
    rate = 1
  ) + 3.5
  
  x
}

d_weird <- function(x) {
  0.65 * dnorm(x, mean = -1.5, sd = 0.7) +
    0.25 * dnorm(x, mean = 2.5, sd = 0.35) +
    0.10 * ifelse(x >= 3.5, dexp(x - 3.5, rate = 1), 0)
}

# ----------------------------
# One simulation draw
# ----------------------------

make_draw <- function(draw_id, n = 200, conf_level = 0.95) {
  x <- r_weird(n)
  
  xbar <- mean(x)
  s <- sd(x)
  se <- s / sqrt(n)
  
  alpha <- 1 - conf_level
  critical_value <- qt(1 - alpha / 2, df = n - 1)
  
  lower <- xbar - critical_value * se
  upper <- xbar + critical_value * se
  
  list(
    sample = data.frame(x = x),
    interval = data.frame(
      draw = draw_id,
      estimate = xbar,
      lower = lower,
      upper = upper,
      covers = lower <= true_mean & true_mean <= upper
    )
  )
}

# ----------------------------
# Shiny app
# ----------------------------

ui <- fluidPage(
  withMathJax(),
  
  titlePanel("Confidence intervals and coverage"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
      
      numericInput(
        inputId = "n",
        label = "Sample size per draw",
        value = 200,
        min = 10,
        max = 1000,
        step = 10
      ),
      
      sliderInput(
        inputId = "conf_level",
        label = "Confidence level",
        min = 0.50,
        max = 0.99,
        value = 0.95,
        step = 0.01
      ),
      
      actionButton("draw_one", "Draw one new sample"),
      actionButton("draw_ten", "Draw 10 new samples"),
      actionButton("draw_hundred", "Draw 100 new samples"),
      actionButton("reset", "Reset"),
      
      hr(),
      
      h4("What should happen?"),
      p("Each confidence interval has a chance of covering the true mean equal to the selected confidence level."),
      p("For example, with a 95% confidence interval, about 1 in 20 intervals should miss the true mean."),
      
      hr(),
      
      h4("Running result"),
      verbatimTextOutput("coverage_text")
    ),
    
    mainPanel(
      width = 9,
      
      tabsetPanel(
        tabPanel(
          "One sample",
          h3("One sample and its confidence interval"),
          
          fluidRow(
            column(
              width = 5,
              
              h4("Population distribution"),
              
              div(
                style = "font-size: 82%; line-height: 1.25; overflow-x: auto;",
                HTML("
                $$
                \\begin{aligned}
                f_X(X=x)
                ={}& 0.65\\,
                \\frac{1}{0.7\\sqrt{2\\pi}}
                \\exp\\!\\left(
                -\\frac{(x+1.5)^2}{2\\cdot 0.7^2}
                \\right) \\\\[0.6em]
                &+ 0.25\\,
                \\frac{1}{0.35\\sqrt{2\\pi}}
                \\exp\\!\\left(
                -\\frac{(x-2.5)^2}{2\\cdot 0.35^2}
                \\right) \\\\[0.6em]
                &+ 0.10\\,
                e^{-(x-3.5)}
                \\mathbf{1}\\{x \\ge 3.5\\}
                \\end{aligned}
                $$
                "),
                
                HTML("
                $$
                E(X) = 0.1
                $$
                ")
              ),
              
              h4("Sample observations"),
              DTOutput("sample_table")
            ),
            
            column(
              width = 7,
              checkboxInput(
                inputId = "show_plot",
                label = "Show plot",
                value = FALSE
              ),
              uiOutput("sample_plot_area"),
              br(),
              textOutput("latest_text")
            )
          )
        ),
        
        tabPanel(
          "Many intervals",
          h3("Consecutive confidence intervals"),
          plotOutput("history_plot", height = "560px")
        ),
        
        tabPanel(
          "Mean estimates",
          h3("Distribution of sample mean estimates"),
          p("Each draw produces one sample mean. This plot shows how those sample means accumulate across repeated samples."),
          plotOutput("mean_estimates_plot", height = "560px")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  
  values <- reactiveValues(
    latest_sample = NULL,
    history = data.frame(
      draw = integer(),
      estimate = numeric(),
      lower = numeric(),
      upper = numeric(),
      covers = logical()
    )
  )
  
  add_one_draw <- function() {
    if (nrow(values$history) >= max_draws) {
      showNotification("Maximum number of intervals reached. Press Reset to start over.")
      return()
    }
    
    draw_id <- nrow(values$history) + 1
    
    result <- make_draw(
      draw_id = draw_id,
      n = input$n,
      conf_level = input$conf_level
    )
    
    values$latest_sample <- result$sample
    values$history <- rbind(values$history, result$interval)
  }
  
  add_many_draws <- function(number_of_draws) {
    for (i in seq_len(number_of_draws)) {
      if (nrow(values$history) < max_draws) {
        add_one_draw()
      }
    }
  }
  
  observeEvent(input$draw_one, {
    add_one_draw()
  })
  
  observeEvent(input$draw_ten, {
    add_many_draws(10)
  })
  
  observeEvent(input$draw_hundred, {
    add_many_draws(100)
  })
  
  observeEvent(input$reset, {
    values$latest_sample <- NULL
    values$history <- data.frame(
      draw = integer(),
      estimate = numeric(),
      lower = numeric(),
      upper = numeric(),
      covers = logical()
    )
  })
  
  output$coverage_text <- renderText({
    h <- values$history
    
    if (nrow(h) == 0) {
      return("No samples drawn yet.")
    }
    
    covered <- sum(h$covers)
    total <- nrow(h)
    missed <- total - covered
    coverage <- covered / total
    
    paste0(
      "Intervals drawn: ", total,
      "\nCovered true mean: ", covered,
      "\nMissed true mean: ", missed,
      "\nObserved coverage: ", round(100 * coverage, 1), "%",
      "\nLong-run target coverage: ", round(100 * input$conf_level, 1), "%"
    )
  })
  
  output$latest_text <- renderText({
    h <- values$history
    
    if (nrow(h) == 0) {
      return("Click 'Draw one new sample' to begin.")
    }
    
    latest <- h[nrow(h), ]
    
    paste0(
      "Latest sample mean: ", round(latest$estimate, 3),
      ". ", round(100 * input$conf_level, 0), "% CI: [",
      round(latest$lower, 3), ", ", round(latest$upper, 3), "]. ",
      "True mean: ", true_mean, ". ",
      ifelse(
        latest$covers,
        "This interval covers the true mean.",
        "This interval misses the true mean."
      )
    )
  })
  
  output$sample_table <- renderDT({
    if (is.null(values$latest_sample)) {
      return(
        datatable(
          data.frame(Message = "Draw a sample to see the observations."),
          rownames = FALSE,
          options = list(
            dom = "t",
            pageLength = 1
          )
        )
      )
    }
    
    out <- values$latest_sample
    out$Observation <- seq_len(nrow(out))
    out <- out[, c("Observation", "x")]
    names(out) <- c("Observation", "Value")
    
    out$Value <- round(out$Value, 3)
    
    datatable(
      out,
      rownames = FALSE,
      options = list(
        pageLength = 5,
        lengthMenu = c(5, 10, 20, 50, 100, 200),
        searching = FALSE,
        ordering = TRUE,
        paging = TRUE,
        info = TRUE
      )
    )
  })
  
  output$sample_plot_area <- renderUI({
    if (is.null(values$latest_sample)) {
      return(
        div(
          style = "height: 520px; display: flex; align-items: center; justify-content: center; border: 1px solid #ddd; border-radius: 6px;",
          p("Draw a sample to create the plot.")
        )
      )
    }
    
    if (!isTRUE(input$show_plot)) {
      return(
        div(
          style = "height: 520px; display: flex; align-items: center; justify-content: center; border: 1px solid #ddd; border-radius: 6px;",
          p("The plot is hidden. Tick 'Show plot' to reveal it.")
        )
      )
    }
    
    plotOutput("sample_plot", height = "520px")
  })
  
  output$sample_plot <- renderPlot({
    h <- values$history
    latest <- h[nrow(h), ]
    
    curve_data <- data.frame(
      x = seq(-5, 8, length.out = 1000)
    )
    curve_data$density <- d_weird(curve_data$x)
    
    ggplot(values$latest_sample, aes(x = x)) +
      geom_histogram(
        aes(y = after_stat(density)),
        bins = 30,
        fill = "grey85",
        color = "white"
      ) +
      geom_line(
        data = curve_data,
        aes(x = x, y = density),
        inherit.aes = FALSE,
        linewidth = 1
      ) +
      geom_vline(
        xintercept = true_mean,
        linewidth = 1
      ) +
      geom_vline(
        xintercept = latest$estimate,
        linetype = "dashed",
        linewidth = 1
      ) +
      geom_vline(
        xintercept = latest$lower,
        linetype = "dotted",
        linewidth = 1
      ) +
      geom_vline(
        xintercept = latest$upper,
        linetype = "dotted",
        linewidth = 1
      ) +
      annotate(
        "segment",
        x = latest$lower,
        xend = latest$upper,
        y = 0.02,
        yend = 0.02,
        linewidth = 2,
        color = ifelse(latest$covers, "forestgreen", "firebrick")
      ) +
      annotate(
        "point",
        x = latest$estimate,
        y = 0.02,
        size = 3
      ) +
      annotate(
        "text",
        x = true_mean,
        y = 0.42,
        label = "True mean",
        hjust = -0.1
      ) +
      annotate(
        "text",
        x = latest$estimate,
        y = 0.36,
        label = "Sample mean",
        hjust = -0.1
      ) +
      labs(
        title = paste0("Sample ", latest$draw, " from the weird distribution"),
        subtitle = "Dashed line = sample mean. Dotted lines = confidence interval limits.",
        x = "Value",
        y = "Density"
      ) +
      coord_cartesian(xlim = c(-5, 8), ylim = c(0, 0.45)) +
      theme_minimal(base_size = 14)
  })
  
  output$history_plot <- renderPlot({
    h <- values$history
    
    if (nrow(h) == 0) {
      empty_data <- data.frame(x = true_mean, y = 1)
      
      ggplot(empty_data, aes(x = x, y = y)) +
        geom_vline(xintercept = true_mean, linewidth = 0.9) +
        annotate(
          "text",
          x = true_mean,
          y = 1,
          label = "Click 'Draw one new sample' to start",
          hjust = -0.1
        ) +
        labs(
          x = "Value",
          y = "Draw number"
        ) +
        coord_cartesian(
          xlim = c(-1, 1),
          ylim = c(0.5, max_draws + 0.5)
        ) +
        theme_minimal(base_size = 12) +
        theme(
          plot.margin = margin(5, 10, 5, 5)
        )
      
    } else {
      ggplot(h) +
        geom_vline(
          xintercept = true_mean,
          linewidth = 0.9
        ) +
        geom_segment(
          aes(
            x = lower,
            xend = upper,
            y = draw,
            yend = draw,
            color = covers
          ),
          linewidth = 0.8
        ) +
        geom_point(
          aes(
            x = estimate,
            y = draw,
            color = covers
          ),
          size = 1.4
        ) +
        scale_color_manual(
          values = c("TRUE" = "forestgreen", "FALSE" = "firebrick"),
          labels = c(
            "FALSE" = "Misses true mean",
            "TRUE" = "Covers true mean"
          ),
          name = ""
        ) +
        scale_y_continuous(
          limits = c(0.5, max_draws + 0.5),
          breaks = seq(0, max_draws, by = 20)
        ) +
        labs(
          title = paste0(
            "Repeated ",
            round(100 * input$conf_level, 0),
            "% confidence intervals"
          ),
          subtitle = "Green intervals cover the true mean. Red intervals miss it.",
          x = "Mean value",
          y = "Draw number"
        ) +
        theme_minimal(base_size = 12) +
        theme(
          legend.position = "top",
          plot.title = element_text(size = 15),
          plot.subtitle = element_text(size = 11),
          axis.title = element_text(size = 11),
          axis.text = element_text(size = 10),
          plot.margin = margin(5, 10, 5, 5)
        )
    }
  })
  
  output$mean_estimates_plot <- renderPlot({
    h <- values$history
    
    if (nrow(h) == 0) {
      empty_data <- data.frame(x = true_mean, y = 1)
      
      ggplot(empty_data, aes(x = x, y = y)) +
        geom_vline(xintercept = true_mean, linewidth = 0.9) +
        annotate(
          "text",
          x = true_mean,
          y = 1,
          label = "Click 'Draw one new sample' to start",
          hjust = -0.1
        ) +
        labs(
          x = "Sample mean estimate",
          y = "Density"
        ) +
        coord_cartesian(
          xlim = c(true_mean - 0.5, true_mean + 0.5),
          ylim = c(0, 1.5)
        ) +
        theme_minimal(base_size = 12)
      
    } else {
      p <- ggplot(h, aes(x = estimate)) +
        geom_histogram(
          aes(y = after_stat(density)),
          bins = 20,
          fill = "grey85",
          color = "white"
        ) +
        geom_vline(
          xintercept = true_mean,
          linewidth = 1
        ) +
        geom_vline(
          xintercept = mean(h$estimate),
          linetype = "dashed",
          linewidth = 1
        ) +
        labs(
          title = "Distribution of sample mean estimates",
          subtitle = paste0(
            "Solid line = true mean. Dashed line = average of the sample mean estimates. Draws so far: ",
            nrow(h)
          ),
          x = "Sample mean estimate",
          y = "Density"
        ) +
        theme_minimal(base_size = 12) +
        theme(
          plot.title = element_text(size = 15),
          plot.subtitle = element_text(size = 11),
          axis.title = element_text(size = 11),
          axis.text = element_text(size = 10),
          plot.margin = margin(5, 10, 5, 5)
        )
      
      if (nrow(h) >= 5) {
        p <- p +
          geom_density(
            linewidth = 1
          )
      }
      
      p
    }
  })
}

shinyApp(ui, server)