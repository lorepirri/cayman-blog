---
layout: post
title: "The Metropolis-Hastings algorithm"
---

The Metropolis-Hastings algorithm is an algorithm that **samples from a probability density function** p from which direct sampling is difficult.

### [](#header-2)Steps

1.  Start by choosing a point x somewhere in space.
2.  Let the point jump to a different location x', using a symmetric jumping distribution (for instance a Gaussian). Such a jumping process is called **Monte Carlo Markov chain** (MCMC). 
3.  Accept x' as one of the sampled points with the probability min(1, p(x’)/p(x)).
4.  If x' is rejected, try the jumping again. Else perform the next jump from x'.

### [](#header-2)Applications

#### [](#header-3)Simulated annealing

In simulated annealing
*   p is a Laplacian of the objective function E(x).
      p(x) = e<sup>-E(x)/k<sub>B</sub>T)</sup>.
*   the jumping function is a Gaussian j(Δx) = (2&pi;T)<sup>n<sub>dims</sub>/2</sup> * e<sup>-Δx<sup>2</sup>/(2T)</sup>
*   the temperature T is decreased, such that p and the jumping function become slimmer and slimmer.

Note the following: If E(x) is the negative log-likelihood/posterior and the finial k<sub>B</sub>T would be one, then simulated annealing samples from the likelihood/posterior function. But I think the purpose of simulated annealing is not to sample from the likelihood/posterior function, but rather to find its maximum (i.e. the final k<sub>B</sub>T is close to zero.

### [](#header-3)Parallel tempering
In parallel tempering
*   The acceptance rate is min(1, e<sup>-ΔE(x)/k<sub>b</sub>T</sup>)
*   Multiple MCMCs of different temperatures T are run in parallel
*   Every now and then chains in decreasing temperature order exchange parameters with a probability of min(1, e<sup>ΔE(x)/k<sub>b</sub>ΔT)</sup>
