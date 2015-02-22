setwd("C:\\Users\\daniel\\Documents\\R\\exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


aggregatedNEI<-aggregate(Emissions~year, data=NEI, sum)
aggregatedNEI$Emissions<-aggregatedNEI$Emissions/1000
barplot(height=aggregatedNEI$Emissions, names.arg=aggregatedNEI$year, col='red', xlab="Years", ylab="Total PM2.5 Emissions (in 1000 tons)", main="Total PM2.5 Emissions in the US from 1999-2008 ")


#Plot 2
isBMorecity<-NEI[,1]==24510
NEI.Bmorecity<-NEI[isBMorecity,]
aggregatedNEI.Bmorecity<-aggregate(Emissions~year, data=NEI.Bmorecity, sum)
barplot(height=aggregatedNEI.Bmorecity$Emissions, names.arg=aggregatedNEI.Bmorecity$year, col='blue', xlab="Years", ylab="Total PM2.5 Emissions (in tons)", main="Total PM2.5 Emissions in Baltimore City from 1999-2008")


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
print(g)

#Plot 4
library(ggplot2)
isCoalASource<-grepl('coal',SCC$Short.Name, ignore.case=TRUE)
coalIsASourceNEI<-NEI[isCoalASource,]
aggregatedNEI.Coal<-aggregate(Emissions~year,coalIsASourceNEI,sum)

g<-ggplot(aggregatedNEI.Coal, aes(year, Emissions))
g<-g+geom_bar(stat="identity")+
  xlab("Year")+
  ylab("Total PM2.5 Emissions (in tons)")+
  ggtitle("Total PM2.5 Emissions Due to Coal Sources from 1999-2008")+
  scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))
print(g)


#Plot5

NEI.BMore<-NEI[NEI$fips=='24510',]
NEI.BMoreRoad<-NEI.BMore[NEI.BMore$type=="ON-ROAD",]
NEI.BMoreRoad$fips[NEI.BMoreRoad$fips=="24510"]<-"Baltimore, MD"
aggregatedNEI.BMoreRoad=aggregate(Emissions~year+fips,NEI.BMoreRoad, sum)
g<-ggplot(aggregatedNEI.BMoreRoad, aes(factor(year), Emissions, fill=fips))
g<-g+geom_bar(stat="identity")+facet_grid(.~fips)+
  xlab("Year")+
  ylab("Total PM2.5 Emissions (in tons)")+
  ggtitle("Total PM2.5 Emissions Due to Motor Vehicles in Baltimore, MD from 1999-2008")
plot(g)


#Plot 6
library(grid)
NEI.BMoreOrLA<-NEI[NEI$fips=="06037"|NEI$fips=='24510',]

NEI.BMoreOrLARoad<-NEI.BMoreOrLA[NEI.BMoreOrLA$type=="ON-ROAD",]
NEI.BMoreOrLARoad$fips[NEI.BMoreOrLARoad$fips=="06037"]<-"Los Angeles, CA"
NEI.BMoreOrLARoad$fips[NEI.BMoreOrLARoad$fips=="24510"]<-"Baltimore, MD"
aggregatedNEI.BMoreOrLARoad=aggregate(Emissions~year+fips,NEI.BMoreOrLARoad, sum)
g<-ggplot(aggregatedNEI.BMoreOrLARoad, aes(factor(year), Emissions, fill=fips))
g<-g+geom_bar(stat="identity")+facet_grid(.~fips)+
  xlab("Year")+
  ylab("Total PM2.5 Emissions (in tons)")+
  ggtitle("Total PM2.5 Emissions Due to Motor Vehicles from 1999-2008")

isLA<-grepl("Los Angeles, CA",aggregatedNEI.BMoreOrLARoad$fips)
isBMore<-grepl("Baltimore, MD",aggregatedNEI.BMoreOrLARoad$fips)
aggregatedNEI.BMoreOrLARoadDiff<-aggregatedNEI.BMoreOrLARoad
aggregatedNEI.BMoreOrLARoadDiff[5:8,3]<-aggregatedNEI.BMoreOrLARoad[isLA,3]-aggregatedNEI.BMoreOrLARoad[isLA,3][1]
aggregatedNEI.BMoreOrLARoadDiff[1:4,3]<-aggregatedNEI.BMoreOrLARoad[isBMore,3]-aggregatedNEI.BMoreOrLARoad[isBMore,3][1]

g2<-ggplot(aggregatedNEI.BMoreOrLARoadDiff, aes(factor(year), Emissions, fill=fips))
g2<-g2+geom_bar(stat="identity")+facet_grid(.~fips)+
  xlab("Year")+
  ylab("Difference in Total PM2.5 Emissions from 1999 (in tons)")+
  ggtitle("PM2.5 Emissions Due to Motor Vehicles from 1999-2008")
pushViewport(viewport(layout = grid.layout(1, 2)))
print(g, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(g2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
