library(dplyr)
library(ggplot2)

#load data
all_data <- read.csv("~/learn/dsw_data.csv", as.is = TRUE, header = TRUE)

#sample graphs Kenya
#graphs data
graph_data <- all_data %>% filter(Country == "Kenya", Year == 2017) %>% 
              select(Period, TC_Adoption,Region,dispensers_with_issues,functionality)

#plotting simple graph
graph_data$Region <- factor(graph_data$Region, levels = c("Awendo", "Busia", "Chavakali", "Matunda","Ugunja","Overall"))
ggplot(data = graph_data, aes(x = Region, y = TC_Adoption, fill = Period))+
         geom_bar(stat = "identity", position = position_dodge())

#plotting simple line graph
ggplot(data = graph_data, aes(x = Period, y = TC_Adoption, group = Region))+
  geom_line(aes(color = Region))+
  geom_point(aes(color = Region))

#Plotting several line graphs
#plot correlogram
library(ggplot2)
library(ggcorrplot)

# Correlation matrix
data(mtcars)
corr <- round(cor(mtcars), 1)

# Plot
ggcorrplot(corr, hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           method="circle", 
           colors = c("tomato2", "white", "springgreen3"), 
           title="Correlogram of mtcars", 
           ggtheme=theme_bw)

#Try this is in our data
# Correlation matrix
corr_data <- read.csv("~/learn/corr_data.csv", as.is = TRUE, header = TRUE)
cleaned_data <- corr_data %>% na.omit()
corr <- round(cor(cleaned_data), 1)

# Plot correlation plot 
ggcorrplot(corr, hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           method="circle", 
           colors = c("tomato2", "white", "springgreen3"), 
           title="Correlogram of All Data", 
           ggtheme=theme_bw)

#plotting scatter plots with smoothline and fitting regression line
ggplot(cleaned_data, aes(functionality, TC_Adoption)) +
  geom_point() +
  geom_smooth(method='lm',formula=y~x) +
  scale_size_area()

#plotting scatter plots with smoothline and fitting regression line
ggplot(cleaned_data, aes(dispensers_with_issues, functionality)) +
  geom_point() +
  geom_smooth(method='lm',formula=y~x) +
  scale_size_area()

