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

# Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

d6<-NEI %>% 
  filter(fips == "24510" | fips == "06037") %>% 
  mutate(city = ifelse(fips == "06037", "LA", "Baltimore"))

# table(SCC$SCC.Level.Two)


condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
d6_final <- d6[d6[, SCC] %in% vehiclesSCC,]

png("plot6.png", height = 480)

ggplot(d6_final, aes(x = factor(year),y = Emissions, fill = city)) +
  geom_bar(stat="identity",aes(fill=city), width=0.75) + 
  facet_grid(scales="free", space="free", .~city) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (in Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))+theme_light()


#LA has much more motor vehicle emissions than Baltimore over time,  and greater changes over time.
dev.off()
