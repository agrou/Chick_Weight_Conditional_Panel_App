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
                
                # if(!('All' %in% input$ShowID)){
                #         data <- data %>% 
                #                 filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                #                 filter(Chick %in% input$chick) 
                #                 
                # } else if (input$ShowID == 'All'){
                #         
                #         data <- data %>% 
                #                 filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2]))
                # 
                #         } else {
                
                # if(!('All' %in% input$ShowDiet)){
                #         data <- data %>%
                #                 filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                #                 filter(Diet %in% input$diet)
                #                 
                # }
                # 
                # if(!('All' %in% input$ShowTime)){
                #         data <- data %>%
                #                 filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                #                 filter(Time %in% input$time)
                #         
                # }

                data %>% 
                        filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                        filter(Diet %in% input$diet) %>% 
                        filter(Time %in% input$time) %>% 
                        arrange(Chick, Diet, Time)
                #}
               
        },  style = "default", rownames = FALSE, options = list(pageLength = 15)))
        
}
)






