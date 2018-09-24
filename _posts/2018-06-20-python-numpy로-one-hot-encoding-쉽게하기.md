---
layout: page
title: "python - Numpy로 One-hot Encoding 쉽게 하기"
description: "python - Numpy로 One-hot Encoding 쉽게 하기"
categories: machine-learning
tags: one-hot-encoding
comments: true
published: true
---


머신러닝(machine-learning)에서 dataset을 돌리기 전에 one-hot encoding을 해야하는 경우가 많다.

이때 numpy의 eye() 함수를 활용하여 쉽고 간결하게 할 수 있다.



먼저, one-hot encoding 이 도대체 뭔지 보자.



## One-hot Encoding 이란?

다음과 같이 3가지 꽃의 종류가 있다고 가정하자.

0: 장미, 1: 튤립, 2: 백합

상위 3가지의 꽃이 데이터 셋에 각각 해당 타입의 숫자의 배열로 되어 있다.

예시)

[0, 1, 2, 1, 2, 0, 0, 0, 1, 2, ...]



머신러닝을 태울때, 위와 같이 0, 1, 2의 데이터가 들어간다면, 장미 / 튤립 / 백합은 서로 관계 없는 꽃의 종류일지라도 숫자로 표현 되어있기 때문에 학습을 할 때 영향을 미칠 수 있다. 

더욱 쉽게 예로 설명하자면,

**1 + 1 = 2 라는 수식이 곧,**

**튤립 + 튤립 = 백합**

이라는 결과를 초래할 수 있다는 점이다.



*이를 방지하기 위해*

꽃의 종류가 **3** 가지라면, 별도의 3개의 column을 만들고 3개의 column 중 해당 타입의 column 에만 1, 다른 column은 0을 대입해주는 pre-processing 을 거쳐야 하고, 이는 곧 one-hot encoding 의 기법이다.

즉, 다음과 같이 바뀌게 된다.

[1, 0, 0]

[0, 1, 0]

[0, 0, 1]

[0, 1, 0]

[0, 0, 1]

...



## Numpy로 one-hot encoding 을 쉽게 하자



우선 sklearn.dataset 의 iris 데이터셋을 이용해 보겠다.



#### Load Dataset

```python
import numpy as np
import pandas as pd

# load dataset
from sklearn.datasets import load_iris
iris = load_iris()
```



#### One-hot encoding

```python
target = iris['target']

num = np.unique(target, axis=0)
num = num.shape[0]

encoding = np.eye(num)[target]
```



#### Result

```python
encoding

array([[1., 0., 0.],
       [1., 0., 0.],
       [1., 0., 0.],
       [1., 0., 0.],
       [1., 0., 0.],
       [1., 0., 0.],
       [1., 0., 0.],
	   ...
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
	   ...
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
       [0., 1., 0.],
	   ...
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.],
       [0., 0., 1.]])
```





##### #python #one_hot_encoding #machine_learning #numpy