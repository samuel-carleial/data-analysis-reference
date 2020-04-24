#
# EXTRACT COORDINATES AND GET MAPS
#
# Author: Samuel Carleial
# Date: May 2018
#
#
# Preliminaries -----------------------------------------------------------
# clean workspace
rm(list = ls())

# load packages and kml file (Google file for spatial data)
library(ggmap)
setwd("C:/Users/voki2/Desktop/DataAnalyses/maps")
kml_text <- readLines("meine_orte_buhumba.kml")  


# Extract information from kml file ---------------------------------------
kml_text[1:20]

# Sector IDs
ID <- grep("<name>", kml_text, value=TRUE)
ID # check if the IDs are complete or if there are extra points that need to be sorted out
ID <- ID[15:113] # to extract the sector ids only (leave out unwanted IDs)

ID <- gsub("\t\t\t<name>","", ID)
ID <- gsub("</name>","", ID)
ID # check IDs

# Coordinates (longitude and latitude)
coords <- grep("<coordinates> *([^<]+?) *<\\/coordinates>", kml_text, value = TRUE)
coords # as with IDs, check if coords. are complete or need to be filtered
coords <- coords[11:109] # filter coordinates of interest
coords

coords <- gsub("\t\t\t\t<coordinates>","", coords)
coords <- gsub("</coordinates>","", coords)
coords <- gsub(",0","", coords) # we dont need elevation information
coords

# Store the information in a matrix
kml_coordinates <- matrix(0, length(coords), 3, dimnames=list(c(),c("ID","LON","LAT")))  

# Add coordinates one by one per sector ID
for(i in 1:length(coords)){  
  lat_lon <- as.numeric(unlist(strsplit(coords[i],",")))  
  longitude <- lat_lon[1]
  latitude <- lat_lon[2]
  kml_coordinates[i,] <- matrix(c(ID[i], longitude, latitude), ncol=3)  
} 

# Check up resulting matrix
kml_coordinates

# Sort matrix by sector IDs
order <- order(kml_coordinates[,1])
kml_coordinates <- kml_coordinates[order,]
kml_coordinates

# Save coordinates
write.table(kml_coordinates,"KML_coordinates.csv",sep=";",row.names=F)
rm(list = ls())


# Getting the maps into R -------------------------------------------------
coordinates <- read.csv('KML_coordinates.csv', sep=";")
head(coordinates)

# OBSERVATION: R may give errors while downloading the maps.
# I suppose it is a Google security issue, which does not allow for multiple downloads.
# To overcome this, you may select the number of points (sectors in the for loop heading)
# Example for (id in 1:4)... it will only get the first four maps.

# Necessary points:
# c(72,78,83,73,79,84)

# example code:
# sector01a <- get_googlemap(
#   center = c(lat = coordinates[1,3], lon = coordinates[1,2])
#   ,zoom = 17
#   ,size = c(640, 320) # maximum is 640x640
#   ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
#   ,format = "png8"
#   ,color = "bw"
#   ,maptype= "satellite")
# 
# sector01b <- "sector01b"
# assign(sector01b, 
#        get_googlemap(
#          center = c(lat = coordinates[1,3], lon = coordinates[1,2])
#          ,zoom = 17
#          ,size = c(640, 320) # maximum is 640x640
#          ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
#          ,format = "png8"
#          ,color = "bw"
#          ,maptype= "satellite"
#          )
# )


# Download maps -------------------------------------------------------
# Each map is relatively heavy, and about 7MB!
# Below is a code to download all maps at intervals of ca. 4 maps/run
# Note that the sectors are ordered sequentially by number. It makes simpler for a loop to get them at once

for (i in 1:4){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 5:8){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 9:12){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 13:16){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 17:20){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 21:24){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 25:28){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 29:32){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 33:36){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 37:40){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 41:44){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 45:48){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 49:52){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 53:56){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 57:60){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 61:64){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 65:68){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 69:72){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 73:76){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 77:80){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 81:84){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 85:88){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 89:92){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 93:96){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}
for (i in 97:99){
  sector <- paste("sector", coordinates[i,1], sep="")
  assign(sector, get_googlemap(
    center = c(lat = coordinates[i,2], lon = coordinates[i,3])
    ,zoom = 17
    ,size = c(640, 320) # maximum is 640x640
    ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
    ,format = "png8"
    ,color = "bw"
    ,maptype= "satellite")
  )
}

# for specific sectors which did not load at first:
# for (i in 61:64){
#   sector <- paste("sector", coordinates[i,1], sep="")
#   assign(sector, get_googlemap(
#     center = c(lat = coordinates[i,2], lon = coordinates[i,3])
#     ,zoom = 17
#     ,size = c(640, 320) # maximum is 640x640
#     ,scale = 2          # 1, 2 or 4x the size (and it affects the labels)
#     ,format = "png8"
#     ,color = "bw"
#     ,maptype= "satellite")
#   )
# }

# clean workspace
rm(i, sector)


# Ploting maps ------------------------------------------------------------
# plots may be shown as ggplot objects

# Automatically save pictures in hard disk:
# for (i in coordinates[1:99,1]){
#   sector <- paste("sector",i,sep="")
#   tiff(filename=paste("sectors-pictures/", sector, ".tiff", sep=""),
#        width = 982, height = 506)
#   print(ggmap(get(sector), extent="panel"))
#   dev.off()
# }


# plot one single sector
ggmap(sector1, extent="panel")


# plot several pictures in RStudio
sectors <- c(1:5)
for (i in sectors){
  sector <- get(paste("sector",i,sep=""))
  print(ggmap(sector, extent="panel"))
}


# Saving and loading the maps ---------------------------------------------
# --> saving --------------------------------------------------------------

# dput(sector1, file="ggmap_sector01")
# dput(sector2, file="ggmap_sector02")
# dput(sector3, file="ggmap_sector03")
# dput(sector4, file="ggmap_sector04")
# dput(sector5, file="ggmap_sector05")
# dput(sector6, file="ggmap_sector06")
# dput(sector7, file="ggmap_sector07")
# dput(sector8, file="ggmap_sector08")
# dput(sector9, file="ggmap_sector09")
# dput(sector10, file="ggmap_sector10")
# 
# dput(sector11, file="ggmap_sector11")
# dput(sector12, file="ggmap_sector12")
# dput(sector13, file="ggmap_sector13")
# dput(sector14, file="ggmap_sector14")
# dput(sector15, file="ggmap_sector15")
# dput(sector16, file="ggmap_sector16")
# dput(sector17, file="ggmap_sector17")
# dput(sector18, file="ggmap_sector18")
# dput(sector19, file="ggmap_sector19")
# dput(sector20, file="ggmap_sector20")
# 
# dput(sector21, file="ggmap_sector21")
# dput(sector22, file="ggmap_sector22")
# dput(sector23, file="ggmap_sector23")
# dput(sector24, file="ggmap_sector24")
# dput(sector25, file="ggmap_sector25")
# dput(sector26, file="ggmap_sector26")
# dput(sector27, file="ggmap_sector27")
# dput(sector28, file="ggmap_sector28")
# dput(sector29, file="ggmap_sector29")
# dput(sector30, file="ggmap_sector30")
# 
# dput(sector31, file="ggmap_sector31")
# dput(sector32, file="ggmap_sector32")
# dput(sector33, file="ggmap_sector33")
# dput(sector34, file="ggmap_sector34")
# dput(sector35, file="ggmap_sector35")
# dput(sector36, file="ggmap_sector36")
# dput(sector37, file="ggmap_sector37")
# dput(sector38, file="ggmap_sector38")
# dput(sector39, file="ggmap_sector39")
# dput(sector40, file="ggmap_sector40")
# 
# dput(sector41, file="ggmap_sector41")
# dput(sector42, file="ggmap_sector42")
# dput(sector43, file="ggmap_sector43")
# dput(sector44, file="ggmap_sector44")
# dput(sector45, file="ggmap_sector45")
# dput(sector46, file="ggmap_sector46")
# dput(sector47, file="ggmap_sector47")
# dput(sector48, file="ggmap_sector48")
# dput(sector49, file="ggmap_sector49")
# dput(sector50, file="ggmap_sector50")
# 
# dput(sector51, file="ggmap_sector51")
# dput(sector52, file="ggmap_sector52")
# dput(sector53, file="ggmap_sector53")
# dput(sector54, file="ggmap_sector54")
# dput(sector55, file="ggmap_sector55")
# dput(sector56, file="ggmap_sector56")
# dput(sector57, file="ggmap_sector57")
# dput(sector58, file="ggmap_sector58")
# dput(sector59, file="ggmap_sector59")
# dput(sector60, file="ggmap_sector60")
# 
# dput(sector61, file="ggmap_sector61")
# dput(sector62, file="ggmap_sector62")
# dput(sector63, file="ggmap_sector63")
# dput(sector64, file="ggmap_sector64")
# dput(sector65, file="ggmap_sector65")
# dput(sector66, file="ggmap_sector66")
# dput(sector67, file="ggmap_sector67")
# dput(sector68, file="ggmap_sector68")
# dput(sector69, file="ggmap_sector69")
# dput(sector70, file="ggmap_sector70")
# 
# dput(sector71, file="ggmap_sector71")
# dput(sector72, file="ggmap_sector72")
# dput(sector73, file="ggmap_sector73")
# dput(sector74, file="ggmap_sector74")
# dput(sector75, file="ggmap_sector75")
# dput(sector76, file="ggmap_sector76")
# dput(sector77, file="ggmap_sector77")
# dput(sector78, file="ggmap_sector78")
# dput(sector79, file="ggmap_sector79")
# dput(sector80, file="ggmap_sector80")
# 
# dput(sector81, file="ggmap_sector81")
# dput(sector82, file="ggmap_sector82")
# dput(sector83, file="ggmap_sector83")
# dput(sector84, file="ggmap_sector84")
# dput(sector85, file="ggmap_sector85")
# dput(sector86, file="ggmap_sector86")
# dput(sector87, file="ggmap_sector87")
# dput(sector88, file="ggmap_sector88")
# dput(sector89, file="ggmap_sector89")
# dput(sector90, file="ggmap_sector90")
# 
# dput(sector91, file="ggmap_sector91")
# dput(sector92, file="ggmap_sector92")
# dput(sector93, file="ggmap_sector93")
# dput(sector94, file="ggmap_sector94")
# dput(sector95, file="ggmap_sector95")
# dput(sector96, file="ggmap_sector96")
# dput(sector97, file="ggmap_sector97")
# dput(sector98, file="ggmap_sector98")
# dput(sector99, file="ggmap_sector99")


# --> loading -------------------------------------------------------------

# 1-9 first plots
for(i in 1:9){
  assign(paste("sector", i, sep=""), dget(paste("sectors/ggmap_sector0", i, sep="")))
}

# remaining plots
for(i in 10:99){
  assign(paste("sector", i, sep=""), dget(paste("sectors/ggmap_sector", i, sep="")))
}


# Test area ---------------------------------------------------------------

