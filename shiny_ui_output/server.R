library(shiny)
library(plotly)

get_numeric_variable <- function(dt){
  return(colnames(dplyr::select_if(get(dt), is.numeric)))
}

shinyServer(function(input, output){
  varis <- reactive({
    get_numeric_variable(input$data1)
  })
  
  output$vx <- renderUI({
    selectInput('x', 'Select the X Variable: ', choices = varis())
  })
  
  output$vy <- renderUI({
    selectInput('y', 'Select the Y Variable: ', choices = setdiff(varis(), input$x))
  })
  
  output$p <- renderPlotly({
     p<-ggplot(get(input$data1), aes(x=get(input$data1)[[input$x]], y=get(input$data1)[[input$y]]))+
       geom_point()+labs(x=input$x, y=input$y)
     ggplotly(p)
  })
})