---
layout: post
title: "Approximate Bayesian Computation"
---

### Approximate Bayesian Computation

The following content is largely taken from [Toni et al.](https://royalsocietypublishing.org/doi/full/10.1098/rsif.2008.0172).

Approximate Bayesian Computation (ABC) is a Bayesian parameter estimation method (note that Bayesian methods typically become infeasible as the dimensionality of the parameter space increases beyond a few dozens). You simply sample parameters from a prior, and accept the sample if the parameters also explain the data well. That way, you combine both, the prior and the likelihood. You repeat this multiple times to get a whole distribution of possible parameter values (i.e. the posterior) rather than a single estimate. This approach is especially useful when the calculation of the likelihood is tough, as this step is replaced with a comparison between simulated and observed data. Only if simulated and observed data are close (wrt a chosen distance function) the chosen parameter set is accepted.
The following explains several ABC methods. The terminology will be

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?p%28%5Ctheta%20%7Cx%29%20%3D%20f%28x%7C%5Ctheta%20%29%20*%20p%28%5Ctheta%20%29)

#### ABC rejection sampler

1.  Sample theta* from the prior p(theta).
2.  Simulate a dataset x* from f(x|theta*).
3.  If the distance metric d(xmesured, x*) <= eps, accept theta*, otherwise reject.
4.  Return to 1.

Pros:
	After running a lot of samples you get an idea of the posterior parameter distribution
Con:
	This algorithm does not learn. It just tries multiple times (especially if the prior is very different from the posterior)

ABC Markov Chain Monte Carlo
Recall that a markov chain is very simple. It is just a chain of probabilities:
P(x) = P(xn|xn-1) * … * P(x2|x1) * P(x1)

	M1 Initialize thetai , i=0.
	M2 Propose theta* according to a proposal distribution q(q|qi) (the wider this distribution, the more you jump around in the parameter space in every step). This is where the markov chain comes in.
	M3 Simulate a dataset x* from f(x|q*).
	M4 If d(x0, x*)<=eps, go to M5, otherwise set thetai+1=thetai and go to M6.
In words: if you are unhappy, try again. If you are happy considering updating theta.
	M5 Set thetai+1 = theta* with the updating probability
alpha=min⁡(1,(q(〖theta〗_i│theta*)p(theta*))/(q(theta*│〖theta〗_i )p(〖theta〗_i ) ))
(note that this is where the prior information comes in) or stick to qi: qi+1=qi.
In words that means: always update theta if jumping into this direction is more probable than jumping in the other direction. Otherwise update with the probability of the probability ratio. Note that for symmetric q this is just the ratio between the priors.
	M6 Set i=i+1, go to M2.
Pros:
	The algorithm learns: outcome is a Markov chain with the stationary distribution p(theta | being very close (<=eps) to the data). That is, ABC MCMC is guaranteed to converge to the target approximate posterior distribution.
Cons:
	Potentially low acceptance probability: the correlated nature of samples coupled with the potentially low acceptance probability may result in very long chains.
	The chain may get stuck in regions of low probability for long periods of time.

ABC Sequential Monte Carlo
Here, the potentially low acceptance probability is circumvented by decreasing eps in a stepwise manner. The approach is parallelized using a population of N particles (theta vectors). Only the best particles survive in each eps (particles are drawn with replacement).
S1 Initialize eps1,., epsT; set the population indicator t=0.
S2.0 Set the particle indicator i=1.
S2.1 If t=0, sample theta** from p(theta). Else, sample theta* from the previous population. Use weights for sampling and perturb the sampled particle using a perturbation kernel K. I you perturb the particle such that p(theta**) = 0, sample a new particle (i.e. repeat S2.1) Otherwise simulate a candidate dataset x* from f(x|theta**). If you are unhappy (distance metric >= epst), sample a new particle (i.e. repeat S2.1)
S2.2 Lift theta** into the next generation. Calculate its weight in the new population. For t=0 the weight will be 1. Else, the weight will be proportional to its prior and indirect proportional to the weights of its neighbour particles in the previous generation. I guess this is to make sure the algorithm does not advantage ‘mainstream’ particles too much (I do not know why, though). Repeat this until you make the new generation full.
S3 Normalize the weights and repeat (i.e. go to S2.0) until you have reached the smallest eps.
Pros:
	Not all particles need to have the same number of dimensions. This allows different particles to represent different models.

ABC SMC with model selection
Here, we have M models, indicated as m1, …, mM.
MS1 Initialize e1,., eT.
Set the population indicator t=0.
MS2.0 Set the particle indicator i=1.
MS2.1 Sample a model m* from p(m). If t=0, sample theta** from p(theta(m*)). If t>0, sample theta* from the weighted previous population. Perturb the particle theta* to obtain theta**. If p(theta**)=0 return to MS2.0. Else, simulate a candidate dataset x* from f(x|theta**, m*). If you are unhappy (distance metric > epst) return to MS2.1.
MS2.2 Lift the model with its parameters into the next population. Go to MS2.1. until the population is full.
MS3 Normalize the weights and repeat (i.e. go to S2.0) until you have reached the smallest eps.
Pros:
	Models with lots of parameters are automatically penalized, as randomly jumping to a better position in parameter space is unlikely
Cons:
	Poor models may become underrepresented (i.e. have few particles in the last generation) or even die out. This makes it difficult to calculate their posterior parameter distribution (i.e. you would have to run a separate ABC SMC for them alone).
ABC sensitivity analysis
Simply calculate the eigenvectors and eigenvalues of the parameter distribution point cloud. The lower the percentage of variance explained by a component, the better the corresponding eigenvector (i.e. eigenparameter) is estimated.
