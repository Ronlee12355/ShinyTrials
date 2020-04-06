# this is shiny app is to demonstrate all layouts provided in shiny package

library(shiny)
library(shinythemes)
shinyUI(fluidPage(
    titlePanel('Shiny Layouts Demos With Navilist Panel'),
    br(),
    themeSelector(),
    navlistPanel(
        "Shiny Layouts",
        tabPanel(
            title = 'sidebarLayout',
            h3('sidebarLayout demo'),
            sidebarLayout(
                sidebarPanel(
                    sliderInput("obs",
                                "Number of observations: ",
                                min = 0,
                                max = 100,
                                value = 40)
                ),
                mainPanel(
                    plotOutput('distPlot')
                )
            )
        ),
        tabPanel(
            title = 'splitLayout',
            h3('splitLayout demo'),
            splitLayout(
                cellWidths = c('30%', '70%'),
                plotOutput('plot1'),
                plotOutput('plot2')
            )
        ),
        tabPanel(
            title = 'verticalLayout',
            h3('verticalLayout demo'),
            verticalLayout(
                a(href="http://example.com/link1", "Link One"),
                a(href="http://example.com/link2", "Link Two"),
                a(href="http://example.com/link3", "Link Three")
            )
        ),
        tabPanel(
            title = 'flowLayout',
            h3('flowLayout demo'),
            flowLayout(
                numericInput("rows", "How many rows?", 5),
                selectInput("letter", "Which letter?", LETTERS),
                sliderInput("value", "What value?", 0, 100, 50)
            )
        ),
        widths = c(2,10)
    )
))
