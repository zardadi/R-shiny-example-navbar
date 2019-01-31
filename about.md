

 The data in air.csv relate to airline cancellations and delays for the year 2008. You can download the air.csv dataset from http://rtricks4kids.ok.ubc.ca/wjbraun/DS550/air.csv. It is too large to fit on the regular github repository. 
 In order to read the data from air.csv into R, you will need to type: 

air <- read.csv("air.csv")

summary(air)

head(air)

To run this shiny app, you will need to use 'ord.RData' and 'airdf.RData' data sets.

*shrinking_air_dataset.R* creates these two data sets 'ord.RData' and 'airdf.RData' from the original air.csv file. 
