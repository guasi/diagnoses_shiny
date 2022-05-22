library(tidyverse)

# DXCCSR_v2022-1.CSV ----------------------------------------------

DXCCSR_v2022 <- read_csv("data/DXCCSR_v2022-1.CSV",
                      col_select = 1:18,
                      col_types = cols(.default = "c"),
                      name_repair = "universal",
                      na = c("", "NA","' '"))

DXCCSR_v2022 <- DXCCSR_v2022 %>% 
  rename_with(~ tolower(sub("\\.(.*)\\.$", "\\1", .x))) %>% 
  rename_with(~ gsub("(\\.)+", "_", .x)) %>% 
  rename_with(~ gsub("(default_|ccsr_|_cm)", "", .x)) %>% 
  rename_with(~ sub("(category)(_description)(_.p)", "\\1\\3\\2", .x)) %>% 
  rename_with(~ sub("(\\d|ip|op)$", "\\1_code", .x))

dxccsr_data <- DXCCSR_v2022 %>% 
  pivot_longer(cols = 3:18, 
               names_to = c("ccsr_designation",".value"), 
               names_pattern = "(.+\\d|.+ip|.+op)_(.+)",
               values_drop_na = TRUE)  %>% 
  rename(ccsr_code = code,
         ccsr_description = description) %>% 
  mutate(icd_10_code = gsub("'", "", icd_10_code),
         ccsr_code = gsub("'", "", ccsr_code)) %>% 
  mutate(ccsr_chapter = str_extract(ccsr_code,"^..."))
  

saveRDS(dxccsr_data,"data/dxccsr_data.rds")

rm(DXCCSR_v2022)

# DXCCSR_CHAPTERS.CSV---------------------------------

dxccsr_chapters <- read_csv("data/DXCCSR_CHAPTERS.CSV",
                     skip = 1,
                     name_repair = "universal")

dxccsr_chapters <- dxccsr_chapters %>% 
  rename(
    ccsr_chapter_description = ICD.10.CM.Diagnosis.Chapter,
    ccsr_chapter = ..3.Character.Abbreviation)

saveRDS(dxccsr_chapters,"data/dxccsr_chapters.rds")

