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


#Convert class of the sub metering columns to numeric

df2[,6] <- as.numeric(as.character(df2[,6]))
df2[,7] <- as.numeric(as.character(df2[,7]))

#plot the timeseries graph and create a png file of the time series plot
dev.copy(png, file = "plot3.png")

png(filename="plot3.png", width=480, height=480, units="px")


plot(df2$Date_Time, df2$Sub_metering_1, type="l", 
     ylab="Energy sub metering", xlab = "")
lines(df2$Date_Time, df2$Sub_metering_2, col="red")
lines(df2$Date_Time, df2$Sub_metering_3, col="blue")

dev.off()