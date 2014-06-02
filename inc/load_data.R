# loads a trimmed version of the data set
#
# the data set is downloaded and extracted to the data folder if
# this has not been done before
#
# the data set will only contain rows for the dates 2007/02/01 and 2007/02/02
#
# missing values have a NA value
#
# an extra column datetime is added containing the parsed datetime values
loadData <- function() {
    
    DATA_FOLDER <- 'data'
    DATA_FILE_TXT <- 'data/household_power_consumption.txt'
    DATA_FILE_TRIMMED_TXT <- 'data/household_power_consumption_trimmed.txt'
    DATA_FILE_ZIP <- 'data/household_power_consumption.zip'
    DATA_FILE_URL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    
    assertDataExists <- function() {
        createDataFolderIfNecessary();
        assertDataFolderExists();
        
        createTrimmedDataFileIfNotExists()
        assertTrimmedDataFileExists();
    }
    
    createDataFolderIfNecessary <- function() {
        if(!file.exists(DATA_FOLDER)) {
            print('creating data folder')
            dir.create(DATA_FOLDER)
        }
    }
    
    assertDataFolderExists <- function() {    
        assertFileExists(DATA_FOLDER);
    }
    
    assertTrimmedDataFileExists <- function() {
        assertFileExists(DATA_FILE_TRIMMED_TXT);
    }
    
    createTrimmedDataFileIfNotExists <- function() {
        if(!file.exists(DATA_FILE_TRIMMED_TXT)) {            
            createDataFileIfNotExists()
            
            print('creating trimmed data file')
            
            # create a trimmed data set, containing only the rows for
            # dates 2007/02/01 and 2007/02/02
            # also, we replace ? with NA to ease reading the file with read.csv
            conIn <- file(DATA_FILE_TXT, open = 'r')
            conOut <- file(DATA_FILE_TRIMMED_TXT, open='w+')
            
            headers <- readLines(conIn, n = 1)
            writeLines(headers,con=conOut)
            
            rows <- NULL;
            while (length(lines <- readLines(conIn, n = 1000, warn = FALSE)) > 0) {
                filteredLines <- sapply(lines, function(line) {
                    if(grepl('^0?[1|2]/0?2/2007;', line )) {
                        naClean <- gsub('\\?', 'NA', line)
                        writeLines(naClean, con=conOut)
                    }
                })
            }
            
            close(conOut)
            close(conIn)
        }
    }
    
    createDataFileIfNotExists <- function() {
        if(!file.exists(DATA_FILE_TXT)) {
            createZipFileIfNotExists()
            
            print ('unzipping data archive')
            unzip(DATA_FILE_ZIP, exdir='data')
        }
    }

    createZipFileIfNotExists <- function() {
        if(!file.exists(DATA_FILE_ZIP)) {
            print('Downloading zip file')
            download.file(url=DATA_FILE_URL, destfile=DATA_FILE_ZIP,method='curl')
            assertFileExists(DATA_FILE_ZIP)
        }
    }
    
    assertFileExists <- function(path) {
        if(!file.exists(path)) {
            stop(paste('assertion error: file or folder "',path, '" could not be found', sep=''))
        }
    }
    
    assertDataExists()
    data <- read.csv(DATA_FILE_TRIMMED_TXT, na.strings = '?', sep=";")
    
    datesClean <- gsub('^(\\d)/(\\d)/', '0\\1/0\\2/', data$Date)
    data$datetime <- strptime(paste(datesClean, data$Time),format='%d/%m/%Y %H:%M:%s')
    
    data
}