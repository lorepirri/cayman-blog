---
layout: post
title: "Cramer-Rao bound"
---

### The Cramer-Rao bound

The Cramer-Rao bound gives you a lower boundary for the variance of an estimator. If the variance reaches this lower bound, the estimate is called [efficient](https://paulflang.github.io/sysbio-glossary/2020/05/22/efficent_estimator.html). One can show for the covariance matrix of an estimator C<sup>2</sup> that the Cramer-Rao bound

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?C%5E%7B2%7D%20%5Cgeq%20%281%20&plus;%20%5Cnabla%20bias%29*FIM%5E%7B-1%7D)

holds. Here, bias describes how much the estimate will be away from the true value on average and FIM is the [Fisher information matrix](). The &ge; sign comes from the Cauchy-Schwartz inequality in the derivation. Here, the &ge; means that the left minus the right side gives a positive-semidefinit matrix. Equality holds, if the bias is the multiple of the gradient of the log-likelihood. For a maximum likelihood estimator we have zero bias. At the point of maximum likelihood we also have zero gradient of the [log-likelihood function](https://paulflang.github.io/sysbio-glossary/2020/05/20/likelihood_function.html). Hence the equality in the Cramer-Rao bound holds for maximum likelihood estimators and we can call the maximum likelihood estimators “[efficient](https://paulflang.github.io/sysbio-glossary/2020/05/22/efficient_estimator.html)”.
