
# UI INTERFACE USES SHINYDASHBOARDPLUS TO GIVE BETTEER CONTROL OF THE WHOLE INTERFACE
# https://rinterface.github.io/shinydashboardPlus/reference/index.html


dashboardPagePlus(
    enable_preloader = TRUE,
    dashboardHeaderPlus(
        title=HTML("<i class='ui icon red dragon'></i>  DSI Portal"),

        left_menu = tagList(
            dropdownBlock(
                id = "mydropdown",
                title = "Dropdown 1",
                icon = "sliders",
                sliderInput(
                    inputId = "n",
                    label = "Number of observations",
                    min = 10, max = 100, value = 30
                ),
                prettyToggle(
                    inputId = "na",
                    label_on = "NAs kept",
                    label_off = "NAs removed",
                    icon_on = icon("check"),
                    icon_off = icon("remove")
                )
            ),
            dropdownBlock(
                id = "mydropdown2",
                title = "Dropdown 2",
                icon = "sliders",
                prettySwitch(
                    inputId = "switch4",
                    label = "Fill switch with status:",
                    fill = TRUE,
                    status = "primary"
                ),
                prettyCheckboxGroup(
                    inputId = "checkgroup2",
                    label = "Click me!",
                    thick = TRUE,
                    choices = c("Click me !", "Me !", "Or me !"),
                    animation = "pulse",
                    status = "info"
                )
            )
        ),
        dropdownMenuOutput("messages"), 
        dropdownMenuOutput("notifications"),
        dropdownMenuOutput("tasks"),
        enable_rightsidebar = TRUE,
        rightSidebarIcon = "gears"       
    ),
    
    dashboardSidebar(
        uiOutput("userpanel"),
        passwordInput("password", placeholder="Password", label = tagList(icon("lock"), "DSI Password"))
    ),
    dashboardBody(
        tags$head(title="DSI PORTAL",
                  tags$link(rel = "stylesheet", type = "text/css", href = "https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.css"),
                  tags$link(rel = "stylesheet", type = "text/css", href = "myassets/css/tree.css"),
                  tags$link(rel="shortcut icon", href="myassets/favicon2.ico"),
                  useShinyjs(),
                  shinyFeedback::useShinyFeedback()
                  # tags$script(src="https://cdn.jsdelivr.net/npm/jquery@3.3.1/dist/jquery.min.js"),
                  # tags$script(src="https://cdn.jsdelivr.net/npm/fomantic-ui@2.8.6/dist/semantic.min.js"),
                  # tags$script("$('.ui.accordion').accordion();")
                  
        ),    
        setShadow(class = "dropdown-menu")
    ),
    rightSidebar(
        
    ),
    title = "DSI interface"
)
