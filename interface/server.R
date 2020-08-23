
shinyServer(function(input, output, session) {
    
    ######
    # DATA
    ######
    
    
    
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
                menuItem("Home",icon=icon("home"),tabName = "home"),
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
                menuItem("Home",icon=icon("home"),tabName = "home"),
                menuItem("Logged in as ", badgeLabel = "Guest", badgeColor="yellow"),
                menuItem(h3("Guest Menu")),
                menuItem("Form",icon=icon("tasks"),tabName = "form"), 
                menuItem("Search",icon=icon("search"),tabName = "search"),        
                menuItem("Testing of data",icon=icon("table"),tabName = "datatest"),
                menuItem("Testing of data",icon=icon("table"),tabName = "cleanreq"),
                menuItem("Metrics",icon=icon("tasks"),tabName = "metrics1"),
                menuItem("Summary",icon=icon("book"),tabName = "summary"),
                menuItem("Documentation",icon=icon("book"),tabName = "documentation", badgeLabel = "new", badgeColor = "green"),
                menuItem("About",icon=icon("question-circle"),tabName = "about")
            )
        }
    })    
    
    # OBSERVE EVENTS ON SIDEBAR

    ######
    # TABS
    ######
    # CLEAN REQUEST TABLE
    
    cleanreq <- reqcon$find()
    # FOR NESTED LISTS WOULD NEED TO UNWIND THEM SO THEY CAN BE EDITABLE
    
    
    
    output$cleanreq_table <- DT::renderDT({
        DT::datatable(cleanreq,
                      editable = TRUE,
                      # Escape the HTML in all except 1st column (which has the buttons)
                      escape = -1,
                      options = list(
                          autoWidth = TRUE,
                          lengthMenu = c(5, 10, 15, 20),
                          columnDefs = list(
                              list(width = '200px', targets = c(1, 3)),
                              list(className = 'dt-center', targets = 1),
                              list(targets = 3,
                                   render = JS(
                                       "function(data, type, row, meta) {",
                                       "return type === 'display' && data.length > 6 ?",
                                       "'<span title=\"' + data + '\">' + data.substr(0, 6) + '...</span>' : data;",
                                       "}") 
                              ),
                              list(targets = 6,
                                   render = JS(
                                       "function(data, type, row, meta) {",
                                       "return '<div><i id=\"' + data[1] + data[2]+data[3]+'\" class=\"ui icon check circle inverted green\"></i>'",
                                       " '<i id=\"' + data[2] + '\" class=\"ui icon times circle inverted red\"></i>'",
                                       " '<i id=\"' + data[3] + '\" class=\"ui icon pause circle inverted blue\"></i>'",
                                       " '<i id=\"' + data[4] + '\" class=\"ui icon times circle inverted red\"></i></div>'",
                                       "}") 
                              ),
                              list(targets = 7,
                                   render = JS(
                                       "function(data, type, row, meta) {",
                                       "return '<div id=\"' + data + '\" class=\"ui label green\">'",
                                       " '<i id=\"' + data + '\" class=\"ui icon mail\"></i>'+data+'</div>'",
                                       "}") 
                              )                              
                          )
                      ))
    }) 
    

    proxy = dataTableProxy('cleanreq_table')
    
    observeEvent(input$cleanreq_table_cell_edit, {
        info = input$cleanreq_table_cell_edit
        str(info)
        i = info$row
        j = info$col
        v = info$value
        
        cleanreq[i, j] <<- DT::coerceValue(v, cleanreq[i, j])
        print(cleanreq)

        replaceData(proxy, cleanreq, resetPaging = FALSE)  # important
    })
    
    
    
    
    
    
    
    
    
     
    
}) #SERVER




