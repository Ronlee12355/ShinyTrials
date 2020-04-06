library(shiny)
library(ggplot2)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$distPlot <- renderPlot({
        hist(rnorm(input$obs), col = "blue")
    })
    
    output$plot1 <- renderPlot({
      barplot(table(iris$Species), col = rainbow(3))
    })
    
    output$plot2 <- renderPlot({
      ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species))+
        geom_point()+theme_classic()
    })
})
