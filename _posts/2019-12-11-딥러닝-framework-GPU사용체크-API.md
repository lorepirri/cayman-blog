---
layout: page
title: "Tensorflow, Keras, Pytorch GPU 사용여부 체크하기"
description: "Tensorflow, Keras, Pytorch GPU 사용여부 체크하는 방법에 대하여 알아보겠습니다."
headline: "Tensorflow, Keras, Pytorch GPU 사용여부 체크하는 방법에 대하여 알아보겠습니다."
tags: [tensorflow, keras, pytorch, cuda, cudnn]
comments: true
published: true
categories: machine-learning
typora-copy-images-to: ../images/2019-12-11
---







딥러닝 프레임워크에서 GPU 사용여부를 체크할 수 있는 API에 대하여 알려드리도록 하겠습니다. 



## Tested Environments

* TensorFlow (1.14.0)
* Keras (2.2.4)
* Pytorch (1.3.1)



## 1. TensorFlow

```python
import tensorflow as tf

print(tf.__version__)
# 1.14.0

tf.test.is_gpu_available(
    cuda_only=False,
    min_cuda_compute_capability=None
)
# True
```



## 2. Keras

```python
from keras import backend as K

print(keras.__version__)
# 2.2.4

K.tensorflow_backend._get_available_gpus()
# ['/job:localhost/replica:0/task:0/device:GPU:0']
```



## 3. PyTorch

```python
import torch

torch.cuda.device_count()
# 1

torch.cuda.get_device_name(0)
# GeForce RTX 2080 Ti

torch.cuda.is_available()
# True
```



<br>

<br>

<hr>

## 끝!



읽어 주셔서 감사합니다.



##### #tensorflow #keras #pytorch #gpu