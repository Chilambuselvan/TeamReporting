#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shinydashboard)

# Define UI for application that draws a histogram
dashboardPage(skin="yellow",
  dashboardHeader(title = "KTOC Team Reporting"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Resource Analysis", tabName = "ResAnalysis", icon = icon("balance-scale")),
      #menuItem("Market Analysis 3D", tabName = "3Dview", icon = icon("bars")),
      # menuItem("Price Analysis", tabName = "OppAnalysis", icon = icon("inr")),
      #menuItem("Data View", tabName = "DataView", icon = icon("th")),
      # menuItem("Elevator Volumes (ALL)", tabName = "ElevVolumes", icon = icon("map-marker")),
      # menuItem("Elevator Analysis", tabName = "ElevAnalysis", icon = icon("map-marker")),
      # menuItem("Price Analysis", tabName = "priceAnalysis", icon = icon("inr")),
      # menuItem("TOP SELLER", tabName = "UnitAnalysis", icon = icon("bar-chart")),
       menuItem("Missing Data", tabName = "missingSummary", icon = icon("warning"))
      # menuItem("Closed opportunities", tabName = "widgets2", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      #### Dashboard ########
      tabItem(tabName = "dashboard",
              fluidRow(
                box(title = "Dashboard",width=12,status = "warning", solidHeader = TRUE,collapsible = FALSE,collapsed = FALSE,
                    dataTableOutput("tabmissingSummary2"))
              )
      ),
      #### Resource Analysis ########
      tabItem(tabName = "ResAnalysis",
              fluidRow(
                box(width = 3,
                  selectInput(inputId = "SelWeek","Week Selected",WeeksAvail,multiple = FALSE))
                      ),
              fluidRow(
                box(title = "Weekly Analysis",width=12,status = "warning", solidHeader = TRUE,collapsible = FALSE,collapsed = FALSE,
                    dataTableOutput("tabWeeklyLoadTasks"))
              )
      ),
      #### DF summary ########
      tabItem(tabName = "missingSummary",
              fluidRow(
                box(title = "Missing Data Summary",width=12,status = "warning", solidHeader = TRUE,collapsible = FALSE,collapsed = FALSE,
                    dataTableOutput("tabmissingSummary"))
              )
      )
    )#End of Tabitems
  )
)
