library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyFeedback)
library(shinyjs)
library(shinyWidgets)
library(mongolite)
library(DT)
library(lubridate)


# STATIS VARIABLES
root <- getwd()


# DATABASE CONNECTIONS
# MONGODB
mcon <- mongo(collection = "metrics", db = "dsi")
tnmcon <- mongo(collection = "tsknotmsg", db = "dsi")
tlcon <- mongo(collection = "timeline", db = "dsi")

