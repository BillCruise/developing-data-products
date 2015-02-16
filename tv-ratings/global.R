library(shiny)

ratings <- read.table("tv.ratings", header=TRUE, sep="\t", na.strings="", fill=TRUE, quote="", encoding="latin1", fileEncoding="latin1")
ratings <- na.omit(ratings)
