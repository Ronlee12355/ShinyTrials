library(shiny)
library(plotly)

get_numeric_variable <- function(dt){
  return(colnames(dplyr::select_if(dt, is.numeric)))
}

shinyServer(function(input, output){
  varis <- reactive({
    switch (input$data1,
      'i' = get_numeric_variable(iris),
      't' = get_numeric_variable(trees),
      'T' = get_numeric_variable(ToothGrowth)
    )
  })
  
  dt <- reactive({
    switch (input$data1,
            'i' = iris,
            't' = trees,
            'T' = ToothGrowth
    )
  })
  
  output$vx <- renderUI({
    selectInput('x', 'Select the X Variable: ', choices = varis())
  })
  
  output$vy <- renderUI({
    selectInput('y', 'Select the Y Variable: ', choices = setdiff(varis(), input$x))
  })
  
  output$p <- renderPlotly({
     p<-ggplot(dt(), aes(x=dt()[[input$x]], y=dt()[[input$y]]))+
       geom_point()+labs(x=input$x, y=input$y)
     ggplotly(p)
  })
})