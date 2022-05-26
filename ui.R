navbarPage("ICD-10-CM Diagnoses",
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
  theme = td_theme,
  tags$script(enter_to_search_js),
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
      column(6,
             textInput("t_search",NULL, value = "contusion great toe"),
             DTOutput("table_search")),
      column(6,
             actionButton("bt_add","save selected", class = "btn btn-primary btn-sm mb-2"),
             actionButton("bt_clear", "clear saved", class = "btm btn-warning btn-sm mb-2"),
             DTOutput("table_added"),
             HTML(click_to_select_alert))
    )
  ),
  tabPanel("About", includeHTML("www/about.html")),
  bslib::nav_spacer(),
  bslib::nav_item(tags$a(icon("github", class="fa-lg"), href = "https://github.com/guasi/diagnoses_shiny")),
  tags$footer(includeHTML("www/footer.html"))
)