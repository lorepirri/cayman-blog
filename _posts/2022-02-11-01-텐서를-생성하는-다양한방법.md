---
layout: page
title:  "[PyTorch] 텐서(tensor)의 다양한 생성 방법, 속성, dtype 그리고 shape 변경"
description: "[PyTorch] 텐서(tensor)의 다양한 생성 방법, 속성, dtype 그리고 shape 변경 방법에 대하여 알아보도록 하겠습니다."
headline: "[PyTorch] 텐서(tensor)의 다양한 생성 방법, 속성, dtype 그리고 shape 변경 방법에 대하여 알아보도록 하겠습니다."
categories: pytorch
tags: [python, 인공지능 책, 테디노트 책, 테디노트, 파이썬, data science, 데이터 분석, 딥러닝, pytorch, 파이토치, torch, 텐서, tensor, from_numpy, as_tensor, numpy, view, reshape, dtype]
comments: true
published: true
---

이번 포스팅에서는 PyTorch의 텐서(Tensor) 생성하는 다양한 방법, 랜덤 텐서의 생성, 그리고 텐서의 shape 확인 및 변경 방법에 대하여 알아보도록 하겠습니다.


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


## torch import



```python
import torch
import numpy as np

# version 체크
print(torch.__version__)
```

<pre>
1.10.2+cu113
</pre>
## 기본 텐서 생성



```python
# 샘플 numpy array 생성
arr = np.arange(0, 5)
print(arr)
```

<pre>
[0 1 2 3 4]
</pre>
### `torch.from_numpy()`



- numpy array 로부터 생성. **sharing** 하므로 numpy array의 요소가 변경되면 tensor로 같이 변경됩니다



```python
t1 = torch.from_numpy(arr)
print(t1) # 출력
print(t1.dtype)  # dtype은 데이터 타입
print(t1.type()) # type()은 텐서의 타입
print(type(t1))  # t1 변수 자체의 타입
```

<pre>
tensor([0, 1, 2, 3, 4])
torch.int64
torch.LongTensor
<class 'torch.Tensor'>
</pre>
### `torch.as_tensor()`



- numpy array 로부터 생성. **sharing** 하므로 numpy array의 요소가 변경되면 tensor로 같이 변경됩니다



```python
t2 = torch.as_tensor(arr)
print(t2) # 출력
print(t2.dtype)  # dtype은 데이터 타입
print(t2.type()) # type()은 텐서의 타입
print(type(t2))  # t2 변수 자체의 타입
```

<pre>
tensor([0, 1, 2, 3, 4])
torch.int64
torch.LongTensor
<class 'torch.Tensor'>
</pre>
### `torch.tensor()` 



- numpy array 로부터 생성. **copying** 하므로 numpy array의 요소가 변경에 영향을 받지 않습니다.



```python
t3 = torch.tensor(arr)
print(t3) # 출력
print(t3.dtype)  # dtype은 데이터 타입
print(t3.type()) # type()은 텐서의 타입
print(type(t3))  # t3 변수 자체의 타입
```

<pre>
tensor([0, 1, 2, 3, 4])
torch.int64
torch.LongTensor
<class 'torch.Tensor'>
</pre>
## Zeros, Ones


### `torch.zeros()`



- 0으로 채워진 tensor를 생성합니다.

- dtype을 직접 지정하는 것이 바람직합니다.



```python
zeros = torch.zeros(3, 5, dtype=torch.int32)
print(zeros)
print(zeros.dtype)
print(zeros.type())
```

<pre>
tensor([[0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]], dtype=torch.int32)
torch.int32
torch.IntTensor
</pre>
### `torch.ones()`



- 1로 채워진 tensor를 생성합니다.

- 역시 dtype을 직접 지정하는 것이 바람직합니다.



```python
ones = torch.zeros(2, 3, dtype=torch.int64)
print(ones)
print(ones.dtype)
print(ones.type())
```

<pre>
tensor([[0, 0, 0],
        [0, 0, 0]])
torch.int64
torch.LongTensor
</pre>


## 범위로 생성


### `torch.arange(start, end, step)`



- 지정된 범위로 tensor를 생성합니다.



```python
# end만 지정
a = torch.arange(5)
print(a)
# start, end 지정
a = torch.arange(2, 6)
print(a)
# start, end, step 모두 지정
a = torch.arange(1, 10, 2)
print(a)
```

<pre>
tensor([0, 1, 2, 3, 4])
tensor([2, 3, 4, 5])
tensor([1, 3, 5, 7, 9])
</pre>
### torch.linspace(start, end, steps)



- start부터 end까지 동일 간격으로 생성합니다. steps 지정시 steps 갯수만큼 생성합니다. (미지정시 100개 생성)



```python
# start, stop 지정 ()
b = torch.linspace(2, 10)
print(b)
print(b.size(0))
print('==='*20)
# start, stop, step 모두 지정
b = torch.linspace(2, 10, 5)
print(b)
```

<pre>
tensor([ 2.0000,  2.0808,  2.1616,  2.2424,  2.3232,  2.4040,  2.4848,  2.5657,
         2.6465,  2.7273,  2.8081,  2.8889,  2.9697,  3.0505,  3.1313,  3.2121,
         3.2929,  3.3737,  3.4545,  3.5354,  3.6162,  3.6970,  3.7778,  3.8586,
         3.9394,  4.0202,  4.1010,  4.1818,  4.2626,  4.3434,  4.4242,  4.5051,
         4.5859,  4.6667,  4.7475,  4.8283,  4.9091,  4.9899,  5.0707,  5.1515,
         5.2323,  5.3131,  5.3939,  5.4747,  5.5556,  5.6364,  5.7172,  5.7980,
         5.8788,  5.9596,  6.0404,  6.1212,  6.2020,  6.2828,  6.3636,  6.4444,
         6.5253,  6.6061,  6.6869,  6.7677,  6.8485,  6.9293,  7.0101,  7.0909,
         7.1717,  7.2525,  7.3333,  7.4141,  7.4949,  7.5758,  7.6566,  7.7374,
         7.8182,  7.8990,  7.9798,  8.0606,  8.1414,  8.2222,  8.3030,  8.3838,
         8.4646,  8.5455,  8.6263,  8.7071,  8.7879,  8.8687,  8.9495,  9.0303,
         9.1111,  9.1919,  9.2727,  9.3535,  9.4343,  9.5152,  9.5960,  9.6768,
         9.7576,  9.8384,  9.9192, 10.0000])
100
============================================================
tensor([ 2.,  4.,  6.,  8., 10.])
</pre>
## tensor의 타입 변경: type()



- tensor의 dtype을 변경하기 위해서는 type() 함수를 사용합니다. type()함수의 인자로 변경할 tensor의 타입을 지정합니다.



```python
aa = torch.arange(10, dtype=torch.int32)
print(aa)
print(aa.type())

print('==='*10)
# tensor의 타입 변경
bb = aa.type(torch.int64)
print(bb)
print(bb.type())
```

<pre>
tensor([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], dtype=torch.int32)
torch.IntTensor
==============================
tensor([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
torch.LongTensor
</pre>
## 랜덤 tensor 생성



- `torch.rand()`: [0, 1) 분포 안에서 랜덤한 tensor를 생성합니다.

- `torch.randn()`: **standard normal** 분포 안에서 랜덤한 tensor를 생성합니다.

- `torch.randint()`: 정수로 채워진 랜덤한 tensor를 생성합니다.



```python
# random 생성 범위: 0 ~ 1 
rd1 = torch.rand(2, 3)
print(rd1)
```

<pre>
tensor([[0.3794, 0.0123, 0.5955],
        [0.9275, 0.2572, 0.5693]])
</pre>

```python
# random 생성 범위: standard normal
rd2 = torch.randn(2, 3)
print(rd2)
```

<pre>
tensor([[ 0.9815,  0.4774,  2.2860],
        [-1.8257, -0.0598, -1.5680]])
</pre>

```python
# randint 생성시 low, high, size를 지정한 경우
rd3 = torch.randint(low=1, high=10, size=(2, 3))
print(rd3)
```

<pre>
tensor([[9, 8, 7],
        [3, 4, 1]])
</pre>
`torch.manual_seed()`: 난수 생성시 시드의 고정



```python
# manual_seed를 고정시 고정한 cell의 난수 생성은 매번 동일한 값을 생성
torch.manual_seed(0)
rd4 = torch.randint(low=1, high=100, size=(2, 3))
print(rd4)
```

<pre>
tensor([[99, 19, 57],
        [70, 53, 70]])
</pre>
## like로 tensor 생성



- 텐서 생성 함수에서 `_like()`가 뒤에 붙는 함수를 종종 볼 수 있습니다.

- `_like()`가 붙은 이름의 함수는 `_like()` 안에 넣어주는 tensor의 shape와 동일한 tensor를 생성합니다.



**_like() 함수 목록**

- `torch.rand_like()`

- `torch.randn_like()`

- `torch.randint_like()`

- `torch.ones_like()`

- `torch.zeros_like()`



```python
x = torch.tensor([[1, 3, 5], 
                  [7, 9, 11]], dtype=torch.float32)
print(x)
print(x.type())
```

<pre>
tensor([[ 1.,  3.,  5.],
        [ 7.,  9., 11.]])
torch.FloatTensor
</pre>

```python
# [0, 1)
like1 = torch.rand_like(x)
print(like1)
print(like1.type())
```

<pre>
tensor([[0.6833, 0.7529, 0.8579],
        [0.6870, 0.0051, 0.1757]])
torch.FloatTensor
</pre>

```python
# standard normal
like2 = torch.randn_like(x)
print(like2)
print(like2.type())
```

<pre>
tensor([[-0.5382,  0.5880,  1.6059],
        [ 0.4279, -0.6776,  1.0422]])
torch.FloatTensor
</pre>

```python
# int range
like3 = torch.randint_like(x, low=1, high=100)
print(like3)
print(like3.type())
```

<pre>
tensor([[70., 62., 10.],
        [69., 22.,  5.]])
torch.FloatTensor
</pre>

```python
# zeros
like4 = torch.zeros_like(x)
print(like4)
print(like4.type())
```

<pre>
tensor([[0., 0., 0.],
        [0., 0., 0.]])
torch.FloatTensor
</pre>

```python
# ones
like5 = torch.ones_like(x)
print(like5)
print(like5.type())
```

<pre>
tensor([[1., 1., 1.],
        [1., 1., 1.]])
torch.FloatTensor
</pre>
## tensor의 shape 확인 및 변경



```python
x = torch.tensor([[1, 3, 5], 
                  [7, 9, 11]], dtype=torch.float32)
print(x)
```

<pre>
tensor([[ 1.,  3.,  5.],
        [ 7.,  9., 11.]])
</pre>
### shape 확인



```python
print(x.shape)
print(x.shape[0])
print(x.shape[1])
```

<pre>
torch.Size([2, 3])
2
3
</pre>

```python
print(x.size())
print(x.size(0))
print(x.size(1))
```

<pre>
torch.Size([2, 3])
2
3
</pre>
### shape 변경


`view()`와 `reshape()` 모두 사용가능합니다.



```python
x = torch.tensor([[1, 3, 5], 
                  [7, 9, 11]], dtype=torch.float32)
print(x)
print(x.shape)
```

<pre>
tensor([[ 1.,  3.,  5.],
        [ 7.,  9., 11.]])
torch.Size([2, 3])
</pre>

```python
print(x)
# view()로 shape 변경
print(x.view(3, 2))
```

<pre>
tensor([[ 1.,  3.,  5.],
        [ 7.,  9., 11.]])
tensor([[ 1.,  3.],
        [ 5.,  7.],
        [ 9., 11.]])
</pre>

```python
# view
x.view(-1, 1)
```

<pre>
tensor([[ 1.],
        [ 3.],
        [ 5.],
        [ 7.],
        [ 9.],
        [11.]])
</pre>

```python
# reshape
x.reshape(-1, 1)
```

<pre>
tensor([[ 1.],
        [ 3.],
        [ 5.],
        [ 7.],
        [ 9.],
        [11.]])
</pre>

```python
# view
x.view(3, -1)
```

<pre>
tensor([[ 1.,  3.],
        [ 5.,  7.],
        [ 9., 11.]])
</pre>

```python
# reshape
x.reshape(3, -1)
```

<pre>
tensor([[ 1.,  3.],
        [ 5.,  7.],
        [ 9., 11.]])
</pre>