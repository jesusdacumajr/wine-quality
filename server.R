library(shiny)

source("helpers.R")

# Define server logic required to calculate wine quality
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should
  #     re-execute automatically when inputs change
  #  2) Its output type is a plot

    output$quality <- renderText({ 
        inputs <- data.frame(type = input$type,
                             volatile.acidity = input$acidity,
                             residual.sugar = input$sugar,
                             chlorides = input$chlorides,
                             free.sulfur.dioxide = input$so2,
                             sulphates = input$sulphates,
                             alcohol = input$alcohol)
        
        levels(inputs$type) <- c("white", "red")

        pred <- predict(fitSVM, inputs)
        
        paste("This wine's rating is a", round(pred, 1), "out of 10.")
    })
})