# title: "Courseproject2"
# author: "Yanan Dong"
# date: '2023-08-16'

library(data.table)
library(dplyr)

path <- getwd()

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

# Q1  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

d1<-NEI %>% group_by(year) %>% summarise(totalNEI = sum(Emissions))


png(file="plot1.png")
barplot(d1$totalNEI/100000~d1$year, xlab = "Years", ylab = "Emissions in 100,000 tons", main = "Total amount of PM 2.5 Emissions(in 100,000 tons) by year")
dev.off()
