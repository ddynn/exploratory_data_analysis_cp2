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

# Q4 Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# need to see Source Classification Code Table, which provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. 
# Subset coal combustion related NEI data
table(SCC$EI.Sector)
coal <- grepl("coal", SCC[, EI.Sector], ignore.case=TRUE) 
comb <- grepl("fuel comb", SCC[, EI.Sector], ignore.case=TRUE) 
combustionSCC <- SCC[comb & coal, SCC]
combustionNEI <- NEI[NEI[,SCC] %in% combustionSCC]

png("plot4.png")

ggplot(combustionNEI,aes(x = factor(year),y = Emissions/100000)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (in 100,000 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))+theme_light()

dev.off()
