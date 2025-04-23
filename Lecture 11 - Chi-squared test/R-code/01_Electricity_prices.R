# Elpriser
# From: https://www.elprisenligenu.dk/elpris-api

# Load necessary libraries
library(httr)
library(jsonlite)
library(lubridate)
library(tidyverse)

# Function to get electricity prices for a specific day
get_prices = function(date, price_class = "DK2") {
  # Format date as required (YYYY/MM/DD)
  year = year(date)
  month = sprintf("%02d", month(date))
  day = sprintf("%02d", day(date))
  
  # Build the API URL
  url = paste0("https://www.elprisenligenu.dk/api/v1/prices/", year, "/", month, "-", day, "_", price_class, ".json")
  
  # Request the data from the API
  response = GET(url)
  
  # Check if the response is successful
  if (status_code(response) == 200) {
    # Parse the JSON data
    data = fromJSON(content(response, "text"))
    return(data)
  } else {
    print(paste("Failed to get data for", date))
    return(NULL)
  }
}

# Loop to get prices for the last 100 days
prices_list = list()

for (i in 0:999) {
  # Calculate the date 100 days ago from today
  date = Sys.Date() - days(i)
  
  # Get the prices for that date
  daily_prices = get_prices(date)
  
  # If data is available, add it to the list
  if (!is.null(daily_prices)) {
    prices_list[[as.character(date)]] = daily_prices
  }
  
  Sys.sleep(1)
  print(i)
}

# Display the results for the first few days
head(prices_list)

df0 = prices_list %>% bind_rows()

df0 = df0 %>%
  mutate(
    time_start = ymd_hms(time_start)
  ) %>% 
  mutate(
    time_of_day = format(time_start, "%H:%M:%S"),
    weekday = weekdays(time_start),
    day_of_month = day(time_start),
    month = month(time_start),
    quarter = quarter(time_start),
    year = year(time_start),
    date = date(time_start)
  ) %>%
  mutate( # Translating weekdays from Danish to English
    weekday = case_when(
      weekday == "mandag" ~ "Monday",
      weekday == "tirsdag" ~ "Tuesday",
      weekday == "onsdag" ~ "Wednesday",
      weekday == "torsdag" ~ "Thursday",
      weekday == "fredag" ~ "Friday",
      weekday == "lørdag" ~ "Saturday",
      weekday == "søndag" ~ "Sunday",
      TRUE ~ weekday  # If weekday doesn't match, keep the original
    )
  ) %>%
  mutate(
    time_of_day = as.numeric(substr(time_of_day, 1, 2))
  )

# Demeaning
df0 = df0 %>%
  group_by(month) %>%
  mutate(
    EUR_per_kWh_demeaned = EUR_per_kWh - mean(EUR_per_kWh)
  ) %>%
  group_by(weekday) %>%
  mutate(
    EUR_per_kWh_demeaned = EUR_per_kWh_demeaned - mean(EUR_per_kWh_demeaned)
  ) %>%
  select(date, year, month, day_of_month, time_of_day, weekday, EUR_per_kWh, EUR_per_kWh_demeaned)

df0 %>%
  write_csv2("Examples/Solved/Electricity_pricesAPI.csv")




