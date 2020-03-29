library(shiny)
library(shinydashboard)
library(plotly)

ti <- tags$a(class='header', 
             href='#', 
             icon('area-chart', class = 'fa-lg'), 
             'Shiny Dashboard With Tabs Boxs and Icons')

shinyUI(
  dashboardPage(skin = 'purple',
    dashboardHeader(title=ti,titleWidth = 500),
    dashboardSidebar(
      sidebarMenu(
        menuItem('Plotly & DataTable', tabName = 'p1', icon = icon('bar-chart')),
        menuItem('Tab Menus', tabName = 'p2', icon = icon('check')),
        menuItem('Github code', href = 'https://github.com/Ronlee12355/ShinyTrials', icon = icon('github'))
      )
    ),
    dashboardBody(
      tags$head(tags$link(rel='stylesheet', type='text/css', href='dash.css'),
                tags$title('Shiny Trials')),
      tabItems(
        tabItem(tabName = 'p1', 
          fluidRow(
            box(title = 'Line plot', status = 'info', solidHeader = T,plotlyOutput('line_plot')),
            box(title = 'Bar plot', status = 'warning', solidHeader = T,plotlyOutput('bar_plot'))
        ),
        fluidRow(
          box(title = 'Data Table', status = 'success', solidHeader = T,DT::dataTableOutput('dt_table'), width = 8),
          box(title = 'Select the variable', solidHeader = T,
              selectInput('vari', label = 'Choose the varibale you want', choices = setdiff(colnames(mtcars),'wt')), width = 4, background = "blue")
        )
        ),
        tabItem(tabName = 'p2', 
                fluidRow(
                  tabBox(width = 12,
                         tabPanel('Summary', 
                                  h4(strong('Summary Table of Iris Dataset')),
                                  verbatimTextOutput('sum_iris'),
                                  br(),
                                  h4(strong('Table Structure of Iris Dataset')),
                                  verbatimTextOutput('str_iris')),
                         tabPanel('Data Review', DT::dataTableOutput('dt_iris'), width='70%'),
                         tabPanel('Scatter Plot', plotOutput('scatter_iris')),
                         tabPanel('Check Variables Relationships', plotOutput('gg_iris'))
                         ),
                         
                )
        )
      )
    )
  )
)