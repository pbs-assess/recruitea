# Saving Bocaccio stock assessment recruitment output as a data object in this
# package. File from Rowan Haigh on 8/4/2024.

# Want to get in same formate as hake_recruitment_mcmc.rds and pop_recruitment_mcmc_2012.rds

load_all()
library(dplyr)

raw <- read.csv("bocaccio-2024/BOR-CST-2024-MCMC(R)-forAndy.csv") %>%
  as_tibble()

rec_new <- raw

names(rec_new) <- gsub(pattern = "X",
                       replacement = "",
                       x = names(rec_new))

rec_new <- select(rec_new,
                  -c("Run.Sample"))

rec_new <- rec_new / 1000           # Convert from 1000s to millions
rec_new <- as_tibble(rec_new)

# R0 is saved separately
R0_dat <- read.csv("bocaccio-2024/BOR-CST-2024-MCMC(R0)-forAndy.csv") %>%
  as_tibble()

# Check the samples line up in the same way between the two files:
expect_equal(select(R0_dat, Run.Sample),
             select(raw, Run.Sample))

R0 <- pull(R0_dat, R_0) / 1000     # Convert from 1000s to millions

rec_new <- cbind("unfished" = R0,
                 rec_new) %>%
  as_tibble()

# Define objects similar to in pacea, but with _mcmc after

# Add these, and then create a recruitea_recruitment class to then plot in
# different ways - would be useful.
bocaccio_recruitment_mcmc <- rec_new

class(bocaccio_recruitment_mcmc) <- c("recruitea_recruitment",
                                      class(bocaccio_recruitment_mcmc))
attr(bocaccio_recruitment_mcmc, "axis_name") <-
  "Bocaccio recruitment (millions of age-1 fish)"

plot(bocaccio_recruitment_mcmc)

usethis::use_data(bocaccio_recruitment_mcmc,
                  overwrite = TRUE)
