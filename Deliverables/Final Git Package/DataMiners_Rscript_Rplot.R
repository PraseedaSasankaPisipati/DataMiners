
## R Markdown

---
title: "R Plot"
author: "Team Data Miners"
date: "11/8/2017"
---

##### The Research Questions had been modified based on the comments given for the previous assignments as below:

1. What is the trend of all the five-leading cause of deaths over time for each year?

2. What is the maximum and minimum number of expected deaths, observed deaths, potentially excess deaths for a particular cause of death in each age group?

3. What is the trend of the deaths over various regions of US? Which region has the maximum and minimum number of deaths?

4. What is the trend of expected deaths, observed deaths, potentially excess deaths in each region for each benchmark in each locality?

5. What is the ratio between the observed deaths and the Population?What is the trend of the ratios over time by region?

6. What is the ratio between the expected deaths and the Population?What is the trend of the ratios over time by region?

7. Are the ratios in questions 5 and 6 correlated?



### This document consists of R script which will help in providing answers to the above questions through R plots.

NCHS_New1 <- read.csv("NCHS.csv")

str(NCHS_New1)

summary(NCHS_New1)

sum(is.na(NCHS_New1))

aft_mis_NCHS_New1<-na.omit(NCHS_New1)

sum(is.na(aft_mis_NCHS_New1))

str(aft_mis_NCHS_New1)

duplicated(NCHS_New1)

str(NCHS_New1)

aft_mis_NCHS_New2<- aft_mis_NCHS_New1[!(aft_mis_NCHS_New1$State == "United States"),]

aft_mis_NCHS_New3<- aft_mis_NCHS_New2[!(aft_mis_NCHS_New2$Locality == "All"),]

dat <- aft_mis_NCHS_New3

head(dat)

library(noncensus)

data("states")

states

Reg <- states[,c(1,3)]

Reg

Health_data <- merge(dat,Reg,by.x = "State.FIPS.Code",by.y = "state")

head(Health_data)

### 1.Trend of all the five leading cause of Observed deaths over time for each region

Data_all <- Health_data[,c(2:3,9,14)]


suppressMessages(library(dplyr))

Data_allNew <- Data_all  %>%
  group_by(region, Year, Cause.of.Death) %>%
  summarise_all(funs(mean))


suppressMessages(library(ggplot2))

ggplot(data = Data_allNew, aes(x=Year, y = Observed.Deaths, colour = region, group = region)) + labs(title="Trend of Observed Deaths by Year", x="Year",y="Observed Deaths") +
  geom_line()+scale_x_continuous(breaks=seq(2005, 2015, 3)) + facet_wrap(~Cause.of.Death,scales = "free_y")


### 2. Trend of all types of deaths in Each age group

Data_sec <- Health_data[,c(3,6,9,11,12)]

library(dplyr)
Data_sec_New <- Data_sec  %>%
  group_by(Age.Range, Cause.of.Death) %>%
  summarise_all(funs(mean))


library(tidyr)
long_data_sec_New <- gather(Data_sec_New,"Death_Type", "Deaths", Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)

library(ggplot2)
ggplot(data = long_data_sec_New, aes(x=factor(Age.Range), y = Deaths, colour = Death_Type, group = Death_Type)) + labs(title="Trend of Deaths by Age Group", x="Age Group",y=" Number of Deaths") + 
  geom_line() + facet_wrap(~Cause.of.Death,scales = "free")+ theme(axis.text=element_text(size=5))


## 3. Comparison of all types of Deaths by region

library(dplyr)

Data_region <- Health_data[,c(9,11,12,14)] %>%
  group_by(region) %>%
  summarise_all(funs(mean))

library(tidyr)

long_data_region <- gather(Data_region,"Death_Type", "Avg_Deaths", Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)

library(ggplot2)

ggplot(long_data_region,aes(x = region,y = Avg_Deaths,fill = Death_Type)) + labs(title="Comparison of Average of Deaths by Region", x="Region",y="Mean of Deaths") + geom_bar(position = "dodge", stat = "identity")


## 4. Comparison of all types of Deaths by locality

library(dplyr)

Data_Locality <- Health_data[,c(8,9,11,12)] %>%
  group_by(Locality) %>%
  summarise_all(funs(mean))

library(tidyr)

long_Data_Locality <- gather(Data_Locality,"Death_Type", "Avg_Deaths", Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)

library(ggplot2)

ggplot(long_Data_Locality,aes(x = Locality,y = Avg_Deaths,fill = Death_Type)) + labs(title="Comparison of Average of Deaths by Locality", x="Locality",y="Mean of Deaths") + geom_bar(position = "dodge", stat = "identity")


## 5. Ratio of observed deaths and population over various regions

Health_data$percent_obs.deaths <- (Health_data$Observed.Deaths / Health_data$Population) * 100000

Obs.Deaths_region <- Health_data[,c(14:15)] %>%
  group_by(region) %>%
  summarise_all(funs(mean))

library(ggplot2)

ggplot(Obs.Deaths_region,aes(x = region,y = percent_obs.deaths,fill = region)) + labs(title="Comparison of Observed Deaths percentage for each region", x="Region",y="Observed Deaths Percentage") + geom_bar(stat = "identity")

## 6. Ratio of Expected Deaths to Population over regions

Health_data$percent_exp.deaths <- (Health_data$Expected.Deaths / Health_data$Population) * 100
Health_data$percent_obs.deaths <- (Health_data$Observed.Deaths / Health_data$Population) * 100

exp.Deaths_region <- Health_data[,c(14,16)] %>%
  group_by(region) %>%
  summarise_all(funs(mean))

library(ggplot2)

ggplot(exp.Deaths_region,aes(x = region,y = percent_exp.deaths,fill = region)) + labs(title="Expected Deaths percentage", x="Region",y="Expected Deaths Percentage")+ geom_bar(stat = "identity")


## 7. Correlation between both the ratios in Questions 5 and 6

cor(Health_data$percent_obs.deaths,Health_data$percent_exp.deaths)

