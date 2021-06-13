system("wget https://gist.github.com/dbrazel/d3cbf8610e0f10978fa9174f7eb4fdd2/raw/0cfbc0f3836866bbdde41fb55e09eba7483ec595/salary_report_ann_arbor.csv")
system("wget https://gist.github.com/dbrazel/d3cbf8610e0f10978fa9174f7eb4fdd2/raw/0cfbc0f3836866bbdde41fb55e09eba7483ec595/salary_report_dearborn.csv")
system("wget https://gist.github.com/dbrazel/d3cbf8610e0f10978fa9174f7eb4fdd2/raw/0cfbc0f3836866bbdde41fb55e09eba7483ec595/salary_report_flint.csv")

library(readr)

df <- read_csv("salary_report_dearborn.csv")
df_ii <- read_csv("salary_report_ann_arbor.csv")


  df_three <- read_csv("salary_report_flint.csv")

library(dplyr)
  
dfp <- filter(df, grepl("professor|LECTurer", title, ignore.case = T))
df_threeac <- filter(df_three, grepl("professo|Lecturer", title, ignore.case = T))

write_csv(df_threeac, "salary_report_flint.csv")
write_csv(dfp, "salary_report_dearborn.csv")

################################################&#########
df_ii_acad <- filter(df_ii, grepl("PROFESSOR|LECTURER", title, ignore.case = T)) %>% mutate(title = tolower(title))
write_csv(
  df_ii_acad,
  "salary_report_ann_arbor.csv")

library(ggplot2)
df <- bind_rows(dfp, df_threeac, df_ii_acad)
plt <- ggplot(df, aes(annual_ftr, forcats::fct_reorder(title, annual_ftr))) + geom_boxplot() + facet_wrap(~campus, nrow = 3, scales = "free_y") + scale_x_continuous(labels = scales::dollar_format()) + labs(x = "Annualised full-time rate", y = "Job title")
ggsave("plt.pdf", plot = plt, width = 8, height = 8)
