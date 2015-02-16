# developing-data-products
Course Project for Coursera's [Developing Data Products](https://www.coursera.org/course/devdataprod), part of the Data Science specialization.

This app uses data downloaded from IMDb's [Plain Text Data Files](http://www.imdb.com/interfaces) to plot user ratings from all episodes of a selected TV series.  The plot can be used to tell at a glance if a series gets better or worse over time. Use it to determine if a series is worth watching before buying DVDs or investing time on Netflix.

View the app at [https://billcruise.shinyapps.io/tv-ratings/](https://billcruise.shinyapps.io/tv-ratings/)

View a short slidify presentation at [http://billcruise.github.io/developing-data-products/tv-ratings/slides/index.html#1](http://billcruise.github.io/developing-data-products/tv-ratings/slides/index.html#1)

---

### TV Ratings Data Preprocessing Steps

Download ratings data from IMDb. 
ftp://ftp.fu-berlin.de/pub/misc/movies/database/ratings.list.gz
Last done February 7, 2015

Unzip ratings.list

Remove all lines that do not contain TV series episode ratings.
This is most easily done in Notepad++.

1. Go to Search menu > Find... > Select "Mark" Tab. 
2. Activate regular expressions. 
3. Search for '\)\}$' ($ is for line end).
4. Don't forget to check "Bookmark lines" and Press "Mark All"
5. Go to Search Menu -> Bookmark -> Remove Unmarked Lines.
6. Search > Bookmarks > Clear all bookmarks

The file starts out with nearly 600,000 lines, but after these steps you should be left with just over 200,000 TV episode ratings.

Run the RatingsProcessor Java program to finish the pre-processing and produce the final data file.
