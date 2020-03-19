library(shiny)

shinyUI(fluidPage(
  titlePanel('Download Hander Demo With Update Functions Family'),
  br(),
  sidebarLayout(
    sidebarPanel(
      selectInput('data1', "Choose the data set to download", 
                  choices = c('iris', 'trees', 'ToothGrowth')),
      numericInput('num', 'Number of table to show', min = 1, value = 10),
      uiOutput('vx'),
      uiOutput('vy'),
      radioButtons('extTable', 'Table output format',choices = c("CSV"='csv', 'TXT'='txt'), inline = T),
      radioButtons('extPlot', 'Plot output format',choices = c("PNG"='png', 'PDF'='pdf','JPEG'='jpeg'), inline = T),
      helpText('Please choose the format of table and plot that you need, the download 
               buttons are placed in respective tabs'),
      h5('Powered by'),
      tags$img(src='rstudio.jpg',width='70px', height='60px'),
      
      # CSS
      tags$style('#tableDown {background-color: red; color: white}'),
      tags$style('#plotDown {background-color: red; color: white}'),
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("plot1"), downloadButton('plotDown',label="Download Plot")),
        tabPanel("Table", tableOutput("table1"), downloadButton('tableDown',label = 'Download Table'))
      )
    )
  )
))