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

# Q2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

d2<-NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarise(totalNEI = sum(Emissions))


png(file="plot2.png")
barplot(d2$totalNEI~d2$year, xlab = "Years", ylab = "Total amount of PM 2.5 Emissions in tons", main = "PM 2.5 Emissions(in tons)in Baltimore City by year")
dev.off()
