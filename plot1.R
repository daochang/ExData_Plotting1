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


#plot histogram of Global Active Power" and create a png file of the diagram

dev.copy(png, file = "plot1.png")

png(filename="plot1.png", width=480, height=480, units="px")
hist(df2$"Global_active_power", xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col=2, ylim=c(0,800))

dev.off()



