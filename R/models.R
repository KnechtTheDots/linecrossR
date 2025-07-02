

#' @title Fit a Bernoulli line cross model
#'
#' @param data A list of inputs for the stan model
#' @param ... Named arguments to the `sample()` method of CmdStan model
#'   objects: <https://mc-stan.org/cmdstanr/reference/model-method-sample.html>
#'
#' @returns A `CmdStanMCMC` object: <https://mc-stan.org/cmdstanr/reference/model-method-sample.html>
#' @export
lc_bern <- function(data, ...){
  mod <- instantiate::stan_package_model(name = "lc_binom", package = "linecrossR")
  return(mod$sample(data = data, ...))
}
