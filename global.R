# Packages -----------------------------------------
library(shiny)
library(tidyverse)
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

# Includes ------------------------------------------

rmarkdown::render("include/about.md",
                  output_file = "about.html",
                  output_format = "html_fragment",
                  output_dir = "www",
                  run_pandoc = T)

