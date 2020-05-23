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

1.  Sample **&theta;\*** from the prior p(**&theta;**).
2.  Simulate a dataset **x\*** from f(**x**\|**&theta;\***).
3.  If the distance metric d(**x<sub>mesured</sub>**, **x\***) &le; &epsilon;, accept **&theta;\***, otherwise reject.
4.  Return to 1.

<ins>Pros</ins>:
After running a lot of samples you get an idea of the posterior parameter distribution.

<ins>Con</ins>:
This algorithm does not learn. It just tries multiple times (especially if the prior is very different from the posterior).

#### ABC Markov Chain Monte Carlo

A markov chain is quite a simple concept. It is just a chain of probabilities:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?p%28x%29%3Dp%28x_%7Bn%7D%7Cx_%7Bn-1%7D%29*...*p%28x_%7B2%7D%7Cx_%7B1%7D%29*p%28x_%7B1%7D%29)

The ABC Markov Chain Monte Carlo works as follows:

1.  Initialize **&theta;<sub>i</sub>**, i = 0
2.  Propose **&theta;\*** according to a proposal distribution q(&theta;\|&theta;<sub>i</sub>) (the wider this distribution, the more you jump around in the parameter space in every step). This is where the markov chain comes in.
3.  Simulate a dataset **x\*** from f(**x**\|q\*).
4.  If d(**x<sub>0</sub>**, **x\***) &le; &epsilon;, go to step 5, otherwise set **&theta;<sub>i+1</sub>** = **&theta;<sub>i</sub>** and go to step 6. In other words: if you are unhappy, try again. If you are happy consider updating **&theta;**.
5.  Set **&theta;<sub>i+1</sub>** = **&theta;\*** with the updating probability

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?%5Calpha%3D%5Cmin%20%281%2C%20%5Cfrac%7Bq%28%5Ctheta_%7Bi%7D%7C%5Ctheta%5E%7B*%7D%29*p%28%5Ctheta%20%5E%7B*%7D%29%7D%7Bq%28%5Ctheta%5E%7B*%7D%7C%5Ctheta_%7Bi%7D%29*p%28%7B%5Ctheta%7D_%7Bi%7D%29%7D%29)

Note that this step is where the prior information comes in. or stick to qi: qi+1=qi.
In words that means: always update **&theta;** if jumping into this direction is more probable than jumping in the other direction. Otherwise update with the probability of the above ratio. Note that for symmetric q this ratio is just the ratio between the two priors.
6.  Set i=i+1, go to step 2.

<ins>Pros:</ins>

The algorithm learns: outcome is a Markov chain with the stationary distribution p(**&theta;** \| being very close (&le; &epsilon;) to the data). That is, ABC MCMC is guaranteed to converge to the target approximate posterior distribution.

<ins>Cons:</ins>
Potentially low acceptance probability: the correlated nature of samples coupled with the potentially low acceptance probability may result in very long chains. The chain may get stuck in regions of low probability for long periods of time.

### ABC Sequential Monte Carlo

Here, the potentially low acceptance probability is circumvented by decreasing &epsilon; in a stepwise manner. The approach is parallelized using a population of N particles (**&theta;** vectors). Only the best particles survive in each &epsilon; (particles are drawn with replacement).

1.  Initialize &epsilon;<sub>1</sub>, ..., &epsilon;<sub>T</sub>; set the population indicator t=0.
2.  Set the particle indicator i=1.
    1.  If t=0, sample **&theta;\*\*** from p(**&theta;**). Else, sample **&theta;\*** from the previous population. Use weights for sampling and perturb the sampled particle using a perturbation kernel K. I you perturb the particle such that p(**&theta;\*\***) = 0, sample a new particle (i.e. repeat 2.1) Otherwise simulate a candidate dataset **x\*** from f(**x**\|**&theta;\*\***). If you are unhappy (distance metric > &epsilon;<sub>t</sub>), sample a new particle (i.e. repeat step 2.1).
    2.  Lift **&theta;\*\*** into the next generation. Calculate its weight in the new population. For t = 0 the weight will be 1. Else, the weight will be proportional to its prior and indirect proportional to the weights of its neighbour particles in the previous generation. I guess this is to make sure the algorithm does not advantage ‘mainstream’ particles too much. Repeat this until you make the new generation full.
3.  Normalize the weights and repeat (i.e. go to step 2) until you have reached the smallest &epsilon;.

<ins>Pros:</ins>
Not all particles need to have the same number of dimensions. This allows different particles to represent different models.

### ABC Sequential Monte Carlo with model selection

Here, we have a populaton of M models, indicated as m<sub>1</sub>, …, m<sub>M</sub>. Each model comprises a population of N particles (i.e. parameter sets).

1.  Initialize &epsilon;<sub>1</sub>, ..., &epsilon;<sub>T</sub>. Set the model population indicator t = 0.
2.  Set the particle indicator i = 1.
    1.  Sample a model m\* from p(m). If t = 0, sample **&theta;\*\*** from p(**&theta;**(m\*)). If t > 0, sample **&theta;\*** from the weighted previous population. Perturb the particle **&theta;\*** to obtain **&theta;\*\***. If p(**&theta;\*\***) = 0 return to step 2. Else, simulate a candidate dataset **x\*** from f(**x**\|**&theta;\*\***, m\*). If you are unhappy (distance metric > &epsilon;<sub>t</sub>) return to step 2.1.
    2.  Lift the model with its parameters into the next population. Go to step 2.1 until the population is full.
3.  Normalize the weights and repeat (i.e. go to step 2) until you have reached the smallest &epsilon;.

<ins>Pros</ins>:

Models with lots of parameters are automatically penalized, because
*  randomly jumping to a better position (step 2.1) in parameter space is unlikely
AND
*  not finding a better position is a missed chance for the particular model to be lifted into the next generation.

<ins>Cons</ins>:

Poor models may become underrepresented (i.e. have few particles in the last generation) or even die out. This makes it difficult to calculate their posterior parameter distribution (i.e. you would have to run a separate ABC Sequential Monte Carlo for them alone).

### ABC sensitivity analysis

Simply calculate the eigenvectors and eigenvalues of the parameter distribution point cloud. The lower the percentage of variance explained by a component, the better the estimation in the direction of the corresponding eigenvector (i.e. eigenparameter).
