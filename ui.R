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
    ),
    br(),
    p("CHA = Chapter; CAT = Category; DIA = Diagnosis")
  ),
  tabPanel("Explore by Search",
    textInput("t_search","Search diagnoses only"),
    DTOutput("table_search"),
    p("CHA = Chapter; CAT = Category; DIA = Diagnosis")),
  tabPanel("About",
    includeMarkdown("include/about.md")
  )
)