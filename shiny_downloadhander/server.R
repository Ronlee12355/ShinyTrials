library(shiny)
library(dplyr)

shinyServer(function(input, output, session){
  dt <- reactive({
    switch (input$data1,
      'iris' = colnames(select_if(get(input$data1), is.numeric)),
      'trees' = colnames(select_if(get(input$data1), is.numeric)),
      'ToothGrowth' = colnames(select_if(get(input$data1), is.numeric))
    )
  })
  
  observeEvent(input$data1, {
    updateNumericInput(session, 'num', value = ceiling(nrow(get(input$data1))/10), max = nrow(get(input$data1)))
  })
  
  output$vx <- renderUI({
    selectInput('x', "X axis variable", choices = dt())
  })
  
  output$vy <- renderUI({
    selectInput('y', "Y axis variable", choices = setdiff(dt(), input$x))
  })
  
  output$table1 <- renderTable({
    head(get(input$data1), n= input$num)
  })
  
  output$plot1 <- renderPlot({
    plot(x=get(input$data1)[[input$x]], y=get(input$data1)[[input$y]], 
         type = "p", xlab = input$x, ylab = input$y)
  })
  
  # download code
  output$plotDown <- downloadHandler(
    filename = function(){
      paste0(input$data1, '.',input$extPlot)
    },
    content = function(file){
      if(input$extPlot == 'pdf'){
        pdf(file)
      }else if(input$extPlot == 'png'){
        png(file)
      }else{
        jpeg(file)
      }
      plot(x=get(input$data1)[[input$x]], y=get(input$data1)[[input$y]], 
           type = "p", xlab = input$x, ylab = input$y)
      dev.off()
    }
  )
  
  output$tableDown <- downloadHandler(
    filename = function(){
      paste0(input$data1, '.',input$extTable)
    },
    content = function(file){
      if(input$extTable == 'csv'){
        write.csv(get(input$data1), file, sep = ',', col.names = T, row.names = F, quote = F)
      }else{
        write.table(get(input$data1), file, sep = '\t', col.names = T, row.names = F, quote = F)
      }
    }
  )
})