navbarPage("ICD-10-CM Diagnoses",
  tags$script(micro_js),
  theme = shinythemes::shinytheme("cosmo"),
  collapsible = T,
  
  tabPanel("Explore by Group",
    fluidRow(
      column(4,
        p(strong("Chapters"), class = "text-info"),
        DTOutput("table_chapter")),
      column(4,
        p(strong("Categories"), class = "text-warning"),
        DTOutput("table_category")),
      column(4,
        p(strong("Diagnoses"), class = "text-success"),
        DTOutput("table_diagnosis"))
    )
  ),
  tabPanel("Explore by Search",
    fluidRow(
      column(9,
             DTOutput("table_search")),
      column(3,
             textInput("t_search","Search diagnoses", value = "contusion great toe"),
             hr(),
             actionButton("bt_clear", "clear box", class = "btn-warning btn-sm pull-right"),
             actionButton("bt_add","add selected", class = "btn-primary btn-sm", style = "margin-bottom:5px"),
             textAreaInput("ta_added",NULL, height = "380px"))
    )
  ),
  tabPanel("About", includeHTML("www/about.html")),
  tags$footer(includeHTML("www/footer.html"))
)