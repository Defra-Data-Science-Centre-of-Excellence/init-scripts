#install.packages(c('shiny', 'stringr', 'DT'))
library(shiny)
library(stringr)
library(DT)


data = {list(
    'r_libs' = {
      as.data.frame(installed.packages())
    },
    'apt_libs' = {
      apt = system('apt list', T,F,T)
      apt = apt[2:length(apt)]
      apt = paste0(apt, collapse='\n\r')
      apt = str_replace_all(str_replace_all(apt, '/', '\t'), ' ', '\t')
      apt = paste0('Package\tUbuntu\tVersion\tArchitecture\n', apt)
      read.table(text=apt, header=TRUE, fill=TRUE)
    },
    'dpkg_libs' = {
      # Architecture,Bugs,Conffiles,Config-Version,Conflicts,Breaks,Depends,Description,Enhances,Protected,Essential,Filename,Homepage,Installed-Size,MD5sum,MSDOS-Filename,Maintainer,Origin,Package,Pre-Depends,Priority,Provides,Recommends,Replaces,Revision,Section,Size,Source,Status,Suggests,Tag,Triggers-Awaited,Triggers-Pending,Version
      cols = 'Package\tVersion\tStatus\tArchitecture\tSection\tInstalled-Size\tSource\tMaintainer\tHomepage'
      cmd = paste0("echo '",cols,"';dpkg-query -Wf '\"${",str_replace_all(cols,'\t','}"\t\"${'),"}\"\n'|sort -n")
      read.table(text=system(cmd, T,F,T), header=TRUE)
    }
)}


ui = {fluidPage(
  selectInput('lib', NULL, choices=names(data)),
  dataTableOutput('table')
)}


server = function(input, output) {
  output$table <- renderDataTable(data[[input$lib]])
}


shinyApp(ui, server)
