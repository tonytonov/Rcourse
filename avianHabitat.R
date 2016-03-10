# Importing and inspecting data
#getwd() #setwd if needed
#list.files()
#list.files(pattern = ".*\\.csv$")
#readLines("avianHabitat.csv", 5)
#options(stringsAsFactors = F)
avian <- read.csv("avianHabitat.csv")
#avian <- read.table("avianHabitat.csv", head = T, sep = ",")
str(avian)
head(avian)
summary(avian)

# Checking data
any(!complete.cases(avian))
any(avian$PDB < 0)
any(avian$PDB > 100)

check_percent_range <- function(x) {
  any(x < 0 | x > 100)
}

check_percent_range(avian$PW)

library(stringr)
coverage_variables <- names(avian)[str_detect(names(avian), "^P")]
sapply(coverage_variables, function(name) check_percent_range(avian[[name]]))

# Transforming variables
#names(avian)
#coverage_variables <- names(avian)[-(1:4)][c(T, F)]
#coverage_variables

avian$total_coverage <- rowSums(avian[, coverage_variables])
summary(avian$total_coverage)

avian$site_name <- factor(str_replace(avian$Site, "[:digit:]+", ""))
tapply(avian$DBHt, avian$site_name, mean)