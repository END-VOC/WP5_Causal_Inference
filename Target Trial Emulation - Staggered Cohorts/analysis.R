library(data.table)
library(survival)
library(meta)
library(gtsummary)

setwd("C:/Users/user/Desktop/code_for_tte")
data <- fread("fake_covid_data.csv")


# Example entry criteria: age < 75...no prior SARs-COV-2 Infection
data_applied_entry_criteria <- subset(data, age_at_vaccination < 75)


data_applied_entry_criteria <- subset(data_applied_entry_criteria, 
                                      is.na(first_sars_cov_2_infection) | 
                                        first_sars_cov_2_infection > date_of_vaccination)

data_applied_entry_criteria <- subset(data_applied_entry_criteria, 
                                      type_of_vaccine %in% c("Oxford", "Pfizer") )


#end of study is defined as: 2023-12-31
data_applied_entry_criteria$end_of_study <- as.Date("2023-12-31")


#end of followup is earliest of, loss to followup (not used in this data), first infection or end of study, whichever is first
data_applied_entry_criteria$end_of_followup <- pmin(data_applied_entry_criteria$first_sars_cov_2_infection, data_applied_entry_criteria$end_of_study,na.rm=TRUE)
data_applied_entry_criteria$followup_time <- data_applied_entry_criteria$end_of_followup - data_applied_entry_criteria$date_of_vaccination

#event defining if event occured during the study period
data_applied_entry_criteria$infected_during_study <- ifelse(data_applied_entry_criteria$first_sars_cov_2_infection == data_applied_entry_criteria$end_of_followup, 1, 0)
data_applied_entry_criteria$infected_during_study <- ifelse(is.na(data_applied_entry_criteria$infected_during_study), 0, data_applied_entry_criteria$infected_during_study)



#plotting age vaccination and age
#our data is designed so this is inversely proportional
ox <- subset(data_applied_entry_criteria, type_of_vaccine == "Oxford")
pf <- subset(data_applied_entry_criteria, type_of_vaccine == "Pfizer")
png("age_through_time.png")
plot(ox$date_of_vaccination, ox$age_at_vaccination, pch = 0, main = "Age through time by vaccination type", xlab = "Date of vaccination", ylab = "Date of Vaccination")
points(pf$date_of_vaccination, pf$age_at_vaccination, pch = 4)
legend("topright",legend = c("Oxford","Pfizer"),pch = c(0,4))
dev.off()

summary_all <- tbl_summary(data_applied_entry_criteria, 
            include = c(age_at_vaccination, sex, infected_during_study),
            by = type_of_vaccine) %>% add_n() %>% add_p()

gt::gtsave(as_gt(summary_all), file = "summary_all.html")


#five trials of 7 days
# 27/01/2023 - 03/02/2023
# 04/02/2023 - 10/02/2023
# 12/02/2023 - 17/02/2023
# 20/02/2023 - 24/02/2023
# 28/02/2023 - 03/03/2023

min_date <- min(data_applied_entry_criteria$date_of_vaccination)

start <- min_date
end <- start + 7
results <- data.frame()
while(start <= as.Date("2023-02-28")){
  temp <- subset(data_applied_entry_criteria, date_of_vaccination >= start)
  temp <- subset(temp, date_of_vaccination <= end)
  print(paste0("Start [", start, "], End [", end, "]"))

  
  
  summary_temp <- tbl_summary(temp, 
                             include = c(age_at_vaccination, sex, infected_during_study),
                             by = type_of_vaccine) %>% add_n() %>% add_p()
  
  gt::gtsave(as_gt(summary_temp), file = paste0("summary_", start, "_to_", end, ".html"))
  
  
  model_temp <- coxph(Surv(followup_time, infected_during_study) ~ type_of_vaccine + age_at_vaccination + sex, data = temp)
  summary_temp <- summary(model_temp)
  coefficients_temp <- summary_temp$coefficients
  coefficients_temp <- as.data.frame(coefficients_temp)
  coefficients_temp$coef_name <- row.names(coefficients_temp)
  row.names(coefficients_temp) <- NULL
  coefficients_temp$cohort  <- paste0("From [", start, "] to End [", end, "]")
  results <- rbind(results, coefficients_temp)
  
  start <- start + 7
  end <- end + 7
  
}


results_vaccination_coef_only <- subset(results, grepl("type_of_vaccine", coef_name))
combine <- metagen(results_vaccination_coef_only$coef, results_vaccination_coef_only$`se(coef)`,sm="HR", studlab = results_vaccination_coef_only$cohort)
png("Forest_plot.png", width = 1920, height = 1080)
forest(combine)
dev.off()
