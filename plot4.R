
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


# Create a Plot layout with 2 rows and 2 columns, assign the below margin

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Create the below 4 plots replicating the same graphs as shown in the assignment

with(hpc, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Copy the created plots in a png file

dev.copy(png, file="plot4.png", height=480, width=480)

# Save the changes and release the device

dev.off()
