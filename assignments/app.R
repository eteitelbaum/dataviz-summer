# load packages


# load the data


# Create list of named values for the input selection

vars <- c("Polyarchy" = "v2x_polyarchy", # be sure to insert the variable names you have
          "Liberal Democracy" = ....      # in your wrangled data on the right hand side
          )                               # of these equations

# Create list of country names

countries <- vdem_trends |>
  filter(....) |> # filter what?
  pull(....) |>   # pull what?
  sort()          # no arguments for sort

# Define ui for application that draws a line chart
ui <- fluidPage(

  # Application title
  titlePanel("Democracy Waves App"),

  fluidRow(

    # 12 columns on one row: this panel will take 1/4 of it
    column(3, wellPanel(
      selectInput(),  # fill in the blanks; you need three arguments here
      selectInput()   # fill in the blanks; you need three arguments here
    ),
    helpText("YOUR help text here")
    ),

    # Remaining 3/4 occupied by plot
    column(8,                              ## This part is done for you
           plotOutput("lineChart"),
           sliderTextInput(
             "range",
             NULL,
             grid = TRUE,
             choices = 1970:2023,
             selected = c(1970, 2023),
             width = "100%"
           )
    )
  )
)

# Define server logic required to draw a line chart
server <- function(input, output) {

  # Select and filter based on country and indicator selection
  ctry_indicator <- reactive({
    vdem_trends |>
    filter(country == INPUT) |>       # replace INPUT with relevant input
    select(year, INPUT)               # ditto
    })

  # Filter based on year slider selection
  plot_df <- reactive({
    ctry_indicator() |>
    filter(year %in% (INPUT:INPUT))   # replace INPUT with relevant input
   })

  # Render line chart
  output$lineChart <- renderPlot({

    # Build plot with ggplot2
    ggplot(DATA, aes(x = year, y = .data[[input$indicator]])) + # replace DATA
      geom_line(color = "navyblue", linewidth = .75) +
      labs(
        x = "",
        y = VARNAMES,                                            # replace with relevant code
        caption = "Source: V-Dem Institute"
      ) +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
