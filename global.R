# Packages -----------------------------------------
library(tidyverse)
library(shiny)
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

# Global ------------------------------------------
