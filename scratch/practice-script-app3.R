# Load packages ----
library(tidyverse)
library(leaflet)


# Read in data ----
lake_data <- read_csv(here::here("shinydashboard", "data", "lake_data_processed.csv" ))

# Filter data ----
filtered_lakes <- lake_data |>
  filter(Elevation >= 8 & Elevation <= 20) |>
  filter(AvgDepth >= 2 & AvgDepth <= 3) |>
  filter(AvgTemp >= 4 & AvgTemp <= 6)

# Leaflet map ----
leaflet() |>
  addProviderTiles(providers$Esri.WorldImagery) |>
  setView(lng = -152.048442,
          lat =  70.249234,
          zoom = 6) |>
  addMiniMap(toggleDisplay = TRUE,
             minimized = FALSE) |>
  addMarkers(data = filtered_lakes,
             lat = filtered_lakes$Latitude,
             lng = filtered_lakes$Longitude,
             popup = paste("Site Name: ", filtered_lakes$Site, "<br>",
                           "Elevation: ", filtered_lakes$Elevation, " meters above SL", "<br>",
                           "Avg Depth: ", filtered_lakes$AvgDepth, " meters", "<br>",
                           "Avg Lake Bed Temperature: ", filtered_lakes$AvgTemp, "\u00B0C"))

