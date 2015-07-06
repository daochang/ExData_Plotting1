#read in data

df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                 stringsAsFactors=FALSE)

#install the lubridate package

if(require(lubridate)!=TRUE)
{install.packages('lubridate')
}

library(lubridate)


#Convert the Date and Time variables to Date/Time classes

df$Date <- dmy(df$Date)

#Subset data only to required days

day1<-ymd("2007-02-01")
day2<-ymd("2007-02-02")

df1 <- subset(df, Date %in% c(day1, day2))

#Combine first 2 columns
df1$Date_Time <- paste(df1$Date, df1$Time, sep=" ")
df1$Date_Time <- ymd_hms(df1$Date_Time)


#Rearrange columns in the dataframe

df2 <- df1[,c(10,3:9)]

#Convert class of columns "Global Active Power" to numeric

df2[,2] <- as.numeric(as.character(df2[,2]))

#Convert class of the sub metering columns 1 and 2 to numeric

df2[,6] <- as.numeric(as.character(df2[,6]))
df2[,7] <- as.numeric(as.character(df2[,7]))

#Convert class of the Voltage column to numeric
df2[,4] <- as.numeric(as.character(df2[,4]))

#Plot the 4 different graphs and export to a png file
dev.copy(png, file = "plot4.png")

png(filename="plot4.png", width=480, height=480, units="px")

par(mfrow = c(2, 2))

with(df2, {
        plot(df2$Date_Time, df2$"Global_active_power", type="l",
             ylab="Global Active Power", xlab = "")
        
        plot(df2$Date_Time, df2$Voltage, type="l", 
             ylab="Voltage", xlab = "datetime")
        
        plot(df2$Date_Time, df2$Sub_metering_1, type="l", 
             ylab="Energy sub metering", xlab = "")
        lines(df2$Date_Time, df2$Sub_metering_2, col="red")
        lines(df2$Date_Time, df2$Sub_metering_3, col="blue")
        
        plot(df2$Date_Time, df2$Global_reactive_power, type="h", 
             ylab="Global Reactive Power", xlab = "datetime")
                
})

dev.off()








