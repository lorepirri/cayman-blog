---
layout: page
title: "판다스(Pandas) .groupby()로 할 수 있는 거의 모든 것! (통계량, 전처리)"
description: "판다스(Pandas) .groupby()로 할 수 있는 거의 모든 것! (통계량, 전처리)에 대해 알아보겠습니다."
headline: "판다스(Pandas) .groupby()로 할 수 있는 거의 모든 것! (통계량, 전처리)에 대해 알아보겠습니다."
categories: pandas
tags: [python, 파이썬, pandas, groupby, 그룹화, 데이터 전처리, 판다스 데이터분석, 데이터프레임, DataFrame, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2022-07-29
---

판다스(Pandas)의 `.groupby()` 기능은 데이터를 **그룹별로 분할**하여 독립된 그룹에 대하여 **별도로 데이터를 처리**(혹은 적용)하거나 **그룹별 통계량**을 확인하고자 할 때 유용한 함수 입니다.

`.groupby()`의 동작 원리는 아래 그림과 같습니다.

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


![pandas-groupby](https://www.w3resource.com/w3r_images/pandas-groupby-split-apply-combine.svg)

이미지 출처: www.w3resource.com


- **Split 단계**: 위에 이미지에서 **Split** 단계에서 `.groupby()`에서 정의한 컬럼 조건에 따라 독립된 그룹으로 나누어 줍니다. 예시에서는 `ID` 값을 기준으로 그룹을 나누었는데, 3개의 sub-group으로 분할된 모습입니다.

- **Apply** 단계: 나뉘어진 독립된 그룹별 함수를 적용하는 단계 입니다. 예시에서는 합계(sum)함수를 적용하여 각 그룹별 총계가 합산된 결과를 확인할 수 있습니다.

- **Combine** 단계: 최종 단계이며, 각각의 독립된 그룹별로 함수가 적용된 결과를 종합하여 다시 하나의 테이블로 합칩니다.


판다스(Pandas)의 `.groupby()` 메서드는 앞서 언급한 바와 같이 데이터를 특정 기준으로 그룹화하여 처리할 수 있는 기능 덕분에, 데이터 전처리/분석 시 유용하게 활용할 수 있습니다.



아래는 다양한 활용 사례에 대하여 소개해 드리고자 합니다.



```python
# 모듈 import
import pandas as pd
import seaborn as sns

# 샘플 데이터 로드
df = sns.load_dataset('tips')
df
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16.99</td>
      <td>1.01</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10.34</td>
      <td>1.66</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>2</th>
      <td>21.01</td>
      <td>3.50</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>23.68</td>
      <td>3.31</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>24.59</td>
      <td>3.61</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>239</th>
      <td>29.03</td>
      <td>5.92</td>
      <td>Male</td>
      <td>No</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>240</th>
      <td>27.18</td>
      <td>2.00</td>
      <td>Female</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>241</th>
      <td>22.67</td>
      <td>2.00</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>242</th>
      <td>17.82</td>
      <td>1.75</td>
      <td>Male</td>
      <td>No</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>243</th>
      <td>18.78</td>
      <td>3.00</td>
      <td>Female</td>
      <td>No</td>
      <td>Thur</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
<p>244 rows × 7 columns</p>
</div>


## 그룹별 통계량 확인



- 데이터 프레임에 `.groupby(컬럼)` + **통계함수**로 그룹별 통계량을 확인할 수 있습니다.

- 통계 결과는 통계계산이 가능한 수치형(numerical) 컬럼에 대해서만 산출합니다.



```python
# 평균(mean)
df.groupby('sex').mean()
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
      <th>total_bill</th>
      <th>tip</th>
      <th>size</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>20.744076</td>
      <td>3.089618</td>
      <td>2.630573</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>18.056897</td>
      <td>2.833448</td>
      <td>2.459770</td>
    </tr>
  </tbody>
</table>
</div>



```python
# 분산(var)
df.groupby('sex').var()
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
      <th>total_bill</th>
      <th>tip</th>
      <th>size</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>85.497185</td>
      <td>2.217424</td>
      <td>0.913931</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>64.147429</td>
      <td>1.344428</td>
      <td>0.879177</td>
    </tr>
  </tbody>
</table>
</div>




> `.agg()`에 적용할 수 있는 통계함수 문자열 표

| 함수            | 내용                |
| --------------- | ------------------- |
| count           | 데이터의 개수       |
| sum             | 합계                |
| mean            | 평균                |
| median          | 중앙값              |
| var, std        | 분산, 표준편차      |
| min, max        | 최소, 최대값        |
| unique, nunique | 고유값, 고유값 개수 |
| prod            | 곲                  |
| first, last     | 첫째, 마지막값      |



`.agg()`를 활용하여 다중 통계량을 구할 수 있습니다.



```python
# 다중 통계 적용
df.groupby('sex').agg(['mean', 'var'])
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
      <th colspan="2" halign="left">total_bill</th>
      <th colspan="2" halign="left">tip</th>
      <th colspan="2" halign="left">size</th>
    </tr>
    <tr>
      <th></th>
      <th>mean</th>
      <th>var</th>
      <th>mean</th>
      <th>var</th>
      <th>mean</th>
      <th>var</th>
    </tr>
    <tr>
      <th>sex</th>
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
      <th>Male</th>
      <td>20.744076</td>
      <td>85.497185</td>
      <td>3.089618</td>
      <td>2.217424</td>
      <td>2.630573</td>
      <td>0.913931</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>18.056897</td>
      <td>64.147429</td>
      <td>2.833448</td>
      <td>1.344428</td>
      <td>2.459770</td>
      <td>0.879177</td>
    </tr>
  </tbody>
</table>
</div>


`.agg()`에서 문자열로 지정할 수 있는 함수 목록은 다음과 같습니다.


`.agg()`로 다중 통계량을 구할 때 컬럼별 적용할 통계 함수를 다르게 적용할 수 있습니다.



```python
# 컬럼별 다른 통계량 산출
df.groupby('sex').agg({'total_bill': 'mean', 
                       'tip': ['sum', 'var'],
                       'size': 'median'
                      })
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
      <th>total_bill</th>
      <th colspan="2" halign="left">tip</th>
      <th>size</th>
    </tr>
    <tr>
      <th></th>
      <th>mean</th>
      <th>sum</th>
      <th>var</th>
      <th>median</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>20.744076</td>
      <td>485.07</td>
      <td>2.217424</td>
      <td>2.0</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>18.056897</td>
      <td>246.51</td>
      <td>1.344428</td>
      <td>2.0</td>
    </tr>
  </tbody>
</table>
</div>


바로 이전 출력 결과에서는 `MultiIndex`로 된 컬럼 형태로 출력이 되는데, 이를 **평탄화(Flatten)** 하여 보기 좋게 만들 수 있습니다.



```python
# MultiIndex 컬럼을 평탄화 하는 함수
def flat_cols(df):
    df.columns = [' / '.join(x) for x in df.columns.to_flat_index()]
    return df

# 컬럼별 다른 통계량 산출
df.groupby('sex').agg({'total_bill': 'mean', 
                       'tip': ['sum', 'var'],
                       'size': 'median'
                      }).pipe(flatten_cols)
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
      <th>total_bill / mean</th>
      <th>tip / sum</th>
      <th>tip / var</th>
      <th>size / median</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>20.744076</td>
      <td>485.07</td>
      <td>2.217424</td>
      <td>2.0</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>18.056897</td>
      <td>246.51</td>
      <td>1.344428</td>
      <td>2.0</td>
    </tr>
  </tbody>
</table>
</div>


만약 위의 결과 테이블에서 출력결과의 소수점 자릿수를 지정하고 싶다면, 끝에 `.round(소수점 자릿수)`를 추가할 수 있습니다.



```python
# .round(2): 소수점 둘째자리까지 반올림하여 결과 출력
df.groupby('sex').agg({'total_bill': 'mean', 
                       'tip': ['sum', 'var'],
                       'size': 'median'
                      }).pipe(flatten_cols).round(2)
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
      <th>total_bill / mean</th>
      <th>tip / sum</th>
      <th>tip / var</th>
      <th>size / median</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>20.74</td>
      <td>485.07</td>
      <td>2.22</td>
      <td>2.0</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>18.06</td>
      <td>246.51</td>
      <td>1.34</td>
      <td>2.0</td>
    </tr>
  </tbody>
</table>
</div>


`.agg()`함수에 사용자 정의 함수(Custom Function)를 적용할 수 있습니다.



- 단, 사용자 정의 함수는 합산(aggregated)된 결과를 반환해야 합니다.



```python
df.groupby('sex')[['total_bill', 'tip']].agg(lambda x: x.mean() / x.std())
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
      <th>total_bill</th>
      <th>tip</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>2.243459</td>
      <td>2.074820</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>2.254517</td>
      <td>2.443693</td>
    </tr>
  </tbody>
</table>
</div>


`.agg()` 적용한 결과에 대하여 `reset_index()`를 적용하여 왼쪽 Index를 초기화할 수 있습니다.



```python
# 인덱스 초기화 전
display(df.groupby('sex').mean())

# 인덱스 초기화 후
df.groupby('sex').mean().reset_index()
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
      <th>total_bill</th>
      <th>tip</th>
      <th>size</th>
    </tr>
    <tr>
      <th>sex</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Male</th>
      <td>20.744076</td>
      <td>3.089618</td>
      <td>2.630573</td>
    </tr>
    <tr>
      <th>Female</th>
      <td>18.056897</td>
      <td>2.833448</td>
      <td>2.459770</td>
    </tr>
  </tbody>
</table>
</div>


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
      <th>sex</th>
      <th>total_bill</th>
      <th>tip</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Male</td>
      <td>20.744076</td>
      <td>3.089618</td>
      <td>2.630573</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Female</td>
      <td>18.056897</td>
      <td>2.833448</td>
      <td>2.459770</td>
    </tr>
  </tbody>
</table>
</div>


## 분리된 group 순회



`groupby`를 활용한 순회시 첫번째 인자는 key값을, 두번재 인자는 group을 반환합니다.



```python
# sex, smoker 기준으로 그룹한 후 순회하며 출력
for (k1, k2), group in df.groupby(['sex', 'smoker']):
    print((k1, k2))
    # 데이터프레임 출력
    display(group.head())
```

<pre>
('Male', 'Yes')
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>56</th>
      <td>38.01</td>
      <td>3.00</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
    <tr>
      <th>58</th>
      <td>11.24</td>
      <td>1.76</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>60</th>
      <td>20.29</td>
      <td>3.21</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>61</th>
      <td>13.81</td>
      <td>2.00</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>62</th>
      <td>11.02</td>
      <td>1.98</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>


<pre>
('Male', 'No')
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>10.34</td>
      <td>1.66</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>2</th>
      <td>21.01</td>
      <td>3.50</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>23.68</td>
      <td>3.31</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>5</th>
      <td>25.29</td>
      <td>4.71</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
    <tr>
      <th>6</th>
      <td>8.77</td>
      <td>2.00</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>


<pre>
('Female', 'Yes')
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>67</th>
      <td>3.07</td>
      <td>1.00</td>
      <td>Female</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>1</td>
    </tr>
    <tr>
      <th>72</th>
      <td>26.86</td>
      <td>3.14</td>
      <td>Female</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>73</th>
      <td>25.28</td>
      <td>5.00</td>
      <td>Female</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>92</th>
      <td>5.75</td>
      <td>1.00</td>
      <td>Female</td>
      <td>Yes</td>
      <td>Fri</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>93</th>
      <td>16.32</td>
      <td>4.30</td>
      <td>Female</td>
      <td>Yes</td>
      <td>Fri</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>


<pre>
('Female', 'No')
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16.99</td>
      <td>1.01</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>24.59</td>
      <td>3.61</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
    <tr>
      <th>11</th>
      <td>35.26</td>
      <td>5.00</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
    <tr>
      <th>14</th>
      <td>14.83</td>
      <td>3.02</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>16</th>
      <td>10.33</td>
      <td>1.67</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>


다음과 같이 `dict`로 변환한 후 키 값으로 조회하여 **그룹별 데이터프레임(DataFrame)을 조회**할 수 있습니다.



```python
# 그룹별 데이터프레임을 생성 후 dict에 저장
output = dict(list(df.groupby(['sex', 'smoker'])))
output.keys()
```

<pre>
dict_keys([('Male', 'Yes'), ('Male', 'No'), ('Female', 'Yes'), ('Female', 'No')])
</pre>

```python
# sex == Male & smoker == Yes 인 그룹 조회
output[('Male', 'Yes')].head()
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>56</th>
      <td>38.01</td>
      <td>3.00</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
    <tr>
      <th>58</th>
      <td>11.24</td>
      <td>1.76</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>60</th>
      <td>20.29</td>
      <td>3.21</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>61</th>
      <td>13.81</td>
      <td>2.00</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>62</th>
      <td>11.02</td>
      <td>1.98</td>
      <td>Male</td>
      <td>Yes</td>
      <td>Sat</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>


## apply()로 그룹별 데이터 전처리



```python
# 샘플 데이터셋 로드
df = sns.load_dataset('titanic')
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
      <th>survived</th>
      <th>pclass</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>fare</th>
      <th>embarked</th>
      <th>class</th>
      <th>who</th>
      <th>adult_male</th>
      <th>deck</th>
      <th>embark_town</th>
      <th>alive</th>
      <th>alone</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>3</td>
      <td>male</td>
      <td>22.0</td>
      <td>1</td>
      <td>0</td>
      <td>7.2500</td>
      <td>S</td>
      <td>Third</td>
      <td>man</td>
      <td>True</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>no</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>1</td>
      <td>female</td>
      <td>38.0</td>
      <td>1</td>
      <td>0</td>
      <td>71.2833</td>
      <td>C</td>
      <td>First</td>
      <td>woman</td>
      <td>False</td>
      <td>C</td>
      <td>Cherbourg</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1</td>
      <td>3</td>
      <td>female</td>
      <td>26.0</td>
      <td>0</td>
      <td>0</td>
      <td>7.9250</td>
      <td>S</td>
      <td>Third</td>
      <td>woman</td>
      <td>False</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>True</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>1</td>
      <td>female</td>
      <td>35.0</td>
      <td>1</td>
      <td>0</td>
      <td>53.1000</td>
      <td>S</td>
      <td>First</td>
      <td>woman</td>
      <td>False</td>
      <td>C</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0</td>
      <td>3</td>
      <td>male</td>
      <td>35.0</td>
      <td>0</td>
      <td>0</td>
      <td>8.0500</td>
      <td>S</td>
      <td>Third</td>
      <td>man</td>
      <td>True</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>no</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>


타아타닉(titanic) 데이터셋을 로드하였습니다.



현재 `age` 컬럼에는 총 177건의 결측 데이터가 존재합니다.



```python
# age 컬럼의 결측치 조회
df['age'].isnull().sum()
```

<pre>
177
</pre>
나이 컬럼에 대한 결측치를 단순 통계량이나 임의의 값으로 채울 수 있지만, `.groupby()`를 활용하여 그룹별 통계량으로 채울 수 있습니다.



아래의 예시는 먼저 `.groupby('sex')`로 성별 그룹으로 나눈 뒤, 나이 컬럼에 대하여 각 그룹의 나이 평균으로 결측치를 채웁니다.



즉, **남자는 남자 나이의 평균값**으로 / **여자는 여자 나이의 평균값**으로 결측치가 채워집니다.



```python
# 성별 나이의 평균으로 각각 성별 그룹의 나이의 평균으로 값을 채웁니다.
df.groupby('sex')['age'].apply(lambda x: x.fillna(x.mean()))
```

<pre>
0      22.000000
1      38.000000
2      26.000000
3      35.000000
4      35.000000
         ...    
886    27.000000
887    19.000000
888    27.915709
889    26.000000
890    32.000000
Name: age, Length: 891, dtype: float64
</pre>
`.apply()` 함수에 사용자 정의 함수(Custom Function)를 적용하는 것도 가능합니다.



아래 예시는 상위 5개의 행을 출력하는 함수를 적용한 예시입니다.



```python
def get_top5(x):
    # 나이를 기준으로 정렬하여 상위 5개 행을 반환
    return x.sort_values('age').head()

df.groupby('sex').apply(get_top5)
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
      <th>survived</th>
      <th>pclass</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>fare</th>
      <th>embarked</th>
      <th>class</th>
      <th>who</th>
      <th>adult_male</th>
      <th>deck</th>
      <th>embark_town</th>
      <th>alive</th>
      <th>alone</th>
    </tr>
    <tr>
      <th>sex</th>
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
      <th rowspan="5" valign="top">female</th>
      <th>469</th>
      <td>1</td>
      <td>3</td>
      <td>female</td>
      <td>0.75</td>
      <td>2</td>
      <td>1</td>
      <td>19.2583</td>
      <td>C</td>
      <td>Third</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Cherbourg</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>644</th>
      <td>1</td>
      <td>3</td>
      <td>female</td>
      <td>0.75</td>
      <td>2</td>
      <td>1</td>
      <td>19.2583</td>
      <td>C</td>
      <td>Third</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Cherbourg</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>381</th>
      <td>1</td>
      <td>3</td>
      <td>female</td>
      <td>1.00</td>
      <td>0</td>
      <td>2</td>
      <td>15.7417</td>
      <td>C</td>
      <td>Third</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Cherbourg</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>172</th>
      <td>1</td>
      <td>3</td>
      <td>female</td>
      <td>1.00</td>
      <td>1</td>
      <td>1</td>
      <td>11.1333</td>
      <td>S</td>
      <td>Third</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>642</th>
      <td>0</td>
      <td>3</td>
      <td>female</td>
      <td>2.00</td>
      <td>3</td>
      <td>2</td>
      <td>27.9000</td>
      <td>S</td>
      <td>Third</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>no</td>
      <td>False</td>
    </tr>
    <tr>
      <th rowspan="5" valign="top">male</th>
      <th>803</th>
      <td>1</td>
      <td>3</td>
      <td>male</td>
      <td>0.42</td>
      <td>0</td>
      <td>1</td>
      <td>8.5167</td>
      <td>C</td>
      <td>Third</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Cherbourg</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>755</th>
      <td>1</td>
      <td>2</td>
      <td>male</td>
      <td>0.67</td>
      <td>1</td>
      <td>1</td>
      <td>14.5000</td>
      <td>S</td>
      <td>Second</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>831</th>
      <td>1</td>
      <td>2</td>
      <td>male</td>
      <td>0.83</td>
      <td>1</td>
      <td>1</td>
      <td>18.7500</td>
      <td>S</td>
      <td>Second</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>78</th>
      <td>1</td>
      <td>2</td>
      <td>male</td>
      <td>0.83</td>
      <td>0</td>
      <td>2</td>
      <td>29.0000</td>
      <td>S</td>
      <td>Second</td>
      <td>child</td>
      <td>False</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>305</th>
      <td>1</td>
      <td>1</td>
      <td>male</td>
      <td>0.92</td>
      <td>1</td>
      <td>2</td>
      <td>151.5500</td>
      <td>S</td>
      <td>First</td>
      <td>child</td>
      <td>False</td>
      <td>C</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>False</td>
    </tr>
  </tbody>
</table>
</div>

