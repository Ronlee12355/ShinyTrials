library(shiny)

shinyUI(fluidPage(
  # header title
  titlePanel('First try of shiny app, only for form elements'),
  br(),
  
  wellPanel(
    dateInput('date', 'Date Choose: ', startview = 'month', language = 'zh-CN'),
    sliderInput('num', 'Choose a number: ', min = 0, max = 100, value = 30),
    radioButtons('gender', 'Gender', c('Male'='m', 'Female'='f','Transgender'='trans'),inline = T),
    conditionalPanel("input.gender == 'f'",
                     radioButtons('gender1', 'Gender', c('Male'='m', 'Female'='f','Transgender'='trans'),inline = T)),
    selectInput("variable", "Variable:",
                c("Cylinders" = "cyl",
                  "Transmission" = "am",
                  "Gears" = "gear"), selected = 'am')
  ),
  
  splitLayout(
    textInput('name', 'Your name is: ', placeholder = 'Your name please'),
    passwordInput('passwd', 'Your password is: ', placeholder = 'Your password please', width = '100%')
  ),
  
  fileInput('file', 'Choose a file: ', accept = c(
    "text/csv",
    "text/comma-separated-values,text/plain",
    ".csv")
  ),
  
  br(),
  
  actionButton('submit', 'Submit Now'),
  
  tableOutput('tableOut')
))