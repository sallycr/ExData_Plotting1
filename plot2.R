# Func : plotGlobalActivePower
# Desc : plot the lines of global active power and save to png format
plotGlobalActivePower <- function(household) {
    # set deivce to PNG 
    png("plot2.png",width=480,height=480)
    
    # add strptime with date and time
    household$dateTime <- strptime(
        paste(household$Date, household$Time, sep=" "), 
        "%d/%m/%Y %T")
    plot(household$dateTime, household$Global_active_power, type="n", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(household$dateTime, household$Global_active_power)
    
    # off the PNG device
    dev.off()
}

# Func : loadHouseholdData 
# Desc : load household data from data file only for the target dates 
#        (1/2/2007 & 2/2/2007)
loadHouseholdData <- function() {
    
    fileName <- "household_power_consumption.txt"
    colNames <- names(read.table(fileName, nrow=1, header=TRUE, sep=";"))
    read.table(fileName, na.strings = "?",sep = ";", header = FALSE,
                    col.names = colNames, 
                    skip = grep("^[1,2]/2/2007", readLines(fileName))-1,
                    nrow = 2880)
}

household <- loadHouseholdData() 
plotGlobalActivePower(household)