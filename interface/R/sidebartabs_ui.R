sidebartabs_ui <- function(id,inputpassword) {
  # `NS(id)` returns a namespace function, which was save as `ns` and will
  # invoke later.
  ns <- NS(id)
  
  # DSI MEMBERS
  if (ns(inputpassword) == 'q') {
    sidebarMenu(
      menuItem("Logged in as " ,badgeLabel = "DSI member", badgeColor = "blue"),
      menuItem(h3("DSI Menu")),
      menuItem("Form",icon=icon("tasks"),tabName = "form"),        
      menuItem("Search",icon=icon("search"),tabName = "search"),
      menuItem("Metrics",icon=icon("tasks"),tabName = "metrics1"),
      menuItem("Summary",icon=icon("book"),tabName = "summary"),
      menuItem("Documentation",icon=icon("book"),tabName = "documentation", badgeLabel = "new", badgeColor = "green"),
      menuItem("Deliverables",icon=icon("truck"),tabName = "deliveries"),
      menuItem("WIP",icon=icon("tasks"),tabName = "wip"),
      menuItem("Data",icon=icon("database"),tabName = "SourceData"),
      menuItem("About",icon=icon("question-circle"),tabName = "about")
    )
  }
  # GUEST
  else if (ns(inputpassword) != 'q') {
    sidebarMenu(
      menuItem("Logged in as ", badgeLabel = "Guest", badgeColor="yellow"),
      menuItem(h3("Guest Menu")),
      menuItem("Form",icon=icon("tasks"),tabName = "form"), 
      menuItem("Search",icon=icon("search"),tabName = "search"),        
      menuItem("Testing of data",icon=icon("table"),tabName = "datatest"),
      menuItem("Testing of data",icon=icon("table"),tabName = "datatest2"),
      menuItem("Metrics",icon=icon("tasks"),tabName = "metrics1"),
      menuItem("Summary",icon=icon("book"),tabName = "summary"),
      menuItem("Documentation",icon=icon("book"),tabName = "documentation", badgeLabel = "new", badgeColor = "green"),
      menuItem("About",icon=icon("question-circle"),tabName = "about")
    )
  }
  
}