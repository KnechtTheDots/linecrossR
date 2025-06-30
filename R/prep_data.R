#' Prepare data to go into the Stan model
#'
#' @param dep_var Dependent variable for the line cross model
#' @param anc_prop Ancestry proportion of the individuals in each observation
#' @param anc_het Ancestry heterozygosity of the individuals in each observation
#'
#' @return Returns a list containing the data to be input into the Stan program through rstan
#' @export

prep_input <- function(dep_var, anc_prop, anc_het){
  N <- length(dep_var)
  theta_s <- 2*anc_prop - 1
  theta_h <- 2*anc_het - 1
  X <- matrix(c(rep(1,N), theta_s, theta_h,
                theta_s^2, theta_s*theta_h, theta_h^2), nrow = N)
  return(list(N = N, y = dep_var, X = X))
}
