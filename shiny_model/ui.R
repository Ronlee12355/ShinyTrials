library(shiny)
library(shinyjs)
library(shinyBS)
library(DT)

shinyUI(fluidPage(
  useShinyjs(),
  titlePanel('Shiny Trail To Display Models and Input Validation'),
  br(),
  splitLayout(
    wellPanel(
      h3('Input Validations'),
      fluidRow(
        column(textInput('name', label = 'Input your name: '), width = 4),
        column(textInput('email', label = 'Input your email: '), width = 4),
        column(passwordInput('passwd', label = "Your password: "), width = 4)
      ),
      textAreaInput('your_text', label = "Your words: "),
      actionButton('submit', label = "Submit", icon = icon('upload')),
      br(),
      tableOutput('form_table')
    ),
    wellPanel(
      h3('Hidden Models'),
      fileInput('file_input',label = "Choose a file", accept = c("text/csv","text/comma-separated-values,text/plain")),
      hidden(
        div(id="show",
          fluidRow(
            column(actionButton(inputId='to_plot', label = "Plot the data", icon = icon('line-chart')), width = 3),
            column(actionButton(inputId='dt_table', label = "See the data", icon = icon('table')), width = 3)
          )
        )
      ),
      bsModal(id='plot_model', title = "To view the plot of uploaded data", trigger = 'to_plot', plotOutput('ppp')),
      bsModal(id='dt_model', title = 'To view data table', trigger = 'dt_table', dataTableOutput('ddd'))
    )
  )
))