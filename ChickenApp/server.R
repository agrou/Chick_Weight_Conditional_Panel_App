# Define server logic
shinyServer(function(input, output, session) {
        
        ## Raw data tab
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
                
                
                else if(input$ShowTime == 'time' && input$ShowID == 'chick' && input$ShowDiet == 'diet')

                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Chick %in% input$chick) %>%
                                filter(Diet %in% input$diet) %>%
                                filter(Time %in% input$time)
                
                else if(input$ShowID == 'chick')
                        
                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Chick %in% input$chick)
                
                else if(input$ShowDiet == 'diet')
                        
                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Diet %in% input$diet)
                
                else if(input$ShowTime == 'time')
                        
                        CW %>%
                                filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
                                filter(Time %in% input$time)
                
                
                
        },  style = "default", rownames = FALSE, options = list(pageLength = 15)))
        
        # output$rawplot <- renderPlot({
        #         
        #         #if(input$ShowID == 'All')
        #                 
        #         ggplot(CW, aes(Time, Weight, colour = Diet)) +
        #                         scale_x_continuous(breaks=unique(CW$Time)) +
        #                         scale_y_continuous(breaks=seq(50, 350, by = 50)) +
        #                         xlab("Time (days)") + 
        #                         ylab("Weight (grams)") +
        #                         #facet_wrap(~Diet) +
        #                         #theme(legend.position = "none") + 
        #                         geom_jitter(size = .4)
                
                
        #})
        
        ## Summaries tab
        
        output$sumtable <- DT::renderDataTable(DT::datatable({
                data <- CW_sum_stats %>%
                        filter(Diet %in% input$SumDiet) %>%
                        filter(Time %in% input$SumTime) %>%
                        arrange(Diet, Time)
        },
        style = "default", rownames = FALSE, options = list(pageLength = 15))
        %>% DT::formatRound(c('Mean', 'SD', 'Median'), digits = c(1, 2, 1)))
        
        output$sumplot <- renderPlot({
                
                CW_dat <- CW %>%
                        filter(Diet %in% input$SumDiet) %>%
                        filter(Time %in% input$SumTime)
                
                CWplot <- ggplot(CW_dat, aes(Time, Weight, colour = Diet)) +
                        scale_x_continuous(breaks=unique(CW$Time)) +
                        scale_y_continuous(breaks=seq(50, 350, by = 50)) +
                        xlab("Time (days)") + 
                        ylab("Weight (grams)") +
                        facet_wrap(~Diet) +
                        #theme(legend.position = "none") + 
                        geom_boxplot(aes(group=interaction(Time, Diet))) 
                
                CWplot
        })
        
}
)






