# Saving Pacific Ocean Perch stock assessment output as a data object in this
# package. Starting with 2012 assessment as that's what we originally used in
# these analyses.

# Want to get in same formate as hake_mcmc.rds



# hake-2024/hake_mcmc.rds contains a large tibble, with each row being an MCMC
# sample, and columns representing various things we might want to look
# at. Extracting some of the useful ones here to save as data objects. Will then
# come back to this to save more.

# Change assess_yr each year, the rest is automated.

# hake_recruitment will become the latest assessment results, and
#  hake_recruitment_2023 retains the 2023 assessment results, this is then ongoing for
#  each year. So hake_recruitment_<assess_yr> = hake_recruitment.
#  See ?hake for details.

load_all()
library(dplyr)

assess_yr <- 2012       # Year of the assessment

load("pop-2012/Bmcmc-pop-5ABC.23.00.rda")
# POP_assessment <- Bmcmc$POP[[1]]

r0 <- Bmcmc$POP[[1]]$P.MCMC$"R_0"
# quantile(r0, c(0.05, 0.5, 0.95))
#      5%      50%      95%
#16315.48 20507.30 27146.07
# median matches Table G3 page 156 of 2012 assessment, but 5% and 95% are very slightly different,
# presumably because of how quantiles are calculated. Median is mean of samples
# 500 and 501 (which are only 2 apart); others are slightly off. ?quantile gives
# different algorithms, so presumably something different was used in
# 2012. Don't worry, just recording here for completeness.

pop_recruitment_mcmc_2012 <- Bmcmc$POP[[1]]$R.MCMC
# 1940 is first year but is not unfished recruitment, as median is 11258.
# median(pop_recruitment_mcmc_2012[, "1940"])

pop_recruitment_mcmc_2012 <- cbind("unfished" = r0,
                                   pop_recruitment_mcmc_2012)

pop_recruitment_mcmc_2012 <- pop_recruitment_mcmc_2012 / 1000     # Convert from
                                        # 1000s to millions
pop_recruitment_mcmc_2012 <- as_tibble(pop_recruitment_mcmc_2012)

pop_recruitment_mcmc_2012


## From JB code:
## df_R_MCMC_all <- POP_assessment$R.MCMC
## MCMC_length <- length(df_R_MCMC_all[,1])
## df_R_MCMC_all <- melt(df_R_MCMC_all, variable.name = 'Year', value.name = 'R')
## df_R_MCMC_all$iter <- rep(seq(1,MCMC_length), length(levels(df_R_MCMC_all$Year)))
## df_R_MCMC_all <- transform(df_R_MCMC_all , Date = as.Date(paste(Year, 01, 15, sep = "-")))
## df_R_MCMC_all <- df_R_MCMC_all


# Define objects similar to in pacea, but with _mcmc after

# Add these, and then create a recruitea_recruitment class to then plot in
# different ways - would be useful.
class(pop_recruitment_mcmc_2012) <- c("recruitea_recruitment",
                                      class(pop_recruitment_mcmc_2012))
attr(pop_recruitment_mcmc_2012, "axis_name") <-
  "POP recruitment (millions of age-1 fish)"

usethis::use_data(pop_recruitment_mcmc_2012,
                  overwrite = TRUE)
