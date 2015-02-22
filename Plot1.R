setwd("C:\\Users\\daniel\\Documents\\R\\exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


aggregatedNEI<-aggregate(Emissions~year, data=NEI, sum)
aggregatedNEI$Emissions<-aggregatedNEI$Emissions/1000
png(filename="plot1.png", width=480,height=480)
barplot(height=aggregatedNEI$Emissions, names.arg=aggregatedNEI$year, col='red', xlab="Years", ylab="Total PM2.5 Emissions (in 1000 tons)", main="Total PM2.5 Emissions in the US from 1999-2008 ")
dev.off()
