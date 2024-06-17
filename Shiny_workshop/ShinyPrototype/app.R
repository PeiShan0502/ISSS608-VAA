
pacman::p_load(shiny, shinydashboard, shinythemes,
               scatterPlotMatrix, parallelPlot,
               cluster, factoextra, tidyverse)

whitewine <- read_csv("data/wine_quality.csv") %>%
  filter(type == "white") %>%
  select(c(1:11))

print(whitewine)

ui <- navbarPage(
  title = "ShinyIDEA: Interactive Data Exploration and Analysis",
  fluid = TRUE,
  theme = shinytheme("flatly"),
  id = "navbarID",
  tabPanel("Introduction"),
  navbarMenu("Univariate"),
  navbarMenu("Bivariate"),
  navbarMenu("Multivariate",
             tabPanel("Scatter Plot Matrix",
                      sidebarLayout(
                        sidebarPanel(width = 3,
                                     selectInput("corrPlotTypeSelect", 
                                                 "Correlation Plot Type:",
                                                 choices = list(
                                                   "Empty" = "Empty",
                                                   "Circles" = "Circles",
                                                   "Text" = "Text",
                                                   "AbsText" = "AbsText"),
                                                 selected = "Text"),
                                     selectInput("distType",
                                                 "Distribution Representation:",
                                                 choices = list("Histogram" = 2,
                                                                "Density Plot" = 1),
                                                 selected = 1)
                                                 ),
                        mainPanel(width = 9,
                                  box(
                                    scatterPlotMatrixOutput("spMatrix",
                                                            height = "500px",
                                                            width = "640px"))
                        )
                        )),
             tabPanel("Optimal No. of Clusters"),
             tabPanel("kmeans Clustering"))
)
                    


server <- function(input, output) {
  
##### Shiny Server: Scatter Plot Matrix #####
  
  output$spMatrix <- renderScatterPlotMatrix({
    scatterPlotMatrix(whitewine,
                      distribType = as.numeric(input$distType),
                      corrPlotType = input$corrPlotTypeSelect,
                      rotateTitle = TRUE
                      )
  })


##### Shiny Server: Determining the Optimal Number of Clusters #####
  output$optimalPlot <- renderPlot({
  })

##### Shiny Server: Visual k-means Clustering #####
output$parallelPlot <- renderPlot({
  })
}

shinyApp(ui = ui, server = server)
