navbarPage("ICD-10-CM Diagnoses",
  tags$script(micro_js),
  theme = shinythemes::shinytheme("cosmo"),
  
  tabPanel("Explore by Group",
    fluidRow(
      column(4,
        h3("Chapters"),
        DTOutput("table_chapter")
      ),
      column(4,
        h3("Categories"),
        DTOutput("table_category")
      ),
      column(4,
        h3("Diagnoses"),
        DTOutput("table_diagnosis")
      )
    )
  ),
  tabPanel("Explore by Search",
    textInput("t_search","Search diagnoses only"),
    DTOutput("table_search")
  ),
  tabPanel("About", includeHTML("www/about.html")),
  tags$footer(includeHTML("www/footer.html"))
)