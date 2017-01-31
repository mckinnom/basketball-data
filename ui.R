
library(shiny)

library(plotly)
library(ggplot2)

Basketball_data3<-read.csv("Data/basketball_data1")
namesofdata=names(Basketball_data3)
namesofdata1=namesofdata[-c(1,2)]

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
  
  # Application title
  "2017 NBA STATISTICS",
  tabPanel("Home",
  
  
  fluidRow(
    column(9,
       imageOutput("teamimg", width = "1%", height = "1%")
    ),
    column(3,
              selectInput("team", label = "Team", choices = c("NBA", as.character(unique(Basketball_data3$TEAM))) 
    
  )
),
fluidRow(
  column(12,
           dataTableOutput("Basketball"))
)
)
),
tabPanel("Interactive Graphs",
         fluidRow(
         column
           (12,
             radioButtons("graph", label = "Select Graph Type",
                          choices = c("Scatter","Heatmap")))),
                          
          
         fluidRow(column(12,
           plotlyOutput("chart")
                       )
           ),
         fluidRow(column
                  (4,
                    selectInput("x", label = "X-axis for Scatter Plot", choices = namesofdata1)),
                    column
                    (8,
                      selectInput("y", label = "Y-axis for Scatter Plot", choices = namesofdata1)
                      
                    )))
         )
)

