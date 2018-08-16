library(dplyr)
library(ggplot2)

#load data
all_data <- read.csv("~/learn/dsw_data.csv", header = TRUE)

#sample graphs Kenya
#graphs data
graph_data <- all_data %>% filter(Country == "Kenya", Year == 2018) %>% 
              select(Period, TC_Adoption,Region)

#plotting simple graph
ggplot(data = graph_data, aes(x = Region, y = TC_Adoption, fill = Period))+
         geom_bar(stat = "identity", position = position_dodge())

#plotting simple line graph
ggplot(data = graph_data, aes(x = Period, y = TC_Adoption, group = Region))+
  geom_line(aes(color = Region))+
  geom_point(aes(color = Region))