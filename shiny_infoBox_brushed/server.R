library(shiny)
library(shinydashboard)
library(ggplot2)
library(rlang)

shinyServer(function(input, output, session){
  output$iris_point <- renderPlot({
    ggplot(iris, aes(x= !!sym(input$point_x), y=!!sym(input$point_y), color=Species))+geom_point()+theme_classic()
  })
  
  output$iris_bar <- renderPlot({
    if(input$reversed){
      ggplot(iris, aes(x=Species, y = !!sym(input$bar_y), fill=Species))+geom_boxplot(outlier.color = 'red')+coord_flip()+theme_bw()
    }else{
      ggplot(iris, aes(x=Species, y = !!sym(input$bar_y), fill=Species))+geom_boxplot(outlier.colour = 'red')+theme_bw()
    }
  })
  
  output$iris_brush <- renderTable({
    res <- brushedPoints(iris, brush=input$point_brush)
    if(nrow(res) == 0){
      return()
    }
    return(res)
  })
  
  output$iris_bar_brush <- renderTable({
    res <- nearPoints(iris, input$point_click)
    if(nrow(res) == 0){
      return()
    }
    return(res)
  })
  
  dt <- reactive({
    get(input$dst)
  })
  
  output$data_str <- renderPrint({
    str(dt())
  })
  
  output$cols <- renderInfoBox({
    infoBox(title = 'The number of features: ', value = ncol(dt()), icon = icon('line-chart'), color = 'aqua')
  })
  
  output$rows <- renderInfoBox({
    infoBox(title = 'The number of Observations: ', value = nrow(dt()), icon = icon('area-chart'), color = 'red')
  })
})

