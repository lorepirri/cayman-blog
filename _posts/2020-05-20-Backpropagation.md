---
layout: post
title: "Backpropagation"
categories: misc
---

Essentially, neural networks are uniform approximators of any function that maps an input vector **x** (fed into the input layer neurons) to an output vector **y** (represented by the output layer neurons). When the neural network means to optimise an objective function of the ground truth output vector **y** and the activation of of the neurons in the output layer. Let this objective function function be

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![equation](https://latex.codecogs.com/gif.latex?C%28a%5E%7BL%7D%29%3D%5Cfrac%7B1%7D%7B2%7D%5Cleft%5C%7Cy-a%5E%7BL%7D%5Cright%5C%7C%5E%7B2%7D%3D%5Cfrac%7B1%7D%7B2%7D%20%5Csum_%7Bj%7D%5Cleft%28y_%7Bj%7D-a_%7Bj%7D%5E%7BL%7D%5Cright%29%5E%7B2%7D)

where **a<sub>L</sub><sup>j</sup>** is the activation of the j<sup>th</sup> neuron in the output layer (denoted with capital L) given an input sample **x**, and **y** is the ground truth output layer activation of the sample **x**.
For any single data point (**x**, **y**) of input vector **x** and ground truth output vector **y**, one calculates the derivatives of the objective function C wrt all weights and biases in the neural network. Note however, that C(a<sup>L</sup>) has a simple shape (a parabola) and we can easily calculate dC(a<sup>L</sup>)/da<sup>L</sup> analytically. However, **a** is a function of the weights, **w** and the biases **b** in the neural network and calculating C(**w**, **b**) is much more demanding. I think it is not possible analytically, but the **backpropagation algorithm** efficiently calculates the gradient of C(**w**, **b**) at the current location (**w**, **b**) numerically.
For a simpler notation, lets define the weighted sum of inputs (plus the bias) into the j<sup>th</sup> neuron in layer l, z<sub>j</sub><sup>L</sup> as

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?z_%7Bj%7D%5E%7Bl%7D%20%3D%20a_%7Bi%7D%5E%7Bl-1%7D*w_%7Bj%7D%5E%7Bl%7D%20&plus;%20b_%7Bj%7D%5E%7Bl%7D)

and the derivative of the cost function wrt z<sub>j</sub><sup>l</sup> as $\delta<sub>j</sub><sup>l</sup>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?%5Cdelta_%7Bj%7D%5E%7Bl%7D%20%5Cequiv%20%5Cfrac%7B%5Cpartial%20C%7D%7B%5Cpartial%20z_%7Bj%7D%5E%7Bl%7D%7D)

Note that for the otuput layer L these derivatives are easily calculated using the chain rule

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?%5Cdelta%5E%7BL%7D%20%3D%20%5Cfrac%7B%5Cpartial%20C%28a%28z%5E%7BL%7D%29%29%7D%7B%5Cpartial%20z%5E%7BL%7D%7D%20%3D%20%5Cfrac%7B%5Cpartial%20C%7D%7B%5Cpartial%20a%5E%7BL%7D%7D%20*%20%5Cfrac%7B%5Cpartial%20a%5E%7BL%7D%7D%7B%5Cpartial%20z%5E%7BL%7D%7D)

In case of sigmoid neurons we define

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?a%28z%29%20%5Cequiv%20%5Csigma%20%28z%29%20%3D%20%5Cfrac%20%7B1%7D%7B1&plus;e%5E%7B-z%7D%7D)

such that 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?%5Cdelta%20%5E%7BL%7D%20%3D%20%5Cnabla%20_aC%20%5Codot%20%7B%5Csigma%20%7D%27%28z%5E%7BL%7D%29)

where the encircled dot means element wise multiplication (Hadamart product) rather than dot product.

Now consider how z is amplified from one layer to the next:
*  First, **z** is cast though sigmoidal neurons to yield an output **a**. The slope of **a** wrt **z** is **$\sigma $'(z)**.
*  Then then **a** is multiplied with weights **w** (added to a bias) and cast into the sigmoidal function of the next neuron. The slope wrt **a** is **w**.

Therefore we can backpropagate the signal according to

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?%5Cdelta%20%5E%7Bl%7D%20%3D%20%28%28w%5E%7Bl&plus;1%7D%29%5ET%5Cdelta%20%5E%7Bl&plus;1%7D%29%20%5Codot%20%7B%5Csigma%20%7D%27%28z%5E%7Bl%7D%29)

Now use the chain rule again to obtain $\delta C/$\delta b:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?%5Cfrac%7B%5Cpartial%20C%28z%28w%5E%7Bl%7D%2C%20b%5E%7Bl%7D%29%29%7D%7B%5Cpartial%20b%5E%7Bl%7D%7D%20%3D%20%5Cfrac%7B%5Cpartial%20C%7D%7B%5Cpartial%20z%5E%7Bl%7D%7D%20*%20%5Cfrac%7B%5Cpartial%20z%5E%7Bl%7D%7D%7B%5Cpartial%20b%5E%7Bl%7D%7D%20%3D%20%5Cdelta%5E%7Bl%7D%20*%201%20%3D%20%5Cdelta%5E%7Bl%7D)

and $\partial C/$\partial w:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://latex.codecogs.com/gif.latex?%5Cfrac%7B%5Cpartial%20C%28z%28w%5E%7Bl%7D%2C%20b%5E%7Bl%7D%29%29%7D%7B%5Cpartial%20w%5E%7Bl%7D%7D%20%3D%20%5Cfrac%7B%5Cpartial%20C%7D%7B%5Cpartial%20z%5E%7Bl%7D%7D%20*%20%5Cfrac%7B%5Cpartial%20z%5E%7Bl%7D%7D%7B%5Cpartial%20w%5E%7Bl%7D%7D%20%3D%20%5Cdelta%5E%7Bl%7D%20*%20a%5E%7Bl-1%7D%20%3D%20a%5E%7Bl-1%7D%20%5Cdelta%5E%7Bl%5ET%7D)
	 

Now we have the gradient of C wrt **w** and **b** for a single data point (**x**, **y**) we could use gradient descent to get closer to the (local) optimum of C by updating **w** and **c** accordingly. Doing a gradient descent step for one datapoint at a time is called online learning. In praxis it is faster to repeat the process for a few more randomly sampled (without replacement) data points (called mini-batch) add all derivatives up, multiply them with a learning rate, and then update **w** and **b**. This is done for several epochs (where one epoch means going through all the data points once).

Why does gradient descent not end up in a local minimum? It sometimes does. Using regularisation techniques helps.
