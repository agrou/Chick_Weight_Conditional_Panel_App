#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

## Questions: 
### 1. Which is the diet with more efficient weight gain?
### 2. Which is the time with higher weight gain from baseline?

## This ShinyApp presents tables with summary statistics of the Chicken's weight,
# for each diet. It is possible to filter the data by Time and compare the values
# in different times.


# Define UI 
shinyUI(dashboardPage(
         skin = "black",
         
         dashboardHeader(title = "Chicken Weight App", titleWidth = 250),
      
         dashboardSidebar(width = 250,
                sidebarMenu(id = "tabs",
                            
                        img(src='chicken-8.jpg', width = '250px'),
                        menuItem("Raw data", tabName = "RawData", startExpanded = FALSE, 
                                 icon = icon('table')),
                        conditionalPanel("input.tabs === 'RawData'",
                                         selectizeInput("ShowID", label = "Chick ID",
                                                        choices = c("Show all" = "All",
                                                                    "Select chick" = "chick"),
                                                        selected = "All"),
                                         conditionalPanel(
                                                 "input.ShowID == 'chick'",
                                                 uiOutput("chickUi")
                                         ),
                                         sliderInput("rangeWgt", "Weight Range:",
                                                     min = rWgt[1], max = rWgt[2],
                                                     value = c(rWgt[1], rWgt[2])),
                                         
                                         selectizeInput("ShowDiet", label = "Diet",
                                                        choices = c("Show all" = "All",
                                                                    "Select diet" = "diet"),
                                                        selected = "All"),
                                         conditionalPanel(
                                                 "input.ShowDiet == 'diet'",
                                                 uiOutput("dietUi")
                                         ),
                                         
                                         selectizeInput("ShowTime",
                                                        label = "Time (days)",
                                                        choices = c("Show all" = "All",
                                                                    "Select time" = "time"),
                                                        selected = "All"),
                                         conditionalPanel(
                                                 "input.ShowTime == 'time'",
                                                 uiOutput("timeUi"))
                        ),
                        menuItem("Data Summaries", tabName = "DataSummaries", icon = icon('stats', lib = "glyphicon")),
                        conditionalPanel("input.tabs === 'DataSummaries'",
                                         selectizeInput("DietID", label = "Diet",
                                                        choices = c("Show all" = "All",
                                                                    "Select diet" = "dietID"),
                                                        selected = "All"),
                                         conditionalPanel(
                                                 "input.DietID == 'dietID'",
                                                 uiOutput("dietIDUi")
                                         ),
                                         selectizeInput("TimeID",
                                                        label = "Time (days)",
                                                        choices = c("Show all" = "All",
                                                                    "Select time" = "timeID"),
                                                        selected = "All"),
                                         conditionalPanel(
                                                 "input.TimeID == 'timeID'",
                                                 uiOutput("timeIDUi"))
                                                 
                                         ),
                        menuItem("Help", tabName = "Rhelp",
                                icon = icon('book'))

                )
        ), 
        dashboardBody(
               #fluidRow(
                tabItems(
                        tabItem(tabName = "RawData", 
                                fluidRow(
                                        box(width = 12,
                                        h3(icon("balance-scale", lib = "font-awesome"), 
                                           strong("Explore Chick Weight data"), 
                                           align = "center"), br(), br(),
                                        DT::dataTableOutput("Chicktable")))
                                ),
                        tabItem(tabName = "DataSummaries",
                                fluidRow(
                                box(width = 12, 
                                    title = h3(icon("table", lib = "font-awesome"), 
                                                           strong("Data Summaries"), 
                                               align = "center"), collapsible = TRUE, 
                                    collapsed = TRUE, br(), br(),
                                    dataTableOutput("sumtable")), 
                                box(width = 4, title = "Plot options", 
                                    radioButtons("plotType", "Plot type:", 
                                                 choices = c("All diets in one plot", "Plot diets separately"), 
                                                 selected = c("All diets in one plot"),
                                                 inline = FALSE), 
                                    checkboxGroupInput("plotShow", label = "Show:", 
                                                       choices = c("Scatter Plot", "Mean Lines", "Box-Whisker Plot"), 
                                                       selected = c("Scatter Plot", "Mean Lines")
                                    )),
                                box(width = 8, title = "Summary Plot", plotlyOutput("sumplot"))
                        
                        )),
                        tabItem(tabName = "Rhelp", box(width = 12,
                                title = h3(icon("book"), strong("R help()"), 
                                           align = "center"), htmlOutput("RHelp"))))
                          
                                        
)
)
)



