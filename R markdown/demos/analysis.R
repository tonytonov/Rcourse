library(dplyr)
library(tidyr)
library(ggplot2)

glacier <- read.csv("glacier.csv", na.strings = "..", comment.char = "#")
glacier <- glacier %>%
  select(Ref_Date, GEO, MEASURE, Value) %>% 
  filter(MEASURE == "Annual mass balance") %>% 
  separate(GEO, c("Name", "Location"), sep = " - ")

# descriptive analysis
glacier %>% 
  group_by(Name) %>% 
  summarise(YearsObserved = n(), 
            MeanChange = mean(Value, na.rm = T), 
            WorstChange = min(Value, na.rm = T),
            WorstYear = Ref_Date[which.min(Value)])

# t-test
glacier %>% 
  group_by(Name) %>% 
  do({
    tt <- t.test(.$Value, alternative = "less", mu = 0, conf.level = 0.99)
    data.frame(PValue = tt$p.value, 
               ConfidenceLimit = tt$conf.int[2])
    })

# ggplot
ggplot(glacier, aes(Ref_Date, Value)) + 
  geom_line() + 
  geom_hline(data = g1, aes(yintercept = MeanChange), 
             color = "red", linetype = "dashed", alpha = 0.8) + 
  facet_wrap(~Name, nrow = 2)
