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

#################
# Plot graphic 1
#################

png(filename="plot1.png", width=480, height=480, units="px")

hist(
    data$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red")

dev.off()
