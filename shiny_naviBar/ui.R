library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    tags$head(tags$link(type="text/css", rel="stylesheet", href="header.css"),
              tags$title('Login Page for Registered Applicants / Current CityU Staff / Current CityU Students')),
    navbarPage(title="Login Page for Registered Applicants",position = 'fixed-top', inverse = T, 
               tabPanel('Home', icon = icon('home'),
                   titlePanel('Admission Application System Of City University of Hong Kong'),
                   br(),
                   wellPanel(
                       p('Suspension of Services in Admission Application System for System Maintenance', class="red"),
                       p('Please be informed that the following services will be temporarily suspended from 9:00 am to 2:00 pm on 13 April 2020 (Monday) due to system maintenance:'),
                       p('- Online Payment of Application/Acceptance Fee Service'),
                       p('We apologize for any inconvenience caused by the system suspension. If you have any queries, please contact us during office hours.')
                   ),
                   textInput('name', label = 'Electronic ID:'),
                   passwordInput('passwd', label = 'Password:'),
                   actionButton('login', label = 'Login'),
                   br(),
                   h5('* To protect your privacy, please press the "exit" button and close your browser when you have finished.', class="bold"),
                   hr(),
                   br(),
                   h5('[',a(' Personal Information Collection Statement', href="#"),'|',
                      a(' Forgot Electronic ID or Password', href="#"),'|',
                      a(' CityU Homepage ', href="#"),']', class="center"),
               ),
               
               tabPanel('Download', icon=icon('download')),
               
               tabPanel('Search', icon=icon('search')),
               
               tabPanel('Contact', icon = icon('user'),
                        h2('Contact Us'),
                        h3('Contact the respective offices if you have enquiries about admission to CityU programmes.'),
                        br(),
                        # bachelar
                        h4('Bachelor\'s Degree Programmes and Government-funded Associate Degree Programmes',class='bold'),
                        p('Admissions Office'),
                        p('Frequently Asked Questions: FAQ'),
                        p('Enquiry hotline: (852) 3442 9094 (during service hours)'),
                        p('Online enquiry: ', a('Online Enquiry Form', href="https://www.admo.cityu.edu.hk/content.cfm?category=enquiry&page=home")),
                        p('To apply: ', a('www.admo.cityu.edu.hk/apply', href='https://www.admo.cityu.edu.hk/apply')),
                        br(),
                        #Msc
                        h4('Taught Postgraduate Programmes',class='bold'),
                        p('Chow Yei Ching School of Graduate Studies'),
                        p('URL: ', a(href='https://www.cityu.edu.hk/sgs/tpg/admission')),
                        p('Enquiry hotline: (852) 3442 5588'),
                        p('Online enquiry: ', a('Online Enquiry Form', href="https://www.cityu.edu.hk/pg/enquiries")),
                        br(),
                        
                        h4(a('Privacy Policy', href="#"),'|',
                           a('Copyright', href="#"),'|',
                           a('Disclaimer', href="#")),
                        helpText('The information provided is subject to ongoing review. The University reserves the right to amend the information from time to time.'),
                        helpText('Best Viewed with resolution of 1024 x 768 (or higher) and supports Internet Explorer 8+, Mozilla Firefox 3.5+, Google Chrome and Safari.'),
                        helpText('© 2017 City University of Hong Kong. All Rights Reserved.')
                        
               )
    )
))
