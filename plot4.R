source('inc/load_data.R')
source('inc/create_png.R')

# creates a graph and saves it to "plot4.png"

createPlot <- function() {
    data <- loadData()
    
    par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
    
    with(data, plot(datetime, Global_active_power, ylab='Global Active Power', xlab='',type='l'))
    with(data, plot(datetime, Voltage, type='l'))
    
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
           col=c('black', 'red', 'blue'),
           bty='n')
    
    with(data, plot(datetime, Global_reactive_power, type='l'))
}

createPng('plot4.png', createPlot);
