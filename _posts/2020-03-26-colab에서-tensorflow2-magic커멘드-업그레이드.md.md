---
layout: page
title: "Google Colab에서 코드 한 줄(magic command)로 tensorflow2.0으로 업그레이드"
description: "Google Colab에서 코드 한 줄(magic command)로 tensorflow2.0으로 업그레이드하는 방법에 대하여 알려드립니다."
headline: "Google Colab에서 코드 한 줄(magic command)로 tensorflow2.0으로 업그레이드하는 방법에 대하여 알려드립니다."
tags: [colab, google, python, tensorflow2.0]
comments: true
published: true
categories: data_science
typora-copy-images-to: ../images/2020-03-26

---



Google Colab에서 tensorflow 2.0으로 magic command를 통해 손쉽게 업그레이드 하는 방법에 대하여 알려드리겠습니다.

**2020년 3월 26일 기준**

- colab에서 제공하는 기본 tensorflow version: **1.15.0**



![image-20200326170958836](../images/2020-03-26/image-20200326170958836.png)



## magic command로 tensorflow 버젼 변경

* magic command를 실행하기 전에, 먼저 **tensorflow를 import 하시면 안됩니다!**

* 반드시, magic command를 먼저 실행해주세요
* 아래의 magic command로 별도의 **tensorflow 버전 설치 필요없이, 버전을 변경**하실 수 있습니다.



> 2.x 버전으로 변경하는 magic command

```python
%tensorflow_version 2.x

import tensorflow as tf
print(tf.__version__)
# 2.1.0
```



> 1.x 버전으로 변경하는 magic command

```python
%tensorflow_version 1.x

import tensorflow as tf
print(tf.__version__)

# 1.15.0
```



## Reference

 Colab 파일은 아래 노트북 파일해서 확인해 보실 수 있습니다.

[The %tensorflow_version magic](https://colab.research.google.com/notebooks/tensorflow_version.ipynb)

