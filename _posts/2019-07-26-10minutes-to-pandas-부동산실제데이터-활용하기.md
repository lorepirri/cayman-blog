---
layout: page
title: "10분만에 pandas 정복하기 - 대한민국 부동산 데이터 활용편"
description: "10분만에 pandas 정복하기 - 대한민국 부동산 데이터 활용편 에 대하여 알아보겠습니다. jupyter notebook을 활용합니다."
tags:  [data_science, pandas, python]
comments: true
published: true
categories: pandas
redirect_from:
  - data_science/10minutes-to-pandas-부동산실제데이터-활용하기
typora-copy-images-to: ../images/2019-07-26
---

Data 분석을 위해서는 **pandas**는 당연히 **기본**입니다.

문법이 어렵거나 하지 않아서 코딩을 전혀 해보지 않은 사람들도 pandas를 활용하여 손쉽게 데이터 분석을 할 수 있도록 만들어 놓은 library 입니다.

pandas의 기본 문법을 pandas에서 제공하는 [10 minutes to pandas](<https://pandas.pydata.org/pandas-docs/stable/getting_started/10min.html>) 따라서 해보면서 한 번 기초적인 분석을 해보도록 하겠습니다.

더욱 자세한 API Documentation 은 [이곳](https://pandas.pydata.org/pandas-docs/version/0.24/reference/index.html)에 있습니다.



## 데이터 준비하기

활용한 데이터는 [전국 신규 민간 아파트 분양가격 동향](https://www.data.go.kr/dataset/3035522/fileData.do)이라는 공공데이터 포탈에서 .csv로 다운로드 받은 데이터 입니다. 자료는 언제든 최신 csv로 다운로드 받으실 수 있습니다.

여기서 간혹 __csv파일을 못불러오는 에러가 뜨는 경우가 있는데__, csv 파일 타입을 반드시 utf-8 csv 파일 타입으로 변경을 해야 제대로 pandas에서 불러올 수 있으며, excel로 먼저 파일을 여신 후에 "다른 이름으로 저장" -> **UTF-8 CSV** 로 저장하시면 제대로 불러올 수 있습니다.



## pandas module import


```python
import pandas as pd
import numpy as np
```

## csv파일을 불러오기


```python
df = pd.read_csv('./data/house_price_2019_03.csv')
```

## 살펴보기


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가격(㎡)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.tail()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가격(㎡)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3565</th>
      <td>제주</td>
      <td>전체</td>
      <td>2019</td>
      <td>3</td>
      <td>3424</td>
    </tr>
    <tr>
      <th>3566</th>
      <td>제주</td>
      <td>전용면적 60㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3804</td>
    </tr>
    <tr>
      <th>3567</th>
      <td>제주</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3504</td>
    </tr>
    <tr>
      <th>3568</th>
      <td>제주</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3226</td>
    </tr>
    <tr>
      <th>3569</th>
      <td>제주</td>
      <td>전용면적 102㎡초과</td>
      <td>2019</td>
      <td>3</td>
      <td>2952</td>
    </tr>
  </tbody>
</table>
</div>



## 열의 이름 바꾸기


```python
df=df.rename(columns={'분양가격(㎡)':'분양가'})
```




```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879</td>
    </tr>
  </tbody>
</table>
</div>



## data type 보기


```python
df.dtypes
```




    지역명     object
    규모구분    object
    연도       int64
    월        int64
    분양가     object
    dtype: object




```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879</td>
    </tr>
  </tbody>
</table>
</div>




```python
df['분양가'] = df['분양가'].convert_objects(convert_numeric=True)
```



```python
df.dtypes
```




    지역명      object
    규모구분     object
    연도        int64
    월         int64
    분양가     float64
    dtype: object




```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>



## numpy array로 변환하기


```python
arr = df.to_numpy()
```


```python
arr
```




    array([['서울', '전체', 2015, 10, 5841.0],
           ['서울', '전용면적 60㎡이하', 2015, 10, 5652.0],
           ['서울', '전용면적 60㎡초과 85㎡이하', 2015, 10, 5882.0],
           ...,
           ['제주', '전용면적 60㎡초과 85㎡이하', 2019, 3, 3504.0],
           ['제주', '전용면적 85㎡초과 102㎡이하', 2019, 3, 3226.0],
           ['제주', '전용면적 102㎡초과', 2019, 3, 2952.0]], dtype=object)




```python
len(arr)
```




    3570




```python
arr[0], arr[1]
```




    (array(['서울', '전체', 2015, 10, 5841.0], dtype=object),
     array(['서울', '전용면적 60㎡이하', 2015, 10, 5652.0], dtype=object))



## 간단한 통계 보기


```python
df.describe()
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
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>3570.000000</td>
      <td>3570.000000</td>
      <td>3273.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>2017.000000</td>
      <td>6.500000</td>
      <td>3130.001833</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1.069195</td>
      <td>3.634017</td>
      <td>1141.740958</td>
    </tr>
    <tr>
      <th>min</th>
      <td>2015.000000</td>
      <td>1.000000</td>
      <td>1868.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>2016.000000</td>
      <td>3.000000</td>
      <td>2387.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>2017.000000</td>
      <td>6.500000</td>
      <td>2787.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>2018.000000</td>
      <td>10.000000</td>
      <td>3383.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>2019.000000</td>
      <td>12.000000</td>
      <td>8191.000000</td>
    </tr>
  </tbody>
</table>
</div>



## Transposing 하기 (축 변환하기)


```python
# 갯수를 지정하여 출력
df.head(3)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.T.head()
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>...</th>
      <th>3560</th>
      <th>3561</th>
      <th>3562</th>
      <th>3563</th>
      <th>3564</th>
      <th>3565</th>
      <th>3566</th>
      <th>3567</th>
      <th>3568</th>
      <th>3569</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>지역명</th>
      <td>서울</td>
      <td>서울</td>
      <td>서울</td>
      <td>서울</td>
      <td>서울</td>
      <td>인천</td>
      <td>인천</td>
      <td>인천</td>
      <td>인천</td>
      <td>인천</td>
      <td>...</td>
      <td>경남</td>
      <td>경남</td>
      <td>경남</td>
      <td>경남</td>
      <td>경남</td>
      <td>제주</td>
      <td>제주</td>
      <td>제주</td>
      <td>제주</td>
      <td>제주</td>
    </tr>
    <tr>
      <th>규모구분</th>
      <td>전체</td>
      <td>전용면적 60㎡이하</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>전용면적 102㎡초과</td>
      <td>전체</td>
      <td>전용면적 60㎡이하</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>전용면적 102㎡초과</td>
      <td>...</td>
      <td>전체</td>
      <td>전용면적 60㎡이하</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>전용면적 102㎡초과</td>
      <td>전체</td>
      <td>전용면적 60㎡이하</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>전용면적 102㎡초과</td>
    </tr>
    <tr>
      <th>연도</th>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>2015</td>
      <td>...</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
      <td>2019</td>
    </tr>
    <tr>
      <th>월</th>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>10</td>
      <td>...</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
      <td>3</td>
    </tr>
    <tr>
      <th>분양가</th>
      <td>5841</td>
      <td>5652</td>
      <td>5882</td>
      <td>5721</td>
      <td>5879</td>
      <td>3163</td>
      <td>3488</td>
      <td>3119</td>
      <td>3545</td>
      <td>3408</td>
      <td>...</td>
      <td>2877</td>
      <td>2776</td>
      <td>2855</td>
      <td>3173</td>
      <td>4303</td>
      <td>3424</td>
      <td>3804</td>
      <td>3504</td>
      <td>3226</td>
      <td>2952</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 3570 columns</p>
</div>



## 정렬


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>



### 1. Index 정렬


```python
# 내림차순 정렬
df.sort_index(axis=0, ascending=False)[:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3569</th>
      <td>제주</td>
      <td>전용면적 102㎡초과</td>
      <td>2019</td>
      <td>3</td>
      <td>2952.0</td>
    </tr>
    <tr>
      <th>3568</th>
      <td>제주</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3226.0</td>
    </tr>
    <tr>
      <th>3567</th>
      <td>제주</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3504.0</td>
    </tr>
    <tr>
      <th>3566</th>
      <td>제주</td>
      <td>전용면적 60㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3804.0</td>
    </tr>
    <tr>
      <th>3565</th>
      <td>제주</td>
      <td>전체</td>
      <td>2019</td>
      <td>3</td>
      <td>3424.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 오름차순 정렬
df.sort_index(axis=0, ascending=True)[:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>



### 2. Value 정렬


```python
# 지역명 별로 정렬
df.sort_values(by='지역명')[:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1831</th>
      <td>강원</td>
      <td>전용면적 60㎡이하</td>
      <td>2017</td>
      <td>7</td>
      <td>2167.0</td>
    </tr>
    <tr>
      <th>896</th>
      <td>강원</td>
      <td>전용면적 60㎡이하</td>
      <td>2016</td>
      <td>8</td>
      <td>2073.0</td>
    </tr>
    <tr>
      <th>895</th>
      <td>강원</td>
      <td>전체</td>
      <td>2016</td>
      <td>8</td>
      <td>2098.0</td>
    </tr>
    <tr>
      <th>215</th>
      <td>강원</td>
      <td>전체</td>
      <td>2015</td>
      <td>12</td>
      <td>2171.0</td>
    </tr>
    <tr>
      <th>216</th>
      <td>강원</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>12</td>
      <td>2292.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 연도 별로 정렬
df.sort_values(by='연도')[:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>162</th>
      <td>경남</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>11</td>
      <td>2322.0</td>
    </tr>
    <tr>
      <th>163</th>
      <td>경남</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>11</td>
      <td>2980.0</td>
    </tr>
    <tr>
      <th>164</th>
      <td>경남</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>11</td>
      <td>3043.0</td>
    </tr>
    <tr>
      <th>165</th>
      <td>제주</td>
      <td>전체</td>
      <td>2015</td>
      <td>11</td>
      <td>2232.0</td>
    </tr>
  </tbody>
</table>
</div>



## 선택 (Selection)

### 1. Column 이름으로 선택


```python
df['지역명'][:5]
```




    0    서울
    1    서울
    2    서울
    3    서울
    4    서울
    Name: 지역명, dtype: object




```python
df['연도'][:5]
```




    0    2015
    1    2015
    2    2015
    3    2015
    4    2015
    Name: 연도, dtype: int64



### 2. Index 선택


```python
# index 0 부터 5 미만까지 선택
# index 지정시 : 기준으로 왼쪽은 포함, : 기준으로 오른쪽은 미만
df[0:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 끝에 5개 출력
df[-5:]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3565</th>
      <td>제주</td>
      <td>전체</td>
      <td>2019</td>
      <td>3</td>
      <td>3424.0</td>
    </tr>
    <tr>
      <th>3566</th>
      <td>제주</td>
      <td>전용면적 60㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3804.0</td>
    </tr>
    <tr>
      <th>3567</th>
      <td>제주</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3504.0</td>
    </tr>
    <tr>
      <th>3568</th>
      <td>제주</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3226.0</td>
    </tr>
    <tr>
      <th>3569</th>
      <td>제주</td>
      <td>전용면적 102㎡초과</td>
      <td>2019</td>
      <td>3</td>
      <td>2952.0</td>
    </tr>
  </tbody>
</table>
</div>



### 3. label로 선택


```python
df.loc[:, ['지역명', '연도']][:5]
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
      <th>지역명</th>
      <th>연도</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
  </tbody>
</table>
</div>




```python
# (주의) 여기서는 :를 기준으로 우측에 있는 범위인 6을 포함하여 출력
df.loc[:6,['지역명', '연도']]
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
      <th>지역명</th>
      <th>연도</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 조건을 삽입 가능
df.loc[df.index > 5, ['지역명', '연도']][:10]
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
      <th>지역명</th>
      <th>연도</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>10</th>
      <td>경기</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>11</th>
      <td>경기</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>12</th>
      <td>경기</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>13</th>
      <td>경기</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>14</th>
      <td>경기</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>15</th>
      <td>부산</td>
      <td>2015</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 지역명 column의 값이 '인천'인 행의 '지역명', '연도' 출력
df.loc[df['지역명']=='인천',['지역명', '연도']][:10]
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
      <th>지역명</th>
      <th>연도</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>90</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>91</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>92</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>93</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>94</th>
      <td>인천</td>
      <td>2015</td>
    </tr>
  </tbody>
</table>
</div>



### 4. iloc을 활용한 인덱스 지정 선택


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.iloc[2, 1]
```




    '전용면적 60㎡초과 85㎡이하'




```python
# df.iloc과 동작방식은 동일하지만, 범위 지정은 불가
df.iat[2, 1]
```




    '전용면적 60㎡초과 85㎡이하'




```python
df.iloc[2, :]
```




    지역명                   서울
    규모구분    전용면적 60㎡초과 85㎡이하
    연도                  2015
    월                     10
    분양가                 5882
    Name: 2, dtype: object




```python
df.iloc[:5, 1]
```




    0                   전체
    1           전용면적 60㎡이하
    2     전용면적 60㎡초과 85㎡이하
    3    전용면적 85㎡초과 102㎡이하
    4          전용면적 102㎡초과
    Name: 규모구분, dtype: object




```python
# iloc으로 인덱스 지정시 : 기준으로 왼쪽은 포함, : 기준으로 오른쪽은 미만
df.iloc[:5, 1:3]
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
      <th>규모구분</th>
      <th>연도</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>전체</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>1</th>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>2</th>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>3</th>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
    </tr>
    <tr>
      <th>4</th>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
    </tr>
  </tbody>
</table>
</div>



### 5. 범위 조건 지정 선택


```python
df[df.index > 3565]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3566</th>
      <td>제주</td>
      <td>전용면적 60㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3804.0</td>
    </tr>
    <tr>
      <th>3567</th>
      <td>제주</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3504.0</td>
    </tr>
    <tr>
      <th>3568</th>
      <td>제주</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>3226.0</td>
    </tr>
    <tr>
      <th>3569</th>
      <td>제주</td>
      <td>전용면적 102㎡초과</td>
      <td>2019</td>
      <td>3</td>
      <td>2952.0</td>
    </tr>
  </tbody>
</table>
</div>



### 5-a. df.연도  와  df['연도'] 의 column 지정방식은 동일하다


```python
df[df.연도 == 2019][:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3315</th>
      <td>서울</td>
      <td>전체</td>
      <td>2019</td>
      <td>1</td>
      <td>7600.0</td>
    </tr>
    <tr>
      <th>3316</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2019</td>
      <td>1</td>
      <td>7400.0</td>
    </tr>
    <tr>
      <th>3317</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>1</td>
      <td>8105.0</td>
    </tr>
    <tr>
      <th>3318</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2019</td>
      <td>1</td>
      <td>6842.0</td>
    </tr>
    <tr>
      <th>3319</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2019</td>
      <td>1</td>
      <td>7787.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df[df['연도'] == 2019][:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3315</th>
      <td>서울</td>
      <td>전체</td>
      <td>2019</td>
      <td>1</td>
      <td>7600.0</td>
    </tr>
    <tr>
      <th>3316</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2019</td>
      <td>1</td>
      <td>7400.0</td>
    </tr>
    <tr>
      <th>3317</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>1</td>
      <td>8105.0</td>
    </tr>
    <tr>
      <th>3318</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2019</td>
      <td>1</td>
      <td>6842.0</td>
    </tr>
    <tr>
      <th>3319</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2019</td>
      <td>1</td>
      <td>7787.0</td>
    </tr>
  </tbody>
</table>
</div>



## Copy로 복사


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
copy = df.copy()
```


```python
copy.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>서울</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>서울</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>서울</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>서울</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>서울</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>



## 값 지정


```python
# 지역명 == 서울 인 지역만 선택
df.loc[df['지역명']=='서울','지역명'][:10]
```




    0     서울
    1     서울
    2     서울
    3     서울
    4     서울
    85    서울
    86    서울
    87    서울
    88    서울
    89    서울
    Name: 지역명, dtype: object




```python
# 지역명 == 서울 인 지역을 Seoul로 변경(값을 set)
df.loc[df['지역명']=='서울','지역명'] = 'Seoul'
```


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>



## reindex를 통한 지정 행과 새로운 열을 추가하여 새로운 dataframe으로 생성


```python
df1 = df.reindex(index=df.index[:7], columns=list(df.columns) + ['extra'])
```


```python
df1
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
df1.loc[:4, 'extra'] = False
```


```python
df1
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



## 빈 데이터 처리


```python
df2 = df1.copy()
```


```python
df2
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



### 1. NaN 값이 있는 행을 제거


```python
df2.dropna(how='any')
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>False</td>
    </tr>
  </tbody>
</table>
</div>



#### 1-a 하지만 원본 데이터에는 반영이 안되어 있음


```python
df2
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



#### 1-b 원본 데이터에 반영을 시키기 위해서는 inplace=True를 적용


```python
df2.dropna(how='any', inplace=True)
```


```python
# NaN 값이 있는 행이 제거됨
df2
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>False</td>
    </tr>
  </tbody>
</table>
</div>



### 2. NaN 값이 있는 행에 값을 채움


```python
df2 = df1.copy()
```


```python
df2
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2.fillna(value=True)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>True</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>



### 3. NaN 값이 있는 데이터를 Boolean 값으로 출력


```python
pd.isna(df2)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>extra</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>5</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
    </tr>
    <tr>
      <th>6</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>



## 연산 (Operation)


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>



#### 열(column) 기준 평균


```python
df.mean()
```




    연도     2017.000000
    월         6.500000
    분양가    3130.001833
    dtype: float64



#### 행(row) 기준 평균


```python
df.mean(1)[:5]
```




    0    2622.000000
    1    2559.000000
    2    2635.666667
    3    2582.000000
    4    2634.666667
    dtype: float64




```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>



#### 행을 2칸 뒤로 밀기


```python
df.shift(2)[:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>5882.0</td>
    </tr>
  </tbody>
</table>
</div>



#### 행을 2칸 당기기


```python
df.shift(-2)[:5]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>5879.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>3163.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015.0</td>
      <td>10.0</td>
      <td>3488.0</td>
    </tr>
  </tbody>
</table>
</div>



### Broadcasting을 이용한 subtract (빼기)


```python
df1 = df[['연도', '월']]
```


```python
df1.head()
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2015</td>
      <td>10</td>
    </tr>
  </tbody>
</table>
</div>




```python
df1.shape
```




    (3570, 2)




```python
s = np.ones(df.shape[0])
```


```python
s.shape
```




    (3570,)




```python
df1.head()
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2015</td>
      <td>10</td>
    </tr>
  </tbody>
</table>
</div>




```python
s
```




    array([1., 1., 1., ..., 1., 1., 1.])




```python
df1.sub(s, axis=0).head()
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
s = np.ones(df1.shape[1])
```


```python
s
```




    array([1., 1.])




```python
df1.sub(s, axis=1).head()
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2014.0</td>
      <td>9.0</td>
    </tr>
  </tbody>
</table>
</div>



### Apply

np.cumsum : cumulative sum의 함수형으로 누적 합을 구하는 함수


```python
df1.apply(np.cumsum)[:10]
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4030</td>
      <td>20</td>
    </tr>
    <tr>
      <th>2</th>
      <td>6045</td>
      <td>30</td>
    </tr>
    <tr>
      <th>3</th>
      <td>8060</td>
      <td>40</td>
    </tr>
    <tr>
      <th>4</th>
      <td>10075</td>
      <td>50</td>
    </tr>
    <tr>
      <th>5</th>
      <td>12090</td>
      <td>60</td>
    </tr>
    <tr>
      <th>6</th>
      <td>14105</td>
      <td>70</td>
    </tr>
    <tr>
      <th>7</th>
      <td>16120</td>
      <td>80</td>
    </tr>
    <tr>
      <th>8</th>
      <td>18135</td>
      <td>90</td>
    </tr>
    <tr>
      <th>9</th>
      <td>20150</td>
      <td>100</td>
    </tr>
  </tbody>
</table>
</div>



#### 연도 column
x.max() 는 최대값인 2019년도의 2019
x.min() 은 최소값인 2015년도의 2015
2019 - 2015 = 4가 출력

#### 월 column
x.max() 는 최대값인 12
x.min() 은 최소값인 1
12 - 1 = 11이 출력


```python
df1.apply(lambda x: x.max() - x.min())
```




    연도     4
    월     11
    dtype: int64




```python
df1.head()
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2015</td>
      <td>10</td>
    </tr>
  </tbody>
</table>
</div>



## 값들의 종류별 출력


```python
df1['연도'].value_counts()
```




    2017    1020
    2018    1020
    2016    1020
    2019     255
    2015     255
    Name: 연도, dtype: int64



## 데이터 합치기 (Data Merge)


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
left = df[['연도', '월']]
```


```python
left.head()
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2015</td>
      <td>10</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2015</td>
      <td>10</td>
    </tr>
  </tbody>
</table>
</div>




```python
right = df[['지역명']]
```


```python
right.head()
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
      <th>지역명</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
    </tr>
  </tbody>
</table>
</div>



### 1. Concat


```python
part_1 = pd.DataFrame(np.random.randn(3, 4))
part_2 = pd.DataFrame(np.random.randn(4, 4))
part_3 = pd.DataFrame(np.random.randn(5, 4))
```


```python
part_1
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>-0.528271</td>
      <td>0.720859</td>
      <td>-0.722125</td>
      <td>-0.899108</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-0.047759</td>
      <td>-1.242737</td>
      <td>0.365917</td>
      <td>0.487562</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.704220</td>
      <td>-1.756446</td>
      <td>-0.115087</td>
      <td>-0.553400</td>
    </tr>
  </tbody>
</table>
</div>




```python
part_2
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.238083</td>
      <td>-0.430535</td>
      <td>-0.676987</td>
      <td>0.895199</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.286559</td>
      <td>0.940526</td>
      <td>-0.511938</td>
      <td>0.821484</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2.192235</td>
      <td>0.472074</td>
      <td>-0.302693</td>
      <td>-0.353570</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.762386</td>
      <td>-0.034152</td>
      <td>0.778173</td>
      <td>0.017409</td>
    </tr>
  </tbody>
</table>
</div>




```python
part_3
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>-2.012103</td>
      <td>-0.190446</td>
      <td>-0.316163</td>
      <td>-1.409107</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-1.895678</td>
      <td>0.214685</td>
      <td>-0.774698</td>
      <td>-1.046805</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1.441786</td>
      <td>1.363821</td>
      <td>0.234136</td>
      <td>-0.427928</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-1.298646</td>
      <td>-0.715675</td>
      <td>0.028136</td>
      <td>0.929860</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.767976</td>
      <td>1.208685</td>
      <td>0.212538</td>
      <td>2.206161</td>
    </tr>
  </tbody>
</table>
</div>




```python
part = [part_1, part_2, part_3]
```


```python
part
```




    [          0         1         2         3
     0 -0.528271  0.720859 -0.722125 -0.899108
     1 -0.047759 -1.242737  0.365917  0.487562
     2  0.704220 -1.756446 -0.115087 -0.553400,
               0         1         2         3
     0  1.238083 -0.430535 -0.676987  0.895199
     1  1.286559  0.940526 -0.511938  0.821484
     2  2.192235  0.472074 -0.302693 -0.353570
     3  0.762386 -0.034152  0.778173  0.017409,
               0         1         2         3
     0 -2.012103 -0.190446 -0.316163 -1.409107
     1 -1.895678  0.214685 -0.774698 -1.046805
     2  1.441786  1.363821  0.234136 -0.427928
     3 -1.298646 -0.715675  0.028136  0.929860
     4  0.767976  1.208685  0.212538  2.206161]




```python
pd.concat(part)
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>-0.528271</td>
      <td>0.720859</td>
      <td>-0.722125</td>
      <td>-0.899108</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-0.047759</td>
      <td>-1.242737</td>
      <td>0.365917</td>
      <td>0.487562</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.704220</td>
      <td>-1.756446</td>
      <td>-0.115087</td>
      <td>-0.553400</td>
    </tr>
    <tr>
      <th>0</th>
      <td>1.238083</td>
      <td>-0.430535</td>
      <td>-0.676987</td>
      <td>0.895199</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.286559</td>
      <td>0.940526</td>
      <td>-0.511938</td>
      <td>0.821484</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2.192235</td>
      <td>0.472074</td>
      <td>-0.302693</td>
      <td>-0.353570</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.762386</td>
      <td>-0.034152</td>
      <td>0.778173</td>
      <td>0.017409</td>
    </tr>
    <tr>
      <th>0</th>
      <td>-2.012103</td>
      <td>-0.190446</td>
      <td>-0.316163</td>
      <td>-1.409107</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-1.895678</td>
      <td>0.214685</td>
      <td>-0.774698</td>
      <td>-1.046805</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1.441786</td>
      <td>1.363821</td>
      <td>0.234136</td>
      <td>-0.427928</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-1.298646</td>
      <td>-0.715675</td>
      <td>0.028136</td>
      <td>0.929860</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.767976</td>
      <td>1.208685</td>
      <td>0.212538</td>
      <td>2.206161</td>
    </tr>
  </tbody>
</table>
</div>



### 2. Join

Join을 Column(열)을 기준으로 합칠 경우에 on='합치고자하는 열의 이름'를 자주 사용하게 되는데, 값이 고유하지 않다면, 매우 혼란스러울 수 있다

#### 예시1: key가 고유한 경우


```python
left = pd.DataFrame({'연도': ['2015', '2016', '2017', '2018', '2019'], '월': ['1', '2', '3', '4', '5']})
left
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2016</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2017</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2018</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2019</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
right = pd.DataFrame({'이름': ['홍길동', '김영희', '이철수', '방탄소년단', 'QUEEN'], '월': ['1', '2', '3', '4', '5']})
right
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
      <th>이름</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>홍길동</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>김영희</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>이철수</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>방탄소년단</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>QUEEN</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
left.shape, right.shape
```




    ((5, 2), (5, 2))



#### 매우 깔끔하게 합쳐진 것을 볼 수 있다


```python
pd.merge(left, right, on='월')
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
      <th>연도</th>
      <th>월</th>
      <th>이름</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>1</td>
      <td>홍길동</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2016</td>
      <td>2</td>
      <td>김영희</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2017</td>
      <td>3</td>
      <td>이철수</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2018</td>
      <td>4</td>
      <td>방탄소년단</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2019</td>
      <td>5</td>
      <td>QUEEN</td>
    </tr>
  </tbody>
</table>
</div>



#### 예시2: 중복되는 key가 있을 때 합치려는 경우 (1월을 중복으로 넣어놨음)


```python
left = pd.DataFrame({'연도': ['2015', '2016', '2017', '2018', '2019'], '월': ['1', '1', '3', '4', '5']})
left
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
      <th>연도</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2016</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2017</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2018</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2019</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
right = pd.DataFrame({'이름': ['홍길동', '김영희', '이철수', '방탄소년단', 'QUEEN'], '월': ['1', '1', '3', '4', '5']})
right
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
      <th>이름</th>
      <th>월</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>홍길동</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>김영희</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>이철수</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>방탄소년단</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>QUEEN</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>



#### 행이 2개가 더 추가로 합쳐진 모습이다.


```python
pd.merge(left, right, on='월')
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
      <th>연도</th>
      <th>월</th>
      <th>이름</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2015</td>
      <td>1</td>
      <td>홍길동</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2015</td>
      <td>1</td>
      <td>김영희</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2016</td>
      <td>1</td>
      <td>홍길동</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2016</td>
      <td>1</td>
      <td>김영희</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2017</td>
      <td>3</td>
      <td>이철수</td>
    </tr>
    <tr>
      <th>5</th>
      <td>2018</td>
      <td>4</td>
      <td>방탄소년단</td>
    </tr>
    <tr>
      <th>6</th>
      <td>2019</td>
      <td>5</td>
      <td>QUEEN</td>
    </tr>
  </tbody>
</table>
</div>



### 3. Append


```python
test = np.arange(0, 50)
test
```




    array([ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
           17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
           34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49])




```python
# 1d -> 2d로 변환
test = test.reshape(10, 5)
```


```python
test
```




    array([[ 0,  1,  2,  3,  4],
           [ 5,  6,  7,  8,  9],
           [10, 11, 12, 13, 14],
           [15, 16, 17, 18, 19],
           [20, 21, 22, 23, 24],
           [25, 26, 27, 28, 29],
           [30, 31, 32, 33, 34],
           [35, 36, 37, 38, 39],
           [40, 41, 42, 43, 44],
           [45, 46, 47, 48, 49]])




```python
test_1 = test[:3]
```


```python
test_1
```




    array([[ 0,  1,  2,  3,  4],
           [ 5,  6,  7,  8,  9],
           [10, 11, 12, 13, 14]])




```python
test_2 = test[3:7]
```


```python
test_2
```




    array([[15, 16, 17, 18, 19],
           [20, 21, 22, 23, 24],
           [25, 26, 27, 28, 29],
           [30, 31, 32, 33, 34]])




```python
test_3 = test[7:10]
```


```python
test_3
```




    array([[35, 36, 37, 38, 39],
           [40, 41, 42, 43, 44],
           [45, 46, 47, 48, 49]])




```python
df1 = pd.DataFrame(test_1)
df1
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>13</td>
      <td>14</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2 = pd.DataFrame(test_2)
df2
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>15</td>
      <td>16</td>
      <td>17</td>
      <td>18</td>
      <td>19</td>
    </tr>
    <tr>
      <th>1</th>
      <td>20</td>
      <td>21</td>
      <td>22</td>
      <td>23</td>
      <td>24</td>
    </tr>
    <tr>
      <th>2</th>
      <td>25</td>
      <td>26</td>
      <td>27</td>
      <td>28</td>
      <td>29</td>
    </tr>
    <tr>
      <th>3</th>
      <td>30</td>
      <td>31</td>
      <td>32</td>
      <td>33</td>
      <td>34</td>
    </tr>
  </tbody>
</table>
</div>




```python
df3 = pd.DataFrame(test_3)
df3
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>35</td>
      <td>36</td>
      <td>37</td>
      <td>38</td>
      <td>39</td>
    </tr>
    <tr>
      <th>1</th>
      <td>40</td>
      <td>41</td>
      <td>42</td>
      <td>43</td>
      <td>44</td>
    </tr>
    <tr>
      <th>2</th>
      <td>45</td>
      <td>46</td>
      <td>47</td>
      <td>48</td>
      <td>49</td>
    </tr>
  </tbody>
</table>
</div>




```python
df1.append(df2)
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>13</td>
      <td>14</td>
    </tr>
    <tr>
      <th>0</th>
      <td>15</td>
      <td>16</td>
      <td>17</td>
      <td>18</td>
      <td>19</td>
    </tr>
    <tr>
      <th>1</th>
      <td>20</td>
      <td>21</td>
      <td>22</td>
      <td>23</td>
      <td>24</td>
    </tr>
    <tr>
      <th>2</th>
      <td>25</td>
      <td>26</td>
      <td>27</td>
      <td>28</td>
      <td>29</td>
    </tr>
    <tr>
      <th>3</th>
      <td>30</td>
      <td>31</td>
      <td>32</td>
      <td>33</td>
      <td>34</td>
    </tr>
  </tbody>
</table>
</div>



#### index가 이상하게 출력되는 부분은 ignore_index=True로 해결할 수 있다


```python
df1.append(df2, ignore_index=True)
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
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
      <td>9</td>
    </tr>
    <tr>
      <th>2</th>
      <td>10</td>
      <td>11</td>
      <td>12</td>
      <td>13</td>
      <td>14</td>
    </tr>
    <tr>
      <th>3</th>
      <td>15</td>
      <td>16</td>
      <td>17</td>
      <td>18</td>
      <td>19</td>
    </tr>
    <tr>
      <th>4</th>
      <td>20</td>
      <td>21</td>
      <td>22</td>
      <td>23</td>
      <td>24</td>
    </tr>
    <tr>
      <th>5</th>
      <td>25</td>
      <td>26</td>
      <td>27</td>
      <td>28</td>
      <td>29</td>
    </tr>
    <tr>
      <th>6</th>
      <td>30</td>
      <td>31</td>
      <td>32</td>
      <td>33</td>
      <td>34</td>
    </tr>
  </tbody>
</table>
</div>



## 그룹화 (Grouping)


```python
df.head()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.shape
```




    (3570, 5)




```python
df.groupby(['지역명', '연도', '월'])['분양가'].agg('sum')
```




    지역명    연도    월 
    Seoul  2015  10    28975.0
                 11    31977.0
                 12    31392.0
           2016  1     31635.0
                 2     31559.0
                 3     32400.0
                 4     33504.0
                 5     33185.0
                 6     33085.0
                 7     33369.0
                 8     33174.0
                 9     33246.0
                 10    34239.0
                 11    32672.0
                 12    33449.0
           2017  1     33413.0
                 2     33202.0
                 3     32526.0
                 4     32519.0
                 5     32536.0
                 6     33637.0
                 7     33285.0
                 8     31812.0
                 9     33788.0
                 10    33160.0
                 11        0.0
                 12    33973.0
           2018  1     33772.0
                 2     34315.0
                 3     35647.0
                        ...   
    충북     2016  10    11276.0
                 11    11283.0
                 12    11497.0
           2017  1     11588.0
                 2     11367.0
                 3     11327.0
                 4     11136.0
                 5     11387.0
                 6     11309.0
                 7     11309.0
                 8     11323.0
                 9     11332.0
                 10    11343.0
                 11        0.0
                 12    11131.0
           2018  1     11131.0
                 2     11435.0
                 3     12212.0
                 4     12961.0
                 5     13028.0
                 6     12552.0
                 7     12506.0
                 8     12506.0
                 9     12494.0
                 10    12494.0
                 11    12425.0
                 12    12425.0
           2019  1     12425.0
                 2     12158.0
                 3     12235.0
    Name: 분양가, Length: 714, dtype: float64



#### 분양가 column이 현재 int 타입이 아닌 object 타입으로 되어 있기 때문에 연산이 잘 이뤄지지 않음. 따라서 int 타입으로 변경


```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 3570 entries, 0 to 3569
    Data columns (total 5 columns):
    지역명     3570 non-null object
    규모구분    3570 non-null object
    연도      3570 non-null int64
    월       3570 non-null int64
    분양가     3273 non-null float64
    dtypes: float64(1), int64(2), object(2)
    memory usage: 139.5+ KB



```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 3570 entries, 0 to 3569
    Data columns (total 5 columns):
    지역명     3570 non-null object
    규모구분    3570 non-null object
    연도      3570 non-null int64
    월       3570 non-null int64
    분양가     3273 non-null float64
    dtypes: float64(1), int64(2), object(2)
    memory usage: 139.5+ KB



```python
grouped = df.groupby(['지역명', '연도', '월']).sum()
grouped
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
      <th></th>
      <th></th>
      <th>분양가</th>
    </tr>
    <tr>
      <th>지역명</th>
      <th>연도</th>
      <th>월</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="30" valign="top">Seoul</th>
      <th rowspan="3" valign="top">2015</th>
      <th>10</th>
      <td>28975.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>31977.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>31392.0</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">2016</th>
      <th>1</th>
      <td>31635.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>31559.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>32400.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>33504.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>33185.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>33085.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>33369.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>33174.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>33246.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>34239.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>32672.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>33449.0</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">2017</th>
      <th>1</th>
      <td>33413.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>33202.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>32526.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>32519.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>32536.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>33637.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>33285.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>31812.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>33788.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>33160.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>33973.0</td>
    </tr>
    <tr>
      <th rowspan="3" valign="top">2018</th>
      <th>1</th>
      <td>33772.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>34315.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>35647.0</td>
    </tr>
    <tr>
      <th>...</th>
      <th>...</th>
      <th>...</th>
      <td>...</td>
    </tr>
    <tr>
      <th rowspan="30" valign="top">충북</th>
      <th rowspan="3" valign="top">2016</th>
      <th>10</th>
      <td>11276.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>11283.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>11497.0</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">2017</th>
      <th>1</th>
      <td>11588.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>11367.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>11327.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>11136.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>11387.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>11309.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>11309.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>11323.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>11332.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11343.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>11131.0</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">2018</th>
      <th>1</th>
      <td>11131.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>11435.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>12212.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>12961.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>13028.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>12552.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>12506.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>12506.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>12494.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>12494.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>12425.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>12425.0</td>
    </tr>
    <tr>
      <th rowspan="3" valign="top">2019</th>
      <th>1</th>
      <td>12425.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>12158.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>12235.0</td>
    </tr>
  </tbody>
</table>
<p>714 rows × 1 columns</p>
</div>




```python
grouped.head()
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
      <th></th>
      <th></th>
      <th>분양가</th>
    </tr>
    <tr>
      <th>지역명</th>
      <th>연도</th>
      <th>월</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="5" valign="top">Seoul</th>
      <th rowspan="3" valign="top">2015</th>
      <th>10</th>
      <td>28975.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>31977.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>31392.0</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">2016</th>
      <th>1</th>
      <td>31635.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>31559.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
grouped.stack()
```




    지역명    연도    월      
    Seoul  2015  10  분양가    28975.0
                 11  분양가    31977.0
                 12  분양가    31392.0
           2016  1   분양가    31635.0
                 2   분양가    31559.0
                 3   분양가    32400.0
                 4   분양가    33504.0
                 5   분양가    33185.0
                 6   분양가    33085.0
                 7   분양가    33369.0
                 8   분양가    33174.0
                 9   분양가    33246.0
                 10  분양가    34239.0
                 11  분양가    32672.0
                 12  분양가    33449.0
           2017  1   분양가    33413.0
                 2   분양가    33202.0
                 3   분양가    32526.0
                 4   분양가    32519.0
                 5   분양가    32536.0
                 6   분양가    33637.0
                 7   분양가    33285.0
                 8   분양가    31812.0
                 9   분양가    33788.0
                 10  분양가    33160.0
                 11  분양가        0.0
                 12  분양가    33973.0
           2018  1   분양가    33772.0
                 2   분양가    34315.0
                 3   분양가    35647.0
                             ...   
    충북     2016  10  분양가    11276.0
                 11  분양가    11283.0
                 12  분양가    11497.0
           2017  1   분양가    11588.0
                 2   분양가    11367.0
                 3   분양가    11327.0
                 4   분양가    11136.0
                 5   분양가    11387.0
                 6   분양가    11309.0
                 7   분양가    11309.0
                 8   분양가    11323.0
                 9   분양가    11332.0
                 10  분양가    11343.0
                 11  분양가        0.0
                 12  분양가    11131.0
           2018  1   분양가    11131.0
                 2   분양가    11435.0
                 3   분양가    12212.0
                 4   분양가    12961.0
                 5   분양가    13028.0
                 6   분양가    12552.0
                 7   분양가    12506.0
                 8   분양가    12506.0
                 9   분양가    12494.0
                 10  분양가    12494.0
                 11  분양가    12425.0
                 12  분양가    12425.0
           2019  1   분양가    12425.0
                 2   분양가    12158.0
                 3   분양가    12235.0
    Length: 714, dtype: float64



**group이 되어 있는 DataFrame을 unstack의 '레벨'을 조정하여 보여줄 수 있다.**
위의 grouped에서 '도시' = level 1, '연도' = level 2, '월'


```python
df.head(10)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3119.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3545.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3408.0</td>
    </tr>
  </tbody>
</table>
</div>



### stack & unstack을 활용한 column별 데이터 그룹핑


```python
# level0: 열을 도시별로 출력
grouped.unstack(0)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
    
    .dataframe thead tr th {
        text-align: left;
    }
    
    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="17" halign="left">분양가</th>
    </tr>
    <tr>
      <th></th>
      <th>지역명</th>
      <th>Seoul</th>
      <th>강원</th>
      <th>경기</th>
      <th>경남</th>
      <th>경북</th>
      <th>광주</th>
      <th>대구</th>
      <th>대전</th>
      <th>부산</th>
      <th>세종</th>
      <th>울산</th>
      <th>인천</th>
      <th>전남</th>
      <th>전북</th>
      <th>제주</th>
      <th>충남</th>
      <th>충북</th>
    </tr>
    <tr>
      <th>연도</th>
      <th>월</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="3" valign="top">2015</th>
      <th>10</th>
      <td>28975.0</td>
      <td>10897.0</td>
      <td>16679.0</td>
      <td>12739.0</td>
      <td>11027.0</td>
      <td>7112.0</td>
      <td>13147.0</td>
      <td>9928.0</td>
      <td>15518.0</td>
      <td>13207.0</td>
      <td>14156.0</td>
      <td>16723.0</td>
      <td>10400.0</td>
      <td>10864.0</td>
      <td>9614.0</td>
      <td>11591.0</td>
      <td>10455.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>31977.0</td>
      <td>10888.0</td>
      <td>16494.0</td>
      <td>12843.0</td>
      <td>11472.0</td>
      <td>7119.0</td>
      <td>13358.0</td>
      <td>9928.0</td>
      <td>15846.0</td>
      <td>13279.0</td>
      <td>14212.0</td>
      <td>16584.0</td>
      <td>10252.0</td>
      <td>10902.0</td>
      <td>9614.0</td>
      <td>11410.0</td>
      <td>10085.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>31392.0</td>
      <td>10888.0</td>
      <td>17104.0</td>
      <td>12869.0</td>
      <td>11429.0</td>
      <td>7360.0</td>
      <td>14490.0</td>
      <td>9928.0</td>
      <td>15806.0</td>
      <td>13355.0</td>
      <td>14212.0</td>
      <td>16584.0</td>
      <td>10252.0</td>
      <td>10554.0</td>
      <td>9685.0</td>
      <td>11953.0</td>
      <td>10500.0</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">2016</th>
      <th>1</th>
      <td>31635.0</td>
      <td>10894.0</td>
      <td>17104.0</td>
      <td>12698.0</td>
      <td>11406.0</td>
      <td>7546.0</td>
      <td>14805.0</td>
      <td>9928.0</td>
      <td>15929.0</td>
      <td>13355.0</td>
      <td>14220.0</td>
      <td>16582.0</td>
      <td>10252.0</td>
      <td>10534.0</td>
      <td>9685.0</td>
      <td>12017.0</td>
      <td>10518.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>31559.0</td>
      <td>9013.0</td>
      <td>16831.0</td>
      <td>12692.0</td>
      <td>11420.0</td>
      <td>7546.0</td>
      <td>14759.0</td>
      <td>9928.0</td>
      <td>15982.0</td>
      <td>13355.0</td>
      <td>14220.0</td>
      <td>16585.0</td>
      <td>10281.0</td>
      <td>10535.0</td>
      <td>9685.0</td>
      <td>12035.0</td>
      <td>10518.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>32400.0</td>
      <td>9014.0</td>
      <td>16958.0</td>
      <td>12839.0</td>
      <td>11532.0</td>
      <td>7661.0</td>
      <td>14896.0</td>
      <td>9928.0</td>
      <td>15915.0</td>
      <td>13374.0</td>
      <td>14445.0</td>
      <td>16577.0</td>
      <td>10280.0</td>
      <td>10382.0</td>
      <td>4628.0</td>
      <td>11440.0</td>
      <td>10463.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>33504.0</td>
      <td>8816.0</td>
      <td>16848.0</td>
      <td>13029.0</td>
      <td>11526.0</td>
      <td>14268.0</td>
      <td>14923.0</td>
      <td>7403.0</td>
      <td>15886.0</td>
      <td>13403.0</td>
      <td>14364.0</td>
      <td>18092.0</td>
      <td>10275.0</td>
      <td>10374.0</td>
      <td>13651.0</td>
      <td>11803.0</td>
      <td>10430.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>33185.0</td>
      <td>8669.0</td>
      <td>17932.0</td>
      <td>13203.0</td>
      <td>11534.0</td>
      <td>14284.0</td>
      <td>14965.0</td>
      <td>7474.0</td>
      <td>15828.0</td>
      <td>13403.0</td>
      <td>14387.0</td>
      <td>17208.0</td>
      <td>10279.0</td>
      <td>10400.0</td>
      <td>13569.0</td>
      <td>11809.0</td>
      <td>10476.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>33085.0</td>
      <td>8678.0</td>
      <td>18269.0</td>
      <td>13026.0</td>
      <td>11828.0</td>
      <td>14319.0</td>
      <td>15266.0</td>
      <td>7757.0</td>
      <td>16167.0</td>
      <td>13372.0</td>
      <td>14330.0</td>
      <td>16567.0</td>
      <td>10549.0</td>
      <td>10371.0</td>
      <td>14122.0</td>
      <td>12048.0</td>
      <td>10681.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>33369.0</td>
      <td>8648.0</td>
      <td>18315.0</td>
      <td>12969.0</td>
      <td>11828.0</td>
      <td>14329.0</td>
      <td>15295.0</td>
      <td>7757.0</td>
      <td>16409.0</td>
      <td>13368.0</td>
      <td>14330.0</td>
      <td>16517.0</td>
      <td>10550.0</td>
      <td>10402.0</td>
      <td>14122.0</td>
      <td>12048.0</td>
      <td>10788.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>33174.0</td>
      <td>8705.0</td>
      <td>18250.0</td>
      <td>12984.0</td>
      <td>11798.0</td>
      <td>14293.0</td>
      <td>15573.0</td>
      <td>7757.0</td>
      <td>16594.0</td>
      <td>13393.0</td>
      <td>14153.0</td>
      <td>16617.0</td>
      <td>10546.0</td>
      <td>10407.0</td>
      <td>14211.0</td>
      <td>12167.0</td>
      <td>10881.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>33246.0</td>
      <td>8690.0</td>
      <td>17479.0</td>
      <td>12787.0</td>
      <td>11812.0</td>
      <td>13853.0</td>
      <td>15573.0</td>
      <td>7611.0</td>
      <td>16611.0</td>
      <td>13428.0</td>
      <td>14153.0</td>
      <td>16289.0</td>
      <td>10563.0</td>
      <td>10410.0</td>
      <td>16407.0</td>
      <td>12168.0</td>
      <td>10886.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>34239.0</td>
      <td>10608.0</td>
      <td>17852.0</td>
      <td>12821.0</td>
      <td>12070.0</td>
      <td>13862.0</td>
      <td>15573.0</td>
      <td>16079.0</td>
      <td>16489.0</td>
      <td>13525.0</td>
      <td>14681.0</td>
      <td>16904.0</td>
      <td>10648.0</td>
      <td>10431.0</td>
      <td>16407.0</td>
      <td>12159.0</td>
      <td>11276.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>32672.0</td>
      <td>10383.0</td>
      <td>18362.0</td>
      <td>12699.0</td>
      <td>12076.0</td>
      <td>14208.0</td>
      <td>17464.0</td>
      <td>14944.0</td>
      <td>16427.0</td>
      <td>13546.0</td>
      <td>12571.0</td>
      <td>16937.0</td>
      <td>10901.0</td>
      <td>10430.0</td>
      <td>16461.0</td>
      <td>12488.0</td>
      <td>11283.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>33449.0</td>
      <td>10752.0</td>
      <td>18254.0</td>
      <td>12739.0</td>
      <td>12141.0</td>
      <td>14224.0</td>
      <td>17854.0</td>
      <td>14944.0</td>
      <td>17100.0</td>
      <td>13529.0</td>
      <td>12567.0</td>
      <td>16926.0</td>
      <td>10996.0</td>
      <td>10899.0</td>
      <td>16510.0</td>
      <td>12513.0</td>
      <td>11497.0</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">2017</th>
      <th>1</th>
      <td>33413.0</td>
      <td>10711.0</td>
      <td>18260.0</td>
      <td>12745.0</td>
      <td>12185.0</td>
      <td>14215.0</td>
      <td>17917.0</td>
      <td>14944.0</td>
      <td>17082.0</td>
      <td>13529.0</td>
      <td>12567.0</td>
      <td>16926.0</td>
      <td>10996.0</td>
      <td>10951.0</td>
      <td>16490.0</td>
      <td>12448.0</td>
      <td>11588.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>33202.0</td>
      <td>10734.0</td>
      <td>18571.0</td>
      <td>12922.0</td>
      <td>12183.0</td>
      <td>14215.0</td>
      <td>17992.0</td>
      <td>15106.0</td>
      <td>17080.0</td>
      <td>13529.0</td>
      <td>12572.0</td>
      <td>17011.0</td>
      <td>11033.0</td>
      <td>10947.0</td>
      <td>16453.0</td>
      <td>12451.0</td>
      <td>11367.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>32526.0</td>
      <td>10682.0</td>
      <td>18838.0</td>
      <td>12853.0</td>
      <td>12215.0</td>
      <td>14119.0</td>
      <td>18486.0</td>
      <td>15106.0</td>
      <td>16971.0</td>
      <td>13529.0</td>
      <td>12572.0</td>
      <td>17100.0</td>
      <td>11021.0</td>
      <td>11070.0</td>
      <td>16412.0</td>
      <td>12453.0</td>
      <td>11327.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>32519.0</td>
      <td>10682.0</td>
      <td>18849.0</td>
      <td>12877.0</td>
      <td>12311.0</td>
      <td>14392.0</td>
      <td>18137.0</td>
      <td>15201.0</td>
      <td>16970.0</td>
      <td>13696.0</td>
      <td>13210.0</td>
      <td>17100.0</td>
      <td>11053.0</td>
      <td>11192.0</td>
      <td>18250.0</td>
      <td>12500.0</td>
      <td>11136.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>32536.0</td>
      <td>10767.0</td>
      <td>18200.0</td>
      <td>12893.0</td>
      <td>12468.0</td>
      <td>12005.0</td>
      <td>18137.0</td>
      <td>15201.0</td>
      <td>17252.0</td>
      <td>13696.0</td>
      <td>13210.0</td>
      <td>17497.0</td>
      <td>11171.0</td>
      <td>11273.0</td>
      <td>20348.0</td>
      <td>12499.0</td>
      <td>11387.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>33637.0</td>
      <td>11026.0</td>
      <td>18379.0</td>
      <td>13223.0</td>
      <td>12513.0</td>
      <td>12049.0</td>
      <td>17782.0</td>
      <td>15201.0</td>
      <td>17374.0</td>
      <td>13715.0</td>
      <td>13217.0</td>
      <td>17415.0</td>
      <td>10938.0</td>
      <td>11414.0</td>
      <td>20762.0</td>
      <td>12417.0</td>
      <td>11309.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>33285.0</td>
      <td>11076.0</td>
      <td>18630.0</td>
      <td>13345.0</td>
      <td>12512.0</td>
      <td>12013.0</td>
      <td>16024.0</td>
      <td>15448.0</td>
      <td>17479.0</td>
      <td>13715.0</td>
      <td>13217.0</td>
      <td>17862.0</td>
      <td>10939.0</td>
      <td>11500.0</td>
      <td>21366.0</td>
      <td>12420.0</td>
      <td>11309.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>31812.0</td>
      <td>11401.0</td>
      <td>18853.0</td>
      <td>13547.0</td>
      <td>12864.0</td>
      <td>12031.0</td>
      <td>15961.0</td>
      <td>15448.0</td>
      <td>17782.0</td>
      <td>13722.0</td>
      <td>13217.0</td>
      <td>18171.0</td>
      <td>11074.0</td>
      <td>11509.0</td>
      <td>21366.0</td>
      <td>12440.0</td>
      <td>11323.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>33788.0</td>
      <td>11237.0</td>
      <td>18872.0</td>
      <td>14758.0</td>
      <td>13166.0</td>
      <td>11797.0</td>
      <td>15190.0</td>
      <td>15932.0</td>
      <td>17697.0</td>
      <td>13840.0</td>
      <td>13217.0</td>
      <td>18403.0</td>
      <td>11074.0</td>
      <td>8870.0</td>
      <td>11752.0</td>
      <td>12440.0</td>
      <td>11332.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>33160.0</td>
      <td>11174.0</td>
      <td>18806.0</td>
      <td>13387.0</td>
      <td>12922.0</td>
      <td>14490.0</td>
      <td>15190.0</td>
      <td>11240.0</td>
      <td>18048.0</td>
      <td>13819.0</td>
      <td>12438.0</td>
      <td>18216.0</td>
      <td>11660.0</td>
      <td>8752.0</td>
      <td>11752.0</td>
      <td>12569.0</td>
      <td>11343.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>33973.0</td>
      <td>11736.0</td>
      <td>18825.0</td>
      <td>13896.0</td>
      <td>10165.0</td>
      <td>11427.0</td>
      <td>14134.0</td>
      <td>11091.0</td>
      <td>18943.0</td>
      <td>12651.0</td>
      <td>6324.0</td>
      <td>18309.0</td>
      <td>11923.0</td>
      <td>11354.0</td>
      <td>15454.0</td>
      <td>9519.0</td>
      <td>11131.0</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">2018</th>
      <th>1</th>
      <td>33772.0</td>
      <td>12157.0</td>
      <td>20740.0</td>
      <td>13896.0</td>
      <td>10268.0</td>
      <td>11422.0</td>
      <td>14236.0</td>
      <td>11189.0</td>
      <td>18943.0</td>
      <td>12651.0</td>
      <td>6324.0</td>
      <td>18346.0</td>
      <td>12124.0</td>
      <td>11354.0</td>
      <td>15557.0</td>
      <td>9507.0</td>
      <td>11131.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>34315.0</td>
      <td>12346.0</td>
      <td>20954.0</td>
      <td>13905.0</td>
      <td>10268.0</td>
      <td>11422.0</td>
      <td>13793.0</td>
      <td>11334.0</td>
      <td>18967.0</td>
      <td>12651.0</td>
      <td>6348.0</td>
      <td>18426.0</td>
      <td>11798.0</td>
      <td>11366.0</td>
      <td>15862.0</td>
      <td>9507.0</td>
      <td>11435.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>35647.0</td>
      <td>12800.0</td>
      <td>20861.0</td>
      <td>13910.0</td>
      <td>10174.0</td>
      <td>11495.0</td>
      <td>13860.0</td>
      <td>11334.0</td>
      <td>18782.0</td>
      <td>12651.0</td>
      <td>6348.0</td>
      <td>18889.0</td>
      <td>11982.0</td>
      <td>11345.0</td>
      <td>16055.0</td>
      <td>9507.0</td>
      <td>12212.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>35662.0</td>
      <td>12260.0</td>
      <td>20891.0</td>
      <td>13816.0</td>
      <td>10121.0</td>
      <td>11004.0</td>
      <td>16635.0</td>
      <td>11514.0</td>
      <td>18874.0</td>
      <td>15615.0</td>
      <td>6348.0</td>
      <td>18889.0</td>
      <td>12024.0</td>
      <td>12641.0</td>
      <td>16055.0</td>
      <td>9507.0</td>
      <td>12961.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>36217.0</td>
      <td>12333.0</td>
      <td>21368.0</td>
      <td>13825.0</td>
      <td>10574.0</td>
      <td>11046.0</td>
      <td>18482.0</td>
      <td>11514.0</td>
      <td>18924.0</td>
      <td>15615.0</td>
      <td>6348.0</td>
      <td>18762.0</td>
      <td>12026.0</td>
      <td>12720.0</td>
      <td>16055.0</td>
      <td>9871.0</td>
      <td>13028.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>35161.0</td>
      <td>12317.0</td>
      <td>21249.0</td>
      <td>13831.0</td>
      <td>10619.0</td>
      <td>11233.0</td>
      <td>18445.0</td>
      <td>11514.0</td>
      <td>19043.0</td>
      <td>15615.0</td>
      <td>6250.0</td>
      <td>13592.0</td>
      <td>12026.0</td>
      <td>12720.0</td>
      <td>16055.0</td>
      <td>12623.0</td>
      <td>12552.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>35595.0</td>
      <td>12434.0</td>
      <td>21708.0</td>
      <td>13813.0</td>
      <td>10702.0</td>
      <td>11103.0</td>
      <td>18767.0</td>
      <td>8383.0</td>
      <td>19496.0</td>
      <td>15615.0</td>
      <td>6250.0</td>
      <td>13592.0</td>
      <td>12029.0</td>
      <td>12780.0</td>
      <td>12906.0</td>
      <td>12623.0</td>
      <td>12506.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>33783.0</td>
      <td>12577.0</td>
      <td>22203.0</td>
      <td>13679.0</td>
      <td>10500.0</td>
      <td>11103.0</td>
      <td>18790.0</td>
      <td>8383.0</td>
      <td>19514.0</td>
      <td>15717.0</td>
      <td>6250.0</td>
      <td>13533.0</td>
      <td>12029.0</td>
      <td>12737.0</td>
      <td>12906.0</td>
      <td>12774.0</td>
      <td>12506.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>32407.0</td>
      <td>12590.0</td>
      <td>22170.0</td>
      <td>14211.0</td>
      <td>13177.0</td>
      <td>11293.0</td>
      <td>18901.0</td>
      <td>14108.0</td>
      <td>20655.0</td>
      <td>15717.0</td>
      <td>6250.0</td>
      <td>13533.0</td>
      <td>12074.0</td>
      <td>12737.0</td>
      <td>12906.0</td>
      <td>12774.0</td>
      <td>12494.0</td>
    </tr>
    <tr>
      <th>10</th>
      <td>36028.0</td>
      <td>12667.0</td>
      <td>22191.0</td>
      <td>14471.0</td>
      <td>13401.0</td>
      <td>9353.0</td>
      <td>19194.0</td>
      <td>14067.0</td>
      <td>20683.0</td>
      <td>15717.0</td>
      <td>5780.0</td>
      <td>16773.0</td>
      <td>12100.0</td>
      <td>12551.0</td>
      <td>12906.0</td>
      <td>12774.0</td>
      <td>12494.0</td>
    </tr>
    <tr>
      <th>11</th>
      <td>36199.0</td>
      <td>12611.0</td>
      <td>22352.0</td>
      <td>14628.0</td>
      <td>13492.0</td>
      <td>9666.0</td>
      <td>19106.0</td>
      <td>14067.0</td>
      <td>20213.0</td>
      <td>15717.0</td>
      <td>5780.0</td>
      <td>18662.0</td>
      <td>11930.0</td>
      <td>12564.0</td>
      <td>16675.0</td>
      <td>12627.0</td>
      <td>12425.0</td>
    </tr>
    <tr>
      <th>12</th>
      <td>37073.0</td>
      <td>12349.0</td>
      <td>22557.0</td>
      <td>15609.0</td>
      <td>13492.0</td>
      <td>9773.0</td>
      <td>19469.0</td>
      <td>12149.0</td>
      <td>20269.0</td>
      <td>15327.0</td>
      <td>0.0</td>
      <td>18629.0</td>
      <td>12037.0</td>
      <td>13114.0</td>
      <td>16910.0</td>
      <td>12603.0</td>
      <td>12425.0</td>
    </tr>
    <tr>
      <th rowspan="3" valign="top">2019</th>
      <th>1</th>
      <td>37734.0</td>
      <td>12618.0</td>
      <td>22750.0</td>
      <td>15609.0</td>
      <td>13322.0</td>
      <td>9831.0</td>
      <td>20013.0</td>
      <td>12243.0</td>
      <td>20269.0</td>
      <td>15327.0</td>
      <td>0.0</td>
      <td>18757.0</td>
      <td>11972.0</td>
      <td>13114.0</td>
      <td>16910.0</td>
      <td>12773.0</td>
      <td>12425.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>37592.0</td>
      <td>12618.0</td>
      <td>22879.0</td>
      <td>15604.0</td>
      <td>13430.0</td>
      <td>9831.0</td>
      <td>20022.0</td>
      <td>12243.0</td>
      <td>20269.0</td>
      <td>15327.0</td>
      <td>0.0</td>
      <td>19151.0</td>
      <td>12314.0</td>
      <td>13229.0</td>
      <td>16910.0</td>
      <td>12994.0</td>
      <td>12158.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>37761.0</td>
      <td>12706.0</td>
      <td>22696.0</td>
      <td>15984.0</td>
      <td>13536.0</td>
      <td>9831.0</td>
      <td>19994.0</td>
      <td>11718.0</td>
      <td>20394.0</td>
      <td>15327.0</td>
      <td>0.0</td>
      <td>19585.0</td>
      <td>12236.0</td>
      <td>13358.0</td>
      <td>16910.0</td>
      <td>13113.0</td>
      <td>12235.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# level1: 열을 연도별로 출력
grouped.unstack(1)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
    
    .dataframe thead tr th {
        text-align: left;
    }
    
    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="5" halign="left">분양가</th>
    </tr>
    <tr>
      <th></th>
      <th>연도</th>
      <th>2015</th>
      <th>2016</th>
      <th>2017</th>
      <th>2018</th>
      <th>2019</th>
    </tr>
    <tr>
      <th>지역명</th>
      <th>월</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="12" valign="top">Seoul</th>
      <th>1</th>
      <td>NaN</td>
      <td>31635.0</td>
      <td>33413.0</td>
      <td>33772.0</td>
      <td>37734.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>NaN</td>
      <td>31559.0</td>
      <td>33202.0</td>
      <td>34315.0</td>
      <td>37592.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>NaN</td>
      <td>32400.0</td>
      <td>32526.0</td>
      <td>35647.0</td>
      <td>37761.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>NaN</td>
      <td>33504.0</td>
      <td>32519.0</td>
      <td>35662.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>NaN</td>
      <td>33185.0</td>
      <td>32536.0</td>
      <td>36217.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>NaN</td>
      <td>33085.0</td>
      <td>33637.0</td>
      <td>35161.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>NaN</td>
      <td>33369.0</td>
      <td>33285.0</td>
      <td>35595.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>NaN</td>
      <td>33174.0</td>
      <td>31812.0</td>
      <td>33783.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>NaN</td>
      <td>33246.0</td>
      <td>33788.0</td>
      <td>32407.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>28975.0</td>
      <td>34239.0</td>
      <td>33160.0</td>
      <td>36028.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>31977.0</td>
      <td>32672.0</td>
      <td>0.0</td>
      <td>36199.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>31392.0</td>
      <td>33449.0</td>
      <td>33973.0</td>
      <td>37073.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">강원</th>
      <th>1</th>
      <td>NaN</td>
      <td>10894.0</td>
      <td>10711.0</td>
      <td>12157.0</td>
      <td>12618.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>NaN</td>
      <td>9013.0</td>
      <td>10734.0</td>
      <td>12346.0</td>
      <td>12618.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>NaN</td>
      <td>9014.0</td>
      <td>10682.0</td>
      <td>12800.0</td>
      <td>12706.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>NaN</td>
      <td>8816.0</td>
      <td>10682.0</td>
      <td>12260.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>NaN</td>
      <td>8669.0</td>
      <td>10767.0</td>
      <td>12333.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>NaN</td>
      <td>8678.0</td>
      <td>11026.0</td>
      <td>12317.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>NaN</td>
      <td>8648.0</td>
      <td>11076.0</td>
      <td>12434.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>NaN</td>
      <td>8705.0</td>
      <td>11401.0</td>
      <td>12577.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>NaN</td>
      <td>8690.0</td>
      <td>11237.0</td>
      <td>12590.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>10897.0</td>
      <td>10608.0</td>
      <td>11174.0</td>
      <td>12667.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>10888.0</td>
      <td>10383.0</td>
      <td>0.0</td>
      <td>12611.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>10888.0</td>
      <td>10752.0</td>
      <td>11736.0</td>
      <td>12349.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="6" valign="top">경기</th>
      <th>1</th>
      <td>NaN</td>
      <td>17104.0</td>
      <td>18260.0</td>
      <td>20740.0</td>
      <td>22750.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>NaN</td>
      <td>16831.0</td>
      <td>18571.0</td>
      <td>20954.0</td>
      <td>22879.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>NaN</td>
      <td>16958.0</td>
      <td>18838.0</td>
      <td>20861.0</td>
      <td>22696.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>NaN</td>
      <td>16848.0</td>
      <td>18849.0</td>
      <td>20891.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>NaN</td>
      <td>17932.0</td>
      <td>18200.0</td>
      <td>21368.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>NaN</td>
      <td>18269.0</td>
      <td>18379.0</td>
      <td>21249.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th rowspan="6" valign="top">제주</th>
      <th>7</th>
      <td>NaN</td>
      <td>14122.0</td>
      <td>21366.0</td>
      <td>12906.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>NaN</td>
      <td>14211.0</td>
      <td>21366.0</td>
      <td>12906.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>NaN</td>
      <td>16407.0</td>
      <td>11752.0</td>
      <td>12906.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>9614.0</td>
      <td>16407.0</td>
      <td>11752.0</td>
      <td>12906.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>9614.0</td>
      <td>16461.0</td>
      <td>0.0</td>
      <td>16675.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>9685.0</td>
      <td>16510.0</td>
      <td>15454.0</td>
      <td>16910.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">충남</th>
      <th>1</th>
      <td>NaN</td>
      <td>12017.0</td>
      <td>12448.0</td>
      <td>9507.0</td>
      <td>12773.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>NaN</td>
      <td>12035.0</td>
      <td>12451.0</td>
      <td>9507.0</td>
      <td>12994.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>NaN</td>
      <td>11440.0</td>
      <td>12453.0</td>
      <td>9507.0</td>
      <td>13113.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>NaN</td>
      <td>11803.0</td>
      <td>12500.0</td>
      <td>9507.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>NaN</td>
      <td>11809.0</td>
      <td>12499.0</td>
      <td>9871.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>NaN</td>
      <td>12048.0</td>
      <td>12417.0</td>
      <td>12623.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>NaN</td>
      <td>12048.0</td>
      <td>12420.0</td>
      <td>12623.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>NaN</td>
      <td>12167.0</td>
      <td>12440.0</td>
      <td>12774.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>NaN</td>
      <td>12168.0</td>
      <td>12440.0</td>
      <td>12774.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>11591.0</td>
      <td>12159.0</td>
      <td>12569.0</td>
      <td>12774.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>11410.0</td>
      <td>12488.0</td>
      <td>0.0</td>
      <td>12627.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>11953.0</td>
      <td>12513.0</td>
      <td>9519.0</td>
      <td>12603.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="12" valign="top">충북</th>
      <th>1</th>
      <td>NaN</td>
      <td>10518.0</td>
      <td>11588.0</td>
      <td>11131.0</td>
      <td>12425.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>NaN</td>
      <td>10518.0</td>
      <td>11367.0</td>
      <td>11435.0</td>
      <td>12158.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>NaN</td>
      <td>10463.0</td>
      <td>11327.0</td>
      <td>12212.0</td>
      <td>12235.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>NaN</td>
      <td>10430.0</td>
      <td>11136.0</td>
      <td>12961.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>NaN</td>
      <td>10476.0</td>
      <td>11387.0</td>
      <td>13028.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>NaN</td>
      <td>10681.0</td>
      <td>11309.0</td>
      <td>12552.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>NaN</td>
      <td>10788.0</td>
      <td>11309.0</td>
      <td>12506.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>NaN</td>
      <td>10881.0</td>
      <td>11323.0</td>
      <td>12506.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>NaN</td>
      <td>10886.0</td>
      <td>11332.0</td>
      <td>12494.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>10</th>
      <td>10455.0</td>
      <td>11276.0</td>
      <td>11343.0</td>
      <td>12494.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>11</th>
      <td>10085.0</td>
      <td>11283.0</td>
      <td>0.0</td>
      <td>12425.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>12</th>
      <td>10500.0</td>
      <td>11497.0</td>
      <td>11131.0</td>
      <td>12425.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>204 rows × 5 columns</p>
</div>




```python
# level2: 열을 연도별로 출력
grouped.unstack(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
    
    .dataframe thead tr th {
        text-align: left;
    }
    
    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="12" halign="left">분양가</th>
    </tr>
    <tr>
      <th></th>
      <th>월</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>10</th>
      <th>11</th>
      <th>12</th>
    </tr>
    <tr>
      <th>지역명</th>
      <th>연도</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="5" valign="top">Seoul</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>28975.0</td>
      <td>31977.0</td>
      <td>31392.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>31635.0</td>
      <td>31559.0</td>
      <td>32400.0</td>
      <td>33504.0</td>
      <td>33185.0</td>
      <td>33085.0</td>
      <td>33369.0</td>
      <td>33174.0</td>
      <td>33246.0</td>
      <td>34239.0</td>
      <td>32672.0</td>
      <td>33449.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>33413.0</td>
      <td>33202.0</td>
      <td>32526.0</td>
      <td>32519.0</td>
      <td>32536.0</td>
      <td>33637.0</td>
      <td>33285.0</td>
      <td>31812.0</td>
      <td>33788.0</td>
      <td>33160.0</td>
      <td>0.0</td>
      <td>33973.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>33772.0</td>
      <td>34315.0</td>
      <td>35647.0</td>
      <td>35662.0</td>
      <td>36217.0</td>
      <td>35161.0</td>
      <td>35595.0</td>
      <td>33783.0</td>
      <td>32407.0</td>
      <td>36028.0</td>
      <td>36199.0</td>
      <td>37073.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>37734.0</td>
      <td>37592.0</td>
      <td>37761.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">강원</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>10897.0</td>
      <td>10888.0</td>
      <td>10888.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>10894.0</td>
      <td>9013.0</td>
      <td>9014.0</td>
      <td>8816.0</td>
      <td>8669.0</td>
      <td>8678.0</td>
      <td>8648.0</td>
      <td>8705.0</td>
      <td>8690.0</td>
      <td>10608.0</td>
      <td>10383.0</td>
      <td>10752.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>10711.0</td>
      <td>10734.0</td>
      <td>10682.0</td>
      <td>10682.0</td>
      <td>10767.0</td>
      <td>11026.0</td>
      <td>11076.0</td>
      <td>11401.0</td>
      <td>11237.0</td>
      <td>11174.0</td>
      <td>0.0</td>
      <td>11736.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>12157.0</td>
      <td>12346.0</td>
      <td>12800.0</td>
      <td>12260.0</td>
      <td>12333.0</td>
      <td>12317.0</td>
      <td>12434.0</td>
      <td>12577.0</td>
      <td>12590.0</td>
      <td>12667.0</td>
      <td>12611.0</td>
      <td>12349.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>12618.0</td>
      <td>12618.0</td>
      <td>12706.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">경기</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>16679.0</td>
      <td>16494.0</td>
      <td>17104.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>17104.0</td>
      <td>16831.0</td>
      <td>16958.0</td>
      <td>16848.0</td>
      <td>17932.0</td>
      <td>18269.0</td>
      <td>18315.0</td>
      <td>18250.0</td>
      <td>17479.0</td>
      <td>17852.0</td>
      <td>18362.0</td>
      <td>18254.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>18260.0</td>
      <td>18571.0</td>
      <td>18838.0</td>
      <td>18849.0</td>
      <td>18200.0</td>
      <td>18379.0</td>
      <td>18630.0</td>
      <td>18853.0</td>
      <td>18872.0</td>
      <td>18806.0</td>
      <td>0.0</td>
      <td>18825.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>20740.0</td>
      <td>20954.0</td>
      <td>20861.0</td>
      <td>20891.0</td>
      <td>21368.0</td>
      <td>21249.0</td>
      <td>21708.0</td>
      <td>22203.0</td>
      <td>22170.0</td>
      <td>22191.0</td>
      <td>22352.0</td>
      <td>22557.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>22750.0</td>
      <td>22879.0</td>
      <td>22696.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">경남</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>12739.0</td>
      <td>12843.0</td>
      <td>12869.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>12698.0</td>
      <td>12692.0</td>
      <td>12839.0</td>
      <td>13029.0</td>
      <td>13203.0</td>
      <td>13026.0</td>
      <td>12969.0</td>
      <td>12984.0</td>
      <td>12787.0</td>
      <td>12821.0</td>
      <td>12699.0</td>
      <td>12739.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>12745.0</td>
      <td>12922.0</td>
      <td>12853.0</td>
      <td>12877.0</td>
      <td>12893.0</td>
      <td>13223.0</td>
      <td>13345.0</td>
      <td>13547.0</td>
      <td>14758.0</td>
      <td>13387.0</td>
      <td>0.0</td>
      <td>13896.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>13896.0</td>
      <td>13905.0</td>
      <td>13910.0</td>
      <td>13816.0</td>
      <td>13825.0</td>
      <td>13831.0</td>
      <td>13813.0</td>
      <td>13679.0</td>
      <td>14211.0</td>
      <td>14471.0</td>
      <td>14628.0</td>
      <td>15609.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>15609.0</td>
      <td>15604.0</td>
      <td>15984.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">경북</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>11027.0</td>
      <td>11472.0</td>
      <td>11429.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>11406.0</td>
      <td>11420.0</td>
      <td>11532.0</td>
      <td>11526.0</td>
      <td>11534.0</td>
      <td>11828.0</td>
      <td>11828.0</td>
      <td>11798.0</td>
      <td>11812.0</td>
      <td>12070.0</td>
      <td>12076.0</td>
      <td>12141.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>12185.0</td>
      <td>12183.0</td>
      <td>12215.0</td>
      <td>12311.0</td>
      <td>12468.0</td>
      <td>12513.0</td>
      <td>12512.0</td>
      <td>12864.0</td>
      <td>13166.0</td>
      <td>12922.0</td>
      <td>0.0</td>
      <td>10165.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>10268.0</td>
      <td>10268.0</td>
      <td>10174.0</td>
      <td>10121.0</td>
      <td>10574.0</td>
      <td>10619.0</td>
      <td>10702.0</td>
      <td>10500.0</td>
      <td>13177.0</td>
      <td>13401.0</td>
      <td>13492.0</td>
      <td>13492.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>13322.0</td>
      <td>13430.0</td>
      <td>13536.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">광주</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>7112.0</td>
      <td>7119.0</td>
      <td>7360.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>7546.0</td>
      <td>7546.0</td>
      <td>7661.0</td>
      <td>14268.0</td>
      <td>14284.0</td>
      <td>14319.0</td>
      <td>14329.0</td>
      <td>14293.0</td>
      <td>13853.0</td>
      <td>13862.0</td>
      <td>14208.0</td>
      <td>14224.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>14215.0</td>
      <td>14215.0</td>
      <td>14119.0</td>
      <td>14392.0</td>
      <td>12005.0</td>
      <td>12049.0</td>
      <td>12013.0</td>
      <td>12031.0</td>
      <td>11797.0</td>
      <td>14490.0</td>
      <td>0.0</td>
      <td>11427.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>11422.0</td>
      <td>11422.0</td>
      <td>11495.0</td>
      <td>11004.0</td>
      <td>11046.0</td>
      <td>11233.0</td>
      <td>11103.0</td>
      <td>11103.0</td>
      <td>11293.0</td>
      <td>9353.0</td>
      <td>9666.0</td>
      <td>9773.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>9831.0</td>
      <td>9831.0</td>
      <td>9831.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">인천</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>16723.0</td>
      <td>16584.0</td>
      <td>16584.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>16582.0</td>
      <td>16585.0</td>
      <td>16577.0</td>
      <td>18092.0</td>
      <td>17208.0</td>
      <td>16567.0</td>
      <td>16517.0</td>
      <td>16617.0</td>
      <td>16289.0</td>
      <td>16904.0</td>
      <td>16937.0</td>
      <td>16926.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>16926.0</td>
      <td>17011.0</td>
      <td>17100.0</td>
      <td>17100.0</td>
      <td>17497.0</td>
      <td>17415.0</td>
      <td>17862.0</td>
      <td>18171.0</td>
      <td>18403.0</td>
      <td>18216.0</td>
      <td>0.0</td>
      <td>18309.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>18346.0</td>
      <td>18426.0</td>
      <td>18889.0</td>
      <td>18889.0</td>
      <td>18762.0</td>
      <td>13592.0</td>
      <td>13592.0</td>
      <td>13533.0</td>
      <td>13533.0</td>
      <td>16773.0</td>
      <td>18662.0</td>
      <td>18629.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>18757.0</td>
      <td>19151.0</td>
      <td>19585.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">전남</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>10400.0</td>
      <td>10252.0</td>
      <td>10252.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>10252.0</td>
      <td>10281.0</td>
      <td>10280.0</td>
      <td>10275.0</td>
      <td>10279.0</td>
      <td>10549.0</td>
      <td>10550.0</td>
      <td>10546.0</td>
      <td>10563.0</td>
      <td>10648.0</td>
      <td>10901.0</td>
      <td>10996.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>10996.0</td>
      <td>11033.0</td>
      <td>11021.0</td>
      <td>11053.0</td>
      <td>11171.0</td>
      <td>10938.0</td>
      <td>10939.0</td>
      <td>11074.0</td>
      <td>11074.0</td>
      <td>11660.0</td>
      <td>0.0</td>
      <td>11923.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>12124.0</td>
      <td>11798.0</td>
      <td>11982.0</td>
      <td>12024.0</td>
      <td>12026.0</td>
      <td>12026.0</td>
      <td>12029.0</td>
      <td>12029.0</td>
      <td>12074.0</td>
      <td>12100.0</td>
      <td>11930.0</td>
      <td>12037.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>11972.0</td>
      <td>12314.0</td>
      <td>12236.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">전북</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>10864.0</td>
      <td>10902.0</td>
      <td>10554.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>10534.0</td>
      <td>10535.0</td>
      <td>10382.0</td>
      <td>10374.0</td>
      <td>10400.0</td>
      <td>10371.0</td>
      <td>10402.0</td>
      <td>10407.0</td>
      <td>10410.0</td>
      <td>10431.0</td>
      <td>10430.0</td>
      <td>10899.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>10951.0</td>
      <td>10947.0</td>
      <td>11070.0</td>
      <td>11192.0</td>
      <td>11273.0</td>
      <td>11414.0</td>
      <td>11500.0</td>
      <td>11509.0</td>
      <td>8870.0</td>
      <td>8752.0</td>
      <td>0.0</td>
      <td>11354.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>11354.0</td>
      <td>11366.0</td>
      <td>11345.0</td>
      <td>12641.0</td>
      <td>12720.0</td>
      <td>12720.0</td>
      <td>12780.0</td>
      <td>12737.0</td>
      <td>12737.0</td>
      <td>12551.0</td>
      <td>12564.0</td>
      <td>13114.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>13114.0</td>
      <td>13229.0</td>
      <td>13358.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">제주</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>9614.0</td>
      <td>9614.0</td>
      <td>9685.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>9685.0</td>
      <td>9685.0</td>
      <td>4628.0</td>
      <td>13651.0</td>
      <td>13569.0</td>
      <td>14122.0</td>
      <td>14122.0</td>
      <td>14211.0</td>
      <td>16407.0</td>
      <td>16407.0</td>
      <td>16461.0</td>
      <td>16510.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>16490.0</td>
      <td>16453.0</td>
      <td>16412.0</td>
      <td>18250.0</td>
      <td>20348.0</td>
      <td>20762.0</td>
      <td>21366.0</td>
      <td>21366.0</td>
      <td>11752.0</td>
      <td>11752.0</td>
      <td>0.0</td>
      <td>15454.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>15557.0</td>
      <td>15862.0</td>
      <td>16055.0</td>
      <td>16055.0</td>
      <td>16055.0</td>
      <td>16055.0</td>
      <td>12906.0</td>
      <td>12906.0</td>
      <td>12906.0</td>
      <td>12906.0</td>
      <td>16675.0</td>
      <td>16910.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>16910.0</td>
      <td>16910.0</td>
      <td>16910.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">충남</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>11591.0</td>
      <td>11410.0</td>
      <td>11953.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>12017.0</td>
      <td>12035.0</td>
      <td>11440.0</td>
      <td>11803.0</td>
      <td>11809.0</td>
      <td>12048.0</td>
      <td>12048.0</td>
      <td>12167.0</td>
      <td>12168.0</td>
      <td>12159.0</td>
      <td>12488.0</td>
      <td>12513.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>12448.0</td>
      <td>12451.0</td>
      <td>12453.0</td>
      <td>12500.0</td>
      <td>12499.0</td>
      <td>12417.0</td>
      <td>12420.0</td>
      <td>12440.0</td>
      <td>12440.0</td>
      <td>12569.0</td>
      <td>0.0</td>
      <td>9519.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>9507.0</td>
      <td>9507.0</td>
      <td>9507.0</td>
      <td>9507.0</td>
      <td>9871.0</td>
      <td>12623.0</td>
      <td>12623.0</td>
      <td>12774.0</td>
      <td>12774.0</td>
      <td>12774.0</td>
      <td>12627.0</td>
      <td>12603.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>12773.0</td>
      <td>12994.0</td>
      <td>13113.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">충북</th>
      <th>2015</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>10455.0</td>
      <td>10085.0</td>
      <td>10500.0</td>
    </tr>
    <tr>
      <th>2016</th>
      <td>10518.0</td>
      <td>10518.0</td>
      <td>10463.0</td>
      <td>10430.0</td>
      <td>10476.0</td>
      <td>10681.0</td>
      <td>10788.0</td>
      <td>10881.0</td>
      <td>10886.0</td>
      <td>11276.0</td>
      <td>11283.0</td>
      <td>11497.0</td>
    </tr>
    <tr>
      <th>2017</th>
      <td>11588.0</td>
      <td>11367.0</td>
      <td>11327.0</td>
      <td>11136.0</td>
      <td>11387.0</td>
      <td>11309.0</td>
      <td>11309.0</td>
      <td>11323.0</td>
      <td>11332.0</td>
      <td>11343.0</td>
      <td>0.0</td>
      <td>11131.0</td>
    </tr>
    <tr>
      <th>2018</th>
      <td>11131.0</td>
      <td>11435.0</td>
      <td>12212.0</td>
      <td>12961.0</td>
      <td>13028.0</td>
      <td>12552.0</td>
      <td>12506.0</td>
      <td>12506.0</td>
      <td>12494.0</td>
      <td>12494.0</td>
      <td>12425.0</td>
      <td>12425.0</td>
    </tr>
    <tr>
      <th>2019</th>
      <td>12425.0</td>
      <td>12158.0</td>
      <td>12235.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>85 rows × 12 columns</p>
</div>



## Pivot Table

#### Pivot Table이란?
다시 말해 피벗 테이블이란 여러 데이터 중에서 자신이 원하는 데이터만을 가지고 원하는 행과 열에 데이터를 배치하여 새로운 보고서를 만드는 기능이다.


```python
df.head(10)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3119.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3545.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3408.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.pivot_table(df, values='분양가', index=['연도','지역명'], columns=['월'])
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
      <th>월</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>10</th>
      <th>11</th>
      <th>12</th>
    </tr>
    <tr>
      <th>연도</th>
      <th>지역명</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="17" valign="top">2015</th>
      <th>Seoul</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>5795.000000</td>
      <td>6395.40</td>
      <td>6278.400000</td>
    </tr>
    <tr>
      <th>강원</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2179.400000</td>
      <td>2177.60</td>
      <td>2177.600000</td>
    </tr>
    <tr>
      <th>경기</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3335.800000</td>
      <td>3298.80</td>
      <td>3420.800000</td>
    </tr>
    <tr>
      <th>경남</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2547.800000</td>
      <td>2568.60</td>
      <td>2573.800000</td>
    </tr>
    <tr>
      <th>경북</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2205.400000</td>
      <td>2294.40</td>
      <td>2285.800000</td>
    </tr>
    <tr>
      <th>광주</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2370.666667</td>
      <td>2373.00</td>
      <td>2453.333333</td>
    </tr>
    <tr>
      <th>대구</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2629.400000</td>
      <td>2671.60</td>
      <td>2898.000000</td>
    </tr>
    <tr>
      <th>대전</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2482.000000</td>
      <td>2482.00</td>
      <td>2482.000000</td>
    </tr>
    <tr>
      <th>부산</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3103.600000</td>
      <td>3169.20</td>
      <td>3161.200000</td>
    </tr>
    <tr>
      <th>세종</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2641.400000</td>
      <td>2655.80</td>
      <td>2671.000000</td>
    </tr>
    <tr>
      <th>울산</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2831.200000</td>
      <td>2842.40</td>
      <td>2842.400000</td>
    </tr>
    <tr>
      <th>인천</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3344.600000</td>
      <td>3316.80</td>
      <td>3316.800000</td>
    </tr>
    <tr>
      <th>전남</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2080.000000</td>
      <td>2050.40</td>
      <td>2050.400000</td>
    </tr>
    <tr>
      <th>전북</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2172.800000</td>
      <td>2180.40</td>
      <td>2110.800000</td>
    </tr>
    <tr>
      <th>제주</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2403.500000</td>
      <td>2403.50</td>
      <td>2421.250000</td>
    </tr>
    <tr>
      <th>충남</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2318.200000</td>
      <td>2282.00</td>
      <td>2390.600000</td>
    </tr>
    <tr>
      <th>충북</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2091.000000</td>
      <td>2017.00</td>
      <td>2100.000000</td>
    </tr>
    <tr>
      <th rowspan="13" valign="top">2016</th>
      <th>Seoul</th>
      <td>6327.000000</td>
      <td>6311.800000</td>
      <td>6480.000000</td>
      <td>6700.800000</td>
      <td>6637.000000</td>
      <td>6617.000000</td>
      <td>6673.800000</td>
      <td>6634.800000</td>
      <td>6649.20</td>
      <td>6847.800000</td>
      <td>6534.40</td>
      <td>6689.800000</td>
    </tr>
    <tr>
      <th>강원</th>
      <td>2178.800000</td>
      <td>2253.250000</td>
      <td>2253.500000</td>
      <td>2204.000000</td>
      <td>2167.250000</td>
      <td>2169.500000</td>
      <td>2162.000000</td>
      <td>2176.250000</td>
      <td>2172.50</td>
      <td>2121.600000</td>
      <td>2076.60</td>
      <td>2150.400000</td>
    </tr>
    <tr>
      <th>경기</th>
      <td>3420.800000</td>
      <td>3366.200000</td>
      <td>3391.600000</td>
      <td>3369.600000</td>
      <td>3586.400000</td>
      <td>3653.800000</td>
      <td>3663.000000</td>
      <td>3650.000000</td>
      <td>3495.80</td>
      <td>3570.400000</td>
      <td>3672.40</td>
      <td>3650.800000</td>
    </tr>
    <tr>
      <th>경남</th>
      <td>2539.600000</td>
      <td>2538.400000</td>
      <td>2567.800000</td>
      <td>2605.800000</td>
      <td>2640.600000</td>
      <td>2605.200000</td>
      <td>2593.800000</td>
      <td>2596.800000</td>
      <td>2557.40</td>
      <td>2564.200000</td>
      <td>2539.80</td>
      <td>2547.800000</td>
    </tr>
    <tr>
      <th>경북</th>
      <td>2281.200000</td>
      <td>2284.000000</td>
      <td>2306.400000</td>
      <td>2305.200000</td>
      <td>2306.800000</td>
      <td>2365.600000</td>
      <td>2365.600000</td>
      <td>2359.600000</td>
      <td>2362.40</td>
      <td>2414.000000</td>
      <td>2415.20</td>
      <td>2428.200000</td>
    </tr>
    <tr>
      <th>광주</th>
      <td>2515.333333</td>
      <td>2515.333333</td>
      <td>2553.666667</td>
      <td>2853.600000</td>
      <td>2856.800000</td>
      <td>2863.800000</td>
      <td>2865.800000</td>
      <td>2858.600000</td>
      <td>2770.60</td>
      <td>2772.400000</td>
      <td>2841.60</td>
      <td>2844.800000</td>
    </tr>
    <tr>
      <th>대구</th>
      <td>2961.000000</td>
      <td>2951.800000</td>
      <td>2979.200000</td>
      <td>2984.600000</td>
      <td>2993.000000</td>
      <td>3053.200000</td>
      <td>3059.000000</td>
      <td>3114.600000</td>
      <td>3114.60</td>
      <td>3114.600000</td>
      <td>3492.80</td>
      <td>3570.800000</td>
    </tr>
    <tr>
      <th>대전</th>
      <td>2482.000000</td>
      <td>2482.000000</td>
      <td>2482.000000</td>
      <td>2467.666667</td>
      <td>2491.333333</td>
      <td>2585.666667</td>
      <td>2585.666667</td>
      <td>2585.666667</td>
      <td>2537.00</td>
      <td>3215.800000</td>
      <td>2988.80</td>
      <td>2988.800000</td>
    </tr>
    <tr>
      <th>부산</th>
      <td>3185.800000</td>
      <td>3196.400000</td>
      <td>3183.000000</td>
      <td>3177.200000</td>
      <td>3165.600000</td>
      <td>3233.400000</td>
      <td>3281.800000</td>
      <td>3318.800000</td>
      <td>3322.20</td>
      <td>3297.800000</td>
      <td>3285.40</td>
      <td>3420.000000</td>
    </tr>
    <tr>
      <th>세종</th>
      <td>2671.000000</td>
      <td>2671.000000</td>
      <td>2674.800000</td>
      <td>2680.600000</td>
      <td>2680.600000</td>
      <td>2674.400000</td>
      <td>2673.600000</td>
      <td>2678.600000</td>
      <td>2685.60</td>
      <td>2705.000000</td>
      <td>2709.20</td>
      <td>2705.800000</td>
    </tr>
    <tr>
      <th>울산</th>
      <td>2844.000000</td>
      <td>2844.000000</td>
      <td>2889.000000</td>
      <td>2872.800000</td>
      <td>2877.400000</td>
      <td>2866.000000</td>
      <td>2866.000000</td>
      <td>2830.600000</td>
      <td>2830.60</td>
      <td>2936.200000</td>
      <td>3142.75</td>
      <td>3141.750000</td>
    </tr>
    <tr>
      <th>인천</th>
      <td>3316.400000</td>
      <td>3317.000000</td>
      <td>3315.400000</td>
      <td>3618.400000</td>
      <td>3441.600000</td>
      <td>3313.400000</td>
      <td>3303.400000</td>
      <td>3323.400000</td>
      <td>3257.80</td>
      <td>3380.800000</td>
      <td>3387.40</td>
      <td>3385.200000</td>
    </tr>
    <tr>
      <th>전남</th>
      <td>2050.400000</td>
      <td>2056.200000</td>
      <td>2056.000000</td>
      <td>2055.000000</td>
      <td>2055.800000</td>
      <td>2109.800000</td>
      <td>2110.000000</td>
      <td>2109.200000</td>
      <td>2112.60</td>
      <td>2129.600000</td>
      <td>2180.20</td>
      <td>2199.200000</td>
    </tr>
    <tr>
      <th>...</th>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th rowspan="14" valign="top">2018</th>
      <th>경남</th>
      <td>2779.200000</td>
      <td>2781.000000</td>
      <td>2782.000000</td>
      <td>2763.200000</td>
      <td>2765.000000</td>
      <td>2766.200000</td>
      <td>2762.600000</td>
      <td>2735.800000</td>
      <td>2842.20</td>
      <td>2894.200000</td>
      <td>2925.60</td>
      <td>3121.800000</td>
    </tr>
    <tr>
      <th>경북</th>
      <td>2567.000000</td>
      <td>2567.000000</td>
      <td>2543.500000</td>
      <td>2530.250000</td>
      <td>2643.500000</td>
      <td>2654.750000</td>
      <td>2675.500000</td>
      <td>2625.000000</td>
      <td>2635.40</td>
      <td>2680.200000</td>
      <td>2698.40</td>
      <td>2698.400000</td>
    </tr>
    <tr>
      <th>광주</th>
      <td>2855.500000</td>
      <td>2855.500000</td>
      <td>2873.750000</td>
      <td>2751.000000</td>
      <td>2761.500000</td>
      <td>2808.250000</td>
      <td>2775.750000</td>
      <td>2775.750000</td>
      <td>2823.25</td>
      <td>3117.666667</td>
      <td>3222.00</td>
      <td>3257.666667</td>
    </tr>
    <tr>
      <th>대구</th>
      <td>3559.000000</td>
      <td>3448.250000</td>
      <td>3465.000000</td>
      <td>3327.000000</td>
      <td>3696.400000</td>
      <td>3689.000000</td>
      <td>3753.400000</td>
      <td>3758.000000</td>
      <td>3780.20</td>
      <td>3838.800000</td>
      <td>3821.20</td>
      <td>3893.800000</td>
    </tr>
    <tr>
      <th>대전</th>
      <td>2797.250000</td>
      <td>2833.500000</td>
      <td>2833.500000</td>
      <td>2878.500000</td>
      <td>2878.500000</td>
      <td>2878.500000</td>
      <td>2794.333333</td>
      <td>2794.333333</td>
      <td>3527.00</td>
      <td>3516.750000</td>
      <td>3516.75</td>
      <td>4049.666667</td>
    </tr>
    <tr>
      <th>부산</th>
      <td>3788.600000</td>
      <td>3793.400000</td>
      <td>3756.400000</td>
      <td>3774.800000</td>
      <td>3784.800000</td>
      <td>3808.600000</td>
      <td>3899.200000</td>
      <td>3902.800000</td>
      <td>4131.00</td>
      <td>4136.600000</td>
      <td>4042.60</td>
      <td>4053.800000</td>
    </tr>
    <tr>
      <th>세종</th>
      <td>3162.750000</td>
      <td>3162.750000</td>
      <td>3162.750000</td>
      <td>3123.000000</td>
      <td>3123.000000</td>
      <td>3123.000000</td>
      <td>3123.000000</td>
      <td>3143.400000</td>
      <td>3143.40</td>
      <td>3143.400000</td>
      <td>3143.40</td>
      <td>3065.400000</td>
    </tr>
    <tr>
      <th>울산</th>
      <td>3162.000000</td>
      <td>3174.000000</td>
      <td>3174.000000</td>
      <td>3174.000000</td>
      <td>3174.000000</td>
      <td>3125.000000</td>
      <td>3125.000000</td>
      <td>3125.000000</td>
      <td>3125.00</td>
      <td>2890.000000</td>
      <td>2890.00</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>인천</th>
      <td>3669.200000</td>
      <td>3685.200000</td>
      <td>3777.800000</td>
      <td>3777.800000</td>
      <td>3752.400000</td>
      <td>3398.000000</td>
      <td>3398.000000</td>
      <td>3383.250000</td>
      <td>3383.25</td>
      <td>3354.600000</td>
      <td>3732.40</td>
      <td>3725.800000</td>
    </tr>
    <tr>
      <th>전남</th>
      <td>2424.800000</td>
      <td>2359.600000</td>
      <td>2396.400000</td>
      <td>2404.800000</td>
      <td>2405.200000</td>
      <td>2405.200000</td>
      <td>2405.800000</td>
      <td>2405.800000</td>
      <td>2414.80</td>
      <td>2420.000000</td>
      <td>2386.00</td>
      <td>2407.400000</td>
    </tr>
    <tr>
      <th>전북</th>
      <td>2270.800000</td>
      <td>2273.200000</td>
      <td>2269.000000</td>
      <td>2528.200000</td>
      <td>2544.000000</td>
      <td>2544.000000</td>
      <td>2556.000000</td>
      <td>2547.400000</td>
      <td>2547.40</td>
      <td>2510.200000</td>
      <td>2512.80</td>
      <td>2622.800000</td>
    </tr>
    <tr>
      <th>제주</th>
      <td>3889.250000</td>
      <td>3965.500000</td>
      <td>4013.750000</td>
      <td>4013.750000</td>
      <td>4013.750000</td>
      <td>4013.750000</td>
      <td>3226.500000</td>
      <td>3226.500000</td>
      <td>3226.50</td>
      <td>3226.500000</td>
      <td>3335.00</td>
      <td>3382.000000</td>
    </tr>
    <tr>
      <th>충남</th>
      <td>2376.750000</td>
      <td>2376.750000</td>
      <td>2376.750000</td>
      <td>2376.750000</td>
      <td>2467.750000</td>
      <td>2524.600000</td>
      <td>2524.600000</td>
      <td>2554.800000</td>
      <td>2554.80</td>
      <td>2554.800000</td>
      <td>2525.40</td>
      <td>2520.600000</td>
    </tr>
    <tr>
      <th>충북</th>
      <td>2226.200000</td>
      <td>2287.000000</td>
      <td>2442.400000</td>
      <td>2592.200000</td>
      <td>2605.600000</td>
      <td>2510.400000</td>
      <td>2501.200000</td>
      <td>2501.200000</td>
      <td>2498.80</td>
      <td>2498.800000</td>
      <td>2485.00</td>
      <td>2485.000000</td>
    </tr>
    <tr>
      <th rowspan="16" valign="top">2019</th>
      <th>Seoul</th>
      <td>7546.800000</td>
      <td>7518.400000</td>
      <td>7552.200000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>강원</th>
      <td>2523.600000</td>
      <td>2523.600000</td>
      <td>2541.200000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>경기</th>
      <td>4550.000000</td>
      <td>4575.800000</td>
      <td>4539.200000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>경남</th>
      <td>3121.800000</td>
      <td>3120.800000</td>
      <td>3196.800000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>경북</th>
      <td>2664.400000</td>
      <td>2686.000000</td>
      <td>2707.200000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>광주</th>
      <td>3277.000000</td>
      <td>3277.000000</td>
      <td>3277.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>대구</th>
      <td>4002.600000</td>
      <td>4004.400000</td>
      <td>3998.800000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>대전</th>
      <td>4081.000000</td>
      <td>4081.000000</td>
      <td>3906.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>부산</th>
      <td>4053.800000</td>
      <td>4053.800000</td>
      <td>4078.800000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>세종</th>
      <td>3065.400000</td>
      <td>3065.400000</td>
      <td>3065.400000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>인천</th>
      <td>3751.400000</td>
      <td>3830.200000</td>
      <td>3917.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>전남</th>
      <td>2394.400000</td>
      <td>2462.800000</td>
      <td>2447.200000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>전북</th>
      <td>2622.800000</td>
      <td>2645.800000</td>
      <td>2671.600000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>제주</th>
      <td>3382.000000</td>
      <td>3382.000000</td>
      <td>3382.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>충남</th>
      <td>2554.600000</td>
      <td>2598.800000</td>
      <td>2622.600000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>충북</th>
      <td>2485.000000</td>
      <td>2431.600000</td>
      <td>2447.000000</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>84 rows × 12 columns</p>
</div>



## Categoricals


```python
df.head(10)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3119.0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3545.0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3408.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df['분양가'].describe()
```




    count    3273.000000
    mean     3130.001833
    std      1141.740958
    min      1868.000000
    25%      2387.000000
    50%      2787.000000
    75%      3383.000000
    max      8191.000000
    Name: 분양가, dtype: float64




```python
df['평가'] = 0
```


```python
df.head(10)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>평가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3119.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3545.0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3408.0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



**가격대 별 평가**

low: 25% = 2387 보다 싼 분양가 

mid: 50% = 2387 ~ 3130 

high: 75% = 3130 ~ 3383

very high: 75% ~ 100% = 3383 보다 비싼 분양가 

### np.select를 활용하여 조건에 맞는 값을 대입하기


```python
conditions = [
    (df['분양가'] < 2387),
    (df['분양가'] >= 2387) & (df['분양가'] < 3130),
    (df['분양가'] >= 3130) & (df['분양가'] < 3383),
    (df['분양가'] >= 3383),
    (df['분양가'] == np.nan)
]
choices = ['저렴', '보통', '비쌈', '매우 비쌈', '-']
df['평가'] = np.select(conditions, choices, default=0)
```


```python
df.head(20)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>평가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>비쌈</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3119.0</td>
      <td>보통</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3545.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3408.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>10</th>
      <td>경기</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3138.0</td>
      <td>비쌈</td>
    </tr>
    <tr>
      <th>11</th>
      <td>경기</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3126.0</td>
      <td>보통</td>
    </tr>
    <tr>
      <th>12</th>
      <td>경기</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3239.0</td>
      <td>비쌈</td>
    </tr>
    <tr>
      <th>13</th>
      <td>경기</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3496.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>14</th>
      <td>경기</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3680.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>15</th>
      <td>부산</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3112.0</td>
      <td>보통</td>
    </tr>
    <tr>
      <th>16</th>
      <td>부산</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>2950.0</td>
      <td>보통</td>
    </tr>
    <tr>
      <th>17</th>
      <td>부산</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>2999.0</td>
      <td>보통</td>
    </tr>
    <tr>
      <th>18</th>
      <td>부산</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>2957.0</td>
      <td>보통</td>
    </tr>
    <tr>
      <th>19</th>
      <td>부산</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3500.0</td>
      <td>매우 비쌈</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.groupby(by='평가').count()
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
    </tr>
    <tr>
      <th>평가</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>297</td>
      <td>297</td>
      <td>297</td>
      <td>297</td>
      <td>0</td>
    </tr>
    <tr>
      <th>매우 비쌈</th>
      <td>819</td>
      <td>819</td>
      <td>819</td>
      <td>819</td>
      <td>819</td>
    </tr>
    <tr>
      <th>보통</th>
      <td>1285</td>
      <td>1285</td>
      <td>1285</td>
      <td>1285</td>
      <td>1285</td>
    </tr>
    <tr>
      <th>비쌈</th>
      <td>352</td>
      <td>352</td>
      <td>352</td>
      <td>352</td>
      <td>352</td>
    </tr>
    <tr>
      <th>저렴</th>
      <td>817</td>
      <td>817</td>
      <td>817</td>
      <td>817</td>
      <td>817</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.sort_values(by='분양가', ascending=False)[:10]
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>평가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3487</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>3</td>
      <td>8191.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>3402</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>2</td>
      <td>8141.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>3317</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2019</td>
      <td>1</td>
      <td>8105.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>2638</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2018</td>
      <td>5</td>
      <td>8098.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>513</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2016</td>
      <td>4</td>
      <td>8096.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>3232</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2018</td>
      <td>12</td>
      <td>7890.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>1958</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2017</td>
      <td>9</td>
      <td>7887.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>2553</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2018</td>
      <td>4</td>
      <td>7823.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>2468</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2018</td>
      <td>3</td>
      <td>7823.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>3319</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2019</td>
      <td>1</td>
      <td>7787.0</td>
      <td>매우 비쌈</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.dtypes
```




    지역명      object
    규모구분     object
    연도        int64
    월         int64
    분양가     float64
    평가       object
    dtype: object




```python
df['평가'] = df['평가'].astype('category')
```


```python
df.dtypes
```




    지역명       object
    규모구분      object
    연도         int64
    월          int64
    분양가      float64
    평가      category
    dtype: object




```python
df.head(10)
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
      <th>지역명</th>
      <th>규모구분</th>
      <th>연도</th>
      <th>월</th>
      <th>분양가</th>
      <th>평가</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Seoul</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>5841.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Seoul</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5652.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Seoul</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5882.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Seoul</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>5721.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Seoul</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>5879.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>5</th>
      <td>인천</td>
      <td>전체</td>
      <td>2015</td>
      <td>10</td>
      <td>3163.0</td>
      <td>비쌈</td>
    </tr>
    <tr>
      <th>6</th>
      <td>인천</td>
      <td>전용면적 60㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3488.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>7</th>
      <td>인천</td>
      <td>전용면적 60㎡초과 85㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3119.0</td>
      <td>보통</td>
    </tr>
    <tr>
      <th>8</th>
      <td>인천</td>
      <td>전용면적 85㎡초과 102㎡이하</td>
      <td>2015</td>
      <td>10</td>
      <td>3545.0</td>
      <td>매우 비쌈</td>
    </tr>
    <tr>
      <th>9</th>
      <td>인천</td>
      <td>전용면적 102㎡초과</td>
      <td>2015</td>
      <td>10</td>
      <td>3408.0</td>
      <td>매우 비쌈</td>
    </tr>
  </tbody>
</table>
</div>




```python
df['평가'].head()
```




    0    매우 비쌈
    1    매우 비쌈
    2    매우 비쌈
    3    매우 비쌈
    4    매우 비쌈
    Name: 평가, dtype: category
    Categories (5, object): [0, 매우 비쌈, 보통, 비쌈, 저렴]




```python
df['평가'].cat.categories = ['해당없음', '개비쌈', '평균', '쫌비쌈', '쌈']
```


```python
df['평가'].head()
```




    0    개비쌈
    1    개비쌈
    2    개비쌈
    3    개비쌈
    4    개비쌈
    Name: 평가, dtype: category
    Categories (5, object): [해당없음, 개비쌈, 평균, 쫌비쌈, 쌈]



## 끝!





##### #python #pandas #10minstopandas