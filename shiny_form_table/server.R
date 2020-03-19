library(shiny)
library(plotly)
shinyServer(function(input, output){
  # output$tableOut <- renderTable({
  #   if(input$submit == 0){
  #     return()
  #   }
  #   
  #   isolate({
  #     data.frame(
  #       'Name' = c('Date', "Number", "Name", "Password","Gender","Variable",'File'),
  #       'Value' = c(as.character(input$date), input$num, input$name, input$passwd, input$gender,input$variable,as.character(input$file$name)),
  #       stringsAsFactors = F
  #     )
  #   })
  # })
  
  observeEvent(input$submit, {
    output$tableOut <- renderTable({
      data.frame(
        'Name' = c('Date', "Number", "Name", "Password","Gender","Variable",'File'),
        'Value' = c(as.character(input$date), input$num, input$name, input$passwd, input$gender,input$variable,as.character(input$file$name)),
        stringsAsFactors = F
      )
    })
  })
})