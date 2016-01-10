# Func : plotEnergySubMeeting
# Desc : plot the graphs of household and save to png format
plotHouseholdGraphs <- function(household) {
    # set deivce to PNG 
    png("plot4.png",width=480,height=480)
    
    # add strptime with date and time
    household$dateTime <- strptime(
        paste(household$Date, household$Time, sep=" "), 
        "%d/%m/%Y %T")
    
    # set 2 x 2 panel
    par(mfrow=c(2,2), mar=c(4,4,1,1))
    
    # 1,1 - Global active power
    plot(household$dateTime, household$Global_active_power, type="n", 
         ylab="Global Active Power", xlab="")
    lines(household$dateTime, household$Global_active_power)
    
    # 1,2 - Voltage
    plot(household$dateTime, household$Voltage, type="n", 
         ylab="Voltage", xlab="datetime")
    lines(household$dateTime, household$Voltage)
    
    # 2,1 - Energy sub meeting
    plot(household$dateTime, household$Sub_metering_1, type="n", 
         ylab="Energy sub meeting", xlab="")
    lines(household$dateTime, household$Sub_metering_1, col="black")
    lines(household$dateTime, household$Sub_metering_2, col="red")
    lines(household$dateTime, household$Sub_metering_3, col="blue")
    legend("topright", 
           legend=c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"), 
           lty=c(1,1,1), col=c("black", "red", "blue"))
    
    # 2,2 - Global reactive power
    plot(household$dateTime, household$Global_reactive_power, type="n", 
         ylab="Global_reactive_power", xlab="datetime")
    lines(household$dateTime, household$Global_reactive_power)
    
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
plotHouseholdGraphs(household)