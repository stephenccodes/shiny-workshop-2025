server <- function(input, output){

 # Filter lake data
  filtered_lakes_df <- reactive({

  lake_data |>
    filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2]) |>
    filter(AvgDepth >= input$depth_slider_input[1] & AvgDepth <= input$depth_slider_input[2]) |>
    filter(AvgTemp >= input$temp_slider_input[1] & AvgTemp <= input$temp_slider_input[2])


  })

  # Build leaflet map ----
  output$lake_map_output <- renderLeaflet({

    leaflet() |>
      addProviderTiles(providers$Esri.WorldImagery) |>
      setView(lng = -152.048442,
              lat =  70.249234,
              zoom = 6) |>
      addMiniMap(toggleDisplay = TRUE,
                 minimized = FALSE) |>
      addMarkers(data = filtered_lakes_df(),

                 lat = filtered_lakes_df()$Latitude,
                 lng = filtered_lakes_df()$Longitude,
                 popup = paste("Site Name: ", filtered_lakes_df()$Site, "<br>",
                               "Elevation: ", filtered_lakes_df()$Elevation, " meters above SL", "<br>",
                               "Avg Depth: ", filtered_lakes_df()$AvgDepth, " meters", "<br>",
                               "Avg Lake Bed Temperature: ", filtered_lakes_df()$AvgTemp, "\u00B0C"))


  })


}
