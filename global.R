# Packages -----------------------------------------
library(shiny)
library(dplyr)
library(DT)

# Data ---------------------------------------------
dxccsr_data <- readRDS("data/dxccsr_data.rds") %>% 
  filter(ccsr_designation == "category_1")

dxccsr_chapters <- readRDS("data/dxccsr_chapters.rds")

# JS snippet ---------------------------------------
enter_to_search_js <- '$(document).on("keyup", function(e) {
  if(e.keyCode == 13) {
    Shiny.onInputChange("keyPressed", Math.random());
  }
});
'

# Themes --------------------------------------------
td_theme <- bslib::bs_theme(version = 5,
                           bootswatch = "sandstone",
                           font_scale = .8,
                           "table-cell-padding-y" = ".2rem")

# Alerts --------------------------------------------
click_to_select_alert <- "<div class='alert alert-dismissible alert-secondary'>
    <button type='button' class='btn-close' data-bs-dismiss = 'alert'></button>
    <strong>Search</strong> for a diagnosis and <strong>click</strong> on a row to select a particular result. Once selected you can save it for copying or downloading.
  </div>"