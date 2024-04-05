
<!-- README.md is generated from README.Rmd. Please edit that file.
Build with

load_all()
rmarkdown::render("README.Rmd")

which builds the .html that can be viewed locally (but isn't pushed to GitHub;
GitHub uses README.md to make the page you see on GitHub). See pacea if want to
save figures.
-->

# recruitea

# hdiAnalysis

<!-- badges: start -->

[![R-CMD-check](https://github.com/pbs-assess/recruitea/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pbs-assess/recruitea/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/pbs-assess/recruitea/branch/main/graph/badge.svg)](https://app.codecov.io/gh/pbs-assess/recruitea?branch=main)
![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fandrew-edwards%2FhdiAnalysis&label=VISITORS&countColor=%23263759&style=flat&labelStyle=lower)
<!-- badges: end -->

An R package to investigate the impacts of ecosystem variability on
recruitment using full MCMC results

This packages functionalises, generalises, and extends our methods
developed by Haigh et al. (2019, Appendix F), to quantitatively detect
environmental influences on annual recruitment of a stock , using a
suite of indicators avaiable in our
[pacea](https://github.com/pbs-assess/pacea) R package.

Crucially, the methods use the full uncertainties of recruitment (and
mortality if desired) as estimated by an assessment model, not just
average estimates for each year. Technically, this is done by using all
Markov chain Monte Carlo (MCMC) samples, rather than just summary
statistics. This aspect of the method was particularly well received at
a national DFO workshop (Edwards et al. 2017).

The package is currently under construction and not intended to be
operational yet.

Edwards, A.M., Haigh, R., Tallman, R., Swain, D.P., Carruthers, T.R.,
Cleary, J.S., Stenson, G. and Doniol-Valcroze, T. (2017). Proceedings of
the Technical Expertise in Stock Assessment (TESA) National Workshop on
‘Incorporating an ecosystem approach into single-species stock
assessments’ 21-25 November 2016, Nanaimo, British Columbia. Can. Tech.
Rep. Fish. Aquat. Sci. 3213: vi + 53
p. <https://waves-vagues.dfo-mpo.gc.ca/Library/40595754.pdf>

Haigh, R., Starr, P.J., Edwards, A.M., King, J.R., and Lecomte, J.-B.
(2019). Stock assessment for Pacific Ocean Perch (Sebastes alutus) in
Queen Charlotte Sound, British Columbia in 2017. DFO Can. Sci. Advis.
Sec. Res. Doc. 2018/038. v + 227
p. <http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2018/2018_038-eng.pdf>

## Installation

To install the latest version just:

    install.packages("remotes")    # If you do not already have the "remotes" package

    remotes::install_github("pbs-assess/recruitea")

If you get an error like

    Error in utils::download.file(....)

then the connection may be timing out (happens to us on the DFO
network). Try

    options(timeout = 1200)

and then try and install again. If you get a different error then post
an Issue or contact
<a href="mailto:andrew.edwards@dfo-mpo.gc.ca">Andy</a> for help.
