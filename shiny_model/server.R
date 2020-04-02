library(shiny)
library(shinyjs)
library(shinyBS)
library(DT)
library(ggplot2)

shinyServer(function(input, output, session){
  observeEvent(input$submit, {
    output$form_table <- renderTable({
      validate(
        need(length(input$name) != 0 , "Your name cannot be empty!!"),
        need(stringr::str_detect(input$email,'@'), "Input right email address!!"),
        need(length(input$passwd) <= 10, 'Paddword should not be larger than 10!!'),
        need(length(input$your_text) > 0 & length(input$your_text) <= 50, "Text should be with 0 to 50")
      )
      
      data.frame('name'=c('Name', 'Email', 'Password', 'Text'),
                 'value'=c(input$name, input$email, input$passwd, input$your_text),
                 stringsAsFactors = F)
    })
  })
  
  dt <- reactive({
    if(is.null(input$file_input)){
      return()
    }else{
      read.csv(input$file_input$datapath, header = T)
    }
  })
  
  observeEvent(input$file_input, {show("show")})
  
  output$ddd <- renderDataTable({
    datatable(dt())
  })
  
  output$ppp <- renderPlot({
    ggplot(dt(), aes(x=Sepal.Length, y=Sepal.Width,size=Petal.Length, color=Petal.Length))+geom_point()+theme_classic()
  })
})