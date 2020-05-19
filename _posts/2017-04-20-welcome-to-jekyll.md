---
layout: post
title: "Likelihood function"
---
The likelihood function is a function of parameters X at fixed data D. It tells you what is the probability density of the data, given the parameters: P(D|X).  
If you integrate the likelihood function over all parameters, you do not necessarily get 1. Hence, the likelihood function is not a probability density function.

Bayesian statistics assumes that a prior probability distribution of the parameters P(X) exists. By multiplying this prior probability density function with a likelihood function (and a normalising constant 1/P(D)) we get a probability density function of X
    P(X|D) = P(D|X) * P(X) / P(D)
that integrates over the parameters X to 1.
