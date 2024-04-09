##' Plot a recruitea recruitment time series object (currently assumes annual values)
##'
##' Temporal plot for a `recruitea` recruitment time series (of class
##' `recruitea_recruitment`) object. Default is to show multiple MCMC samples.
##' TODO Add an option to create pacea type recruitment plot.
##'
##' @param obj a `recruitea_recruitment` object, which is a tibble with rows
##'   representing MCMC samples, the `unfished` column being the unfished
##'   equilibrium, and remaining columns whose names are the years.
##' @param xlab label for the x axis
##' @param ylab label for the y axis, defaults to a `axis-name` attribute of `obj`
##' @param subsample number of MCMC samples to plot
##' @param unfished_years_before years before the start to plot the unfished
##'   equilibrium recruitment
##' @param y_tick_by increments for y tick marks
##' @param start_decade_ticks decade to start decadal tickmarks
##' @param y_max maximum y value for certain types of plot (use this if you get
##'   an error when specifying `ylim`)
##' @param ... further options passed onto `plot.default()`
##' @return plot of the time series with `subsample` number of MCMC samples to
##'   the current device; returns nothing.
##' @export
##' @author Andrew Edwards
##' @examples
##' \dontrun{
##' plot(hake_recruitment_mcmc)
##' plot(hake_recruitment_mcmc,
##'      xlim = c(lubridate::dmy(01011950),
##'               lubridate::dmy(01012040))) # to expand x-axis
##' }
plot.recruitea_recruitment <- function(obj,
                                       xlab = "Year",
                                       ylab = attr(obj, "axis_name"),
                                       subsample = 10,
                                       unfished_years_before = 3,
                                       y_tick_by = 1,
                                       x_tick_extra_years = 20,
                                       start_decade_ticks = lubridate::ymd("1800-01-01",
                                                                           truncated = 2),
                                       y_max = NULL,
                                       ...
                                       ){

  ## stopifnot("value must be a column of the recreatea_recruitment object" =
  ##           value %in% names(obj))

  ## stopifnot("function currently assumes annual (not monthly) recruitments" =
  ##           !("month" %in% names(obj)))

  # Doesn't really working making the column headings of the obj tibble be
  #  Dates, so do:
  years_as_dates <- names(obj)
  years_as_dates[1] <- as.character(as.numeric(years_as_dates[2]) - unfished_years_before)
  years_as_dates <- lubridate::ymd(years_as_dates,
                                   truncated = 2)

  sample_rows <- sample(nrow(obj),
                        subsample)

  matplot(years_as_dates,
          t(obj[sample_rows, ]),
          type="l",
          lty=1,
          xlab = xlab,
          ylab = ylab)

  pacea::add_tickmarks(tibble(date = years_as_dates),
                y_tick_by = y_tick_by,
                y_tick_start = floor(par("usr")[3]),
                y_tick_end = ceiling(par("usr")[4]),
                x_tick_extra_years = x_tick_extra_years,
                start_decade_ticks = start_decade_ticks)

  # Look at plot.pacea_recruitment() if want more options.
 invisible()
}
