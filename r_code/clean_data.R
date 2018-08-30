# Read raw data
raw_data <- readxl::read_xlsx("data/ruwe_data.xlsx", range = "A5:E17")
# Assign computer friendly column names
names(raw_data) <- c("n_spelers", "n_lopers", "n_tikkers", "duur", "n_getikt")
# Set n_getikt values to numeric
raw_data$n_getikt <- ifelse(raw_data$n_getikt == "niemand", "0",
       ifelse(raw_data$n_getikt == "iedereen", as.character(raw_data$n_lopers), raw_data$n_getikt))
raw_data$n_getikt <- as.numeric(raw_data$n_getikt)
# Separate minutes and seconds from 'duur'
# If "min" is found, take all characters from before, strip whitespace, and set blanks to 0
min_pos <- unlist(gregexpr(pattern = "min", text = raw_data$duur, ignore.case = TRUE))
min_pos <- ifelse(min_pos < 0, 0, min_pos)
raw_data$duur_min <- substr(x = raw_data$duur, start = 0, stop = min_pos - 1)
raw_data$duur_min <- trimws(raw_data$duur_min)
raw_data$duur_min <- ifelse(raw_data$duur_min == "", "0", raw_data$duur_min)
raw_data$duur_min <- as.numeric(raw_data$duur_min)
# If "min" is found, take all characters from after 
raw_data$duur_sec <- substr(x = raw_data$duur, start = min_pos + 3, stop = 10)
raw_data$duur_sec <- trimws(raw_data$duur_sec)
# If "sec" is found, take all characters from before
sec_pos <- unlist(gregexpr(pattern = "sec", text = raw_data$duur, ignore.case = TRUE))
sec_pos <- ifelse(sec_pos < 0, 0, sec_pos)
raw_data$duur_sec <- ifelse(sec_pos > 0, substr(x = raw_data$duur, start = 0, stop = sec_pos - 1), raw_data$duur_sec)
# Strip whitespace, set blanks to 0
raw_data$duur_sec <- trimws(raw_data$duur_sec)
raw_data$duur_sec <- ifelse(raw_data$duur_sec == "", "0", raw_data$duur_sec)
raw_data$duur_sec <- as.numeric(raw_data$duur_sec)
# Replace 'duur' as an amount in seconds
raw_data$duur <- raw_data$duur_min * 60 + raw_data$duur_sec
# Save
write.csv(raw_data, file = "data/schone_data.csv", row.names = FALSE)
