navbarPage("ICD-10-CM Diagnoses",
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
  theme = td_theme,
  tags$script(micro_js),
  collapsible = T,
  
  tabPanel("Explore by Group",
    fluidRow(
      column(4,
        p(strong("Chapters"), class = "text-primary"),
        DTOutput("table_chapter")),
      column(4,
        p(strong("Categories"), class = "text-primary"),
        DTOutput("table_category")),
      column(4,
        p(strong("Diagnoses"), class = "text-primary"),
        DTOutput("table_diagnosis"))
    )
  ),
  tabPanel("Explore by Search",
    fluidRow(
      column(9,
             DTOutput("table_search")),
      column(3,
             textInput("t_search","Search diagnoses", value = "contusion great toe"),
             textAreaInput("ta_added","Add selected", height = "380px"),
             actionButton("bt_add","add", class = "btn-primary btn-sm"),
             actionButton("bt_clear", "clear", class = "btn-warning btn-sm"))
    )
  ),
  tabPanel("About", includeHTML("www/about.html")),
  tags$footer(includeHTML("www/footer.html"))
)