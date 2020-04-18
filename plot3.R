getwd()
unzip("exdata_data_household_power_consumption.zip", exdir= "household_power_consumption")

library(data.table)

Household_energy <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")

Household_energy[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

Household_energy[, Date_Time := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

Household_energy <- Household_energy[(Date_Time >= "2007-02-01") & (Date_Time < "2007-02-03")]

png("plot3.png", width=480, height=480)

plot(Household_energy[, Date_Time], Household_energy[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Household_energy[, Date_Time], Household_energy[, Sub_metering_2],col="red")
lines(Household_energy[, Date_Time], Household_energy[, Sub_metering_3],col="blue")
legend("topright" , col=c("black","red","blue"),
        c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
        lty=c(1,1), lwd=c(1,1))

dev.off()

                                                                      
                                                                      