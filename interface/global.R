library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyFeedback)
library(shinyjs)
library(shinyWidgets)
library(mongolite)
library(DT)
library(lubridate)
library(reticulate)
library(glue)


# STATIC VARIABLES
root <- getwd()

use_python("E:/Python/Python36")


# DATABASE CONNECTIONS
# MONGODB
mcon <- mongo(collection = "metrics", db = "dsi")
tnmcon <- mongo(collection = "tsknotmsg", db = "dsi")
tlcon <- mongo(collection = "timeline", db = "dsi")
reqcon <- mongo(collection = "requests", db = "demo")
