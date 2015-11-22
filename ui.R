library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Wine Quality Predictor"),

  # Sidebar with an app description
  sidebarLayout(
    sidebarPanel(
        h2("Directions"),
        p("Input the physiochemical properties of a wine, then click 
          \"Rate this wine!\" to get a prediction of how experts would rate the 
          wine. Have fun!"),
        img(src="wine_icon.jpg", height = 140, width = 166)
    ),

    # Show the input widgets and the predicted quality
    mainPanel(
        radioButtons("type", label = h4("Wine Color"),
                     choices = list("Red", "White"), 
                     selected = "Red"),
        
        sliderInput("alcohol", label = h4("Alcohol"), 
                    min = 0.0, 
                    max = 25.0, 
                    value = 12.5,
                    step = 0.1),
        
        numericInput("acidity", label = h4("Volatile Acidity"), value = 0.350),
        numericInput("sugar", label = h4("Residual Sugar"), value = 5.50),
        numericInput("chlorides", label = h4("Chlorides"), value = 0.045),
        numericInput("so2", label = h4("Free Sulfur Dioxide"), value = 30),
        numericInput("sulphates", label = h4("Sulphates"), value = 0.55),
        
        submitButton(text = "Rate this wine!"),
        
        h3(textOutput("quality"))
    )
  )
))