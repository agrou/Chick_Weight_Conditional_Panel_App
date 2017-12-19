This is a Shiny app with `ChickWeight` data, available in the R package `datasets`. The intention is to use `Shiny::conditionalPanel` function, which incorporates a JavaScript expression, to manage user experience dependent on user interactions. 

This app is based on the `Chick_Weight_Basic_App`, developed by @saghirb and published in the following repository: https://github.com/saghirb/Chick_Weight_Basic_App 

To run `ChickWeight` app, run the following code in R console:

shiny::runGitHub("Chick_Weight_Conditional_Panel_App", "agrou", subdir = "ChickenApp")

