suppressMessages(library(shinydashboard))
# suppressMessages(library(openxlsx))
suppressMessages(library(readxl))
suppressMessages(library(tidyr))
suppressMessages(library(dplyr))
suppressMessages(library(ggmap))
suppressMessages(library(data.table))
suppressMessages(library(plotly))
suppressMessages(library(leaflet))
suppressMessages(library(htmltools))
suppressMessages(library(RColorBrewer))
suppressMessages(library(threejs))
suppressMessages(library(DT))
suppressMessages(library(shiny))


# devtools::install_github("rstudio/addinexamples", type = "source")
# install.packages("addinslist")

# if (dir.exists("D:/Official/09_Analytics/KEICRMreporting/CRMReporting/Data"))
# {
#   setwd("D:/Official/09_Analytics/KEICRMreporting/CRMReporting/Data")
# }
# 
# if (dir.exists("D:/Reporting/KEICRMreporting/CRMReporting/Data"))
# {
#   setwd("D:/Reporting/KEICRMreporting/CRMReporting/Data")
# }
# 
# if (dir.exists("C:/Analytics/TeamReporting/Data"))
# {
#   setwd("C:/Analytics/TeamReporting/Data")
# }

if (dir.exists("Y:/03_KTOC Team/00_GENERAL/04_KTOC Task Report"))
{
  setwd("Y:/03_KTOC Team/00_GENERAL/04_KTOC Task Report")
}





# if (!exists("TaskTracker"))
# {
#   # TaskTracker = read.xlsx("Y2016.xlsx",sheet = 1,startRow = 1, colNames = TRUE, detectDates = TRUE, rowNames = FALSE)
#   TaskTracker = read_excel("Y2016.xlsx",sheet = 1, col_names = TRUE, col_types = NULL)
# }
# if (!exists("Con_TimeCard"))
# {
#   TimeCardV1 = read_excel("Y2016.xlsx",sheet = 2, col_names = TRUE, col_types = NULL)
#   TimeCardV1$TaskIDFromTaskTracker=sub("_", "", TimeCardV1$TaskIDFromTaskTracker, fixed = TRUE)
#   TimeCardV2 = read_excel("Y2016.xlsx",sheet = 3, col_names = TRUE, col_types = NULL)
#   TimeCardV3 = read_excel("Y2016.xlsx",sheet = 4, col_names = TRUE, col_types = NULL)
#   Con_TimeCard = rbind(TimeCardV1,TimeCardV2,TimeCardV3)
#   rm(TimeCardV1)
#   rm(TimeCardV2)
#   rm(TimeCardV3)
#   Con_TimeCard$TaskIDFromTaskTracker=as.numeric(Con_TimeCard$TaskIDFromTaskTracker)
#  #
#   TasksCon=left_join(Con_TimeCard,TaskTracker,by=c("TaskIDFromTaskTracker"="ID"))
#   names(TasksCon) <- gsub(" ", "_", names(TasksCon))
#   names(TasksCon) <- gsub("\\.", "_", names(TasksCon))
#   TasksCon$Assigned_To_x =sapply(strsplit(TasksCon$Assigned_To_x, split=';', fixed=TRUE), function(x) (x[1]))
#   TasksCon$Assigned_To_y =sapply(strsplit(TasksCon$Assigned_To_y, split=';', fixed=TRUE), function(x) (x[1]))
#   WeeksAvail = unique(TasksCon$Week_x)
#   TasksCon$DateOfTimeSpent=as.Date(TasksCon$Start_Date_x)
# }
if (!exists("Con_TimeCard"))
{
 # TaskTracker16 = read.xlsx("Y2016.xlsx",sheet = 1,startRow = 1, colNames = TRUE, detectDates = TRUE, rowNames = FALSE)
  TaskTracker = read_excel("Y2017Reporting.xlsx",sheet = 1, col_names = TRUE, col_types = NULL)
  #TaskTracker16 = read_excel("Y2016.xlsx",sheet = 2, col_names = TRUE, col_types = NULL)


  TimeCardV1 = read_excel("Y2017Reporting.xlsx",sheet = 2, col_names = TRUE, col_types = NULL)
  # str(TaskTracker16)
  
  TaskTracker$TaskIDFromTaskTracker=sub("_", "", TaskTracker$TaskIDFromTaskTracker, fixed = TRUE)
  # TimeCardV2 = read_excel("Y2016.xlsx",sheet = 3, col_names = TRUE, col_types = NULL)
  # TimeCardV3 = read_excel("Y2016.xlsx",sheet = 4, col_names = TRUE, col_types = NULL)
  Con_TimeCard = TimeCardV1
  #Con_TimeCard = rbind(TimeCardV1,TimeCardV2,TimeCardV3)
  rm(TimeCardV1)
  # rm(TimeCardV2)
  # rm(TimeCardV3)
  Con_TimeCard$TaskIDFromTaskTracker=as.numeric(Con_TimeCard$TaskIDFromTaskTracker)
  # Con_TimeCard=subset(Con_TimeCard,Con_TimeCard$Week >=26)
  TasksCon=left_join(Con_TimeCard,TaskTracker,by=c("TaskIDFromTaskTracker"="ID"))
  

  
  names(TasksCon) <- gsub(" ", "_", names(TasksCon))
  names(TasksCon) <- gsub("\\.", "_", names(TasksCon))
  TasksCon$Assigned_To_x =sapply(strsplit(TasksCon$Assigned_To_x, split=';', fixed=TRUE), function(x) (x[1]))
  TasksCon$Assigned_To_y =sapply(strsplit(TasksCon$Assigned_To_y, split=';', fixed=TRUE), function(x) (x[1]))
  WeeksAvail = unique(TasksCon$Week_x)
  TasksCon$DateOfTimeSpent=as.Date(TasksCon$Start_Date_x)
}
  