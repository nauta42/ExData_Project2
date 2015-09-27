# parameters
plotname <- "plot4.png"

# load Source Classification Code (SCC) Table
SCC <- readRDS("Source_Classification_Code.rds")
# load National Emissions Inventory (NEI) data; slow!
NEI <- readRDS("summarySCC_PM25.rds")

# get coal combustion sources
comb <- SCC[grepl("Comb", SCC$EI.Sector, ignore.case = TRUE), c(1,3,4,7,9)]
coalcombsources <- comb[grepl("coal|lignite",comb$SCC.Level.Three, ignore.case = TRUE), 1]
# filter NEI data
nei2 <- NEI[NEI$SCC %in% coalcombsources,]

# summarize Emissions by year
emi <- aggregate(Emissions ~ year, data = nei2, FUN = sum)
# 
# Open the png device
png(filename = plotname, width = 480, height = 480, units = "px");

# Plot
with(emi, plot(year, Emissions))
with(emi, lines(year, Emissions))
title(main = "Total PM2.5 emission from carbon combustion-related sources")

# Close the device
dev.off()

