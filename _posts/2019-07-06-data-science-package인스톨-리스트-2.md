---
layout: page
title: "Data Science (데이터 분석)을 위한 python package 리스트(2) - 시각화"
description: "Data Science (데이터 분석)을 위한 python package 리스트 모음에 대하여 알아보겠습니다."
tags: [data_science, python]
comments: true
published: true
categories: data_science
typora-copy-images-to: ../images/2019-07-05
---



Data 분석시 유용하게 쓰이는 시각화 관련 파이썬 라이브러리에 대하여 알아보겠습니다.

기본 필수 라이브러리는 설치되어 있다고 가정하겠습니다.

만약, 그렇지 않다면 [Data Science (데이터 분석)을 위한 python package 리스트(1) - 필수 패키지](https://teddylee777.github.io/python/data-science-package인스톨-리스트-1) 를 참고하시면 됩니다.



## Visualization (시각화)

### Matplotlib

> Summery

Matplotlib는 파이썬에서 자료를 차트(chart)나 플롯(plot)으로 시각화(visulaization)하는 패키지입니다. Matplotlib는 다음과 같은 정형화된 차트나 플롯 이외에도 저수준 api를 사용한 다양한 시각화 기능을 제공합니다.



> Documentation

https://matplotlib.org/api/index.html



> Install

```bash
pip install matplotlib
conda install -c conda-forge matplotlib
```



### Seaborn

> Summery

Seaborn은 Matplotlib을 기반으로 다양한 색상 테마와 통계용 차트 등의 기능을 추가한 시각화 패키지이다. 기본적인 시각화 기능은 Matplotlib 패키지에 의존하며 통계 기능은 Statsmodels 패키지에 의존합니다.



> Documentation

https://seaborn.pydata.org/api.html



> install

```bash
pip install seaborn
conda install -c conda-forge seaborn
```



### Bokeh

> Summery

Bokeh는 웹사이트에서 현대적인 웹 기반 인터랙티브 플롯을 제공하는 것을 목표로 만든 파이썬 라이브러리입니다.



> Documentation

https://bokeh.pydata.org/en/latest/docs/user_guide.html



> Install

```bash
pip install bokeh
conda install bokeh
```



