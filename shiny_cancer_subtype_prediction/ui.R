library(shiny)
library(DT)
library(shinyjs)
library(shinythemes)

navbarPage(
  title = "HNSCclassifier",
  position = 'static-top',
  inverse = T,
  theme = shinytheme("spacelab"),
  collapsible = T,
  id = "mainNav",

  # ---------- Tab 1: Predict ----------
  tabPanel(title = "Predict", fluidPage(
    h1('HNSC molecular subtype prediction'),
    br(),
    column(
      5,
      wellPanel(
        shinyjs::useShinyjs(),
        radioButtons(
          "idType",
          "Gene ID type:",
          choices = c("SYMBOL", "ENSEMBL", "ENTREZID", "REFSEQ"),
          selected = "SYMBOL",
          inline = TRUE
        ),
        radioButtons(
          "outputType",
          "Output type:",
          choices = c("Class labels" = "class", "Probabilities" = "prob"),
          selected = "class",
          inline = TRUE
        ),
        radioButtons(
          "sep",
          "File separator",
          choices = c(Comma = ",", Tab = "\t"),
          selected = ",",
          inline = TRUE
        ),
        fileInput("Expr", "Upload your expression matrix", accept = c(".csv", ".txt")),
        uiOutput('mRNA_view'),
        uiOutput("mRNA_msg"),
        HTML(
          'Example input dataset could download <a href="HNSCclassifier_example.csv", target="_blank" download="HNSCclassifier_example.csv">HERE</a>'
        ),
        helpText(
          'Gene IDs column should be specified as \'Gene_ID\' in gene expression profiles'
        ),
        actionButton("submit", "Classify!", class = "btn-primary")
      )
    ),
    column(7,
           shinyjs::hidden(div(
             id = "result_panel",
             tabsetPanel(
               type = "pills",
               tabPanel("Classification result",
                        DT::dataTableOutput("result_table")),
               tabPanel(
                 "Visualization result",
                 plotOutput("result_plot", width = "85%")
               )
             )
           )))
  )),

  # ---------- Tab 2: Tutorial ----------
  tabPanel(
    title = "Tutorial",
    fluidPage(
      h1('Tutorial'),
      h2("1. Prepare your expression matrix"),
      tags$ul(
        tags$li("The input file must be a CSV or tab‑delimited text file."),
        tags$li(
          "The first column must be named \"Gene_ID\" and contain gene identifiers (e.g., SYMBOL, ENSEMBL, ENTREZID, REFSEQ)."
        ),
        tags$li(
          "The remaining columns are sample names, and the values must be non‑negative normalized expression values (TPM/FPKM)."
        ),
        tags$li("Missing values (NA) and negative values are not allowed."),
        tags$li(
          "Sample names should not exactly match any of the supported gene ID types (SYMBOL, ENSEMBL, ENTREZID, REFSEQ)."
        )
      ),
      br(),
      h2("2. Upload and set options"),
      p(
        "Go to the",
        strong("Predict"),
        "tab, choose your file, and specify the correct separator. Then select your gene ID type and desired output (subtype labels or probabilities)."
      ),
      br(),
      h2("3. Run classification"),
      p(
        "Click",
        strong("Classify!"),
        ". A progress indicator will appear. Once finished, the classification table will be shown. You can copy, print, or download the result using the buttons above the table."
      ),
      br(),
      h2('4. More information'),
      p(
        "For more details, see the package vignette:",
        code(
          "vignette('HNSCclassifier_intro', package='HNSCclassifier')"
        )
      )
    )
  ),

  # ---------- Tab 3: Contact ----------
  tabPanel(title = "Contact", fluidPage(
    h1("Contact"),
    p(strong("Dr. Jiang Li")),
    p("lijiang(a)suat-sz.edu.cn"),
    p(
      "Insititute of Cell and Gene Technology, Shenzhen University of Advanced Technology"
    ),
    br(),
    h1('More information'),
    p(
      "For bug reports or feature requests, please visit our",
      a("GitHub repository", href = "https://github.com/JLI-CBB/HNSCclassifier/issues"),
      "."
    )
  ))
)
