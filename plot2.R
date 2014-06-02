source('inc/load_data.R')
source('inc/create_png.R')

# creates a graph and saves it to "plot2.png"

createPng('plot2.png', function() {
    data <- loadData()
    
    plot(data$datetime, data$Global_active_power, 
         type='l', 
         xlab='', 
         ylab='Global Active Power (kilowatts)')    
})