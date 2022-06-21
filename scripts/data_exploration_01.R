# Loading packages
library(dplyr)
library(arrow)
library(readr)
library(ggplot2)
library(tibble)

# Loading data
df_lfp = read_parquet("data/raw/lfp.parquet")

# Transforming signal into a column
df_lfp = df_lfp %>% rowwise() %>%
                    mutate(signal=list(c_across(`0`:`2699`))) %>%
                    select(-paste(seq(0,2699)))

# Mean columnwise
df_lfp_stim8 = df_lfp %>%
               filter(stimulus == 8) %>%
               select(paste(seq(0,2699)))
mt_stim8 = as.matrix(df_lfp_stim8, ncol=2700)


mean_stim8 = t(colMeans(df_lfp_stim8))
mean_stim8 = df_lfp_stim8 %>%
             summarise(mean)  
mean_stim8 = as.data.frame(mean_stim8)
mean_stim8 = rownames_to_column(mean_stim8)

std_stim8 = colStdevs()
std_stim8 = t(colStdevs(df_lfp_stim8))
