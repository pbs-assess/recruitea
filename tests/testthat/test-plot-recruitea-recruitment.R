# These are on plotting functions for recruitea_recruitment objects.

# Recruitment plotting
test_that("recruitment plotting works with various options", {
  expect_invisible(plot(hake_recruitment_mcmc))
  ## expect_invisible(plot(hake_recruitment,
  ##                       style = "foo"))
  ## expect_invisible(plot(dplyr::select(hake_recruitment,
  ##                                     -c("low"))))
  ## expect_invisible(plot(hake_recruitment,
  ##                       y_max = 100))
  ## expect_invisible(plot(hake_recruitment_over_2010))
  ## expect_invisible(plot(hake_recruitment_over_R0))
})
