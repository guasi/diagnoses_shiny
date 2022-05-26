# Packages -----------------------------------------
library(shiny)
library(dplyr)
library(DT)

# Data ---------------------------------------------
dxccsr_data <- readRDS("data/dxccsr_data.rds") %>% 
  filter(ccsr_designation == "category_1")

dxccsr_chapters <- readRDS("data/dxccsr_chapters.rds")

# JS snippet ---------------------------------------
micro_js <- '
$(document).on("keyup", function(e) {
  if(e.keyCode == 13) {
    Shiny.onInputChange("keyPressed", Math.random());
  }
});
'

# Themes --------------------------------------------
td_theme = bslib::bs_theme(version = 5,
                           bootswatch = "sandstone",
                           font_scale = .8,
                           "table-cell-padding-y" = ".2rem")

