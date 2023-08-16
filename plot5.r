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

# Q5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

d5<-NEI %>% filter(fips == "24510")

table(SCC$SCC.Level.Two)


condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
d5_final <- d5[d5[, SCC] %in% vehiclesSCC,]

png("plot5.png", height = 480)

ggplot(d5_final,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", width=0.75) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (in Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))+theme_light()
 
dev.off()
