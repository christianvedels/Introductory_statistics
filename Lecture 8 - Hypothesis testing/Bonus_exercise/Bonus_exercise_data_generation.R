# Generating data for multiple testing exercise
library(tidyverse)
library(foreach)
library(writexl)
set.seed(20)

n2017 = 1876
n2018 = 2768

df2017 = data.frame(
  respondent_id = 1:n2017
)

df2018 = data.frame(
  respondent_id = 1:n2018
)

for(q in 1:100){
  df2017[,paste0("Q",q)] = sample(1:50, n2017, replace = TRUE)
  df2018[,paste0("Q",q)] = sample(1:50, n2018, replace = TRUE)
}

df2017 %>% write_xlsx("Bonus_exercise/Data2017.xlsx")
df2018 %>% write_xlsx("Bonus_exercise/Data2017.xlsx")


# Test difference
means2017 = df2017 %>% summarise_all(mean) %>% unlist()
means2018 = df2018 %>% summarise_all(mean) %>% unlist()
se2017 = df2017 %>% summarise_all(function(x){sd(x)/sqrt(length(x))}) %>% unlist()
se2018 = df2018 %>% summarise_all(function(x){sd(x)/sqrt(length(x))}) %>% unlist()
z2018 = (means2018 - means2017)/se2017
sum(abs(z2018[-1])>1.96)
which(abs(z2018[-1])>1.96)
z2018

pval = (1-pnorm(abs(z2018)))*2
bonferonicorrected_ps = pval*100
which(pval<0.05)
which(bonferonicorrected_ps < 0.05)

# Theoretical dist
res = c()
for(i in 1:1000){
  for(q in 1:100){
    df2017[,paste0("Q",q)] = sample(1:50, n2017, replace = TRUE)
    df2018[,paste0("Q",q)] = sample(1:50, n2018, replace = TRUE)
  }
  
  df2017 %>% write_xlsx("Bonus_exercise/Data2017.xlsx")
  df2018 %>% write_xlsx("Bonus_exercise/Data2017.xlsx")
  
  
  # Test difference
  means2017 = df2017 %>% summarise_all(mean) %>% unlist()
  means2018 = df2018 %>% summarise_all(mean) %>% unlist()
  se2017 = df2017 %>% summarise_all(function(x){sd(x)/sqrt(length(x))}) %>% unlist()
  se2018 = df2018 %>% summarise_all(function(x){sd(x)/sqrt(length(x))}) %>% unlist()
  z2018 = (means2018 - means2017)/se2017
  res = c(res, sum(abs(z2018[-1])>1.96))
}

hist(res)
