function(input, output, session) {
  r <- reactiveValues(
    active_cats = NULL,
    active_chas = NULL
  )

  # Explore by Groups ---------------------------------
  output$table_chapter <- renderDT({
    dt <- dxccsr_data %>% 
      group_by(ccsr_chapter) %>% 
      summarise(n_ccsr_code = n_distinct(ccsr_code),
                n_icd_10_code = n()) %>% 
      left_join(dxccsr_chapters) %>%
      select(ccsr_chapter, ccsr_chapter_description, n_ccsr_code,n_icd_10_code)
    
    r$active_chas <- dt$ccsr_chapter
    
    datatable(dt,
      style = "bootstrap",
      colnames = c("CHA","Description","CATs","DIAs"),
      rownames = FALSE,
      selection = list(mode = "single", selected = 1),
      options = list(paging = F, scrollY = "500")) %>% 
      formatStyle(1:4, cursor = "pointer") %>% 
      formatStyle(2, `font-size` = "75%")
  })
  
  output$table_category <- renderDT({
    if (is.null(input$table_chapter_rows_selected)) return()
    code <- r$active_chas[input$table_chapter_rows_selected]

    dt <- dxccsr_data %>% 
      filter(ccsr_chapter == code) %>% 
      group_by(ccsr_code, ccsr_description) %>% 
      summarise(icd10 = n(), .groups = "drop")
    
    r$active_cats <- dt$ccsr_code

    datatable(dt,
      style = "bootstrap",
      colnames = c("CAT","Description","DIAs"),
      rownames = FALSE,
      selection = list(mode = "single", selected = 1),
      options = list(paging = F, scrollY = "500")) %>% 
      formatStyle(1:3, cursor = "pointer") %>% 
      formatStyle(2, `font-size` = "75%")
  })
  
  output$table_diagnosis <- renderDT({
    if (is.null(input$table_category_rows_selected)) return()
    code <- r$active_cats[input$table_category_rows_selected]
    
    dt <- dxccsr_data %>% 
      filter(ccsr_code == code) %>% 
      select(icd_10_code, icd_10_code_description)
    
    datatable(dt,
      style = "bootstrap",
      colnames = c("DIA","Description"),
      rownames = FALSE,
      selection = "none",
      options = list(paging = F, scrollY = "500")) %>% 
      formatStyle(2, `font-size` = "75%")
  })
  # Explore by Search -------------------------------
  
  output$table_search <- renderDT({
    input$keyPressed
    search_terms <- str_split(isolate(input$t_search), " ", simplify = T)
    
    dt <- dxccsr_data %>% 
      filter(Reduce("&", lapply(search_terms, grepl, icd_10_code_description, c(fixed = TRUE, ignore_case = TRUE)))) %>% 
      select(ccsr_code, ccsr_description, icd_10_code, icd_10_code_description)
    
    datatable(dt,
      style = "bootstrap",
      colnames = c("CAT", "Category Description", "DIA", "Diagnosis Description"),
      rownames = FALSE,
      selection = "none",
      options = list(searching = F))
  })
}