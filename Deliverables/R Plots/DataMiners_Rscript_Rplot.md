NCHS

## R Markdown

This is an R Markdown document.

Note that the echo = FALSE parameter was added to the code chunk to prevent printing of the R code that generated the plot.

The Research Questions had been modified based on the comments given for the previous assignments as below:

1. What is the trend of all the five-leading cause of deaths over time for each year?

2. What is the maximum and minimum number of expected deaths, observed deaths, potentially excess deaths for a particular cause of death in each age group?

3. What is the trend of the deaths over various regions of US? Which region has the maximum and minimum number of deaths?

4. What is the trend of expected deaths, observed deaths, potentially excess deaths in each region for each benchmark in each locality?

5. What is the ratio between the observed deaths and the Population?

What is the trend of the ratios over time by region?

6. What is the ratio between the expected deaths and the Population?

What is the trend of the ratios over time by region?

7. Are the ratios in questions 5 and 6 correlated?



This document consists of R script and R plots which will help in providing answers to the above questions.

NCHS\_New1 &lt;-read.csv(&quot;NCHS.csv&quot;)
str(NCHS\_New1)

summary(NCHS\_New1)

sum(is.na(NCHS\_New1))

aft\_mis\_NCHS\_New1&lt;-na.omit(NCHS\_New1)
sum(is.na(aft\_mis\_NCHS\_New1))

str(aft\_mis\_NCHS\_New1)

_#duplicated(NCHS\_New1)_
str(NCHS\_New1)

aft\_mis\_NCHS\_New2&lt;-aft\_mis\_NCHS\_New1[!(aft\_mis\_NCHS\_New1$State == &quot;United States&quot;),]
dat &lt;-aft\_mis\_NCHS\_New2
head(dat)

## Code to include regions column in the data

library(noncensus)

data(&quot;states&quot;)

states

Reg &lt;-states[,c(1,3)]

Reg

Health\_data &lt;-merge(dat,Reg,by.x =&quot;State.FIPS.Code&quot;,by.y =&quot;state&quot;)

head(Health\_data)

_# write.csv(Health\_data,&quot;Health data.csv&quot;)_

_# 1.trend of all the five leading cause of Observed deaths over time for each region_

Data\_all &lt;-Health\_data[,c(2:3,9,14)]

head(Data\_all)

library(dplyr)

Data\_allNew &lt;-Data\_all  %&gt;%
  group\_by(region, Year, Cause.of.Death) %&gt;%
  summarise\_all(funs(mean))

Data\_allNew

library(ggplot2)

ggplot(data = Data\_allNew, aes(x=Year, y = Observed.Deaths, colour = region, group = region)) +labs(title=&quot;Trend of Observed Deaths by Year&quot;, x=&quot;Year&quot;,y=&quot;Observed Deaths&quot;) +
  geom\_line()+scale\_x\_continuous(breaks=seq(2005, 2015, 3)) +facet\_wrap(~Cause.of.Death,scales =&quot;free\_y&quot;)

This plot provides the overview of trend for the five leading cause of deaths (observed deaths) over time. From the plot we could see that &quot;Cancer&quot; has the highest number of deaths and that is in the southern region of United States. The lower number of deaths could be seen for &quot;Stroke&quot; in the western region of United States. The order of the trends in descending order are Cancer, Heart Disease, Unintentional Injury, Chronic Lower Respiratory Disease, Stroke.




_# 2. Max and Min value of all types of deaths in Each age group_

Data\_sec &lt;-Health\_data[,c(3,6,9,11,12)]
str(Data\_sec)

library(dplyr)
Data\_sec\_New &lt;-Data\_sec  %&gt;%
  group\_by(Age.Range, Cause.of.Death) %&gt;%
  summarise\_all(funs(mean))
Data\_sec\_New

library(tidyr)

long\_data\_sec\_New &lt;-gather(Data\_sec\_New,&quot;Death\_Type&quot;, &quot;Deaths&quot;, Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)
long\_data\_sec\_New

library(ggplot2)
ggplot(data = long\_data\_sec\_New, aes(x=factor(Age.Range), y = Deaths, colour = Death\_Type, group = Death\_Type)) + labs(title=&quot;Trend of Deaths by Age Group&quot;, x=&quot;Age Group&quot;,y=&quot; Number of Deaths&quot;) +
  geom\_line() +facet\_wrap(~Cause.of.Death,scales =&quot;free&quot;)

This plot provides the trend of all types of deaths for each age group. In this plot we could see that the observed deaths are always greater than the expected deaths. As the age increases the numbers of deaths kept increasing. This behavior is consistent for all the causes of death.


_# 3. Max and Min Deaths by region_
library(dplyr)
Data\_region &lt;-Health\_data[,c(9,11,12,14)] %&gt;%
  group\_by(region) %&gt;%
  summarise\_all(funs(mean))
Data\_region

library(tidyr)
long\_data\_region &lt;-gather(Data\_region,&quot;Death\_Type&quot;, &quot;Avg\_Deaths&quot;, Observed.Deaths, Expected.Deaths, Potentially.Excess.Deaths)
long\_data\_region

library(ggplot2)
ggplot(long\_data\_region,aes(x = region,y = Avg\_Deaths,fill = Death\_Type)) + labs(title=&quot;Trend of Average of Deaths by Region&quot;, x=&quot;Region&quot;,y=&quot;Mean of Deaths&quot;) +geom\_bar(position =&quot;dodge&quot;, stat =&quot;identity&quot;)

This plot gives the mean of all the deaths over various regions. The observed deaths are more in the southern part of the United States followed by Northeast, Midwest and West. The Expected Deaths average is almost equal in both South and Northeast. Midwest and West also have equal averages but lower than South and Northeast. South region also has the maximum average for potentially excess deaths followed by Midwest, Northeast and West


_#5. Ratio of observed deaths and population over various regions_
Health\_data$percent\_obs.deaths &lt;-Health\_data$Observed.Deaths /Health\_data$Population
head(Health\_data)

Obs.Deaths\_region &lt;-Health\_data[,c(14:15)] %&gt;%
  group\_by(region) %&gt;%
  summarise\_all(funs(mean))
Obs.Deaths\_region

library(ggplot2)
ggplot(Obs.Deaths\_region,aes(x = region,y = percent\_obs.deaths,fill = region)) +labs(title= &quot;Trend of Observed Deaths percentage&quot;, x=&quot;Region&quot;,y=&quot;Observed Deaths/Population&quot;)) +geom\_bar(stat =&quot;identity&quot;)

This plot provides the fact that the observed deaths percentage is found highest in the Northeast and the lowest in West. Based on different regions (Midwest, Northeast, West and South) in the united states, the average for Observed deaths in south of united states is larger than other regions and so percentage of observed deaths in south of united states is more than other regions.



_#6. Ratio of Expected Deaths to Population over regions_
Health\_data$percent\_exp.deaths &lt;-Health\_data$Expected.Deaths /Health\_data$Population
head(Health\_data)

exp.Deaths\_region &lt;-Health\_data[,c(14,16)] %&gt;%
  group\_by(region) %&gt;%
  summarise\_all(funs(mean))
exp.Deaths\_region

library(ggplot2)
ggplot(exp.Deaths\_region,aes(x = region,y = percent\_exp.deaths,fill = region)) + labs(title=&quot;Trend of Expected Deaths percentage&quot;, x=&quot;Region&quot;,y=&quot;Expected Deaths/Population&quot;) +geom\_bar(stat =&quot;identity&quot;)

This plot is between ratio of expected deaths to population over regions. The expected death in northeast has highest rate compared with other regions. So even the expected death in northeast is greater than other regions. But as observed deaths in south of the united states is much greater than other regions, the potentially excess deaths (difference between expected death and observed death) in south of America is greater than other regions.


_7. What is the correlation between the two ratios in Question 5 and 6_

_cor(Health\_data$percent\_obs.deaths,Health\_data$percent\_exp.deaths)_

_This gives a 0.94 positive correlation value_

_#Standard deviation:_

sd(Health\_data$Potentially.Excess.Deaths)

sd(Health\_data$Observed.Deaths)

sd(Health\_data$Expected.Deaths)

_#Anova table_
Anova.aov=aov(Health\_data$Expected.Deaths~Health\_data$Cause.of.Death)
Anova.aov

summary(Anova.aov)

Anova.aov=aov(Health\_data$Population~Health\_data$Observed.Death)
Anova.aov

summary(Anova.aov)

Anova.aov=aov(Health\_data$Observed.Deaths~Health\_data$Cause.of.Death)
Anova.aov

summary(Anova.aov)

_#Linear Regression_
Regression&lt;-lm(Health\_data$Expected.Deaths ~Health\_data$Cause.of.Death +Health\_data$Population)
summary(Regression)

_#Correlation_
cor.test(Health\_data$percent\_obs.deaths,Health\_data$Population)

_# partial correlations_
library(ggm)

pcor(c(&quot;Observed.Deaths&quot;, &quot;percent\_obs.deaths&quot;), var(Health\_data))
