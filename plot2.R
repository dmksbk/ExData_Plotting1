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
# Plot graphic 2
#################

#Set correct locale for correct x marks (Thu/Fri/Sat)
oldTimeLocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

# OPen png device
png(filename="plot2.png", width=480, height=480, units="px")

# Draw a plot
plot(
    data$DateTime,
    data$Global_active_power,
    type="l",
    main="",
    xlab="",
    ylab="Global Active Power (kilowatts)")

# Close device
dev.off()

# Return previous locale
Sys.setlocale("LC_TIME", oldTimeLocale)
