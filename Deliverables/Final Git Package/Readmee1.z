## Group Members
1. Praseeda Sasanka
2. Sowjanya
3. Zahra Hatami
## License
MIT License

Copyright (c) 2017 PraseedaSasankaPisipati

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Table of Content
1. Data Information
2. Data Cleaning Documentation
3. HTML Documentation
4. Audience
5. Summarry
6. Presentation
7. Contribution Document

# Data
The data colleted from center for desieas control prevention (CDC). This data set was collected for the years 2005-2015 Mortality data for U.S. residents come from the National Vital Statistics System. Estimates based on fewer than 10 observed deaths are not shown and shaded yellow on the map.
Underlying cause of death is based on the International Classification of Diseases, 10th Revision (ICD-10)

## License
The License details for the Excess Deaths Data Set can be found in License Info
There are no constraints on this data in regards to the license. This is public data set and can be downloaded by any individual within or outside the organization.

[License Info](https://www.cms.gov/about-cms/agency-information/aboutwebsite/privacy-policy.html)

## Data Cleaning:
This data represented the percentage of expected death, observed deaths and potential death in different states in the United States. All data is collected based on five leading causes of death in metropolitan and non-metropolitan areas. Heart disease, Cancer, Unintentional injury, Chronic lower respiratory disease and Stroke are the major causes of death that patients are spending so much money for any treatment for them. The data consists of 20,5921 rows and 13 columns.
## Metadata
This data set was collected for the years 2005-2015
**Mortality** data for U.S. residents come from the National Vital Statistics System. Estimates based on fewer than 10 observed deaths are not shown and shaded yellow on the map.

**Underlying cause of death** is based on the International Classification of Diseases, 10th Revision (ICD-10)

Heart disease (I00-I09, I11, I13, and I20–I51)
Cancer (C00–C97)
Unintentional injury (V01–X59 and Y85–Y86)
Chronic lower respiratory disease (J40–J47)
Stroke (I60–I69)

**Locality** (nonmetropolitan vs. metropolitan) is based on the Office of Management and Budget’s 2013 county-based classification scheme.

**Benchmarks** are based on the three states with the lowest age and cause-specific mortality rates.

**Potentially excess deaths** for each state are calculated by subtracting deaths at the benchmark rates (expected deaths) from observed deaths.

Users can explore three benchmarks:

“2010 Fixed” is a fixed benchmark based on the best performing States in 2010.
“2005 Fixed” is a fixed benchmark based on the best performing States in 2005.
“Floating” is based on the best performing States in each year so change from year to year.

Page last reviewed: July 14, 2017
Page last updated: August 28, 2017
 Strategies for Data Cleaning
_Steps/Strategies for cleaning data_:
1.	Analyzed the research questions and identified the required columns for analysis of Excess Deaths data set
2.	Reviewed the format of the column values in the data set to understand which command in R will be more effective to be used for this format
3.	The summary of data was obtained using R to get an overall view of the data
4.	Performed a check for missing data and found all missing data. Replaced all missing data with “NA”
5.	Tried to figure out how can we deal missing value like deleting the observations, deleting the variable, prediction or imputation with mean/median/mode. By keen observation of the data, decision was taken to delete the observations as the incomplete data cannot be of much use for the analysis. There are enormous number of observations in the data set, where all the classifications are sufficiently represented in the data. For example, having the details of locality, age, cause of death without the metrics like Expected Deaths, Potentially Excess Deaths is of not much use for analysis
6.	Checked the format of the data set to see which kind of command is needed to use in R and executed those commands in R Studio
7.	We also found few duplicate values in the data set and deleted them using R command

## 6. Issues during Data Cleaning
Below are the issues faced during cleaning the data set
1. As this was the first time, all the team members are using R for data analysis, it took us time to get familiar with R. For example, creation of block for the code to run and closing the block before running the code
2. Another issue was, we had the age range as 0-59, 0-64, 0-74 and so on but with the same locality, state and year. Initially, the team felt this might be redundant data. But later, when we looked at the total population values, the numbers kept increasing for each range. So, we finally reviewed the description of the data in the CDC website and understood that the age ranges were always kept at standard minimum value ‘0’. As there is no redundancy we didn’t delete any data.
3. Deciding on which method to follow for the missing data was not an easy task. It consumed a lot of time too. 
