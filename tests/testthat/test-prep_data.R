test_that("Stan data prep works", {
  stan_dat <- prep_input(dep_var = oakley$full_size,
                         anc_prop = oakley$anc_prop,
                         anc_het = oakley$anc_het)
  expect_equal(stan_dat$N, nrow(oakley))
  expect_equal(ncol(stan_dat$X), 6)
  expect_equal(nrow(stan_dat$X), stan_dat$N)
  expect_equal(length(stan_dat$y), stan_dat$N)
})
