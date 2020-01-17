---
layout: page
title: "[Keras] 손실함수(Loss Function)와 평가지표(metric) 커스텀하기"
description: "[Keras] 손실함수(Loss Function)와 평가지표(metric) 커스텀법에 대하여 알아보겠습니다."
headline: "[Keras] 손실함수(Loss Function)와 평가지표(metric) 커스텀법에 대하여 알아보겠습니다."
tags: [keras, loss-function]
comments: true
published: true
categories: machine-learning
typora-copy-images-to: ../images/2020-01-17
---





이번 포스팅에서는 Keras 딥러닝 프레임워크 활용시 **loss function과 metric 을 커스텀**하는 방법에 대하여 다뤄보도록 하겠습니다.



## 나만의 Loss Function 정의

먼저, 함수형으로 Loss Function을 정의해야하는데, **미분 가능한 Loss Function** 이어야 합니다. 그렇지 않다면 나중에 Model을 compile 할 때 에러가 나게 됩니다. 그리고 인자로는 실제값인 `y_true`와 예측 값인 `y_pred`을 받게 됩니다.



> 활용 예제

```python
from keras import backend as K


# 손실함수 정의
def my_loss(y_true, y_pred):
    # 내가 정의한 손실 함수
    y_true = y_true ** 2
    y_pred = y_pred ** 2
 
 	loss = K.mean(K.abs(y_true - y_pred) + K.square(y_true - y_pred))
    return loss
```



위에서는 `y_true`와 `y_pred`의 오차율에 대한 absolute 값과 오차 제곱 값을 더한 이에 대한 평균 값을 손실로 return 해주는 예제입니다.



## 나만의 Metric 정의

때론, default로 제공되는 metric 외에 나만의 metric으로 모델이 잘 평가 되고 있는지 확인하고 싶을 수 있습니다. 

> 활용 예제

```python
# metric 정의
def my_metric(y_true, y_pred):  
    return K.mean(K.abs(y_true_f - y_pred_f)) * 1000
```

우선, 내가 평가하고 싶은 metric을 함수형으로 만들어 놓습니다.

저는 `Mean Absolute Error` metric에 1000을 곱해주었는데, 이유는 전처리 진행시 모든 값을 1000으로 나누어 주었기 때문입니다. 따라서 매 epoch 마다 print 되는 결과값이 실제 값과 차이가 있기 때문에 **metric을 정의해주면 모니터링하기 훨씬 수월**합니다.



## Model 에 적용

```python
def my_model():
    model = Sequential()
    model.add(Dense(units=100, activation='relu'))
    model.add(Dense(units=50, activation='relu'))
    model.add(Dense(units=10, activation='relu'))
    model.add(Dense(units=4, activation='relu'))
    return model

# model을 생성합니다
model = my_model()
# model을 compile 합니다. loss와 metric에는 내가 만든 함수를 대입합니다
model.compile(optimizer='adam', loss=my_loss, metrics=[my_metric])
```



이렇게 매우 간단하게 커스텀해서 loss와 metric을 측정할 수 있습니다. 여러 metric을 만들어서 매 epoch 마다 동시에 모니터링 해 볼 수 있습니다.











