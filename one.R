#load libraries
library(dplyr)
library(g)

#load data into R
trafficstops <- read.csv("~/learn/MS_cleaned.csv")

#selecting
select(trafficstops, police_department, officer_id, driver_race)

#samples to show.
select(trafficstops, starts_with("driver"))

#using filtering
head(filter(trafficstops, county_name == "Tallahatchie County"))

#slicing data
slice(trafficstops,1:3)



#sample slices
sample_n(trafficstops, 5)
sample_frac(trafficstops, 0.1)

#arrange things
arrange(trafficstops, county_name, stop_date)

#selecting creating temporary data frame.
tmp_df <- filter(trafficstops,driver_age > 85)
select(tmp_df,violation_raw, driver_gender, driver_race)

#nexting together functions
select(filter(trafficstops, driver_age > 85), violation_raw, driver_gender, driver_race)

#using pipes
trafficstops %>% filter(driver_age > 85) %>% select(violation_raw, driver_gender, driver_race)

#challange
tunica_stops <- trafficstops %>% filter(county_name == "Tunica County") %>% select(stop_date, driver_age,violation_raw) %>% arrange(driver_age)