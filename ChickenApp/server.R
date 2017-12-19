# Define server logic
shinyServer(function(input, output, session) {
        
        # output conditional panels for conditional user selection
        output$chickUi <- renderUI({
                selectizeInput("chick", "", 
                               as.factor(CW$Chick), selected = 1,
                               multiple = TRUE,
                               options = list(placeholder = "Select chick"))
        })
        
        output$dietUi <- renderUI({
                selectizeInput("diet", "",
                               as.factor(CW$Diet), selected = NULL,
                               multiple = TRUE,
                               options = list(placeholder = "Select diet"))
        })
        
        output$timeUi <- renderUI({
                selectizeInput("time", "",
                               as.factor(CW$Time), selected = NULL,
                               multiple = TRUE,
                               options = list(placehoder = "Select time"))
        })
        
        output$rawtable <- DT::renderDataTable(DT::datatable({
                
                data <- CW
                
        
                # 1. First controler: Select chicken ID
                if(input$ShowID == 'All')
                
                        data <- CW 
                
                else if(input$ShowID == 'chick') 
               
                        data <- CW %>%
                                filter(Chick %in% input$chick) 
                
                # 2. Second controler: Select diet 
                
                if(input$ShowDiet == 'All')
                        data <- CW %>%
                                filter(Chick %in% input$chick)
                else if(input$ShowDiet == 'diet' && input$ShowID == 'All')
                        data <- CW %>%
                                filter(Diet %in% input$diet)
                else if(input$ShowDiet == 'diet' && input$ShowID == 'chick')
                        data <- CW %>%
                                filter(Chick %in% input$chick) %>%
                                filter(Diet %in% input$diet)
                
                # 3. Third controler: Select time
                
                # code will be added here
                
                # 4. Fourth controler: Select range
                
                # code will be added here
               
        },  style = "default", rownames = FALSE, options = list(pageLength = 15)))
        
}
)






