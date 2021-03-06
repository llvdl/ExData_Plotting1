source('inc/load_data.R')
source('inc/create_png.R')

# creates a histogram plot and saves it to "plot1.png"

createPlot <- function() {
    data <- loadData()
    hist(data$Global_active_power, 
         col="red", 
         main='Global Active Power', 
         xlab='Global Active Power (kilowatts)', 
         ylab='Frequency')
}

createPng('plot1.png', createPlot)