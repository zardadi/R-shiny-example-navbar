# Project: airline cancellations and delays
# Author: Mohsen Zardadi
# January 2019

##################################################################################################
##################################################################################################
# The data in air.csv relate to airline cancellations and delays for the year 2008.
# You can download the air.csv dataset from
# http://rtricks4kids.ok.ubc.ca/wjbraun/DS550/air.csv.
# It is too large to fit on the regular github repository.
# In order to read the data from air.csv into R, you will need to type

#air <- read.csv("air.csv")
#summary(air)
#head(air)

############################################# data wrangling ##############################################################
###########################################################################################################################
library(dplyr)

# Exploring air data set:
summary(air)

# replace all the empty vlaues with 'Null'
air[air==""] <- NA
# checking null values
sapply(air,function(x) sum(is.na(x)))

# missing values visualizing. 
#library(Amelia)
#missmap(air, main = "Missing values vs observed")

# drop columns which are non-relevent or have the most missing values
drop <- c('DepTime', 'ArrTime', 'ActualElapsedTime', 'CRSElapsedTime','AirTime',
          'TaxiIn','TaxiOut','LateAircraftDelay', 'SecurityDelay', 'NASDelay',
          'WeatherDelay', 'CarrierDelay','TailNum', 'CancellationCode', 'CRSDepTime', 'FlightNum', 'Distance', 'Cancelled',
          'Diverted','CRSArrTime')
airdf <- air[,!(names(air)%in%drop)]


# checking missing values in the  sub-set
sapply(airdf, function(x) sum(is.na(x)))

# removing all rows with null values.
# (we may replace null values with some specific values)
airdf <- na.omit(airdf)

# checking null values

sapply(airdf, function(x) sum(is.na(x)))

# no more null values, Hooray!

# explor the data
sapply(airdf, function(x) length(unique(x)))


################################################################################################################################
###############################################################################################################################

# Now we can save new data set for shiny app.

save(airdf,file = 'airdf.RData')

# We may need subset of one specific airport
ord <- subset(airdf, Dest =="ORD")

save(ord,file = "ord.RData")
