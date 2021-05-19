---
layout: page
title: "Data Science (데이터 분석)을 위한 python package 리스트(1) - 필수 패키지"
description: "데이터 분석을 위한 python package 리스트 모음에 대하여 알아보겠습니다."
tags: [data_science, python]
comments: true
published: true
categories: data_science
typora-copy-images-to: ../images/2019-07-05
---



Python을 활용한 Data Science, 즉 더 구체적으로 얘기하자면, 데이터 분석을 할 때는 다양한 패키지들을 활용하게 됩니다. 초기에 가상환경을 여러개 만들어 놓고 상황에 맞춰 돌아가면서 쓸 수 있습니다.

가령, 딥러닝이 필요한 순간에는 딥러닝에 필요한 다양한 패키지들로 구성된 가상환경을 만들어 놓고, 해당 패키지들이 설치된 가상환경을 로딩하겠구요, 단순 시각화가 필요한 순간에는 무거운 딥러닝 관련 패키지들이 필요 없을테니, 시각화에 필요한 패키지들이 설치된 가상환경을 불러다 사용하면 되겠죠?

(사실은, 너무 귀찮아서 딥러닝 패키지에 왠만한 시각화 패키지들도 설치되어 있으니, 그냥 딥러닝용 가상환경을 불러와서 시각화 작업을 하기도 합니다.)



하지만, 이렇게만 사용한다면, 굳이 가상환경을 사용할 필요 없이 모든 패키지를 디폴트 환경에 설치해놓고 무겁게 사용하는 것과 다를바 없겠죠?



어찌되었건, 이번에 컴퓨터도 깨끗하게 포맷한 김에, Data Science에 필요한 패키지들, 혹은 그 밖에 파이썬을 한다면 유용한 패키지들을 분류해보기로 하였습니다.



## 필수 설치 (Tools)

### Jupyter Notebook

> Summery

아나콘다가 설치되어 있다면, 따로 설치할 필요는 없습니다. 하지만, 그렇지 않다면 반드시 설치해야하는 라이브러리 중에 하나입니다. Jupyter Notebook은 웹브라우져에서 파이썬 코드를 작성 및 실행해 주는 라이브러리입니다. 저는 거의 모든 작업을 jupyter notebook에서 한다고 해도 과언이 아니죠. 정말 jupyter notebook을 만들어 주신 분께 깊은 감사를 드립니다.



> Documentation

https://jupyter.org/documentation



> Install

```bash
pip install jupyter
# anaconda는 기본 설치 되어 있음
conda install -c conda-forge jupyter 
```



## Data Analysis (데이터 분석)

### 1. Pandas

> Summery 

Pandas는 파이썬에서 사용하는 데이터분석 라이브러리로, 행과 열로 이루어진 데이터 객체를 만들어 다룰 수 있게 되며 보다 안정적으로 대용량의 데이터들을 처리하는데 매우 편리한 도구 입니다. DataFrame은 사랑입니다. 무조건 설치합시다.



> Documentation

https://pandas.pydata.org/pandas-docs/stable/



> Install

```bash
pip install pandas
conda install pandas
```



> More

Pandas를 연습해 보고 싶다면, 유명한 **[10 Minutes to pandas](https://pandas.pydata.org/pandas-docs/stable/getting_started/10min.html)** 를 반드시 해보세요!



### 2. Numpy

> Summery

Numpy 역시 무조건 설치해야 하는 패키지 중에 하나죠. 수학적 계산을 위한 라이브러리 입니다. 다양한 연산을 가능케 하고, 머신러닝을 한다면 무조건 설치해야하는 라이브러리 이기도 합니다. Pandas와 더불어 필수 설치 라이브러리 입니다.



> Documentation

https://pandas.pydata.org/



> Install

```bash
pip install numpy
# anaconda는 기본 설치 되어 있음
conda install -c conda-forge numpy
```



### 3. SciPy

> Summery

SciPy는 NumPy, Matplotlib, pandas와 밀접한 관계에 있는 라이브러리입니다. wikidocs에 의하면,

*'SciPy는 NumPy 상위에서 구동되는 라이브러리 정도로 이해해도 무방하다'*

*'NumPy, SciPy 등은 수치계산을 위한 패키지이므로 성능이 중요하다'*

주로 수학/과학 연산을 할 때 많이 사용하는 라이브러리입니다.



> Documentation

https://docs.scipy.org/doc/scipy/reference/



> Install

```bash
pip install scipy
# anaconda는 기본 설치 되어 있음
conda install -c conda-forge scipy
```







다음 포스팅에서는 이어서 머신러닝/딥러닝에 활용하는 패키지에 대하여 설명드리도록 하겠습니다.


