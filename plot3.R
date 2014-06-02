source('inc/load_data.R')
source('inc/create_png.R')

# creates a graph and saves it to "plot3.png"

createPng('plot3.png', function() {
    data <- loadData()
    
    plot(data$datetime, data$Sub_metering_1,
         type='l', 
         xlab='', 
         ylab='Energy sub metering',
         col='black')
    
    lines(data$datetime, data$Sub_metering_2, col='red')
    lines(data$datetime, data$Sub_metering_3, col='blue')
    
    legend('topright', 
           c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
           lty=c(1,1),
           col=c('black', 'red', 'blue'))
})