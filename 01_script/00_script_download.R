#' ----
#' aim: project brazil roadkill
#' author: mauricio vancine
#' date: 21/11/2024
#' ----

# prepare r ---------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)
library(sf)
library(tmap)

# download data -----------------------------------------------------------

# # brazil roadkill
# download.file(url = "https://zenodo.org/records/1420508/files/LEEClab/BRAZIL_SERIES-v1.0.zip?download=1", 
#               destfile = "01_data/BRAZIL_SERIES-v1.0.zip", mode = "wb")
# 
# # unzip 
# unzip(zipfile = "01_data/BRAZIL_SERIES-v1.0.zip", exdir = "01_data")
# unzip(zipfile = "01_data/LEEClab-BRAZIL_SERIES-b06d03f/BRAZIL_ROADKILLS/DATASET/Brazil_Roadkill_DataS1.zip", 
#       exdir = "01_data")

# import ------------------------------------------------------------------

# brazil
brazil <- World %>% 
    dplyr::filter(name == "Brazil")
brazil

# brazil roadkill
brazil_roadkill <- readr::read_csv("01_data/Brazil_Roadkill_20180527.csv") %>% 
    janitor::clean_names() %>% 
    dplyr::select(-1)
brazil_roadkill

# vector
brazil_roadkill_v <- sf::st_as_sf(brazil_roadkill, coords = c("long", "lat"), crs = 4326)
brazil_roadkill_v

# map
tm_shape(brazil) +
    tm_polygons() +
    tm_shape(brazil_roadkill_v) +
    tm_dots()

# export
readr::write_csv(brazil_roadkill, "01_data/brazil_roadkill.csv")
sf::st_write(brazil_roadkill, "01_data/brazil_roadkill.gpkg")

# end ---------------------------------------------------------------------
