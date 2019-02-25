# Reading the CSV file (File Source is from Udacity birthday examples)
birthdays <- read.csv('birthdaysExample.csv')

#Removing empty columns
birthdays <- remove_empty( birthdays, 'cols')
#Checking the data structure
str(birthdays)
#Converting  dates column to a vector so that I can parse it with "lubridate"
library(lubridate)
birthdays$dates <- as.vector(birthdays$dates)
#Parsing the date
birthdays$formated_dates <-parse_date_time(birthdays$dates, 'mdy')
#seperate the date into day month and year and store it into a new variable
new_db <- separate(birthdays, formated_dates, c("year","month","days"), sep='-')
#checking the structure of the data
str(new_db)
#Converting data types to be convienant 
new_db$days <- as.numeric(new_db$days)
new_db$month <- as.factor(new_db$month)
new_db$year <- as.numeric(new_db$year)

#Plotting a histogram using ggplot2, with fill as month, and faceted with month
qplot(data = new_db, x = days, fill = month, geom = 'histogram', binwidth = 1) +
  facet_wrap(~month, scales = 'free') +
  scale_x_continuous(breaks = seq(1,31,1))
  
#Plotting a frequency polygon using ggplot2, with color as month
ggplot(data = new_db, aes(x = days, color = month)) +
  geom_freqpoly(binwidth = 1)

#Plotting a histogra, using ggplot2, with fill as month
qplot(data = new_db, x = days, fill = month, binwidth = 1) +
  scale_x_continuous(breaks = seq(1,31,1))

#Adding quarters to the dataset
new_db$month <- as.numeric(new_db$month) # switching back to numeric to pass it to luridate function
new_db$quarter <- quarter(parse_date_time(new_db$dates, 'mdy'))

#visulizing data using quarters 
new_db$month <- as.factor(new_db$month) # switching back to factor to use as categoral variable
str(new_db)

qplot(data = new_db, x=quarter, fill = month) +
  scale_y_continuous(breaks = seq(0,300,25))

qplot(data = new_db, x=quarter, fill = month) +
  scale_y_continuous(breaks = seq(0,300,25)) +
  facet_wrap(~month)

