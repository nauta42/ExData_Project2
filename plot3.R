# parameters
plotname <- "plot3.png"

# load Source Classification Code (SCC) Table
SCC <- readRDS("Source_Classification_Code.rds")
# load National Emissions Inventory (NEI) data; slow!
NEI <- readRDS("summarySCC_PM25.rds")

# filter data for Baltimore City
NEI <- NEI[NEI$fips == "24510",]
# year as factor
NEI  <- transform(NEI, year = factor(year))
# type as factor
NEI  <- transform(NEI, type = factor(type))

# summarize Emissions by year and type
emi <- aggregate(Emissions ~ year+type, data = NEI, FUN = sum)

# Open the png device
png(filename = plotname, width = 480, height = 480, units = "px");

# Plot
library(ggplot2)
g <- ggplot(emi, aes(year, Emissions))
g <- g + geom_point() + facet_grid(type ~ ., scales = "free_y") + labs(title = "Emissions in Baltimore by source type")
print(g)

# Close the device
dev.off()
