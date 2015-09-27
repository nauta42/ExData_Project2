# parameters
plotname <- "plot2.png"

# load Source Classification Code (SCC) Table
SCC <- readRDS("Source_Classification_Code.rds")
# load National Emissions Inventory (NEI) data; slow!
NEI <- readRDS("summarySCC_PM25.rds")

# filter data for Baltimore City
NEI <- NEI[NEI$fips == "24510",]

# year as factor
NEI  <- transform(NEI, year = factor(year))

# summarize Emissions by year
emi <- aggregate(Emissions ~ year, data = NEI, FUN = sum)
# 
# Open the png device
png(filename = plotname, width = 480, height = 480, units = "px");

# Plot
with(emi, plot(year, Emissions))
with(emi, lines(year, Emissions))
title(main = "Baltimore City PM2.5 emission from all sources", xlab = "Year", ylab = "Emissions Total")

# Close the device
dev.off()
