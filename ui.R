library(leaflet)
library(dplyr)


navbarPage("Navbar!",
           tabPanel("Airports",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput("numAirport","Number of busiest airports cutoff:", "10", min = 1, max = 50 )
                      ),
                      mainPanel(
                        plotOutput("plot1")
                       
                      )
                    )
           ),           
           tabPanel("ORD Airport",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput("MinDelay","Minimum delay cutoff:", "5", min = -5, max = 20 )
                      ),
                      mainPanel(
                        plotOutput("plot2"),
                        plotOutput("plot3")
                      )
                    )
           ),
           tabPanel("Airlines",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput("MinDelay3","Minimum delay cutoff:", "5", min = -5, max = 20 ),
                        sliderInput("num","Number of Airlines:", "15", min = 1, max = 15 )
                      ),
                      mainPanel(
                        plotOutput("plot4"),
                        plotOutput("plot5")
                      )
                    )
           )
)