#################
# Read the data
#################

# Source data paths
urlData <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
pathFile <- "exdata-data-household_power_consumption.zip"
nameData <- "household_power_consumption.txt"

# Check if file exists otherwise download it
if (!file.exists(pathFile))
    download.file(url=urlData, destfile=pathFile)

# Get col names and classes
data <- read.csv(unz(pathFile, nameData), header=T, sep=";", na.strings="?", nrows=10)
colNames <- names(data)
colClasses <- sapply(data, class)

# Read only first column for subsetting
data <- read.csv(unz(pathFile, nameData), header=T, na.strings="?", comment.char=";")

# Define first and last row for reading
rowFirst <- head(which(data$Date == "1/2/2007"), n=1)
rowLast  <- head(which(data$Date == "3/2/2007"), n=1)

# Read subsetted data
data <- read.csv(
    unz(pathFile, nameData),
    header=F,
    sep=";",
    na.strings="?",
    skip = rowFirst,
    nrows = rowLast - rowFirst,
    col.names = colNames,
    colClasses = colClasses)

data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

#################
# Plot graphic 3
#################

#Set correct locale for correct x marks (Thu/Fri/Sat)
oldTimeLocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

# OPen png device
png(filename="plot3.png", width=480, height=480, units="px")

# Draw a plot
plot(
    data$DateTime,
    data$Sub_metering_1,
    type="l",
    col="black",
    main="",
    xlab="",
    ylab="Energy sub metering")

lines(
    data$DateTime,
    data$Sub_metering_2,
    col="red")

lines(
    data$DateTime,
    data$Sub_metering_3,
    col="blue")

legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lty="solid")

# Close device
dev.off()

# Return previous locale
Sys.setlocale("LC_TIME", oldTimeLocale)
