
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
            ),
            div(h2("some title"))
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
        ),    
        setShadow(class = "dropdown-menu"),
        tabItems(
            tabItem(tabName = "home", class="active",
                    fluidRow(
                        wellPanel(
                            div(class="ui container",
                                img(src="myassets/images/banners/th1.jpg", class="ui centered aligned huge")
                            )
                        )
                    )
            ),            
            tabItem(tabName = "form",
            ),
            tabItem(tabName = "search"
            ),
            tabItem(tabName = "datatest",
            ),
            #REQUESTS THAT HAVE BEEN CLEANED
            tabItem(tabName = "cleanreq",
                    fluidRow(
                        wellPanel( 
                            tags$div(class = "ui segment teal inverted center aligned", h1("Requests")
                            ),
                            DTOutput("cleanreq_table")
                        )
                    )
            )
            
    ),
    rightSidebar(
        
    ),
    title = "DSI interface"
)
)
