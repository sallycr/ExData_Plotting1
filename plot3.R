# Func : plotEnergySubMeeting
# Desc : plot engergy sub meeting and save to png format
plotEnergySubMeeting <- function(household) {
    # set deivce to PNG 
    png("plot3.png",width=480,height=480)
    
    # add strptime with date and time
    household$dateTime <- strptime(
        paste(household$Date, household$Time, sep=" "), 
        "%d/%m/%Y %T")
    plot(household$dateTime, household$Sub_metering_1, type="n", 
         ylab="Energy sub meeting", xlab="")
    lines(household$dateTime, household$Sub_metering_1, col="black")
    lines(household$dateTime, household$Sub_metering_2, col="red")
    lines(household$dateTime, household$Sub_metering_3, col="blue")
    legend("topright", 
           legend=c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"), 
           lty=c(1,1,1), col=c("black", "red", "blue"))
    
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
plotEnergySubMeeting(household)