# Load packages ----
library(shiny)
library(tidyverse)
library(palmerpenguins)

# Filter penguins df for obs where body_mass)g >= 3000 & <= 4000 ----
#body_mass_df <- penguins %>%
 # filter(body_mass_g %in% c(3000:4000))

# Filter for years 2007 - 2009
#penguins_year_df <- penguins %>%
#  filter(year %in% c(2007,2008))

# Create user interface ----
ui <- fluidPage(
  # App title ----
  tags$h1("My App Title"),

  # App subtitle ----
  tags$h4(tags$strong("Exploring Antarctic Penguin Data")),

  # Body mass slider input ----
  sliderInput( # Add input to our UI
    inputId = "body_mass_input",
    label = "Select a range of body masses (g)",
    min = 2700,
    max = 6300,
    value = c(3000, 4000)),

  # Body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot_output"), # Add output to our UI

  # Year checkbox input ----
  checkboxGroupInput(
    inputId = "year_input",
    label = "Select years(s):",
    choices = c(2007, 2008, 2009),
    selected = c(2007, 2008)),

  # DT output ----
  DT::dataTableOutput(outputId = "penguin_DT_output")


)

# Server ----
server <- function(input, output) {
  # Tell server how to assemble inputs into outputs

  # Filter body masses ----
  body_mass_df <- reactive({
    penguins %>%
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  })

  # Filter for year 2007 and 2008 ----
    penguins_year_df <- reactive({
      penguins %>%
        filter(year %in% c(input$year_input[1], input$year_input[2]))
    })


  # Render DT::datatable - penguins 2007 - 2008 ----
  output$penguin_DT_output <- DT::renderDataTable({
    DT::datatable(penguins_year_df())

  })


  # Render penguin scatter plot ----
  output$body_mass_scatterplot_output <- renderPlot({ # Save objects we want to display

    # Code to generate our plot
    ggplot(
      na.omit(body_mass_df()),
      # Include open/close parenthesis for any reactive data frame
      aes(
        x = flipper_length_mm,
        y = bill_length_mm,
        color = species,
        shape = species
      )
    ) +
      geom_point() +
      scale_color_manual(values = c(
        "Adelie" = "darkorange",
        "Chinstrap" = "purple",
        "Gentoo" = "cyan4"
      )) +
      scale_shape_manual(values = c(
        "Adelie" = 19,
        "Chinstrap" = 17,
        "Gentoo" = 15
      )) +
      labs(
        x = "Flipper length (mm)",
        y = "Bill length (mm)",
        color = "Penguin species",
        shape = "Penguin species"
      ) +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(
        legend.position.inside = c(0.85, 0.2),
        legend.background = element_rect(color = "white")
      )
  })
}


# Combine UI and server into an app ----
shinyApp(ui = ui, server = server)
