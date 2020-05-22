The Cramer Rao bound

The Cramer Rao bound gives you a lower boundary for the variance of an estimate. If the variance reaches this lower bound, the estimate is called efficient. One can show that the covariance matrix C2
C2 >= (1 + grad(bias)) * FIM-1
Where bias describes how much the estimate will be away from the true value on average.
The >= sign comes from the Cauchy-Schwartz inequality in the derivation. The equality holds, if the bias is the multiple of the gradient of the log-likelihood. For a maximum likelihood estimator we have zero bias for all possible parameter values (i.e. zero bias gradient everywhere) and at the point of ML also zero log-likelihood gradient. Hence the equality holds and we call the MLE “efficient”.
