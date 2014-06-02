# creates a png file
#
# fileName is the name of the file that is created
#
# plotFunc is the function that is called to create the plot
createPng <- function(fileName, plotFunc) {
    png(fileName)
    plotFunc()
    dev.off()
}
