##' Hake recruitment MCMC estimates (billions of age-0 fish) from the 2024 assessment
##'
##' @format A tibble with each row representing an MCMC sample, and columns:
##' \describe{
##'   \item{unfished:}{presumably gives `R0`}
##'   \item{`1966`:`2027`:}{year for each recruitment}
##'  }
##' @examples
##' \dontrun{
##' hake_recruitment_mcmc
##' plot(hake_recruitment_mcmc)  # when plot function written
##' }
##' @author Andrew Edwards
##' @source Generated from running `data-raw/hake.R`
"hake_recruitment_mcmc"

##' Pacific Ocean Perch recruitment MCMC estimates (millions of age-1 fish) for
##' Queen Charlotte Sounds from the 2012 assessment
##'
##' As originally used in Haigh et al. (2019) analysis.
##'
##' @format A tibble, also of class `recruitea_recruitment` for plotting, with each row representing an MCMC sample, and columns:
##' \describe{
##'   \item{unfished:}{unfished equilibrium, not the same as the 1940 value}
##'   \item{`1940`:`2010`:}{year for each recruitment}
##'  }
##' @examples
##' \dontrun{
##' pop_recruitment_mcmc_2012
##' plot(recruitment_mcmc_2012)  # when plot function written
##' }
##' @author Andrew Edwards
##' @source Generated from running `data-raw/pop.R`
"pop_recruitment_mcmc_2012"
