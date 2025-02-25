library(fresh)



create_theme(
  adminlte_color(light_blue = "navy"),

  adminlte_global(content_bg = "plum"),

  adminlte_sidebar(
    dark_bg = "lightblue",
    dark_hover_bg = "orange",
    dark_color = "red",
    width = "400px"
  ),

  output_file = ("shinydashboard/www/dashboard-fresh-theme.css")
)
