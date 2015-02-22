
setwd("C:\\Users\\daniel\\Documents\\R\\exdata_data_NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot 4
png(filename="plot4.png", width=480,height=480)

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

dev.off()