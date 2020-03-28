library(shiny)
library(plotly)

shinyServer(function(input,output, session){
  output$sum_iris <- renderPrint({
    summary(iris)
  })
  
  output$dt_iris <- DT::renderDataTable({
    DT::datatable(iris, rownames = F)
  })
  
  output$scatter_iris <- renderPlot({
    car::scatterplotMatrix(iris)
  })
  
  output$str_iris <- renderPrint({
    str(iris)
  })
  
  output$bar_plot <- renderPlotly({
    p <- ggplot(mtcars, aes(mtcars[[input$vari]]))+geom_histogram(fill="red",bins = 10)+
      labs(x=input$vari)+theme_bw()
    ggplotly(p)
  })
  
  output$line_plot <- renderPlotly({
    p <- ggplot(mtcars, aes(x=wt, y=mtcars[[input$vari]]))+
      geom_point(color="blue")+labs(x='wt', y=input$vari)+theme_classic()
    ggplotly(p)
  })
  
  output$dt_table <- DT::renderDataTable({
    DT::datatable(mtcars)
  })
  
  output$gg_iris <- renderPlot({
    suppressMessages(GGally::ggpairs(iris))
  })
})