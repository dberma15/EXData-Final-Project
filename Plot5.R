
setwd("C:\\Users\\daniel\\Documents\\R\\exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot5
png(filename="plot5.png", width=480,height=480)

NEI.BMore<-NEI[NEI$fips=='24510',]
NEI.BMoreRoad<-NEI.BMore[NEI.BMore$type=="ON-ROAD",]
NEI.BMoreRoad$fips[NEI.BMoreRoad$fips=="24510"]<-"Baltimore, MD"
aggregatedNEI.BMoreRoad=aggregate(Emissions~year+fips,NEI.BMoreRoad, sum)
g<-ggplot(aggregatedNEI.BMoreRoad, aes(factor(year), Emissions, fill=fips))
g<-g+geom_bar(stat="identity")+facet_grid(.~fips)+
  xlab("Year")+
  ylab("Total PM2.5 Emissions (in tons)")+
  ggtitle("Total PM2.5 Emissions From Vehicles in 
          Baltimore, MD from 1999-2008")
plot(g)

dev.off()