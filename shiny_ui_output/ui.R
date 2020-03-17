library(shiny)

shinyUI(fluidPage(
  titlePanel('The dynamic renderUI and interactive plots with plotly'),
  br(),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('data1', 'Choose a dataset: ', choices = c('iris','ToothGrowth','trees'), selected = 'iris'),
      br(),
      
      helpText('Select a dataset you want and the input variables will automatically change with your selection, the output plot
               will be shown in interactive format'),
      br(),
      
      uiOutput('vx'),
      br(),
      
      uiOutput('vy')
    ),
    
    mainPanel(
      plotly::plotlyOutput('p')
    )
  )
))