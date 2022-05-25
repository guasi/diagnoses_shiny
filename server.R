function(input, output, session) {

  r <- reactiveValues(
    active_cats = NULL,
    active_chas = NULL,
    active_srch = NULL,
    saved_search = NULL
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
      style = "auto",
      colnames = c("CHA","Description","CATs","DIAs"),
      rownames = FALSE,
      selection = list(mode = "single", selected = 1),
      options = list(paging = F, scrollY = "500")) %>% 
      formatStyle(1:4, cursor = "pointer") %>% 
      formatStyle(2, `font-size` = "75%")
  })
  
  output$table_category <- renderDT({
    ifelse(is.null(input$table_chapter_rows_selected),
           code <- r$active_chas[1],
           code <- r$active_chas[input$table_chapter_rows_selected])

    dt <- dxccsr_data %>% 
      filter(ccsr_chapter == code) %>% 
      group_by(ccsr_code, ccsr_description) %>% 
      summarise(icd10 = n(), .groups = "drop")
    
    r$active_cats <- dt$ccsr_code

    datatable(dt,
      style = "auto",
      colnames = c("CAT","Description","DIAs"),
      rownames = FALSE,
      selection = list(mode = "single", selected = 1),
      options = list(paging = F, scrollY = "500")) %>% 
      formatStyle(1:3, cursor = "pointer") %>% 
      formatStyle(2, `font-size` = "75%")
  })
  
  output$table_diagnosis <- renderDT({
    ifelse(is.null(input$table_category_rows_selected),
            code <- r$active_cats[1],
            code <- r$active_cats[input$table_category_rows_selected])
    
    dt <- dxccsr_data %>% 
      filter(ccsr_code == code) %>% 
      select(icd_10_code, icd_10_code_description)
    
    datatable(dt,
      style = "auto",
      colnames = c("DIA","Description"),
      rownames = FALSE,
      selection = "none",
      options = list(paging = F, scrollY = "500")) %>% 
      formatStyle(2, `font-size` = "75%")
  })
  
  # Explore by Search -------------------------------
  
  output$table_search <- renderDT({
    input$keyPressed
    search_terms <- unlist(strsplit(isolate(input$t_search), " "))
    
    dt <- dxccsr_data %>% 
      filter(Reduce("&", lapply(search_terms, grepl, icd_10_code_description, c(fixed = TRUE, ignore_case = TRUE)))) %>% 
      select(ccsr_code, ccsr_description, icd_10_code, icd_10_code_description)
    
    r$active_srch <- dt$icd_10_code
    
    datatable(dt,
      style = "auto",
      colnames = c("CAT", "Category Description", "DIA", "Diagnosis Description"),
      rownames = FALSE,
      height = 500,
      selection = "multiple",
      options = list(searching = F, search = list(search = isolate(input$t_search))))
  })
  
  observeEvent(input$bt_add, {
    r$saved_search <- c(r$saved_search, r$active_srch[input$table_search_rows_selected])
    
    text_value <- dxccsr_data %>%
      filter(icd_10_code %in% r$saved_search) %>% 
      mutate(v = paste(icd_10_code, icd_10_code_description)) %>% 
      .$v
    
    updateTextAreaInput(session,"ta_added", value = paste(text_value, collapse = "\n"))
  })
  
  observeEvent(input$bt_clear, {
    r$saved_search = NULL
    updateTextAreaInput(session,"ta_added", value = "")
  })
}