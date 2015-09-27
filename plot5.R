# parameters
plotname <- "plot5.png"

# load Source Classification Code (SCC) Table
SCC <- readRDS("Source_Classification_Code.rds")
# load National Emissions Inventory (NEI) data; slow!
NEI <- readRDS("summarySCC_PM25.rds")

# filter data for Baltimore City
NEI <- NEI[NEI$fips == "24510",]

# year as factor
NEI  <- transform(NEI, year = factor(year))

# get motor vehicle sources
mobilesources <- SCC[SCC$SCC.Level.One %in% c("Mobile Sources"), 1]

# filter NEI data
nei2 <- NEI[NEI$SCC %in% mobilesources,]

# summarize Emissions by year
emi <- aggregate(Emissions ~ year, data = nei2, FUN = sum)
# 
# Open the png device
png(filename = plotname, width = 480, height = 480, units = "px");

# Plot
with(emi, plot(year, Emissions))
with(emi, lines(year, Emissions))
title(main = "Baltimore City PM2.5 emission from mobile sources")

# Close the device
dev.off()
