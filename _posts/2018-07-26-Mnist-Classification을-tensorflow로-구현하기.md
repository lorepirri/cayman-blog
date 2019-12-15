---
layout: page
title: "Tensorflow를 활용하여 Mnist data classification을 CNN으로 구현"
description: "Tensorflow를 활용하여 Mnist data classification을 CNN으로 구현해 보겠습니다."
categories: machine-learning
tags: [tensorflow, cnn, machine-learning]
comments: true
published: true
---

이번 포스팅에서는 Google Tensorflow의 웹사이트의 Demo에 나와 있는 가이드라인에 따라, tensorflow 라이브러리를 활용하여 구현해 보도록 하겠습니다.



우선 Mnist 데이터를 Classification 하기 위하여 Convolution Neural Network (CNN) 를 활용할 예정인데요.

CNN을 활용하기 위해서 Filter, Strides, Max pooling 과 같은 파라미터 값들을 데모에서 가이드라인으로 제시하고 있습니다. 

관련 내용은 [이곳](https://www.tensorflow.org/tutorials/estimators/cnn) 에서 확인하실 수 있습니다.



### CNN Architecture Modeling



**Convolutional Layer #1**: Applies 32 5x5 filters (extracting 5x5-pixel subregions), with ReLU activation function

**Pooling Layer #1**: Performs max pooling with a 2x2 filter and stride of 2 (which specifies that pooled regions do not overlap)

**Convolutional Layer #2**: Applies 64 5x5 filters, with ReLU activation function

**Pooling Layer #2**: Again, performs max pooling with a 2x2 filter and stride of 2

**Dense Layer #1**: 1,024 neurons, with dropout regularization rate of 0.4 (probability of 0.4 that any given element will be dropped during training)

**Dense Layer #2 (Logits Layer)**: 10 neurons, one for each digit target class (0–9).



CNN layer를 2개층으로 구성하고, Fully-connected 한 후 classification 하는 것으로 가이드라인을 하고 있습니다.



### Tensorflow 로 구현해보기

```python
import numpy as np
import tensorflow as tf

# load dataset
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)

# parameter
learning_rate = 0.01
batch_size = 1000
num_epoch = 15

X = tf.placeholder(tf.float32, shape=[None, 28*28])
Y = tf.placeholder(tf.float32, shape=[None, 10])
keep_prob = tf.placeholder(tf.float32)

X_input = tf.reshape(X, shape=[-1, 28, 28, 1])
# shape (?, 28, 28, 1)

W1 = tf.get_variable('W1', shape=[5, 5, 1, 32])
# shape (5, 5, 1, 32)

L1 = tf.nn.conv2d(X_input, W1, strides=[1, 1, 1, 1], padding='SAME')
# shape (?, 28, 28, 32)

L1 = tf.nn.relu(L1)
# shape (?, 28, 28, 32)

L1 = tf.nn.max_pool(L1, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding='VALID')
# shape (?, 14, 14, 32)

W2 = tf.get_variable('W2', shape=[5, 5, 32, 64])
# shape (5, 5, 32, 64)

L2 = tf.nn.conv2d(L1, W2, strides=[1, 1, 1, 1], padding='SAME')
# shape (?, 14, 14, 64)

L2 = tf.nn.relu(L2)
# shape (?, 14, 14, 64)

L2 = tf.nn.max_pool(L2, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding='VALID')
# shape (?, 7, 7, 64)

# fully-connected를 위한 matrix flatten
L2 = tf.layers.flatten(L2)

# fully-connected
W3 = tf.get_variable('W3', shape=[7*7*64, 1024], initializer=tf.contrib.layers.xavier_initializer())
b3 = tf.Variable(tf.random_normal([1024], stddev=0.01))
L3 = tf.matmul(L2, W3) + b3
L3 = tf.nn.dropout(L3, keep_prob=keep_prob)

W4 = tf.get_variable('W4', shape=[1024, 10], initializer=tf.contrib.layers.xavier_initializer())
b4 = tf.Variable(tf.random_normal([10], stddev=0.01))
logit = tf.matmul(L3, W4) + b4

hypothesis = tf.nn.softmax(logit)
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits_v2(logits=logit, labels=Y))
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate).minimize(cost)

# accuracy 측정
predicted = tf.argmax(hypothesis, axis=1)
actual = tf.argmax(Y, axis=1)
accuracy = tf.reduce_mean(tf.cast(tf.equal(predicted, actual), tf.float32))

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    num_batch = int(mnist.train.num_examples / batch_size)
    for epoch in range(num_epoch):
        avg_cost = 0
        for b in range(num_batch):
            batch_xs, batch_ys = mnist.train.next_batch(batch_size)
            cost_val, _ = sess.run([cost, optimizer], feed_dict={X: batch_xs, Y: batch_ys, keep_prob: 0.4})
            avg_cost += cost_val / num_batch
        print("epoch {0}, cost = {1:.5f}".format(epoch, cost_val))
    accuracy_val = sess.run(accuracy, feed_dict={X: mnist.test.images, Y: mnist.test.labels, keep_prob: 1.0}) 
    print("result, accuracy = {0:.5f}".format(accuracy_val))

```



최종 Accuracy는 epoch을 15번 돈 기준으로 98.66%가 나왔습니다.



참고 문헌: https://www.tensorflow.org/tutorials/estimators/cnn


