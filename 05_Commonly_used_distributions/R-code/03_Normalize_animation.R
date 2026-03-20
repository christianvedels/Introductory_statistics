library(shiny)
library(tidyverse)

# ── UI ───────────────────────────────────────────────────────────────────────
ui <- fluidPage(
  titlePanel("Normalizing a Distribution"),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      numericInput("mu",    "Mean (μ):",    value = 3,   step = 0.5),
      numericInput("sigma", "Std Dev (σ):", value = 2,   step = 0.5, min = 0.1),
      hr(),
      actionButton("btn_next",  "Step 1: Subtract mean \u2192",
                   class = "btn-primary",  style = "width:100%; margin-bottom:6px;"),
      actionButton("btn_reset", "Reset",
                   class = "btn-default",  style = "width:100%;")
    ),
    mainPanel(
      plotOutput("dist_plot", height = "460px")
    )
  )
)

# ── Server ────────────────────────────────────────────────────────────────────
server <- function(input, output, session) {

  # step: 0 = original, 1 = mean subtracted, 2 = also divided by sigma
  step <- reactiveVal(0)

  observeEvent(input$btn_next, {
    s <- step()
    if (s == 0) {
      step(1)
      updateActionButton(session, "btn_next",
                         label = "Step 2: Divide by \u03c3 \u2192")
    } else if (s == 1) {
      step(2)
      updateActionButton(session, "btn_next",
                         label = "Done \u2713", disabled = TRUE)
    }
  })

  observeEvent(input$btn_reset, {
    step(0)
    updateActionButton(session, "btn_next",
                       label    = "Step 1: Subtract mean \u2192",
                       disabled = FALSE)
  })

  # Plot ───────────────────────────────────────────────────────────────────────
  output$dist_plot <- renderPlot({
    mu    <- input$mu
    sigma <- max(input$sigma, 0.1)
    s     <- step()

    curr_mu    <- if (s >= 1) 0      else mu
    curr_sigma <- if (s >= 2) 1      else sigma

    # x-axis: wide enough to cover original and standard normal
    x_lo <- min(-4.5, mu - 4 * sigma) - 0.3
    x_hi <- max( 4.5, mu + 4 * sigma) + 0.3
    xs   <- seq(x_lo, x_hi, length.out = 600)

    std_df  <- tibble(x = xs, y = dnorm(xs, 0,       1))
    curr_df <- tibble(x = xs, y = dnorm(xs, curr_mu, curr_sigma))

    title_str <- switch(s + 1,
      sprintf("Original distribution:  N(\u03bc = %.1f,  \u03c3 = %.1f)", mu, sigma),
      sprintf("Step 1 \u2014 Subtract \u03bc:  X \u2212 %.1f   \u27a4  N(0, %.1f)", mu, sigma),
      sprintf("Step 2 \u2014 Divide by \u03c3:  X / %.1f   \u27a4  N(0, 1)", sigma)
    )

    ggplot() +
      # ── Standard normal (reference, faint) ──────────────────────────────────
      geom_area(data = std_df,  aes(x, y),
                fill = "#2166ac", alpha = 0.12) +
      geom_line(data = std_df,  aes(x, y),
                color = "#2166ac", alpha = 0.45, linewidth = 0.9, linetype = "dashed") +
      # ── Current (animated) distribution ─────────────────────────────────────
      geom_area(data = curr_df, aes(x, y),
                fill = "#d6604d", alpha = 0.40) +
      geom_line(data = curr_df, aes(x, y),
                color = "#d6604d", linewidth = 1.3) +
      # ── Annotations ─────────────────────────────────────────────────────────
      annotate("text",
               x = x_hi - 0.2, y = max(std_df$y) * 0.95,
               label = "N(0, 1)", color = "#2166ac",
               hjust = 1, size = 4.5) +
      annotate("text",
               x = curr_mu, y = max(curr_df$y) * 1.06,
               label = sprintf("N(%.2f,  %.2f)", curr_mu, curr_sigma),
               color = "#d6604d", hjust = 0.5, size = 4.5) +
      # ── Labels & theme ───────────────────────────────────────────────────────
      labs(title = title_str, x = "x", y = "Density") +
      coord_cartesian(xlim = c(x_lo, x_hi)) +
      theme_minimal(base_size = 14) +
      theme(
        plot.title       = element_text(face = "bold"),
        axis.text.y      = element_blank(),
        axis.ticks.y     = element_blank(),
        panel.grid.minor = element_blank()
      )
  })
}

shinyApp(ui = ui, server = server)
