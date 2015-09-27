# parameters
plotname <- "plot6.png"

# load Source Classification Code (SCC) Table
SCC <- readRDS("Source_Classification_Code.rds")
# load National Emissions Inventory (NEI) data; slow!
NEI <- readRDS("summarySCC_PM25.rds")

# filter data for Baltimore City & Los Angeles County
NEI <- NEI[NEI$fips %in% c("24510", "06037"),]
# year as factor
NEI  <- transform(NEI, year = factor(year))
# fips as factor
NEI  <- transform(NEI, fips = factor(fips))

# get motor vehicle sources
mobilesources <- SCC[SCC$SCC.Level.One %in% c("Mobile Sources"), 1]

# filter NEI data
nei2 <- NEI[NEI$SCC %in% mobilesources,]

# summarize Emissions by year and county
emi <- aggregate(Emissions ~ year + fips, data = nei2, FUN = sum)
emi[emi$fips=="24510", "logChange"]  <- 100 * c(0, diff(log(emi[emi$fips=="24510", 3])))
emi[emi$fips=="06037", "logChange"]  <- 100 * c(0, diff(log(emi[emi$fips=="06037", 3])))

# Open the png device
png(filename = plotname, width = 480, height = 480, units = "px");

# Plot
library(ggplot2)
g <- ggplot(emi, aes(x = year, y = logChange, colour = fips))
g <- g + geom_line(aes(group = fips))
#g <- g + geom_point() + facet_grid(fips ~ ., scales = "free_y")
g <- g + labs(title = "Rate of change over time in motor vehicle emissions")
g <- g + xlab("Year") + ylab("%Log rate of change of emissions")
print(g)

# Close the device
dev.off()
