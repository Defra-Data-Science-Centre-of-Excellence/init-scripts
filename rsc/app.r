library('shiny')


if (require('DT')) {
  tableOutput = DT::dataTableOutput
  renderTable = DT::renderDataTable
}


data = {
  rdata = as.data.frame(installed.packages())
  cdata = read.csv(text=system("echo 'Package,Version,Section,Homepage,Source'; dpkg-query -Wf '${Package},${Version},${Section},${Homepage},${Source}\\n' | sort -n", T,F,T))
  
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
