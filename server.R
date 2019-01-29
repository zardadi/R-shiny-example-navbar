function(input, output, session) {
  load('ord.RData')
  library(lattice)
 
  
  output$plot5 <- renderPlot({
      load('airdf.RData')
      cutoff <- as.numeric(input$numAirport)
      # Finding all the Airports in the data set and sort them by most arrivals
      Airports <- airdf %>% group_by(Dest) %>% count(Dest)
      Airports <- Airports[order(-Airports$n),]
      # select top busiest airports by arrival
      topAirports <- Airports[1:cutoff,][1]
      top <- subset(airdf, Dest %in% topAirports$Dest)
      # removing negative arrivals
      top <- top[top$ArrDelay > 5,]
      # Arrdelay box plot for top airports
      bwplot(ArrDelay~Dest, data = top, ylim=c(0,180), do.out= FALSE, col='black', pch=20,
             xlab = "airports", ylab = "arrival delay per minute",
             main = "Arrival Delay for Top Busiest Airports")
      
      
  }) 

  output$plot1 <- renderPlot({
    cutoff <- as.numeric(input$MinDelay)
    ord <- ord[ord$ArrDelay > cutoff,]
    ord$Month <- as.factor(ord$Month)
    ord$DayOfWeek <- as.factor(ord$DayOfWeek)
    
    bwplot(ArrDelay~Month, data=ord, ylim = c(cutoff-5,(cutoff+250)), do.out=FALSE, col ='black', pch =20,
           xlab = "month", ylab="arrival delay per minute",
           main = "Arrival Flight Delays at ORD Airport")
    
  })
  output$plot2 <- renderPlot({
     season <- list('spring' = 3:5 , 'summer' = 6:8, 'fall'= 9:11 , 'winter' = c(1,2,12))   
    
      ord$season <- ifelse(ord$Month %in% season$fall, "fall", 
                         ifelse(ord$Month %in% season$winter, "winter",
                                ifelse(ord$Month %in% season$spring, "spring", "summer")))
      cutoff <- as.numeric(input$MinDelay)
      ord <- ord[ord$ArrDelay > cutoff,]
      ord$Month <- as.factor(ord$Month)
      ord$DayOfWeek <- as.factor(ord$DayOfWeek)
      
      bwplot(ArrDelay~season, data = ord, ylim = c(cutoff-5,(cutoff+230)), do.out =FALSE, col='black', pch=16,
           xlab = "seasons", ylab = "arrival delay per minute",
           main = "Arrival Flight Delays at ORD Airport per Season")
    # Winter has the most delays in Chicago airport
    
  })
  
  output$plot3 <- renderPlot({
    
    # sort ORD data by airlines 
    cutoff3 <- as.numeric(input$MinDelay3)
    airlines.ord <- ord %>% group_by(UniqueCarrier) %>% count(UniqueCarrier)
    airlines.ord <- airlines.ord[order(-airlines.ord$n),] 
    # Number of airlines 
    #nrow(airlines.ord)
    numAirlines <- as.numeric(input$num)
    topAirlines.ord <- airlines.ord[1:numAirlines,]
    #topAirlines.ord
    top.airlines <- subset(ord, UniqueCarrier %in% topAirlines.ord$UniqueCarrier)
    # removing arrival delays less than cutoff per minutes
    top.airlines <- top.airlines[top.airlines$ArrDelay > cutoff3,]
    # Arrdelay box plot for top airports
    bwplot(ArrDelay~UniqueCarrier, data = top.airlines, ylim=c(cutoff3-5,(cutoff3+250)), do.out=FALSE,
           xlab = "airline", ylab = "arrival delay per minute",
           main ="Arrival Flight Delays at ORD airport")
    # We can conclude that two airlines YV and OO have the worst delay result
    
    
  })
  output$plot4 <- renderPlot({
    # sort ORD data by airlines 
    cutoff3 <- as.numeric(input$MinDelay3)
    airlines.ord <- ord %>% group_by(UniqueCarrier) %>% count(UniqueCarrier)
    airlines.ord <- airlines.ord[order(-airlines.ord$n),] 
    # Number of airlines 
    #nrow(airlines.ord)
    numAirlines <- as.numeric(input$num)
    topAirlines.ord <- airlines.ord[1:numAirlines,]
    #topAirlines.ord
    top.airlines <- subset(ord, UniqueCarrier %in% topAirlines.ord$UniqueCarrier)
    # removing arrival delays less than cutoff per minutes
    top.airlines <- top.airlines[top.airlines$ArrDelay > cutoff3,]
    
    airline <- top.airlines %>% group_by(UniqueCarrier) %>% count(UniqueCarrier)
    airline <- airline[order(-airline$n),]
    xyplot(n~UniqueCarrier, data=airline, )
    xx <- barplot(airline$n, main = "Number of Inbound Flights per Airline at ORD Airport", las=1,
                  names.arg = airline$UniqueCarrier,
                  width = c(1,1,1,1),
                  xlab = "airline",
                  ylab = "number of flights",
                  ylim = c(0,airline$n[1]+0.1*airline$n[1]))
    text(x = xx, y = airline$n, label = round(airline$n), pos = 3, cex = 0.8, col = "black")
    
  })
 
}