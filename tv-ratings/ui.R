
shinyUI(pageWithSidebar(
    headerPanel("TV Series IMDb Ratings"),
    sidebarPanel(
        selectizeInput(inputId="series", label="Series (select or search):", choices=levels(ratings$Series),
                       options=list(placeholder='enter a series name...', maxOptions=25, preload=TRUE),
                       selected=levels(ratings$Series)[1142], multiple=FALSE
        ),
        checkboxGroupInput("showSeriesTrend", "", c("Show series trendline" = "show")),
        submitButton('Submit'),
        br(),
        textOutput("numVotes"),
        br(),
        textOutput("bestSeason"),
        br(),
        textOutput("worstSeason"),
        br(),
        textOutput("seriesSlope"),
        hr(),
        helpText("Ratings data last downloaded on February 7, 2015 from the", 
                 a("IMDb Plain Text Data Files", href="http://www.imdb.com/interfaces"), ".")
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Plot", plotOutput('ratingsPlot')),
            tabPanel("Help", 
                     p("Select a TV series from the list on the left, or type in a title to search. (Click the current selection and hit the Backspace key on your keyboard to clear the current selection.) Click 'Submit' when you've made your selection. There are over 9000 TV series in the data set, so be sure to search for your favorite shows."),
                     p("Check the box labeled 'Show series trendline' to display the tendline for the entire series. Trendlines for each season will be displayed by default."),
                     p("The number of episodes and total number of user ratings will be displayed, as well as the highest and lowest average rated seasons. Whether the series tends to get better or worse will also be displayed, based on the slope of the series trendline.")
                    )
        )
    )
))
