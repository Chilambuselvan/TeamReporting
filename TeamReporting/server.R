#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  
  #######################DataFrame_Summary################ Weekly Load Tasks
  #DataFrame for Closed Opp  & selected Market 
  reactdataWorkHrs=reactive({
    TasksCon%>%
      filter(Week_x==input$SelWeek & Leave_Permission=="NOT APPLICABLE")%>%
      group_by(KTOC_Stream,Assigned_To_x)%>%
      summarise(WorkHours=sum(HoursTaken_x,na.rm = TRUE))
  })
  reactdataOffHrs=reactive({
    TasksCon%>%
      filter(Week_x==input$SelWeek & Leave_Permission!="NOT APPLICABLE")%>%
      group_by(Assigned_To_x)%>%
      summarise(WorkHours=sum(HoursTaken_x,na.rm = TRUE))
  })
  reactdataDays=reactive({
    tabfilt=TasksCon%>%
      filter(Week_x==input$SelWeek & Leave_Permission=="NOT APPLICABLE")
  })
  output$tabWeeklyLoadTasks = renderDataTable({
    Weekly_table_temp=left_join(reactdataWorkHrs(),reactdataOffHrs(),by=c("Assigned_To_x"="Assigned_To_x"))
    Weekly_table_temp[is.na(Weekly_table_temp)] = 0
    #retrive workdays & max occured days
    tabWorkDays=aggregate(DateOfTimeSpent ~ Assigned_To_x, reactdataDays(), function(x) length(unique(x)))
    Weekly_table=left_join(Weekly_table_temp,tabWorkDays,by=c("Assigned_To_x"="Assigned_To_x"))
    MaxWorkDays=tail(names(sort(table(tabWorkDays$DateOfTimeSpent))), 1)
    rm(tabWorkDays)
    Weekly_table$Effeciency= paste0(round(Weekly_table$WorkHours.x/(Weekly_table$DateOfTimeSpent*8.5)*100,0),"%")
    datatable(Weekly_table,filter="none",class = 'cell-border stripe',rownames = FALSE,
              options = list(pageLength=25),
              colnames = c('STREAM', 'Name', 'Work Hours','Off Work Hours','No.Of Work Days','Efficiency'))
  })
  
  #######################DataFrame_Summary################ tabmissingSummary
  output$tabmissingSummary = renderDataTable({
    missing.summary <- sapply(TasksCon, function(x) sum(is.na(x))) 
    indexs.missing <- sapply(TasksCon, function(x) sum(is.na(x))) > 0 
    num.variable.missing <- length(missing.summary[indexs.missing])
    
    freq.table.miss <- data.frame( Variable = names(missing.summary[indexs.missing]), Number.of.Missing = as.integer(missing.summary[indexs.missing]), 
                                   Percentage.of.Missing = paste0(round(as.numeric(prop.table(missing.summary[indexs.missing]))*100,2)," %") )
    
    freq.table.miss <- freq.table.miss %>% 
      select(Variable:Percentage.of.Missing) %>%
      arrange(desc(Number.of.Missing))
    
    datatable(freq.table.miss)
  })
  
})
