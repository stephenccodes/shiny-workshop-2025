# Dashboard header ----
header <- dashboardHeader(

  # Title ----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
)


# Dashboard sidebar ----
sidebar <- dashboardSidebar(

  # SidebarMenu ----
  sidebarMenu(
    menuItem(text = "Welcome", tabName = "welcome",  icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))

  )  # END sidebarMenu

) # END dashboardsidebar


# Dashboard body ----
body <- dashboardBody(

  # Set theme ----
  fresh::use_theme("dashboard-fresh-theme.css"),

  # tabitems ----
  tabItems(

    # Welomce tabItem ----
    tabItem(tabName = "welcome",

            # left-hand column ----
            column(width = 6,

                   # Background info box ----
                   box(width = NULL,
                       title = tagList(icon("water"), strong("Monitoring Fish Creek Watershed")),
                       includeMarkdown("text/intro.md"),
                       tags$img(src = "FishCreekWatershedSiteMap_2020.jpg",
                                alt = "A map of Northern Alaska, showing Fish Creek Watershed located within the National Petroleum Reserve.",
                                style = "max-width: 100%;"),
                       tags$h6(tags$em("Map Source:", tags$a(href = "http://www.fishcreekwatershed.org/", "FCWO")),
                               style = "text-align: center;")

                   ) # END background info box

            ), # END left-hand column

            # right-hand column ----
            column(width = 6,

                   # first fluidRow ----
                   fluidRow(

                     # Citation box ----
                     box(width = NULL,

                         title = tagList(icon("table"), strong("Data Source")),
                         includeMarkdown("text/citation.md")

                     ) # END citation box

                   ), # END first fluidRow


                   # Second fluidRow ----
                   fluidRow(

                     # Disclaimer box ----
                     box(width = NULL,

                         title = tagList(icon("triangle-exclamation"), strong("Disclaimer")),
                         includeMarkdown("text/disclaimer.md")

                     ) # END disclaimer box

                   )# END second fluidRow

            ) # END right-hand column

    ), # END welcome tabItem

    # Dashboard tabItem ----
    tabItem(tabName = "dashboard",

            # fluidRow ----
            fluidRow(

              # input box ----
              box(width = 4,

                  title = tags$strong("Adjust lake parameter ranges:"),

                  # Elevation sliderinput ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above SL)",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),
                                        max(lake_data$Elevation))), # END elevation sliderinput

                  # AvgDepth
                  sliderInput(inputId = "depth_slider_input",
                              label = "Average depth (meters)",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth),
                                        max(lake_data$AvgDepth))),

                  # AvgTemp
                  sliderInput(inputId = "temp_slider_input",
                              label = "Average lake bed temperature (°C)",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp),
                                        max(lake_data$AvgTemp))) # END sliderinputs

              ), # END inputs box


              # leaflet box ----
              box(width = 8,

                  title = "Monitored lakes within Fish Creek Watershed",

                  # leaflet output ----
                  leafletOutput(outputId = "lake_map_output") |>
                    withSpinner(type = 1, color = 'navy')

              ) # END leaflet box

              ) # END fluidRow

            ) # END dashboard tabItem


  ) # END tabItems



) # END dashboardBody


# Combine features ----
dashboardPage(header, sidebar, body)
