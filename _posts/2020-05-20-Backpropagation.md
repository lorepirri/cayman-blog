---
layout: post
title: "Backpropagation"
categories: misc
---

Essentially, neural networks are uniform approximators of any function that maps an input vector **x** (fed into the input layer neurons) to an output vector **y** (represented by the output layer neurons). When the neural network means to optimise an objective function of the ground truth output vector **y** and the activation of of the neurons in the output layer. Let this objective function function be

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![equation](https://latex.codecogs.com/gif.latex?C%28a%5E%7BL%7D%29%3D%5Cfrac%7B1%7D%7B2%7D%5Cleft%5C%7Cy-a%5E%7BL%7D%5Cright%5C%7C%5E%7B2%7D%3D%5Cfrac%7B1%7D%7B2%7D%20%5Csum_%7Bj%7D%5Cleft%28y_%7Bj%7D-a_%7Bj%7D%5E%7BL%7D%5Cright%29%5E%7B2%7D)

where **a<sub>L</sub><sup>j</sup>** is the activation of the j<sup>th</sup> neuron in the output layer (denoted with capital L) given an input sample **x**, and **y** is the ground truth output layer activation of the sample **x**.
For any single data point (**x**, **y**) of input vector **x** and ground truth output vector **y**, one calculates the derivatives of the objective function C wrt all weights and biases in the neural network*. Note however, that C(a<sup>L</sup>) has a simple shape (a parabola) and we can easily calculate dC(a<sup>L</sup>)/da<sup>L</sup> analytically. However, **a** is a function of the weights, **w** and the biases **b** in the neural network and calculating C(**w**, **b**) is much more demanding. I think it is not possible analytically, but the **backpropagation algorithm** efficiently calculates the gradient of C(**w**, **b**) at the current location (**w**, **b**) numerically.
For a simpler notation, lets define the derivative of the cost function wrt zjl (zjl = ail-1*wjl + bjl, the weighted sum of inputs from the previous layer plus the bias; i.e. the input in the sigmoid function) of neuron j in layer l as deltajl
 
Note that for the output layer L these derivatives are easily calculated using the chain rule dC(a(z))/dz = dC/da * da/dz:
  or in vector notation  
Where the encircled dot means element wise multiplication (Hadamart product) rather than dot product.
Now observe that delta in layer l is amplified through layer l+1 proportionally to the weights in layer l+1:
 
Now use the chain rule again to get from delta = dC/dz(w, b) to dC/db
dC/dbl = dC/dzL * dzl/dbl = deltal * 1 = deltal.
 

And similarly for dC/dz(w, b) to dC/dw:
dC/dwl = dC/dzL * dzl/dwl = deltal * al-1
	 

Now that we have the gradient of C for o single data point (x, y), we technically could adapt the weights (called online learning). In praxis it is faster to repeat the process for a few more randomly sampled (without replacement) data points (called mini-batch) add all derivatives up, multiply them with a learning rate, and then update the weights. This is done for several epochs (where one epoch means going through all the data points once).
A quite easy to read code can be found in my bookshelf.

Why does gradient descent not end up in a local minimum? It probably does, I guess. But the objective function value in this local minimum is usually low enough for the neural network to be a good classifier.

* a sigmoidal neuron follows the function
		Σ(z)=1/(1+e^(-z) )
where z is the weighted sum of the outputs of neurons of the previous layer minus a bias
		z=∑_j▒〖w_j x_j*-b〗
