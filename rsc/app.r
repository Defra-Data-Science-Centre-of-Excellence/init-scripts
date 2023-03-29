library('shiny')

if (require('DT')) {
  tableOutput = DT::dataTableOutput
  renderTable = DT::renderDataTable
}

data = as.data.frame(installed.packages())

ui = {
  tableOutput('table')
}

server = function(input, output) {
  output$table <- renderTable(data)
}

shinyApp(ui, server)
