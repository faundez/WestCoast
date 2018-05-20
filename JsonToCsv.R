# Author: Jorge Cornejo
# Date:   Jan 5, 2017
# Goal:   Take the json file from "https://www.nwfsc.noaa.gov/data/api/v1/source/trawl.catch_fact/selection.json", 
#         download it and then transform into a csv archive.

library(jsonlite)
library(RCurl)
library(data.table)
library(leaflet)
library(dplyr)

library(sp)  # vector data
# library(raster)  # raster data
# library(rgdal)  # input/output, projections
# library(rgeos)  # geometry ops
# library(spdep)  # spatial dependence

# This works if you download the file by hand.
#dataTable <- fromJSON("~/Desktop/20180105_WC_GroundFish.json", flatten=TRUE)

#An alternative is to download directle the file into R
#dataTable <- fromJSON(getURL('https://www.nwfsc.noaa.gov/data/api/v1/source/trawl.catch_fact/selection.json')) 

setwd("~/Google Drive/Personales/Patricia/WestCoast")
#write.csv(dataTable, file = "~/Desktop/20180105_WC_GroundFish.csv")


#WCsurvey <- fromJSON("C:/Users/Patricia/Box Sync/Thesis/Chapter1/R/20180105_WC_GroundFish.json", flatten=TRUE)
#write.csv(WCsurvey, file = "C:/Users/Patricia/Box Sync/Thesis/Chapter1/R/WCsurvey.csv")

wc <- fread(file="data/WCsurvey.csv")
wc <- filter(data, !is.na(longitude_dd), !is.na(latitude_dd))
which(is.na(data$longitude_dd), T)


coords = cbind(wc$longitude_dd, wc$latitude_dd)
sp = SpatialPoints(coords)
# make spatial data frame
# spdf = SpatialPointsDataFrame(coords, data)
# spdf = SpatialPointsDataFrame(sp, data)
# # promote data frame to spatial
# coordinates(data) = cbind(data$longitude_dd, data$latitude_dd)
# coordinates(data) = ~lon + lat
# # back to data
# as.data.frame(data)

plot(sp, pch=".")

temp <- wc %>% 
  filter(year==2008) %>% 
  filter(latitude_dd < 40 & latitude_dd > 35) %>% 
  mutate(popUp = paste(scientific_name, round(cpue_kg_per_ha_der, 3), sep="\n"))

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(data=temp, lng=~longitude_dd, lat=~latitude_dd, popup=~popUp, 
             clusterOptions = markerClusterOptions()
  )
m

