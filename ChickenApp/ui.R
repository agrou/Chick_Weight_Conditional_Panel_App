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
                        
                        # selectizeInput("AppID", label = "DataVis options",
                        #                choices = c("Raw data" = "Rawdata", 
                        #                            "Sumary Stats" = "stats", 
                        #                            "About" = "about")),
                        
                        
                        menuItem("Raw data", tabName = 'Raw data', 
                                 icon = icon('table'),
                                
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
                                uiOutput("timeUi")
                                
                        )),
                        
                         menuItem("Data Summaries", tabName = "Data Summaries", 
                                 icon = icon('stats', lib = "glyphicon"),
                                  
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
                                         uiOutput("timeIDUi")
                                         
                                 )),
                                 
                        # 
                         menuItem("About", tabName = 'About', icon = icon('book'))
                        
                        
                )
        ), 
        dashboardBody(
               fluidRow(
                       tabBox(
                              
                               width = 12, height = "1000px", 
                               title = tagList(shiny::icon("balance-scale", 
                                                           lib = "font-awesome"), 
                                               strong("Explore Chicken Weight data")),
                               br(),
                               box(width = 12, title = "Raw Data", collapsible = TRUE,
                                   collapsed = TRUE,
                                   DT::dataTableOutput("Chicktable")),
                               box(width = 12, title = "Data Summaries", collapsible = TRUE, 
                                   collapsed = TRUE, 
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
                                                                        )
                        #tabPanel(tagList(icon("book", 
                                              #                       lib = "font-awesome"),
                                              #                  "About"))
                                                                        
                                                       ))
                                        
)
)



