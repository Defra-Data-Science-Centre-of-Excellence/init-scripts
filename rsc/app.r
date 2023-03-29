library('shiny')


if (require('DT')) {
  tableOutput = DT::dataTableOutput
  renderTable = DT::renderDataTable
}


data = {list(
    'r_libs' = {
      as.data.frame(installed.packages())
    },
    'apt_libs' = {
      apt = system('apt list', T,F,T)
      apt = apt[2:length(apt)]
      as.data.frame(apt)
    },
    'dpkg_libs' = {
      read.csv(text=system("echo 'Package,Version,Section,Homepage,Source'; dpkg-query -Wf '${Package},${Version},${Section},${Homepage},${Source}\\n' | sort -n", T,F,T))
    }
)}



ui = fluidPage(
  selectInput('lib', NULL, choices=names(data)),
  tableOutput('table')
)


server = function(input, output) {
  output$table <- renderTable(data[[input$lib]])
}


shinyApp(ui, server)
