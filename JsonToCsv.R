# Author: Jorge Cornejo
# Date:   Jan 5, 2017
# Goal:   Take the json file from "https://www.nwfsc.noaa.gov/data/api/v1/source/trawl.catch_fact/selection.json", 
#         download it and then transform into a csv archive.

library(jsonlite)
library(RCurl)

# This works if you download the file by hand.
#dataTable <- fromJSON("~/Desktop/20180105_WC_GroundFish.json", flatten=TRUE)

#An alternative is to download directle the file into R
# dataTable <- fromJSON(getURL('https://www.nwfsc.noaa.gov/data/api/v1/source/trawl.catch_fact/selection.json'))
# write.csv(dataTable, file = "~/Desktop/20180105_WC_GroundFish.csv")

WCsurvey <- fromJSON("C:/Users/Patricia/Box Sync/Thesis/Chapter1/R/20180105_WC_GroundFish.json", flatten=TRUE)
write.csv(WCsurvey, file = "C:/Users/Patricia/Box Sync/Thesis/Chapter1/R/WCsurvey.csv")

