library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinyBS)


dashboardPage(
  title = "Interactive visualization of COVID19 case and death forecasts (Germany)",
  dashboardHeader(title = "COVID19 - Prediction"),
  skin = "green",
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Prediction", tabName = "Prediction", icon = icon("area-chart")))
  ),
  ## Body content
  dashboardBody(
    tabItems(

      # start tab:
      tabItem(tabName = "Prediction",
              titlePanel("Predicting the death toll from covid-19 cases in Germany"),
              # input elements generated on server side:
              div(style="display:inline-block",
                  radioButtons("select_stratification", "Show Prediction by:",
                           choices = list("Prediction date" = "forecast_date"),
                           selected = "forecast_date", inline = TRUE)
                  ),
              
              br(),
              div(style="display:inline-block", uiOutput("inp_select_date")),
              div(style="display:inline-block", selectInput("select_target", label = "Select target:",
                                                            choices = list("cumulative deaths" = "cum death",
                                                                           "incident deaths" = "inc death",
                                                                           "cumulative cases" = "cum case",
                                                                           "incident cases" = "inc case"))),
              div(style="display:inline-block", uiOutput("inp_select_location")),
              uiOutput("inp_select_model"),

              actionButton("show_all", "Show all"),
              actionButton("hide_all", "Hide all"),
              div(style="display:none",
                  checkboxInput("show_pi.50", label = "Show 50% prediction interval where available", value = FALSE)              ),
              div(style="display:none",
                  checkboxInput("show_pi.95", label = "Show 95% prediction interval where available", value = TRUE)
              ),
              br(),
              br(),
              div(style="display:inline-block",
                  radioButtons("select_truths", "Select handling of truth data:",
                                 choiceNames = c("Show original Prediction irrespective of used truth data", "Shift all Prediction to ECDC/RKI data"),
                                 choiceValues = c("both", "ECDC"),
                                 selected = c("ECDC"), inline = TRUE)
                  ),
              
              br(),
              
              br(),
              # checkboxInput("show_model_past", label = "Show past values assumed by models where available", value = TRUE),
              tags$b("Draw rectangle to zoom in, double click to zoom out. Hover over grey line to display numbers (point forecasts and observed)."),
              h3(""),
              # plot:
              plotOutput("plot_forecasts", height = 500,
                         click = "coord_click", hover = "coord_hover",
                         brush = brushOpts(id = "coord_brush", resetOnNew = TRUE),
                         dblclick = clickOpts("coord_dblclick")),
              # evaluation plot:
              conditionalPanel("input.show_evaluation",
                               plotOutput("plot_evaluation", height = 500))

      )

    )
  )
)
