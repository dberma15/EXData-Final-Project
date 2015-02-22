
setwd("C:\\Users\\daniel\\Documents\\R\\exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

isBMorecity<-NEI[,1]==24510
NEI.Bmorecity<-NEI[isBMorecity,]
aggregatedNEI.Bmorecity<-aggregate(Emissions~year, data=NEI.Bmorecity, sum)
png(filename="plot2.png", width=480,height=480)
barplot(height=aggregatedNEI.Bmorecity$Emissions, names.arg=aggregatedNEI.Bmorecity$year, col='blue', xlab="Years", ylab="Total PM2.5 Emissions (in tons)", main="Total PM2.5 Emissions in Baltimore City from 1999-2008")
dev.off()
