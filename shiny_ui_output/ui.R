library(shiny)

shinyUI(fluidPage(
  titlePanel('The dynamic renderUI and interactive plots with plotly'),
  br(),
  shinythemes::themeSelector(),
  sidebarLayout(
    sidebarPanel(
      selectInput('data1', 'Choose a dataset: ', choices = c('i','T','t'), selected = 'i'),
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