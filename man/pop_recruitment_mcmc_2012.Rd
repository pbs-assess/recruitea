% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{pop_recruitment_mcmc_2012}
\alias{pop_recruitment_mcmc_2012}
\title{Pacific Ocean Perch recruitment MCMC estimates (millions of age-1 fish) for
Queen Charlotte Sound from the 2012 assessment}
\format{
A tibble, also of class \code{recruitea_recruitment} for plotting, with each row representing an MCMC sample, and columns:
\describe{
\item{unfished:}{unfished equilibrium, not the same as the 1940 value}
\item{\code{1940}:\code{2010}:}{year for each recruitment}
}
}
\source{
Generated from running \code{data-raw/pop.R}
}
\usage{
pop_recruitment_mcmc_2012
}
\description{
As originally used in Haigh et al. (2019) analysis.
}
\examples{
\dontrun{
pop_recruitment_mcmc_2012
plot(poprecruitment_mcmc_2012)
}
}
\author{
Andrew Edwards
}
\keyword{datasets}
