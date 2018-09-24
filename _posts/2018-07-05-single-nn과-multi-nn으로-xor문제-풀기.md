---
layout: page
title: "Machine Learning - Single Layer NN과 Multi Layer NN으로 XOR문제 다뤄보기"
description: "Machine Learning - Single Layer NN과 Multi Layer NN으로 XOR문제 다뤄보기"
categories: machine-learning
tags: [tensorflow, xor]
comments: true
published: true
---

Single-Layer Neural Network 에서 풀 수 없는 문제인 XOR Problem을 Tensorflow를 활용하여 Multi-Layer Neural Network로 구현해 보도록 하겠다.

머신러닝/ 딥러닝 분야에서 중요하게 다루는 **XOR Problem** 은 이번 포스팅에서는 다루지 않도록 하겠다. 다만, [김성훈 교수님의 lecture](https://youtu.be/n7DNueHGkqE)를 들으면 쉽게 이해할 수 있을 것이다. 



### 간단한 데이터셋 정의

```python
x_data = np.array([[0, 0], [0, 1], [1, 0], [1, 1]], dtype=np.float32)
y_data = np.array([[0], [1], [1], [0]], dtype=np.float32)
```



### Single Layer Neural Network

```python
## feed placeholder 선언
X = tf.placeholder(tf.float32, shape=[4, 2])
Y = tf.placeholder(tf.float32, shape=[4, 1])

## Weight/ Bias 정의
W = tf.Variable(tf.random_normal([2, 1]))
b = tf.Variable(tf.random_normal([1]))

## hypothesis function
hypothesis = tf.sigmoid(tf.matmul(X, W) + b)

## cost - cross entropy
cost = -tf.reduce_mean(Y * tf.log(hypothesis) + (1-Y) * tf.log(1 - hypothesis))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.1)
train = optimizer.minimize(cost)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

## for accuracy and results
prediction = tf.cast( (hypothesis > 0.5), dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(Y, prediction), dtype=tf.float32))

for epoch in range(10000):
    _, acc_val, cost_val = sess.run([train, accuracy, cost], feed_dict={X: x_data, Y: y_data})
    if epoch % 1000 == 0:
        print(acc_val, cost_val)

print("result", acc_val, cost_val)

## result 0.5 0.6931472
```



간단한 데이터임에도 불구하고 50%의 accuracy가 나온다.



### Multi-Layer Neural Network

```python
## feed placeholder 선언
X = tf.placeholder(tf.float32, shape=[4, 2])
Y = tf.placeholder(tf.float32, shape=[4, 1])

## Weight/ Bias 정의
W1 = tf.Variable(tf.random_normal([2, 10]))
b1 = tf.Variable(tf.random_normal([10]))
W2 = tf.Variable(tf.random_normal([10, 1]))
b2 = tf.Variable(tf.random_normal([1]))

## hypothesis function (multi-layer)
hypothesis1 = tf.sigmoid(tf.matmul(X, W1) + b1)
hypothesis2 = tf.sigmoid(tf.matmul(hypothesis1, W2) + b2)

## cost - cross entropy
cost = -tf.reduce_mean(Y * tf.log(hypothesis2) + (1-Y) * tf.log(1 - hypothesis2))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.1)
train = optimizer.minimize(cost)

## for accuracy and results
prediction = tf.cast( (hypothesis2 > 0.5), dtype=tf.float32)
accuracy = tf.reduce_mean(tf.cast(tf.equal(Y, prediction), dtype=tf.float32))

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for epoch in range(10000):
    _, acc_val, cost_val = sess.run([train, accuracy, cost], feed_dict={X: x_data, Y: y_data})
    if epoch % 1000 == 0:
        print(acc_val, cost_val)

print("result", acc_val, cost_val)

## result 1.0 0.009044339
```



100% accuracy 에 도달함을 볼 수 있다.

참고로, 

W1의 shape을 [2, 2]

W2의 shape을 [2, 1]

로 적용했을 때는 accuracy가 0.5가 나온다 (높은 확률로)

이 점에 대해서는 왜그런지 좀 더 스터디 해 봐야겠다.





##### 참고: [김성훈 교수님의 "모두를 위한 딥러닝 시즌 1"](https://www.youtube.com/playlist?list=PLlMkM4tgfjnLSOjrEJN31gZATbcj_MpUm)



##### #딥러닝 #머신러닝 #XOR문제 #Multi_Layer_Neural_Network #Tensorflow

