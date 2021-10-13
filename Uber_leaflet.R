library(readxl)
library(tidyr)
library(dplyr)
library(tidyverse)
library(openxlsx)
library(ggplot2)
library(leaflet)

setwd("your drive")

uber_tidy2 <- read_excel("Uber_tidy.xlsx", 3) 
uber_tidy2 <- as.data.frame(uber_tidy2)

head(uber_tidy2)

# Plotting start and end points
x <- uber_tidy2 %>% leaflet() %>%
  addProviderTiles(provider = "Esri") %>%
  addCircleMarkers(lng = ~as.numeric(end_lon), lat = ~as.numeric(end_lat), radius = 5, color = "red", stroke = FALSE, fillOpacity = 0.5) %>%
  addCircleMarkers(lng = ~as.numeric(start_lon), lat = ~as.numeric(start_lat), radius = 5, color = "blue", stroke = FALSE, fillOpacity = 0.5)
x


# Adding Polylines - Trial 1
for(i in 1:nrow(uber_tidy2)){
  y <- addPolylines(x, lat = as.numeric(uber_tidy2[i, c("start_lat", "end_lat")]), 
                       lng = as.numeric(uber_tidy2[i, c("start_lon", "end_lon")]))
}
y

# Adding Polylines - Trial 2
z<-leaflet(data=uber_tidy2)%>%addTiles()

for (i in 1:nrow(uber_tidy2)){ 
  z<-z%>%addPolylines(lat=c(uber_tidy2[i,]$start_lat,uber_tidy2[i,]$end_lat),lng=c(uber_tidy2[i,]$start_lon,uber_tidy2[i,]$end_lon), weight = 1, opacity =3) %>%
  addCircleMarkers(lng = uber_tidy2[i,]$end_lon, lat = uber_tidy2[i,]$end_lat, radius = 5, color = "red", stroke = FALSE, fillOpacity = 0.5)%>%
  addCircleMarkers(lng = uber_tidy2[i,]$start_lon, lat = uber_tidy2[i,]$start_lat, radius = 5, color = "blue", stroke = FALSE, fillOpacity = 0.5)
}

z



