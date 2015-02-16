library(UsingR)
data(galton)

shinyServer(
    function(input, output) {
        output$ratingsPlot <- renderPlot({
            # Set the color palette for the plot
            colors <- c("blue", "red", "orange", "green2", "purple", "yellow3")
            palette(colors)
            numColors = 6
            
            # Get the ratings for each episode of the selected series
            series <- ratings[ratings$Series == input$series,]
            # Sort the episodes by season and episode
            series <- series[with(series, order(Season, Episode)),]
            # Add row numbers to the series dataframe
            series$row.nums <- 1:nrow(series)
            # Finally, plot the data
            plot(series$Rating ~ series$row.nums, col=series$Season,
                 main=paste(input$series,"IMDb Episode Ratings", sep=" "),
                 xlab="Episodes", ylab="Ratings")
            if (length(input$showSeriesTrend) > 0) {
                # Plot the series trendline.
                abline(lm(series$Rating ~ series$row.nums))
            }
            grid(col = "lightgray")
            
            # Draw trendline segments for each season of the series
            seasons <- unique(series$Season)
            for (i in 1:length(seasons)) {
                mod <- lm(series$Rating[series$Season==seasons[i]] ~ series$row.nums[series$Season==seasons[i]])
                coeff <- summary(mod)$coefficients
                m <- coeff[2, 1]
                b <- coeff[1, 1]
                x0 <- min(series$row.nums[series$Season==seasons[i]])
                y0 <- m * x0 + b
                x1 <- max(series$row.nums[series$Season==seasons[i]])
                y1 <- m * x1 + b
                segments(x0, y0, x1, y1, col=colors[((seasons[i]-1) %% numColors)+1])
            }
        })
        
        output$numVotes <- renderText({
            series <- ratings[ratings$Series == input$series,]
            totVotes <- sum(series$Votes)
            numEpisodes <- nrow(series)
            # paste(totVotes, "total votes on IMDb.", sep=" ")
            sprintf("There were %d episodes, and a total of %d IMDb user ratings were recorded.", numEpisodes, totVotes)
        })
        
        output$bestSeason <- renderText({
            series <- ratings[ratings$Series == input$series,]
            series$ratingTotal <- series$Votes * series$Rating
            seasons <- unique(series$Season)
            
            topSeason <- 1
            topRating <- 0.0
            for (i in 1:length(seasons)) {
                season <- series[series$Season == seasons[i],]
                voteTotal <- sum(season$Votes)
                ratingsTotal <- sum(season$ratingTotal)
                averageRating <- ratingsTotal / voteTotal
                if (averageRating > topRating) {
                    topRating <- averageRating
                    topSeason <- seasons[i]
                }
            }
            
            sprintf("Season %d is the highest-rated season, with an average episode rating of %.1f.", topSeason, topRating)
        })
        
        output$worstSeason <- renderText({
            series <- ratings[ratings$Series == input$series,]
            series$ratingTotal <- series$Votes * series$Rating
            seasons <- unique(series$Season)
            
            bottomSeason <- 1
            bottomRating <- 10.0
            for (i in 1:length(seasons)) {
                season <- series[series$Season == seasons[i],]
                voteTotal <- sum(season$Votes)
                ratingsTotal <- sum(season$ratingTotal)
                averageRating <- ratingsTotal / voteTotal
                if (averageRating < bottomRating) {
                    bottomRating <- averageRating
                    bottomSeason <- seasons[i]
                }
            }
            
            sprintf("Season %d is the lowest-rated season, with an average episode rating of %.1f.", bottomSeason, bottomRating)
        })
        
        output$seriesSlope <- renderText({
            series <- ratings[ratings$Series == input$series,]
            series <- series[with(series, order(Season, Episode)),]
            series$row.nums <- 1:nrow(series)
            
            mod <- lm(series$Rating ~ series$row.nums)
            coeff <- summary(mod)$coefficients
            slope <- coeff[2, 1]
            betterOrWorse <- "better"
            if(slope < 0) {
                betterOrWorse <- "worse"
            }
            sprintf("Overall, the series gets %s over time.", betterOrWorse)
        })
    }
)
