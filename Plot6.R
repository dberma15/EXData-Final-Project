
setwd("C:\\Users\\daniel\\Documents\\R\\EXData Final Project")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 6

library(grid)
png(filename="plot6.png", width=480,height=480)

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
  ylab("Difference in Total PM2.5 Emissions
       from 1999 (in tons)")+
  ggtitle("Difference in Total PM2.5 Emissions 
          Due to Motor Vehicles from 1999-2008")
pushViewport(viewport(layout = grid.layout(2, 1)))
print(g, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(g2, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
dev.off()