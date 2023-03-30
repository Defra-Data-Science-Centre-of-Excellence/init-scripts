#install.packages(c('shiny', 'stringr', 'DT'))
library(shiny)
library(dplyr)
library(stringr)
library(DT)


data = {list(
    'r_libs' = {
      installed.packages() %>%
        as.data.frame()
    },
    'apt_libs' = {
      system('apt list', T,F,T) %>%
        .[2:length(.)] %>%
        paste0(., collapse='\n\r') %>%
        str_replace_all(., '/', '\t') %>%
        str_replace_all(., ' ', '\t') %>%
        paste0('Package\tUbuntu\tVersion\tArchitecture\n', .) %>%
        read.table(text=., header=TRUE, fill=TRUE)
    },
    'dpkg_libs' = {
      # Architecture,Bugs,Conffiles,Config-Version,Conflicts,Breaks,Depends,Description,Enhances,Protected,Essential,Filename,Homepage,Installed-Size,MD5sum,MSDOS-Filename,Maintainer,Origin,Package,Pre-Depends,Priority,Provides,Recommends,Replaces,Revision,Section,Size,Source,Status,Suggests,Tag,Triggers-Awaited,Triggers-Pending,Version
      'Package\tVersion\tStatus\tArchitecture\tSection\tInstalled-Size\tSource\tMaintainer\tHomepage' %>%
        paste0("echo '",.,"';dpkg-query -Wf '\"${",str_replace_all(.,'\t','}"\t\"${'),"}\"\n'|sort -n") %>%
        system(., T,F,T) %>%
        read.table(text=., header=TRUE)
    },
    'ubuntu' = {
      sys_read <- function (cmd, sep) {
        read.table(text=system(cmd, T,F,T), sep=sep, fill=T) %>%
          mutate(method=cmd) %>%
          select(method, variable=V1, value=V2)
      }
      rbind(
        sys_read('cat /etc/os-release', '='),
        sys_read('lsb_release -a', ':'),
        sys_read('hostnamectl', ':')
      )
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
