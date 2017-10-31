
## Data Cleaning Script

setwd("~/Downloads/r/Team/Team")
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
summary(aft_mis_NCHS_New2$Expected.Deaths)
summary(aft_mis_NCHS_New2$Potentially.Excess.Deaths)
summary(aft_mis_NCHS_New2$Observed.Deaths)

## Mean of data by Column
mean_expected_deaths = mean(aft_mis_NCHS_New2$Expected.Deaths)
mean_excess_deaths = mean(aft_mis_NCHS_New2$Potentially.Excess.Deaths)
mean_observed_deaths = mean(aft_mis_NCHS_New2$Observed.Deaths)

## Mean of expected deaths, excess deaths, observed deaths data grouped by State
mean_expected_deaths_by_state = aggregate( Expected.Deaths ~ State, aft_mis_NCHS_New2, mean )
mean_excess_deaths_by_state = aggregate( Potentially.Excess.Deaths ~ State, aft_mis_NCHS_New2, mean)
mean_observed_deaths_by_state = aggregate(Observed.Deaths ~ State, aft_mis_NCHS_New2, mean)

## Maximum values for the data 
max_expected_deaths = max(aft_mis_NCHS_New2$Expected.Deaths)
max_excess_deaths = max(aft_mis_NCHS_New2$Potentially.Excess.Deaths)
max_observed_deaths = max(aft_mis_NCHS_New2$Observed.Deaths)

## Maximum values for expected deaths, excess deaths and observed deaths grouped by State
max_expected_deaths_by_state <- aft_mis_NCHS_New2%>%group_by(State)%>%summarise(x =max(Expected.Deaths))%>%na.omit(Expected.Deaths)
max_excess_deaths_by_state <- aft_mis_NCHS_New2%>%group_by(State)%>%summarise(x =max(Potentially.Excess.Deaths))%>%na.omit(Potentially.Excess.Deaths)
max_observed_deaths_by_state <- aft_mis_NCHS_New2%>%group_by(State)%>%summarise(x =max(Observed.Deaths))%>%na.omit(Observed.Deaths)


## Minimum values for the data 
min_expected_deaths = max(aft_mis_NCHS_New2$Expected.Deaths)
min_excess_deaths = max(aft_mis_NCHS_New2$Potentially.Excess.Deaths)
min_observed_deaths = max(aft_mis_NCHS_New2$Observed.Deaths)


## Minimum values for expected deaths, excess deaths and observed deaths grouped by State
min_expected_deaths_by_State <- aft_mis_NCHS_New2%>%group_by(State)%>%summarise(x =max(Expected.Deaths))%>%na.omit(Expected.Deaths)
min_excess_deaths_by_State <- aft_mis_NCHS_New2%>%group_by(State)%>%summarise(x =max(Potentially.Excess.Deaths))%>%na.omit(Potentially.Excess.Deaths)
min_observed_deaths_by_State <- aft_mis_NCHS_New2%>%group_by(State)%>%summarise(x =max(Observed.Deaths))%>%na.omit(Observed.Deaths)


## Range of the variables
range_expected_deaths = range(aft_mis_NCHS_New2$Expected.Deaths, na.rm = TRUE)
range_potentiall_excess_deaths = range(aft_mis_NCHS_New2$Potentially.Excess.Deaths, na.rm = TRUE)
range_observed_deaths = range(aft_mis_NCHS_New2$Observed.Deaths, na.rm = TRUE)


## Standard Deviation of data by Column
sd_expected_deaths = sd(aft_mis_NCHS_New2$Expected.Deaths)
sd_excess_deaths = sd(aft_mis_NCHS_New2$Potentially.Excess.Deaths)
sd_observed_deaths = sd(aft_mis_NCHS_New2$Observed.Deaths)

## Standard Deviation of expected deaths, excess deaths, observed deaths data grouped by State
sd_expected_deaths_by_state = aggregate( Expected.Deaths ~ State, aft_mis_NCHS_New2, mean )
sd_excess_deaths_by_state = aggregate( Potentially.Excess.Deaths ~ State, aft_mis_NCHS_New2, mean)
sd_observed_deaths_by_state = aggregate(Observed.Deaths ~ State, aft_mis_NCHS_New2, mean)

#Anova table
Anova.aov= aov(aft_mis_NCHS_New2$Expected.Deaths~aft_mis_NCHS_New2$Cause.of.Death)
Anova.aov
summary(Anova.aov)

#Linear Regression
Regression<-lm(aft_mis_NCHS_New2$Expected.Deaths ~ aft_mis_NCHS_New2$Cause.of.Death + aft_mis_NCHS_New2$Population)
summary(Regression)

