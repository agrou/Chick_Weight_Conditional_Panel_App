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
         
         dashboardHeader(title = "Chicken Weight Data Summaries", titleWidth = 320),
      
         dashboardSidebar(width = 320,
                sidebarMenu(
                        img(src='chicken-8.jpg', width = '320px'),
                        menuItem("Raw data", tabName = "Rawdata",
                                 icon = icon("balance-scale", lib = "font-awesome")),
                        menuItem("Summary Stats", tabName = "SummaryStats",
                                 icon = icon("table", lib = "font-awesome")),
                        menuItem("Graphs", tabName = "Graphs", 
                                 icon = icon("stats", lib = "glyphicon"))
                )
        ), 
        dashboardBody(
               
                tabItems(
                        tabItem(tabName = "Rawdata",
                                #fluidRow(
                                        box(width = 4, title = "Filter data",
                                            selectizeInput("ShowID", label = "Chick ID",
                                                           choices = c("Show all" = "All",
                                                             "Select chick" = "chick"), 
                                                           selected = "All"),
                                            conditionalPanel(
                                                    "input.ShowID == 'chick'",
                                                    uiOutput("chickUi")
                                            ),
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
                                                    uiOutput("timeUi")
                                            ),
                                            
                                            sliderInput("rangeWgt", "Weight Range:",
                                                        min = rWgt[1], max = rWgt[2],
                                                        value = c(rWgt[1], rWgt[2]))
                                            ),
                                        #),
                                #fluidRow(
                                        box(width = 8,
                                        title = "Table",
                                        DT::dataTableOutput("rawtable")
                                        )),
                                #),

                        tabItem(tabName = "SummaryStats",
                                
                                fluidRow(
                                        box(title = "Summary Table",
                                                dataTableOutput("Chick_table")),
                                        box(title = "Summary Plot",
                                                plotOutput("Chick_plot"))

                                )),
                        tabItem(tabName = "Graphs")#,
                        #tabItem("About")
                )
         )
 
)
)



