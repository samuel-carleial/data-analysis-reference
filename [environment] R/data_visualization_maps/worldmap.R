library(maps)       # Provides functions that let us plot the maps
library(mapdata)    # Contains the hi-resolution points that mark out the countries.

# worldmap
map('worldHires')
map('world2Hires')

map.scale(-10,-50,relwidth = 0.15, metric = TRUE, ratio = TRUE)
map.scale(160,-40,relwidth = 0.15, metric = TRUE, ratio = TRUE)

# plot one country
map('worldHires','Italy')

# plot multiple countries
map('worldHires', c('Italy', 'Brazil', 'Wales:Anglesey'))

# plot multiple countries, and delimit longitude/latitude
map('worldHires'
    , c('UK', 'Ireland', 'Isle of Man','Isle of Wight')
    , xlim=c(-11,3)
    , ylim=c(49,60.9))	

# plot points on top of map
points(-1.615672,54.977768,col=2,pch=18, cex=5)

# world map, personalized
map(database = "worldHires"
    , resolution = 0
    , wrap = c(0, 360, NA)
    , fill = FALSE
    , col = "#6E6E6E6E"
    , cex = 5)

# increased functionality of maps
library(leaflet)

