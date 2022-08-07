---
layout: page
title: "PyTorch의 자동미분(AutoGrad)을 활용하여 정형 데이터 예측기(regression model)구현"
description: "PyTorch의 자동미분(AutoGrad)을 활용하여 정형 데이터 예측기(regression model)에 대해 알아보겠습니다."
headline: "PPyTorch의 자동미분(AutoGrad)을 활용하여 정형 데이터 예측기(regression model)에 대해 알아보겠습니다."
categories: pytorch
tags: [python, 파이썬, pytorch, 파이토치, 경사하강법, gradient descent, 파이토치 입문, 정형데이터, 보스톤 주택가격, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2022-08-06
---

이번 튜토리얼에서는 scikit-learn의 내장 데이터셋인 보스톤 주택 가격 데이터셋을 활용하여 회귀 예측 모델(regression model)을 만들고 예측해 보도록 하겠습니다.

PyTorch의 자동 미분 기능을 활용하여 구현하였으며, 자동미분 기능에 대한 내용은 이전 포스팅에서 공유하였습니다.(아래 링크를 참고해 주세요)

- [경사하강법 구현](https://teddylee777.github.io/scikit-learn/gradient-descent)

- [PyTorch의 자동미분(AutoGrad)기능과 경사하강법(Gradient Descent) 구현](https://teddylee777.github.io/pytorch/pytorch-gradient-descent)

- [경사하강법 기본 개념(YouTube)](https://www.youtube.com/watch?v=GEdLNvPIbiM)


<head>
  <style>
    table.dataframe {
      white-space: normal;
      width: 100%;
      height: 240px;
      display: block;
      overflow: auto;
      font-family: Arial, sans-serif;
      font-size: 0.9rem;
      line-height: 20px;
      text-align: center;
      border: 0px !important;
    }

    table.dataframe th {
      text-align: center;
      font-weight: bold;
      padding: 8px;
    }

    table.dataframe td {
      text-align: center;
      padding: 8px;
    }

    table.dataframe tr:hover {
      background: #b8d1f3; 
    }

    .output_prompt {
      overflow: auto;
      font-size: 0.9rem;
      line-height: 1.45;
      border-radius: 0.3rem;
      -webkit-overflow-scrolling: touch;
      padding: 0.8rem;
      margin-top: 0;
      margin-bottom: 15px;
      font: 1rem Consolas, "Liberation Mono", Menlo, Courier, monospace;
      color: $code-text-color;
      border: solid 1px $border-color;
      border-radius: 0.3rem;
      word-break: normal;
      white-space: pre;
    }

  .dataframe tbody tr th:only-of-type {
      vertical-align: middle;
  }

  .dataframe tbody tr th {
      vertical-align: top;
  }

  .dataframe thead th {
      text-align: center !important;
      padding: 8px;
  }

  .page__content p {
      margin: 0 0 0px !important;
  }

  .page__content p > strong {
    font-size: 0.8rem !important;
  }

  </style>
</head>


## 샘플 데이터셋 로드



```python
import pandas as pd
import matplotlib.pyplot as plt
import warnings
from sklearn.datasets import load_boston
import torch

warnings.filterwarnings('ignore')
```


```python
# sklearn.datasets 내장 데이터셋인 보스톤 주택 가격 데이터셋 로드
data = load_boston()
```

**컬럼 소개**



속성 수 : 13



* **CRIM**: 자치시 별 범죄율

* **ZN**: 25,000 평방 피트를 초과하는 주거용 토지의 비율

* **INDUS**: 비소매(non-retail) 비즈니스 토지 비율

* **CHAS**: 찰스 강과 인접한 경우에 대한 더비 변수 (1= 인접, 0= 인접하지 않음)

* **NOX**: 산화 질소 농도 (10ppm)

* **RM**:주택당 평균 객실 수

* **AGE**: 1940 년 이전에 건축된 자가소유 점유 비율

* **DIS**: 5 개의 보스턴 고용 센터까지의 가중 거리     

* **RAD**: 고속도로 접근성 지수

* **TAX**: 10,000 달러 당 전체 가치 재산 세율

* **PTRATIO**  도시별 학생-교사 비율

* **B**: 인구당 흑인의 비율. 1000(Bk - 0.63)^2, (Bk는 흑인의 비율을 뜻함)

* **LSTAT**: 하위 계층의 비율

* **target**: 자가 주택의 중앙값 (1,000 달러 단위)



```python
# 데이터프레임 생성. 504개의 행. Feature: 13개, target은 예측 변수(주택가격)
df = pd.DataFrame(data['data'], columns=data['feature_names'])
df['target'] = data['target']
print(df.shape)
df.head()
```

<pre>
(506, 14)
</pre>
<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CRIM</th>
      <th>ZN</th>
      <th>INDUS</th>
      <th>CHAS</th>
      <th>NOX</th>
      <th>RM</th>
      <th>AGE</th>
      <th>DIS</th>
      <th>RAD</th>
      <th>TAX</th>
      <th>PTRATIO</th>
      <th>B</th>
      <th>LSTAT</th>
      <th>target</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.00632</td>
      <td>18.0</td>
      <td>2.31</td>
      <td>0.0</td>
      <td>0.538</td>
      <td>6.575</td>
      <td>65.2</td>
      <td>4.0900</td>
      <td>1.0</td>
      <td>296.0</td>
      <td>15.3</td>
      <td>396.90</td>
      <td>4.98</td>
      <td>24.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.02731</td>
      <td>0.0</td>
      <td>7.07</td>
      <td>0.0</td>
      <td>0.469</td>
      <td>6.421</td>
      <td>78.9</td>
      <td>4.9671</td>
      <td>2.0</td>
      <td>242.0</td>
      <td>17.8</td>
      <td>396.90</td>
      <td>9.14</td>
      <td>21.6</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.02729</td>
      <td>0.0</td>
      <td>7.07</td>
      <td>0.0</td>
      <td>0.469</td>
      <td>7.185</td>
      <td>61.1</td>
      <td>4.9671</td>
      <td>2.0</td>
      <td>242.0</td>
      <td>17.8</td>
      <td>392.83</td>
      <td>4.03</td>
      <td>34.7</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.03237</td>
      <td>0.0</td>
      <td>2.18</td>
      <td>0.0</td>
      <td>0.458</td>
      <td>6.998</td>
      <td>45.8</td>
      <td>6.0622</td>
      <td>3.0</td>
      <td>222.0</td>
      <td>18.7</td>
      <td>394.63</td>
      <td>2.94</td>
      <td>33.4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.06905</td>
      <td>0.0</td>
      <td>2.18</td>
      <td>0.0</td>
      <td>0.458</td>
      <td>7.147</td>
      <td>54.2</td>
      <td>6.0622</td>
      <td>3.0</td>
      <td>222.0</td>
      <td>18.7</td>
      <td>396.90</td>
      <td>5.33</td>
      <td>36.2</td>
    </tr>
  </tbody>
</table>
</div>


## 데이터셋 분할 (x, y)



```python
# feature(x), label(y)로 분할
x = df.drop('target', 1)
y = df['target']

# feature 변수의 개수 지정
NUM_FEATURES = len(x.columns)
```

## 데이터 정규화



- `sklearn.preprocessing 의 `StandardScaler`나 `MinMaxScaler`로 특성(feature) 값을 표준화 혹은 정규화를 진행합니다.



```python
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
x_scaled = scaler.fit_transform(x)
x_scaled[:5]
```

<pre>
array([[-0.41978194,  0.28482986, -1.2879095 , -0.27259857, -0.14421743,
         0.41367189, -0.12001342,  0.1402136 , -0.98284286, -0.66660821,
        -1.45900038,  0.44105193, -1.0755623 ],
       [-0.41733926, -0.48772236, -0.59338101, -0.27259857, -0.74026221,
         0.19427445,  0.36716642,  0.55715988, -0.8678825 , -0.98732948,
        -0.30309415,  0.44105193, -0.49243937],
       [-0.41734159, -0.48772236, -0.59338101, -0.27259857, -0.74026221,
         1.28271368, -0.26581176,  0.55715988, -0.8678825 , -0.98732948,
        -0.30309415,  0.39642699, -1.2087274 ],
       [-0.41675042, -0.48772236, -1.30687771, -0.27259857, -0.83528384,
         1.01630251, -0.80988851,  1.07773662, -0.75292215, -1.10611514,
         0.1130321 ,  0.41616284, -1.36151682],
       [-0.41248185, -0.48772236, -1.30687771, -0.27259857, -0.83528384,
         1.22857665, -0.51117971,  1.07773662, -0.75292215, -1.10611514,
         0.1130321 ,  0.44105193, -1.02650148]])
</pre>
## PyTorch를 활용하여 회귀(regression) 예측


random 텐서 `w`, 와 `b`를 생성합니다.



`w`의 `Size()`는 `13개`입니다. 이유는 특성(feature) 변수의 개수와 동일해야 합니다.



```python
# random w, b 생성
w = torch.randn(NUM_FEATURES, requires_grad=True, dtype=torch.float64)
b = torch.randn(1, requires_grad=True, dtype=torch.float64)

# w의 Size()는 13, b는 1개 생성
w.shape, b.shape
```

<pre>
(torch.Size([13]), torch.Size([1]))
</pre>
손실함수(Mean Squared Error)를 정의 합니다.



```python
# Mean Squared Error(MSE) 오차 정의
loss_fn = lambda y_true, y_pred: ((y_true - y_pred)**2).mean()
```

`x`, `y`를 tensor로 변환합니다.



```python
x = torch.tensor(x.values)
y = torch.tensor(y.values)

x.shape, y.shape
```

<pre>
(torch.Size([506, 13]), torch.Size([506]))
</pre>
단순 선형회귀 생성(simple linear regression)



```python
y_hat = torch.matmul(x, w)
print(y_hat.shape)

# y_hat 10개 출력
y_hat[:10].data.numpy()
```

<pre>
torch.Size([506])
</pre>
<pre>
array([504.58749365, 501.44041442, 507.16780689, 500.17918239,
       498.14041044, 493.3604812 , 516.7218424 , 503.8540962 ,
       484.73801297, 498.52203452])
</pre>
## 경사하강법을 활용한 회귀 예측



```python
# 최대 반복 횟수 정의
num_epoch = 20000

# 학습율 (learning_rate)
learning_rate = 3e-6

# random w, b 생성
w = torch.randn(NUM_FEATURES, requires_grad=True, dtype=torch.float64)
b = torch.randn(1, requires_grad=True, dtype=torch.float64)

# loss, w, b 기록하기 위한 list 정의
losses = []

for epoch in range(num_epoch):
    # Affine Function
    y_hat =  torch.matmul(x, w) + b

    # 손실(loss) 계산
    loss = loss_fn(y, y_hat)
    
    # 손실이 20 보다 작으면 break 합니다.
    if loss < 20:
        break

    # w, b의 미분 값인 grad 확인시 다음 미분 계산 값은 None이 return 됩니다.
    # 이러한 현상을 방지하기 위하여 retain_grad()를 loss.backward() 이전에 호출해 줍니다.
    w.retain_grad()
    b.retain_grad()
    
    # 미분 계산
    loss.backward()
    
    # 경사하강법 계산 및 적용
    # w에 learning_rate * (그라디언트 w) 를 차감합니다.
    w = w - learning_rate * w.grad
    # b에 learning_rate * (그라디언트 b) 를 차감합니다.
    b = b - learning_rate * b.grad
    
    # 계산된 loss, w, b를 저장합니다.
    losses.append(loss.item())

    if epoch % 2500 == 0:
        print("{0:05d} loss = {1:.5f}".format(epoch, loss.item()))
    
print("----" * 15)
print("{0:05d} loss = {1:.5f}".format(epoch, loss.item()))
```

<pre>
00000 loss = 228077.91919
02500 loss = 106.72257
05000 loss = 83.11569
07500 loss = 69.57229
10000 loss = 61.05278
12500 loss = 55.39707
15000 loss = 51.50926
17500 loss = 48.76540
------------------------------------------------------------
19999 loss = 46.78366
</pre>
## weight 출력



- 음수: 종속변수(주택가격)에 대한 반비례

- 양수: 종속변수(주택가격)에 대한 정비례

- 회귀계수:

  - 계수의 값이 커질 수록 종속변수(주택가격)에 더 크게 영향을 미침을 의미

  - 계수의 값이 0에 가깝다면 종속변수(주택가격)에 영향력이 없음을 의미



```python
pd.DataFrame(list(zip(df.drop('target', 1).columns, w.data.numpy())), columns=['features', 'weights']) \
.sort_values('weights', ignore_index=True)
```

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>features</th>
      <th>weights</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>CHAS</td>
      <td>-2.446808</td>
    </tr>
    <tr>
      <th>1</th>
      <td>DIS</td>
      <td>-0.928738</td>
    </tr>
    <tr>
      <th>2</th>
      <td>LSTAT</td>
      <td>-0.659547</td>
    </tr>
    <tr>
      <th>3</th>
      <td>CRIM</td>
      <td>-0.207502</td>
    </tr>
    <tr>
      <th>4</th>
      <td>INDUS</td>
      <td>-0.034981</td>
    </tr>
    <tr>
      <th>5</th>
      <td>TAX</td>
      <td>-0.016615</td>
    </tr>
    <tr>
      <th>6</th>
      <td>B</td>
      <td>0.040406</td>
    </tr>
    <tr>
      <th>7</th>
      <td>AGE</td>
      <td>0.091680</td>
    </tr>
    <tr>
      <th>8</th>
      <td>ZN</td>
      <td>0.163376</td>
    </tr>
    <tr>
      <th>9</th>
      <td>NOX</td>
      <td>0.210683</td>
    </tr>
    <tr>
      <th>10</th>
      <td>RAD</td>
      <td>0.445787</td>
    </tr>
    <tr>
      <th>11</th>
      <td>PTRATIO</td>
      <td>0.510213</td>
    </tr>
    <tr>
      <th>12</th>
      <td>RM</td>
      <td>0.885634</td>
    </tr>
  </tbody>
</table>
</div>



```python
# 전체 loss 에 대한 변화량 시각화
plt.figure(figsize=(14, 6))
plt.plot(losses[:100], c='darkviolet', linestyle=':')

plt.title('Losses over epoches', fontsize=15)
plt.xlabel('Epochs')
plt.ylabel('Error')
plt.show()
```

<img src="data:image/png;base64,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"/>
