
<!-- README.md is generated from README.Rmd. Please edit that file.
Build with

load_all()
rmarkdown::render("README.Rmd")

which builds the .html that can be viewed locally (but isn't pushed to GitHub;
GitHub uses README.md to make the page you see on GitHub). See pacea if want to
save figures.
-->

# recruitea

<!-- badges: start -->

[![R-CMD-check](https://github.com/pbs-assess/recruitea/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pbs-assess/recruitea/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/pbs-assess/recruitea/branch/main/graph/badge.svg)](https://app.codecov.io/gh/pbs-assess/recruitea?branch=main)
<!-- badges: end -->

<!-- ![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fpbs-assess%2Frecruitea&label=VISITORS&countColor=%23263759&style=flat&labelStyle=lower) -->

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

Adapting code from what I have locally in `POP_QCS_ClimateFB`, the
non-FB folder is older and has less in it, so just using this one. FB
stands for Fully Bayesian (iirc).

## Outline of older code and plan for converting

My POP_QCS_ClimateFB fork is 34 ahead of Jean-Baptiste’s; only branch is
called Uncertainty. README describes workflow, so need to copy useful
files over and functionalise them; copying that here to then edit and
keep track of what we need to move over and rewrite.

Next steps, based on notes below:

-   go through **Main_DescriptiveModel.R** first.

Lots of hard-wired names everywhere. Let’s just focus on doing the POP
values with NPGO, as those results looked okay, ‘almost significant’ (so
may possibly change with updated data).

Next steps: D save previous POP mcmc values as a data object, so can use
to repeat - use npgo from pacea - work through steps from
**Main_Descriptive_Model.R** - a lot is book-keeping and hardwired
values. Think don’t get too hung up on reusing the old code, maybe
simpler to mostly start again. - decide on JAGS or Stan. Probably Stan.
Or RTMB \[no, as want the MCMC, not the approximation\]? Or TMBStan?.
Catarina and Carrie: go with RTMB and then TMBStan to get the samples.

## Directories

**Main_DescriptiveModel.R** is the master R file which controls the
analysis. AE: start with this.

**Data/** - datasets organize in sub-directories (i.e. Climate). AE:
shouldn’t need these as want to link directly from pacea.

**Doc/** - Documentations of data and analysis, which are pdf files
generated with knitr and latex:

      1. Climate: Description of available climate variables for the QCS.
      2. DescriptiveModels: Methods available to model the association between POP productivity and climate variables.
      3. 3rd-InternationalSymposiun presentation
      4. Paper_Conceptual_Mechanism submitted to Fisheries Oceanography
      5. Other: bib files, post-doc adds, TSC 2015

**figure/** - save figures in the right sub-directory (i.e. Climate).

**R/** - All R codes organized in sub-directories:

-   **Fun/** R functions required to run the analysis AE: will need some
-   **Climate/** R code to load and plot climate data AE: again, just
    use pacea
-   **Load_Data/** R code to load and prepare data AE: may need some
-   **DescriptiveModel/** R code to make inference and post-inference
    computations AE: will need some

## How to start

Requirements:

-   Put the file `Bmcmc-pop-5ABC.rda` in the following directory:
    /POP_QCS_Climate/Data/Recruitment AE: make this a data object to
    rerun old analyses if desired
-   JAGS need to be installed <http://mcmc-jags.sourceforge.net/> AE:
    might be tricky in a package; better to use Stan?

**Main.R**

Main.R is the main file, which is controlling all the other R files. It
calls three files:

    1. Boot.R loads useful R functions and packages.     AE: will use some of
    but in a package form
    2. Load_Data.R loads climatic and recruitment data.  AE: just pacea
    3. Compute_descriptivemodels.R performs inference and post-inference.  AE:
    will need

A lot of options are available within the Main.R file, to active the
option set it to `TRUE`: AE: not sure about these; keep it simple at
first

-   Saving Tex files and figures: `Tex <- TRUE ; SaveFig <- TRUE`
-   Standardized covariates: `Cov_Std <- TRUE`
-   Split covariates into `nClass` classes:
    `Class <- TRUE ;        if(Class){       nClass <- 3 ;       Cov_Std <- FALSE     }`
-   Set the lag between the covariates and the recruitment. Default t-1:
    `Cov_lag <- NULL`
-   Choose covariates type (i.e. “Haida” “LargeScale” “NPCurrent”
    “LocalScale”): `Cov_Type <- "Haida"`
-   Choose time period: `Years <- c(1940:2010)`
-   Choose observational model: Normal with a link function `'Norm_Log'`
    OR Log-Normal `'LogN'` OR Poisson `'Poisson'`
-   Choose latent model: just covariates `''` OR covariates + trend
    analysis `'YearTd'` OR covariates + polynomial for a non-linear
    effect `'NonLi'` OR covariates + trend analysis + polynomial
    `'YearTdNonLi'`
-   Parallel computing: `Paralell <- TRUE`
-   Number of MCMC recruitment samples used in the inference process of
    `nMCMC=188`

## Workflow

`Main.R` first calls the `Load_Data.R` which loads the recruitment and
climatic data. `Load_Data.R` creates a data.frame `df_data_sample`,
which contains `nMCMC` samples of recruitment values and all the
available climatic and environmental covariates. A `df_data_sample` is
saved on the first time that `Main.R` is launched with a name:
`df_data_sample_nMCMC.RData`, where `nMCMC` is an integer i.e. 150.

To select a covariate or a list of covariates, which will be included in
the models, you can choose to assign a value at the object `Cov_Type` in
the `Main.R` (i.e. “Haida”, “LargeScale”, “LocalScale”,
“SpawningBiomass”, …). Or you can edit the `make_Cov_name_list.R` file
in the Load_Data sub-directory.

To run the inference, execute the `Compute_descriptivemodels.R` from the
`Main.R` file. `Compute_descriptivemodels.R` consists of a loop, over
the models set in `Main.R` and over the number of recruitment sample
`nMCMC`. It performs `nMCMC` inferences of the same model with the R
file `make_bayes_infer.R` located in R/DescriptiveModel/. Results are
stored in the sub-directory R/DescriptiveModel/Estimates/ by model name
(i.e. R/DescriptiveModel/Estimates/Poisson_CovStd/) and by the
covariates that are included in it
(i.e. R/DescriptiveModel/Estimates/Poisson_CovStd/Model_ALPI_km2_EPNPW_NPGO_indexW).

The post-inference computations are centralized in the
R/DescriptiveModel/Post_Inference/ sub-directory and controlled with the
file `PostInference_Processing.R`. It merges the `nMCMC` inferences in
one data.frame `df_mcmcChain_all`, and produces figures and tables of
the posterior distributions. The tables are stored with the estimates,
and the figures are saved in the directory figures/ following the same
naming rule as the estimates
(i.e. figure/DescriptiveModel/Estimates/Poisson_CovStd/Model_ALPI_km2_EPNPW_NPGO_indexW).

------------------------------------------------------------------------

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
