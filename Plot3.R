
setwd("C:\\Users\\daniel\\Documents\\R\\exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 3
library(ggplot2)
isBMorecity<-NEI[,1]==24510
NEI.Bmorecity<-NEI[isBMorecity,]
aggregatedNEI.Bmorecity<-aggregate(Emissions~year+type, data=NEI.Bmorecity, sum)
g<-ggplot(aggregatedNEI.Bmorecity, aes(year, Emissions, color=type))
g<-g+geom_line()+
  xlab("Year")+
  ylab("Total PM2.5 Emissions (in tons)")+
  ggtitle("Total PM2.5 Emissions in Baltimore City from 1999-2008 by Type")
png(filename="plot3.png", width=480,height=480)
print(g)
dev.off()
