---
layout: page
title: "torchvision의 transform으로 이미지 정규화하기(평균, 표준편차를 계산하여 적용)"
description: "torchvision의 transform으로 이미지 정규화하기(평균, 표준편차를 계산하여 적용)에 대해 알아보겠습니다."
headline: "torchvision의 transform으로 이미지 정규화하기(평균, 표준편차를 계산하여 적용)에 대해 알아보겠습니다."
categories: linux
tags: [python, 파이썬, torch, pytorch, 이미지정규화, torchvision, transform, Image Transform, 이미지 전처리,data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2022-07-20
---

딥러닝 모델이 이미지를 학습하기 전 **이미지 정규화**를 진행하는 것은 **일반적으로 수행하는 전처리** 입니다.


이미지 정규화를 진행하는 대표적인 이유 중 하나는 오차역전파(backpropagation)시, 그라디언트(Gradient) 계산을 수행하게 되는데, 데이터가 유사한 범위를 가지도록 하기 위함입니다.


하지만, 정규화를 어떻게 수행하는가에 따라서 모델의 학습결과는 달라질 수 있습니다.


이번에는 다양한 정규화 적용 방법에 대하여 알아보고, 정규화된 결과가 어떻게 달라지는지 확인해 보도록 하겠습니다.

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




## 모듈 import

```python
import numpy as np
import torch
from torch.utils.data import Dataset
from torchvision import datasets, transforms
```



## `torchvision.transforms`


`torchvision`의 `transforms`를 활용하여 정규화를 적용할 수 있습니다.


`transoforms.ToTensor()` 외 다른 Normalize()를 적용하지 않은 경우



- 정규화(Normalize) 한 결과가 **0 ~ 1** 범위로 변환됩니다.



```python
transform = transforms.Compose([
    # 0~1의 범위를 가지도록 정규화
    transforms.ToTensor(),
])
```

`datasets.CIFAR10` 데이터셋을 로드 하였습니다.



데이터셋 로드시 `transform` 옵션에 지정할 수 있습니다.



```python
# datasets의 CIFAR10 데이터셋 로드 (train 데이터셋)
train = datasets.CIFAR10(root='data', 
                         train=True, 
                         download=True, 
                         # transform 지정
                         transform=transform                
                        )
```

<pre>
Files already downloaded and verified
</pre>

```python
# datasets의 CIFAR10 데이터셋 로드 (test 데이터셋)
test = datasets.CIFAR10(root='data', 
                        train=False, 
                        download=True, 
                        # transform 지정
                        transform=transform
                       )
```

<pre>
Files already downloaded and verified
</pre>

```python
# 이미지의 RGB 채널별 통계량 확인 함수
def print_stats(dataset):
    imgs = np.array([img.numpy() for img, _ in dataset])
    print(f'shape: {imgs.shape}')
    
    min_r = np.min(imgs, axis=(2, 3))[:, 0].min()
    min_g = np.min(imgs, axis=(2, 3))[:, 1].min()
    min_b = np.min(imgs, axis=(2, 3))[:, 2].min()

    max_r = np.max(imgs, axis=(2, 3))[:, 0].max()
    max_g = np.max(imgs, axis=(2, 3))[:, 1].max()
    max_b = np.max(imgs, axis=(2, 3))[:, 2].max()

    mean_r = np.mean(imgs, axis=(2, 3))[:, 0].mean()
    mean_g = np.mean(imgs, axis=(2, 3))[:, 1].mean()
    mean_b = np.mean(imgs, axis=(2, 3))[:, 2].mean()

    std_r = np.std(imgs, axis=(2, 3))[:, 0].std()
    std_g = np.std(imgs, axis=(2, 3))[:, 1].std()
    std_b = np.std(imgs, axis=(2, 3))[:, 2].std()
    
    print(f'min: {min_r, min_g, min_b}')
    print(f'max: {max_r, max_g, max_b}')
    print(f'mean: {mean_r, mean_g, mean_b}')
    print(f'std: {std_r, std_g, std_b}')
```

`transforms.ToTensor()`만 적용한 경우, 모든 이미지의 픽셀 값이 `0~1`의 범위를 가지도록 변환되었습니다.



```python
print_stats(train)
print('==='*10)
print_stats(test)
```

<pre>
shape: (50000, 3, 32, 32)
min: (0.0, 0.0, 0.0)
max: (1.0, 1.0, 1.0)
mean: (0.49139965, 0.48215845, 0.4465309)
std: (0.060528398, 0.061124973, 0.06764512)
==============================
shape: (10000, 3, 32, 32)
min: (0.0, 0.0, 0.0)
max: (1.0, 1.0, 1.0)
mean: (0.49421427, 0.48513138, 0.45040908)
std: (0.06047972, 0.06123986, 0.06758436)
</pre>


## `transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))` 적용


이번에는 `Normalize()` 함수 안에 `(0.5, 0.5, 0.5), (0.5, 0.5, 0.5)`로 적용하겠습니다.



- 정규화(Normalize) 한 결과가 **-1 ~ 1** 범위로 변환됩니다.



```python
transform = transforms.Compose([
    transforms.ToTensor(),
    # -1 ~ 1 사이의 범위를 가지도록 정규화
    transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))
])
```


```python
# datasets의 CIFAR10 데이터셋 로드 (train 데이터셋)
train = datasets.CIFAR10(root='data', 
                         train=True, 
                         download=True, 
                         transform=transform                
                        )
```

<pre>
Files already downloaded and verified
</pre>

```python
# datasets의 CIFAR10 데이터셋 로드 (test 데이터셋)
test = datasets.CIFAR10(root='data', 
                        train=False, 
                        download=True, 
                        transform=transform
                       )
```

<pre>
Files already downloaded and verified
</pre>
아래 통계에서 확인할 수 있듯이, 이미지의 픽셀 값의 범위가 `0 ~ 1` 이 아닌 `-1 ~ 1` 사이의 범위를 가지도록 변환 되었습니다.



```python
print_stats(train)
print('==='*10)
print_stats(test)
```

<pre>
shape: (50000, 3, 32, 32)
min: (-1.0, -1.0, -1.0)
max: (1.0, 1.0, 1.0)
mean: (-0.017200625, -0.035683163, -0.10693816)
std: (0.121056795, 0.122249946, 0.13529024)
==============================
shape: (10000, 3, 32, 32)
min: (-1.0, -1.0, -1.0)
max: (1.0, 1.0, 1.0)
mean: (-0.011571422, -0.029737204, -0.0991818)
std: (0.12095944, 0.12247972, 0.13516872)
</pre>


## `transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225)),` 적용시



- ImageNet이 학습한 수백만장의 이미지의 RGB 각각의 채널에 대한 평균은 `0.485`, `0.456`, `0.406` 그리고 표준편차는 `0.229`, `0.224`, `0.225` 입니다. 만약, 일반적인 조도, 각도, 배경을 포함하는 평범한 이미지의 경우는 `(0.485, 0.456, 0.406), (0.229, 0.224, 0.225)`으로 정규화하는 것을 추천한다는 커뮤니티 의견이 지배적입니다.



- 하지만, 전혀 새로운 이미지 데이터를 학습할 경우는 이 다음 섹션에서 가지고 있는 데이터셋에 대한 평균, 표준편차를 산출하여 적용할 수 있습니다.



```python
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225)),
])
```


```python
# datasets의 CIFAR10 데이터셋 로드 (train 데이터셋)
train = datasets.CIFAR10(root='data', 
                         train=True, 
                         download=True, 
                         transform=transform                
                        )
```

<pre>
Files already downloaded and verified
</pre>

```python
# datasets의 CIFAR10 데이터셋 로드 (test 데이터셋)
test = datasets.CIFAR10(root='data', 
                        train=False, 
                        download=True, 
                        transform=transform
                       )
```

<pre>
Files already downloaded and verified
</pre>

```python
print_stats(train)
print('==='*10)
print_stats(test)
```

<pre>
shape: (50000, 3, 32, 32)
min: (-2.117904, -2.0357141, -1.8044444)
max: (2.2489083, 2.4285715, 2.64)
mean: (0.027946174, 0.116778664, 0.1801375)
std: (0.2643161, 0.27287933, 0.30064496)
==============================
shape: (10000, 3, 32, 32)
min: (-2.117904, -2.0357141, -1.8044444)
max: (2.2489083, 2.4285715, 2.64)
mean: (0.04023701, 0.1300509, 0.19737385)
std: (0.26410356, 0.27339223, 0.30037493)
</pre>


## 데이터셋의 평균(mean)과 표준편차(std)를 계산하여 적용시



- 학습할 이미지 데이터셋이 일반적인 조도, 각도, 배경, 사물체가 아닌 경우는 직접 평균/표준편차를 계산하여 적용할 수 있습니다.


아래 함수는 이미지 데이터셋에 대하여 평균, 표준편차를 산출해 주는 함수 입니다.



```python
def calculate_norm(dataset):
    # dataset의 axis=1, 2에 대한 평균 산출
    mean_ = np.array([np.mean(x.numpy(), axis=(1, 2)) for x, _ in dataset])
    # r, g, b 채널에 대한 각각의 평균 산출
    mean_r = mean_[:, 0].mean()
    mean_g = mean_[:, 1].mean()
    mean_b = mean_[:, 2].mean()

    # dataset의 axis=1, 2에 대한 표준편차 산출
    std_ = np.array([np.std(x.numpy(), axis=(1, 2)) for x, _ in dataset])
    # r, g, b 채널에 대한 각각의 표준편차 산출
    std_r = std_[:, 0].mean()
    std_g = std_[:, 1].mean()
    std_b = std_[:, 2].mean()
    
    return (mean_r, mean_g, mean_b), (std_r, std_g, std_b)
```


```python
# 먼저, 변환하기 전 이미지 데이터셋을 로드 하기 위하여 transforms.ToTensor() 만 적용합니다.
transform = transforms.Compose([
    transforms.ToTensor(),
])
```


```python
# datasets의 CIFAR10 데이터셋 로드 (train 데이터셋)
train = datasets.CIFAR10(root='data', 
                         train=True, 
                         download=True, 
                         transform=transform                
                        )
```

<pre>
Files already downloaded and verified
</pre>
계산된 평균과 표준편차는 다음과 같습니다.



```python
mean_, std_ = calculate_norm(train)
print(f'평균(R,G,B): {mean_}\n표준편차(R,G,B): {std_}')
```

<pre>
평균(R,G,B): (0.49139965, 0.48215845, 0.4465309)
표준편차(R,G,B): (0.20220213, 0.19931543, 0.20086348)
</pre>
이제 계산된 평균과 표준편차를 적용하여 변환합니다.



```python
transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize(mean_, std_),
])
```


```python
# datasets의 CIFAR10 데이터셋 로드 (train 데이터셋)
train = datasets.CIFAR10(root='data', 
                         train=True, 
                         download=True, 
                         transform=transform                
                        )
```

<pre>
Files already downloaded and verified
</pre>

```python
# datasets의 CIFAR10 데이터셋 로드 (test 데이터셋)
test = datasets.CIFAR10(root='data', 
                        train=False, 
                        download=True, 
                        transform=transform
                       )
```

<pre>
Files already downloaded and verified
</pre>
아래 변환된 통계량을 보면, train 셋의 평균은 거의 `(0, 0, 0)`에 수렴하는 것을 확인할 수 있습니다. (이는 train 셋을 기준으로 변환했기 때문입니다.)



```python
print_stats(train)
print('==='*10)
print_stats(test)
```

<pre>
shape: (50000, 3, 32, 32)
min: (-2.4302397, -2.4190724, -2.2230568)
max: (2.5153067, 2.598101, 2.7554488)
mean: (2.0912171e-07, -1.5499116e-07, 8.5353854e-08)
std: (0.299346, 0.30667457, 0.3367716)
==============================
shape: (10000, 3, 32, 32)
min: (-2.4302397, -2.4190724, -2.2230568)
max: (2.5153067, 2.598101, 2.7554488)
mean: (0.01391995, 0.014915802, 0.019307619)
std: (0.29910526, 0.307251, 0.33646908)
</pre>