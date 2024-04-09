# Saving Bocaccio stock assessment recruitment output as a data object in this
# package. File from Rowan Haigh on 8/4/2024.

# Want to get in same formate as hake_recruitment_mcmc.rds and pop_recruitment_mcmc_2012.rds

load_all()
library(dplyr)

dat <- read.csv("bocaccio-2024/BOR-CST-2024-MCMC(R)-forAndy.csv") %>%
  as_tibble()

names(dat) <- gsub(pattern = "X",
                   replacement = "",
                   x = names(dat))

# 1935 is first year but presumably not unfished recruitment, though need to
# check SR TODO
# TODO and check units

dat <- select(dat,
              -c("Run.Sample"))

dat <- dat / 1000     # Convert from 1000s to millions
dat <- as_tibble(dat)

# Define objects similar to in pacea, but with _mcmc after

# Add these, and then create a recruitea_recruitment class to then plot in
# different ways - would be useful.
bocaccio_recruitment_mcmc <- dat

class(bocaccio_recruitment_mcmc) <- c("recruitea_recruitment",
                                      class(bocaccio_recruitment_mcmc))
attr(bocaccio_recruitment_mcmc, "axis_name") <-
  "Bocaccio recruitment (millions of age-1 fish)"

usethis::use_data(bocaccio_recruitment_mcmc,
                  overwrite = TRUE)
