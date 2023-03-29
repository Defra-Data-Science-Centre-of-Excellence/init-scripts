library('shiny')


if (require('DT')) {
  tableOutput = DT::dataTableOutput
  renderTable = DT::renderDataTable
}


data = {
  cdata = system('apt list --installed', T,F,T)
  cdata = cdata[2:length(cdata)]
  cdata = as.data.frame(cdata)

  rdata = as.data.frame(installed.packages())
  
  list(
    'r_libs' = rdata,
    'bin_libs' = cdata
  )
}


ui = fluidPage(
  selectInput('lib', NULL, choices=names(data)),
  tableOutput('table')
)


server = function(input, output) {
  output$table <- renderTable(data[[input$lib]])
}


shinyApp(ui, server)
