# Load packages ----
library(shiny)
library(shinydashboard)
library(leaflet)
library(tidyverse)
library(shinycssloaders)
library(markdown)
library(fresh)

# Read in data ----
lake_data <- read.csv("data/lake_data_processed.csv")
