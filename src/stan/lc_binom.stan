data{
  int N; // number of observations
  array[N] int y; // array of N observations that take on 0 or 1
  matrix[N, 6] X; // matrix of the line cross inputs
}
parameters{
  vector[6] beta; // genetic effects of the line cross model
}
model{
  // priors
  beta[1] ~ normal(0, .5);
  beta[2:6] ~ normal(0, .25);

  // likelihood
  y ~ bernoulli_logit(X*beta);
}
