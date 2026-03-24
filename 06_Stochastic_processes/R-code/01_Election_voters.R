library(shiny)
library(tidyverse)

# Poll probabilities (March 21, 2026)
P_RED  <- 0.475   # Red bloc
P_MID  <- 0.066   # Middle (Moderaterne)
P_BLUE <- 0.458   # Blue bloc  (sums to 0.999 ≈ 1)

N_VOTERS <- 1000

# ── UI ────────────────────────────────────────────────────────────────────────
ui <- fluidPage(
  titlePanel("Election 2026: One voter at a time"),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      numericInput("n_paths", "Number of simulations:", value = 10, min = 1, max = 50, step = 1),
      hr(),
      actionButton("btn_run",   "Draw voters →",
                   class = "btn-primary", style = "width:100%; margin-bottom:6px;"),
      actionButton("btn_reset", "Reset",
                   class = "btn-default",  style = "width:100%;"),
      hr(),
      helpText("Each step adds one voter. The curve shows the",
               "running red advantage S_t = #red − #blue after t voters.")
    ),
    mainPanel(
      plotOutput("path_plot", height = "500px")
    )
  )
)

# ── Server ────────────────────────────────────────────────────────────────────
server <- function(input, output, session) {

  # Store all simulated paths: list of numeric vectors length N_VOTERS
  paths     <- reactiveVal(list())
  t_shown   <- reactiveVal(0)    # how many voters have been revealed so far
  animating <- reactiveVal(FALSE)

  # Generate all paths up front when button is pressed
  observeEvent(input$btn_run, {
    n <- input$n_paths
    new_paths <- replicate(n, {
      votes <- sample(c(1, 0, -1),
                      size    = N_VOTERS,
                      replace = TRUE,
                      prob    = c(P_RED, P_MID, P_BLUE))
      cumsum(votes)
    }, simplify = FALSE)
    paths(new_paths)
    t_shown(0)
    animating(TRUE)
  })

  observeEvent(input$btn_reset, {
    animating(FALSE)
    paths(list())
    t_shown(0)
  })

  # Animation: reveal voters one at a time (jump by 5 for speed)
  STEP_SIZE <- 5
  FRAME_MS  <- 30

  observe({
    if (animating()) {
      t <- t_shown()
      if (t < N_VOTERS) {
        invalidateLater(FRAME_MS, session)
        t_shown(min(t + STEP_SIZE, N_VOTERS))
      } else {
        animating(FALSE)
      }
    }
  })

  # ── Plot ──────────────────────────────────────────────────────────────────
  output$path_plot <- renderPlot({
    ps <- paths()
    t  <- t_shown()

    if (length(ps) == 0 || t == 0) {
      # Empty canvas with axis
      ggplot() +
        annotate("text", x = 500, y = 0,
                 label = "Press 'Draw voters' to start",
                 size = 6, color = "grey60") +
        scale_x_continuous("Voters drawn (t)", limits = c(0, N_VOTERS)) +
        scale_y_continuous("Red advantage  S_t") +
        theme_minimal(base_size = 14) +
        theme(panel.grid.minor = element_blank())
    } else {
      # Build tidy data for the revealed portion
      df <- map_dfr(seq_along(ps), function(i) {
        tibble(
          path = factor(i),
          t    = seq_len(t),
          S    = ps[[i]][seq_len(t)]
        )
      })

      # Final values for colour (red > 0, blue < 0)
      finals <- df %>%
        group_by(path) %>%
        slice_tail(n = 1) %>%
        mutate(winner = if_else(S > 0, "Red ahead", "Blue ahead"))

      df <- left_join(df, select(finals, path, winner), by = "path")

      expected_line <- tibble(t = seq_len(t),
                              S = t * (P_RED - P_BLUE))

      ggplot(df, aes(t, S, group = path, color = winner)) +
        geom_hline(yintercept = 0, linewidth = 0.6, color = "grey50") +
        geom_line(alpha = 0.6, linewidth = 0.8) +
        geom_line(data = expected_line, aes(t, S),
                  inherit.aes = FALSE,
                  color = "black", linewidth = 1.2,
                  linetype = "dashed") +
        annotate("text",
                 x = t * 0.98, y = tail(expected_line$S, 1) + 8,
                 label = sprintf("E[S_t] = %.3f·t", P_RED - P_BLUE),
                 hjust = 1, size = 4, color = "black") +
        scale_color_manual(values = c("Red ahead"  = "#d6604d",
                                      "Blue ahead" = "#4393c3"),
                           name = NULL) +
        scale_x_continuous("Voters drawn (t)", limits = c(0, N_VOTERS)) +
        scale_y_continuous("Red advantage  S_t") +
        labs(title = sprintf("Running red advantage after %d voters  (%d simulations)",
                             t, length(ps))) +
        theme_minimal(base_size = 14) +
        theme(
          plot.title       = element_text(face = "bold"),
          panel.grid.minor = element_blank(),
          legend.position  = "top"
        )
    }
  })
}

shinyApp(ui = ui, server = server)
