# User interface ----
ui <- navbarPage(

  title = "LTER Animal Data Explorer",

  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",

           # Intro text fluidRow ----
           fluidRow(

             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)

           ), # END intro text fluidRow


           tags$hr(),
           column(1),

           # Footer text
           column(10, includeMarkdown("text/footer.md")),
           column(1)


  ), #END (Page 1) intro tabPanel

  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",

           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             tabPanel(title = "Trout",

                       # Trout sidebarLayout ----
                      sidebarLayout(

                        # Trout sidebarPanel ----
                        sidebarPanel(

                          # Channel type pickerInput ----
                          pickerInput(inputId = 'channel_type_input',
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)), # Select/deselect all option

                          # Section checkboxGroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling selection(s):",
                                               choices = c("Clear Cut Forest" = "clear cut forest",
                                                           "Old Growth Forest" = "old growth forest"),
                                               selected = c("clear cut forest",
                                                            "old growth forest"),
                                               justified = TRUE, # Expland width to box for aesthetics
                                               checkIcon = list(
                                                 yes = icon("check", lib = "font-awesome"),
                                                 no = icon("xmark")))
                        ), # END Trout sidebarPanel

                        # Trout mainPanel ----
                        mainPanel(

                          # Trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") %>%
                            withSpinner(color = "limegreen", type = 4, size = 2) # Add a loading icon

                        ), # END trout mainPanel

                      ) # END trout sidebarLayout

             ), # END trout tabPanel

             # Penguin tabPanel ----
             tabPanel(title = "Penguins",

                      # Penguin sidebarLayout ----
                      sidebarLayout(

                        # Penguin sidebarPanel ----
                        sidebarPanel(

                          # Island type pickerInput
                          pickerInput(inputId = 'penguin_island_input',
                                      label = "Select Island(s):",
                                      choices = c("Torgersen", "Dream", "Biscoe"),
                                      selected = c("Torgersen","Dream", "Biscoe"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),

                          # Bin number sliderInput
                          sliderInput(inputId = 'bin_num_input',
                                      label = "Select Number of Bins:",
                                      min = 1,
                                      max = 100,
                                      value = 25)


                        ), # END Penguin sidebarPanel


                        # Penguin mainPanel ----
                        mainPanel(

                          plotOutput(outputId = "flipper_length_histogram_output") %>%
                           withSpinner(color = "orchid", type = 4, size = 2) # Add a loading icon

                        ) # END Penguin mainPanel


                      ) # END Penguin sidebarlayout


                      ) # END penguin tabPanel

           ) # END tabsetPanel

           ) # END (Page 2) data viz tabPanel
) # END UI
