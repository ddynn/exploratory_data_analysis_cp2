# title: "Courseproject2"
# author: "Yanan Dong"
# date: '2023-08-16'

library(data.table)
library(dplyr)
library(ggplot2)

path <- getwd()

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

# Q3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

d3<-NEI %>% filter(fips == "24510") %>% 
  group_by(type, year) %>% summarise(totalNEI = sum(Emissions))


png(file="plot3.png")

ggplot(d3,aes(factor(year),totalNEI,fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))+
  theme_light()
#From the data, we could see three types of the PM 2.5 emission have been decreased 
# other than the POINT. The Point SOURCE showed an increasing trend over 1999-2008. 

dev.off()
