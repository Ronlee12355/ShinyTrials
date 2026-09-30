------------------------------------------------------------------------
<table>
<tr>
<td valign="middle" width="170">

<img src="shiny-logo.png" alt="Shiny logo" width="137"/>

</td>
<td valign="middle">

# ShinyTrials

A collection of small Shiny applications written while learning how to build interactive web apps for bioinformatics and data analysis work. Each folder is a self-contained app built around one or two ideas — a layout, an input widget, a rendering function, a dashboard component, or a validation pattern.

These are learning exercises, not polished products. For production-quality examples, the [official Shiny site](http://shiny.rstudio.com) and the [rstudio/shiny](https://github.com/rstudio/shiny) repository are better starting points.

</td>
</tr>
</table>

## Getting started

Every app needs the `shiny` package, and a few need extra packages for dashboards, themes, or interactive graphics:

``` r
install.packages(c(
  "shiny",        # core
  "shinydashboard", "shinythemes", "shinyjs", "shinyBS",  # UI / theming
  "ggplot2", "plotly", "DT", "dplyr", "rlang", "stringr", "GGally", "car"
))
```

The cancer subtype app additionally needs `HNSCclassifier`, which is not on CRAN and has to come from its GitHub repository:

``` r
remotes::install_github("JLI-CBB/HNSCclassifier")
```

To run an app locally, either open its `ui.R` or `server.R` in RStudio and click **Run App**, or from the console:

``` r
shiny::runApp("shiny_layouts")
```

## Apps

| Folder | What it demonstrates |
|------------------------------------|------------------------------------|
| [`shiny_form_table`](shiny_form_table/) | A tour of the form-style inputs: `dateInput`, `sliderInput`, `radioButtons`, `selectInput`, `textInput`, `passwordInput` and `fileInput`. A `conditionalPanel` reveals a second radio group when "Female" is selected, and `splitLayout` places the name and password fields side by side. Values are collected into a table only after the submit button fires, using `observeEvent` to defer the render. |
| [`shiny_ui_output`](shiny_ui_output/) | Server-driven UI. The dataset selector (`iris`, `trees`, `ToothGrowth`) rebuilds both variable dropdowns through `renderUI`, and the Y dropdown excludes whatever is already chosen for X. The scatter plot is drawn with ggplot2 and handed to plotly for interactivity. |
| [`shiny_downloadhander`](shiny_downloadhander/) | Downloading results with `downloadHandler`. Users pick the table and plot export formats (CSV/TXT, PNG/PDF/JPEG), and the filename is generated from the current dataset. Also shows `updateNumericInput` reacting to a dataset change, a `tabsetPanel`, and CSS injected with `tags$style` to restyle the download buttons. |
| [`shiny_dashboard`](shiny_dashboard/) | A shinydashboard layout: `menuItem` navigation, colored `box`es with headers and status, and a `tabBox` grouping summary, data review, scatter matrix and pairwise plots of `iris`. Plots and tables are interactive via plotly and DT, driven by a `selectInput` over the `mtcars` columns. |
| [`shiny_infoBox_brushed`](shiny_infoBox_brushed/) | Dashboard chrome — message, notification and task dropdown menus in the header, plus a search form in the sidebar. In the body, `infoBox`es report the dimensions of the selected dataset, `brushedPoints` captures a brushed region of a scatter plot, and `nearPoints` captures a clicked point in a boxplot. |
| [`shiny_model`](shiny_model/) | Form validation and modal dialogs. `validate`/`need` reject empty names, malformed emails, overlong passwords and out-of-range text before the table renders. Uploading a CSV reveals a previously hidden div, whose buttons open `bsModal` dialogs for the plot and the data table. |
| [`shiny_layouts`](shiny_layouts/) | A `navlistPanel` that walks through four container layouts side by side: `sidebarLayout`, `splitLayout` with custom cell widths, `verticalLayout` and `flowLayout`. |
| [`shiny_naviBar`](shiny_naviBar/) | A `navbarPage` with fixed positioning and tabs for home, download, search and contact — a mock-up of a university admission portal login page, styled with a small custom CSS file in `www/`. |
| [`shiny_reactive_value_image_output`](shiny_reactive_value_image_output/) | Storing state across clicks with `reactiveValues` (two independent counters), and serving a PNG written to disk through `renderImage` rather than `renderPlot`. Generates the histogram with `png()`/`dev.off()` and returns the file path. |
| [`shiny_cancer_subtype_prediction`](shiny_cancer_subtype_prediction/) | A front end for the [`HNSCclassifier`](https://github.com/JLI-CBB/HNSCclassifier) package: upload a bulk expression matrix and predict head and neck squamous cell carcinoma (HNSC) molecular subtypes, returned either as subtype labels or as probabilities. Validates the uploaded matrix and only enables the submit button once it passes, shows a progress modal while classifying, and reports results as a DT table plus a plot. |

## Other files

- `shiny-logo.png` — the Shiny logo, shown at the top of this README.
- `shiny.pdf` — the Shiny cheat sheet, kept for quick reference.
- `shiny_reactive_value_image_output/tempfile/` — output directory used by the image-output app. The path is currently hard-coded in its `server.R`, so it needs updating before the app will run outside this repository's original location.
