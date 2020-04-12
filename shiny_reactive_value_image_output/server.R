library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    counts <- reactiveValues(a=0,b=0)
    observeEvent(input$add,{
        counts$a <- counts$a + 1
        output$prints <- renderPrint({
            cat(paste0("Number of clicking +1 :", counts$a))
        })
    })
    
    observeEvent(input$min,{
        counts$b <- counts$b + 1
        output$prints <- renderPrint({
            cat(paste0("Number of clicking -1 :", counts$b))
        })
    })
    output$distPlot <- renderImage({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins,
        # and need to create a temp file 
        outfile <- tempfile(fileext = '.png',tmpdir = '~/Documents/ShinyTrials/shiny_reactive_value_image_output/tempfile')
        png(outfile, width = 600, height = 500)
        hist(x, breaks = bins, col = 'darkgray', border = 'white',main = as.character(input$store))
        dev.off()
        
        list(src=outfile, alt="This is alternate text")
    }, deleteFile = F)
    # deleteFile = F means that we don't delete the temp file
})
