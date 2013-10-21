##
## For a Multivariate Normal Posterior with mean A^-1 b and variance A^-1 of length n
##

devs <- rnorm(n)
Sigma.chol <- chol(A)
Simulated.vector <- backsolve(Sigma.chol, backsolve(A, b, transpose = TRUE) + devs)


