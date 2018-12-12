# tmap and tmaptools 
# December 5, 2018
# NAU
# package for visualizing thematic maps
# takes in rastor file and another way to visualize spatial data

library(tmap)
library(tmaptools)

# brief introduction on spatial data
# discrete spatial data - vector data - i.e. water body, country border. Most common type of vector data are shapefiles
# continuous spatial field - Raster data 
# additional variable that describe data called attributes 
# similar grammer to ggplot

# example of using a shapefile 
data(World, metro)
names(c(World, metro))

tm_shape(World) +
  tm_polygons()

tm_shape(World) +
  tm_polygons("HPI") # happy people index


tm_shape(World) +
  tm_polygons("HPI",
              style="pretty",
              palette="YlOrRd",
              id="name",
              popup.var=T,
              colorNA=NULL) +
  tm_shape(metro) + tm_dots("black")

summary(World$HPI)
happy <- c(12.78, 26.48, 44.71)

# include breaks in continuous data
tm_shape(World) +
  tm_polygons("HPI",
              breaks=happy,
              labels=c("unhappy", "happy"),
              colorNA=NULL)

tm_shape(World) +
  tm_polygons("HPI",
              breaks=happy,
              labels=c("unhappy", "happy"),
              colorNA=NULL) +
  tm_facets(by="continent")

tm_shape(World) +
  tm_polygons("HPI",
              breaks=happy,
              colorNA=NULL,
              border.col = "grey",
              border.alpha = 0.1) +
  tm_symbols(size = "well_being",
             col = "grey",
             border.lwd = NA,
             alpha = 0.5,
             shape="footprint",
             shapes.legend.fill = "blue")

# compare two or more maps
tm_shape(World) +
  tm_polygons(c("economy", "HPI"),
              palette="seq",
              breaks=happy,
              colorNA=NULL,
              border.col = "grey",
              border.alpha = 0.1) 

# examples with raster data
data(land)
names(land)

tm_shape(land) +
  tm_raster(col = "cover_cls",
            title = "Global Land Cover Classes",
            legend.hist = T,
            legend.hist.title = "Frequency of land cover classes") +

tm_shape(land) +
  tm_raster(col = "cover_cls",
            title = "Global Land Cover Classes") +
  tmap_style("col_blind") +
  tm_legend(legend.position = c("left", "bottom")) +
  tm_shape(World) + 
  tm_borders(col = "black") +
  tm_layout(scale = 0.8) +
  tm_shape(metro) +
  tm_dots("black")

# change view mode
ttm()
qtm()
last_map()  

save_tmap(filename)

# continuous raster data
tm_shape(land) +
  tm_raster(col = "trees",
            palette = "seq",
            style = "cont") +
  tm_legend(legend.position = c("left", "bottom"))

tm_shape(land) +
  tm_raster(col = "trees",
            palette = "seq",
            style = "cont",
            n=3) +
  tm_legend(legend.position = c("left", "bottom"))


