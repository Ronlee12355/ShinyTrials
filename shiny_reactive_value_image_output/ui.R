library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Demo of reactive values and image output"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            br(),
            p(actionButton('add', '+1'), actionButton('min','-1'))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            imageOutput("distPlot"),
            br(),
            verbatimTextOutput('prints')
        )
    )
))
