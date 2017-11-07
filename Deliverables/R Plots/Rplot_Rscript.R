
###### R plots Assignment#########

dat <- aft_mis_NCHS_New2
head(dat)
library(noncensus)
data("states")
states
Reg <- states[,c(1,3)]
Reg
Health_data <- merge(dat,Reg,by.x = "State.FIPS.Code",by.y = "state")
head(Health_data)
# write.csv(Health_data,"Health data.csv")

# 1.trend of all the five leading cause of Observed deaths over time for each region

Data_all <- Health_data[,c(2:3,9,14)]
head(Data_all)

library(dplyr)
Data_allNew <- Data_all  %>%
  group_by(region, Year, Cause.of.Death) %>%
  summarise_all(funs(mean))
Data_allNew

library(ggplot2)
ggplot(data = Data_allNew, aes(x=Year, y = Observed.Deaths, colour = region, group = region)) + 
  geom_line()+scale_x_continuous(breaks=seq(2005, 2015, 3)) + facet_wrap(~Cause.of.Death,scales = "free_y")

# 2. Max and Min value of all types of deaths in Each age group

Data_sec <- Health_data[,c(3,6,9,11,12)]
str(Data_sec)

library(dplyr)
Data_sec_New <- Data_sec  %>%
  group_by(Age.Range, Cause.of.Death) %>%
  summarise_all(funs(mean))
Data_sec_New

library(tidyr)
long_data_sec_New <- gather(Data_sec_New,"Death_Type", "Deaths", Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)
long_data_sec_New

library(ggplot2)
ggplot(data = long_data_sec_New, aes(x=factor(Age.Range), y = Deaths, colour = Death_Type, group = Death_Type)) + 
  geom_line() + facet_wrap(~Cause.of.Death,scales = "free")



# 3. Max and Min Deaths by region
library(dplyr)
Data_region <- Health_data[,c(9,11,12,14)] %>%
        group_by(region) %>%
  summarise_all(funs(mean))
Data_region

library(tidyr)
long_data_region <- gather(Data_region,"Death_Type", "Avg_Deaths", Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)
long_data_region
  
library(ggplot2)
ggplot(long_data_region,aes(x = region,y = Avg_Deaths,fill = Death_Type)) + geom_bar(position = "dodge", stat = "identity")

#4.
library(dplyr)
Data_Locality <- Health_data[,c(8,9,11,12)] %>%
  group_by(Locality) %>%
  summarise_all(funs(mean))
Data_Locality

library(tidyr)
long_Data_Locality <- gather(Data_Locality,"Death_Type", "Avg_Deaths", Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)
long_Data_Locality

library(ggplot2)
ggplot(long_Data_Locality,aes(x = Locality,y = Avg_Deaths,fill = Death_Type)) + geom_bar(position = "dodge", stat = "identity")

#5
Health_data$percent_obs.deaths <- Health_data$Observed.Deaths / Health_data$Population
head(Health_data)
Obs.Deaths_region <- Health_data[,c(14:15)] %>%
  group_by(region) %>%
  summarise_all(funs(mean))
Obs.Deaths_region

library(ggplot2)
ggplot(Obs.Deaths_region,aes(x = region,y = percent_obs.deaths,fill = region)) + geom_bar(stat = "identity")

#6
Health_data$percent_exp.deaths <- Health_data$Expected.Deaths / Health_data$Population
head(Health_data)
exp.Deaths_region <- Health_data[,c(14,16)] %>%
  group_by(region) %>%
  summarise_all(funs(mean))
exp.Deaths_region

library(ggplot2)
ggplot(exp.Deaths_region,aes(x = region,y = percent_exp.deaths,fill = region)) + geom_bar(stat = "identity")

#7
cor(Health_data$percent_obs.deaths,Health_data$percent_exp.deaths)

# There is a Positive correlation of 0.9469511 between the two ratios

dev.off()
