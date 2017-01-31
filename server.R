
library(shiny)

library(plotly)
library(ggplot2)


Basketball_data2<-read.csv("Data/basketball_data1")
Games=Basketball_data2$GAMES
Name=Basketball_data2$NAME

basketballd=Basketball_data2[,3:17]
basketballd2=basketballd[,-6]
correlation= round(cor(basketballd2),3)
namesofb=names(basketballd2)

shinyServer(
  function(input, output, session) {
    output$Basketball = renderDataTable({
    if (input$team =="NBA"){Basketball_data2}
    else{
    
    Basketball_data2[which(Basketball_data2$TEAM==input$team),]}
  })
    
  output$teamimg = renderImage({
  filename <- normalizePath(file.path('./www',paste(input$team)))
                                                                                          
   list(src = filename,
    alt = paste("Image", input$team))
                                                              
  }, deleteFile = FALSE)
  
test= reactive({input$graph})
  
  output$chart =  renderPlotly({if (test() == "Scatter"){
  {
    bballp= data.frame(x=as.numeric(Basketball_data2[[input$x]]), y=as.numeric(Basketball_data2[[input$y]]))

    bballp2= ggplot(bballp, aes(x,y,label=Name))+geom_point(aes(color= Games))+labs(x=input$x,y=input$y)+geom_smooth()
  bballp3=ggplotly(bballp2, tooltip=c("Name","x","y","Games"), originalData = FALSE);
  print(bballp3)
  }
  }
  else{
  
    bballm= plot_ly(z=correlation,x=namesofb,y=namesofb,type = "heatmap", colors = "Reds");
    print(bballm)
    
  
  }
  })
  })