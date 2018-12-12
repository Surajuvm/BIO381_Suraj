# shiny app
# november 28, 2018
# JSC

# ShinApp package is an r package that build interactive web apps
# use R coding and web interactiveness to create a reactive experience 
# ui - user interface : this control/appearance the app
# server - the coding instructions for the shiny app
# control widgets: web elements that users will interact with

# library(shiny)
# # define ui 
# 
# ui <- fluidPage(
#   titlePanel(""),
#   sidebarLayout(
#     sidebarPanel(
#     ),
#     mainPanel(
#     )
#   )
# )
# 
# # define server 
# server <- function(input, output){
# } 
# 
# # run the app
# shinyApp(ui=ui, server=server)

library(shiny)

ui <- fluidPage(
  
  # add a title
  titlePanel("This is a test shiny"),
  
  #create a sidebar
  sidebarLayout(position = "right",
                sidebarPanel(
                  # add a header in side panel
                  h1("this is my first header"),
                  h2("second"),
                  h3("third"),
                  selectInput("x", label = "x", names(trees)),
                  selectInput("Y", label= "Y", names(trees))),
                mainPanel(
                  # add a header
                  h1("header"),
                  strong("this is an important text"), 
                  # add a paragraph
                  p("This is a paragraph about my graph"),
                  br(),
                  # add in an image
                  img(scr="ant.jpg", height = 75, width = 75), 
                  plotOutput("TreePlot")
                )
  )
)

server <- function(input,output){
  selectedData <- reactive({
    trees[,c(input$x, input$Y)]
  })
  
  # use render plot to add reactive element to plot 
  output$TreePlot <- renderPlot({
    
    #basic plot function that built into r 
    plot(selectedData(),
         type = "p",
         
         # change point: pch values stored plot: 21.25 - color and fill points, 19 - point 
         pch = 21.25,
         col = "black",
         bg = "blue",
         # add main title to graph
         main = "this is the title",
        
         # subtitle
         sub = "This is a good place to put a caption")
  }
  )
}

# call to shiny app
shinyApp(ui=ui, server=server)

