library(survival)
library(data.table)
setwd("C:/Users/user/Desktop/code_for_tte")

test_data <- lung
test_data$inverse_age <- 100 - test_data$age

test_data$date_of_vaccination <- as.Date("2023-01-01") + test_data$inverse_age
test_data$first_sars_cov_2_infection <-  as.Date("2023-01-01") +test_data$meal.cal
test_data$type_of_vaccine <- ifelse(test_data$ph.ecog == 1, "Oxford","Pfizer")
test_data <- subset(test_data, select = c("age","sex","date_of_vaccination","first_sars_cov_2_infection","type_of_vaccine"))
colnames(test_data) <- gsub("age", "age_at_vaccination", colnames(test_data))
fwrite(test_data, "fake_covid_data.csv")
