
navbar_ui <- function(id) {
  # `NS(id)` returns a namespace function, which was save as `ns` and will
  # invoke later.
  ns <- NS(id)
  
  dropdownMenu(
    type = "tasks",
    badgeStatus = "danger",
    taskItem(value = 20, color = "aqua", "Refactor code"),
    taskItem(value = 40, color = "green", "Design new layout"),
    taskItem(value = 60, color = "yellow", "Another task"),
    taskItem(value = 60, color = "yellow", "Another task"),
    taskItem(value = 60, color = "yellow", "Another task"),
    taskItem(value = 60, color = "yellow", "Another task"),
    taskItem(value = 60, color = "yellow", "Another task"),
    taskItem(value = 80, color = "red", "Write documentation")
  )
  
}


