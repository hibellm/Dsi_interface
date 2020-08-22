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
shinyServer(function(input, output, session) {
    
    
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
    
    ##################
    # NAVIGATION ITEMS
    ##################
    
    # THE DATA TASK/NOTES/MESSAGES
        
    # TASKS
    tlist<-tnmcon$find('{"type": "task"}')
    tasks <- vector("list")
    for(i in 1:nrow(tlist)) { 
        tasks[[i]] <- list(
            value = tlist[[2]][i],
            color = tlist[[3]][i],
            text = tlist[[4]][i]
        ) 
    }
    output$tasks <- renderMenu({
        titems <- lapply(tasks, function(el) {
            taskItem(value = el$value, color = el$color, text = el$text)
        })
        dropdownMenu(
            type = "tasks", badgeStatus = "danger", .list = titems
        )
    })
    
    # NOTIFICATIIONS
    nlist<-tnmcon$find('{"type": "note"}')
    notes <- vector("list")
    for(i in 1:nrow(nlist)) { 
        notes[[i]] <- list(
            icon = icon(nlist[[2]][i]),
            status = nlist[[3]][i],
            text = nlist[[1]][i]
        ) 
    }
    output$notifications <- renderMenu({
        nitems <- lapply(notes, function(el) {
            notificationItem(icon = el$icon, status = el$status, text = el$text)
        })
        dropdownMenu(
            type = "notifications", .list = nitems
        )
    })
    
    # MESSAGES
    mlist<-tnmcon$find('{"type": "msg"}')
    msg <- vector("list")
    for(i in 1:nrow(mlist)) { 
        msg[[i]] <- list(
            from = mlist[[1]][i],
            message = tags$span(tags$a(href="https://www.jira.roche.com/PLDSRD/", mlist[[2]][i])),
            icon = icon(mlist[[3]][i]),
            time = mlist[[4]][i]
        ) 
    }
    output$messages <- renderMenu({
        mitems <- lapply(msg, function(el) {
            messageItem(from = el$from, message = el$message, icon = el$icon, time = el$time)
        })
        dropdownMenu(
            type = "messages", .list = mitems
        )
    })
        
    
    ####################
    # LEFT SIDEBAR ITEMS
    ####################  
    
    output$userpanel <- renderUI({
        # DSI MEMBERS
        if (input$password == 'q') {
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
        else if (input$password != 'q') {
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
    })    
    
    # OBSERVE EVENTS ON SIDEBAR

    
    
    
}) #SERVER




