library(shiny)
options(shiny.maxRequestSize = 50 * 1024^2)

shinyServer(function(input, output, session) {
  # 用 reactiveValues 存储数据矩阵和校验状态
  data.inputs <- reactiveValues(mRNA = NULL, message = F)
  # 动态控制提交按钮状态
  observe({
    if (is.null(data.inputs$mRNA) || !isTRUE(data.inputs$message)) {
      shinyjs::disable("submit")
    } else {
      shinyjs::enable("submit")
    }
  })

  # 文件上传处理
  observeEvent(input$Expr, {
    req(input$Expr$datapath)
    df <- read.csv(input$Expr$datapath,
                   check.names = FALSE,
                   sep = input$sep)

    # 检查第一列是否为 Gene_ID
    if (!("Gene_ID" %in% colnames(df))) {
      data.inputs$message <- FALSE
      output$mRNA_msg <- renderUI({
        p(
          icon("window-close"),
          "Column names must include 'Gene_ID' to identify gene IDs.",
          style = "color:red;"
        )
      })
      return()
    }

    # 检查 Gene_ID 是否重复或为空
    if (any(duplicated(df$Gene_ID)) || any(df$Gene_ID == "")) {
      data.inputs$message <- FALSE
      output$mRNA_msg <- renderUI({
        p(
          icon("window-close"),
          "Duplicate or empty Gene_ID values are not allowed.",
          style = "color:red;"
        )
      })
      return()
    }

    # 读入数值矩阵
    mat <- as.matrix(
      read.csv(
        input$Expr$datapath,
        check.names = FALSE,
        row.names = "Gene_ID",
        sep = input$sep
      )
    )

    # 校验数值
    if (any(is.na(mat))) {
      data.inputs$message <- FALSE
      output$mRNA_msg <- renderUI({
        p(
          icon("window-close"),
          "Gene expression profile cannot contain any NA value(s).",
          style = "color:red;"
        )
      })
      return()
    }
    if (any(mat < 0, na.rm = TRUE)) {
      data.inputs$message <- FALSE
      output$mRNA_msg <- renderUI({
        p(
          icon("window-close"),
          "Gene expression profile cannot contain any negative value(s).",
          style = "color:red;"
        )
      })
      return()
    }
    if (any(colnames(mat) %in% c("SYMBOL", "ENSEMBL", "ENTREZID", "REFSEQ"))) {
      data.inputs$message <- FALSE
      output$mRNA_msg <- renderUI({
        p(
          icon("window-close"),
          "Sample names should not be 'SYMBOL', 'ENSEMBL', 'ENTREZID' or 'REFSEQ'.",
          style = "color:red;"
        )
      })
      return()
    }
    if (ncol(mat) < 2) {
      data.inputs$message <- FALSE
      output$mRNA_msg <- renderUI({
        p(icon("window-close"),
          "Sample size must be larger than one.",
          style = "color:red;")
      })
      return()
    }

    # 所有校验通过
    data.inputs$mRNA <- mat
    data.inputs$message <- TRUE
    output$mRNA_msg <- renderUI({
      p(icon("check-square"), "Data is ready to classify.", style = "color:green;")
    })

    # 显示数据预览
    output$mRNA_view <- renderTable({
      mat[1:min(4, nrow(mat)), 1:min(4, ncol(mat)), drop = FALSE]
    }, rownames = TRUE, digits = 2, bordered = TRUE, striped = TRUE)
  })

  # 分类提交
  observeEvent(input$submit, {
    # 显示处理进度弹窗
    showModal(modalDialog(tagList(
      h3(
        img(
          src = "Loading_icon.gif",
          height = "30%",
          width = "30%"
        ),
        "HNSCC molecular subtype prediction is processing...",
        align = "center",
        style = "color:black;"
      )
    ), footer = NULL, size = "l"))

    Sys.sleep(1.0)
    tryCatch({
      res <- HNSCclassifier::classifyHNSC(
        input_expr = data.inputs$mRNA,
        idType = input$idType,
        outputType = input$outputType
      )

      if (is.matrix(res)) {
        ## Probability matrix
        result_df <- as.data.frame(round(res, 3))
        result_df <- cbind(Sample = rownames(result_df), result_df)
        output$result_plot <- renderPlot({
          HNSCclassifier::plot_subtype_probabilities(res)
        })
      } else {
        ## Classification result
        result_df <- data.frame(Sample = names(res), Subtype = res)
        p <- HNSCclassifier::plot_subtype_heatmap(
          data.inputs$mRNA,
          subtype = res,
          idType = input$idType,
          silent = TRUE
        )
        output$result_plot <- renderPlot({
          p
        })
      }

      output$result_table <- DT::renderDataTable({
        DT::datatable(
          result_df,
          rownames = FALSE,
          extensions = "Buttons",
          options = list(
            paging = TRUE,
            searching = TRUE,
            scrollX = TRUE,
            dom = "Bfrtip",
            pageLength = 15,
            buttons = c("copy", "csv", "excel")
          )
        )
      })
      shinyjs::show('result_panel')

      removeModal()
    }, error = function(e) {
      removeModal()
      showModal(modalDialog(
        title = p(icon("exclamation"), strong("Error information")),
        tagList(
          h3(
            "An error occurred during classification. Please check your file and parameters.",
            style = "color:red;",
            align = "center"
          ),
          h4(as.character(e), align = "center")
        ),
        footer = NULL,
        easyClose = TRUE,
        size = "l"
      ))
    })
  })
}
)
