
# Ensure the file has been downloaded, unzipped and ready in the working directory

library(data.table) # Required for the fread function

# hpc is the abbreviated form or household power consumption

# Read the data from the input file by looking up records for either 2007-02-01 or 2007-02-02 dates [Works in Windows OS]

hpc <- fread("findstr /B 1/2/2007 household_power_consumption.txt && findstr /B 2/2/2007 household_power_consumption.txt"
             , data.table = FALSE, sep = ";", 
             col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1",
                           "Sub_metering_2","Sub_metering_3"))

# Combine both Date and Time with paste function, finally convert it to Date class and create a new column in the hpc data frame

hpc$DateTime <- as.POSIXct(paste(as.Date(hpc$Date,"%d/%m/%Y"),hpc$Time))

# Create a plot for Global Active Power vs various Sub Metering Units

with(hpc, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime, col="Red")
  lines(Sub_metering_3~DateTime, col="Blue")
})
legend("topright",col=c("black","red","blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy the created plot into a png file with appropriate dimensions

dev.copy(png, file="plot3.png", height=480, width=480)

# Save the changes and release the device

dev.off()
