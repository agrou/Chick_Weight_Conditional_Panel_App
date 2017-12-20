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
                
                if(input$ShowID == 'All' && input$ShowDiet == 'All' && input$ShowTime == 'All')
                
                        data <- CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2]))
                
                else if(input$ShowID == 'chick' && input$ShowDiet == 'All' && input$ShowTime == 'All') 
               
                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Chick %in% input$chick) 
                
                else if(input$ShowDiet == 'diet' && input$ShowDiet == 'All' && input$ShowTime == 'All')

                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Diet %in% input$diet) 
                                
                else if(input$ShowDiet == 'time' && input$ShowDiet == 'All' && input$ShowTime == 'All')
                        
                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Diet %in% input$diet) 
                
                else if(input$ShowTime == 'time' || input$ShowID == 'chick' || input$ShowDiet == 'diet')

                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Chick %in% input$chick) %>%
                                filter(Diet %in% input$diet) %>%
                                filter(Time %in% input$time) 
               
                
        },  style = "default", rownames = FALSE, options = list(pageLength = 15)))
        
}
)






