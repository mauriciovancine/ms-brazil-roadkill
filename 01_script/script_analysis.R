#' ---
#' title: brazil road-kill
#' author: mauricio vancine
#' date: 2025-03-19
#' ----

# prepare r ---------------------------------------------------------------

# packages
library(tidyverse)
library(terra)
library(tmap)

# import ------------------------------------------------------------------

# brazil road-kill
brazil_road_kill <- readr::read_csv("02_data/00_raw/Brazil_Roadkill_20180527.csv") %>% 
    janitor::clean_names()
brazil_road_kill

# filter
brazil_road_kill_filter <- brazil_road_kill %>% 
    dplyr::filter(scientific_name %in% c("Didelphis albiventris", "Leopardus geoffroyi", "Myrmecophaga tridactyla"))
brazil_road_kill_filter

# sf
brazil_road_kill_filter_v <- sf::st_as_sf(brazil_road_kill_filter, coords = c("long", "lat"), crs = 4326)
brazil_road_kill_filter_v

# explore data ------------------------------------------------------------
    
# year
range(brazil_road_kill_filter$year, na.rm = TRUE)
count(brazil_road_kill_filter, year)

brazil_road_kill_filter %>% 
    filter(scientific_name == "Didelphis albiventris") %>% 
    count(year)

brazil_road_kill_filter %>% 
    filter(scientific_name == "Leopardus geoffroyi") %>% 
    count(year)

brazil_road_kill_filter %>% 
    filter(scientific_name == "Myrmecophaga tridactyla") %>% 
    count(year)

# maps --------------------------------------------------------------------

# roads
roads <- sf::st_read("02_data/00_raw/rod_trecho_rodoviario_l.shp")
roads

# br
br <- geobr::read_country(year = 2020)
br

# map
tm_shape(br) +
    tm_polygons() +
    tm_shape(brazil_road_kill_filter_v[brazil_road_kill_filter_v$scientific_name == "Didelphis albiventris", ]) +
    tm_bubbles(size = .5, fill = "cyan4")

tm_shape(br) +
    tm_polygons() +
    tm_shape(brazil_road_kill_filter_v[brazil_road_kill_filter_v$scientific_name == "Leopardus geoffroyi", ]) +
    tm_bubbles(size = .5, fill = "steelblue")

tm_shape(br) +
    tm_polygons() +
    tm_shape(brazil_road_kill_filter_v[brazil_road_kill_filter_v$scientific_name == "Myrmecophaga tridactyla", ]) +
    tm_bubbles(size = .5, fill = "tomato")

