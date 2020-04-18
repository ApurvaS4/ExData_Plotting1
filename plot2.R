getwd()
unzip("exdata_data_household_power_consumption.zip", exdir= "household_power_consumption")

library(data.table)

Household_energy <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")

Household_energy[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

Household_energy[, Date_Time := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

Household_energy <- Household_energy[(Date_Time >= "2007-02-01") & (Date_Time < "2007-02-03")]

png("plot2.png", width=480, height=480)

plot(x = Household_energy[, Date_Time],
     y = Household_energy[, Global_active_power],
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

