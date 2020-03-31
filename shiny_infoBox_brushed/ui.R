library(shiny)
library(shinydashboard)

shinyUI(
  dashboardPage(
    title = 'Shiny Dashborad With InfoBox and Brushed Plot',
    skin = "yellow",
    dashboardHeader(
      title = 'Shiny Dashborad With InfoBox and Brushed Plot',
      titleWidth = 600,
      # Dropdown menu for messages
      dropdownMenu(type = "messages", badgeStatus = "success",
                   messageItem("Support Team",
                               "This is the content of a message.",
                               time = "5 mins"
                   ),
                   messageItem("Support Team",
                               "This is the content of another message.",
                               time = "2 hours"
                   )
      ),
      
      # Dropdown menu for notifications
      dropdownMenu(type = "notifications", badgeStatus = "warning",
                   notificationItem(icon = icon("users"), status = "info",
                                    "5 new members joined today"
                   ),
                   notificationItem(icon = icon("warning"), status = "danger",
                                    "Resource usage near limit."
                   ),
                   notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),
                                    status = "success", "25 sales made"
                   )
      ),
      
      # Dropdown menu for tasks, with progress bar
      dropdownMenu(type = "tasks", badgeStatus = "danger",
                   taskItem(value = 20, color = "aqua",
                            "Refactor code"
                   ),
                   taskItem(value = 40, color = "green",
                            "Design new layout"
                   ),
                   taskItem(value = 60, color = "yellow",
                            "Another task"
                   )
      )
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem(text = 'InfoBox & ValueBox', tabName = 'info_box',icon=icon('info-circle')),
        menuItem(text = 'Brushed Plot', tabName = 'brushed_box',icon=icon('paint-brush')),
        menuItem(text = 'External Links', icon = icon('external-link'),
                 menuSubItem('GitHub Repo', icon = icon('github'), href = 'https://github.com/Ronlee12355/ShinyTrials/'),
                 menuSubItem('LinkedIn Profile', icon = icon('linkedin'), href = 'http://www.linkedin.com/in/ronlee12355/'),
                 menuSubItem('Quora Info', icon = icon('quora'), href = '#'))
      ),
      sidebarSearchForm(textId = 'ipt_text', buttonId = 'sub_btn', 'Input a number')
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = 'info_box',
                fluidPage(
                  h2(strong('InfoBox & ValueBox Demo')),
                  selectInput('dst', label = 'Choose a dataset: ', choices = c('trees','iris','mtcars')),
                  br(),
                  p(strong('Basic Information of Selected Dataset: ')),
                  verbatimTextOutput('data_str'),
                  fluidRow(infoBoxOutput('cols',width = 3), infoBoxOutput('rows', width = 3))
                )),
        tabItem(tabName = 'brushed_box',
                fluidRow(
                  box(fluidRow(column(width=6, selectInput('point_x', 'X Variable: ', choices = setdiff(colnames(iris),'Species'))),
                               column(width=6, selectInput('point_y', 'Y Variable: ', choices = setdiff(colnames(iris),'Species')))),
                      plotOutput('iris_point', brush = brushOpts(id='point_brush')),
                      br(),
                      column(p(strong('Selected Data Points')),
                             tableOutput(outputId = 'iris_brush'),
                             width=12),
                      title = 'Brushed Point Plot of Iris',
                      status = 'success',
                      footer = 'Powered by ggplot2',
                      solidHeader = T,
                      width = 6
                      ),
                  box(fluidRow(column(width=6, selectInput('bar_y', 'Y Variable: ', choices = setdiff(colnames(iris),'Species'))),
                               column(width=6, radioButtons('reversed','Reverse: ', choices = c('Yes'=T, 'No'=F), inline = T))),
                      plotOutput('iris_bar', click = clickOpts(id='point_click')),
                      br(),
                      p(strong('Clicked Outlier Data Points')),
                      tableOutput('iris_bar_brush'),
                      title = 'Brushed Bar Plot of Iris',
                      status = 'danger',
                      footer = 'Powered by ggplot2',
                      solidHeader = T,
                      width = 6
                  ),
                )
            )
      )
    )
  )
)