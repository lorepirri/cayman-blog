---
layout: page
title:  "캐글/데이콘 경진대회 Baseline을 잡기 위한 optuna + [xgboost, lightgbm, catboost] 패키지 소개"
description: "캐글/데이콘 경진대회 Baseline을 잡기 위한 optuna + [xgboost, lightgbm, catboost] 패키지 소개드리도록 하겠습니다."
headline: "캐글/데이콘 경진대회 Baseline을 잡기 위한 optuna + [xgboost, lightgbm, catboost] 패키지 소개드리도록 하겠습니다."
categories: machine-learning
tags: [python, 인공지능 책, 테디노트 책, 테디노트, 파이썬, 파이썬 딥러닝 텐서플로, data science, 데이터 분석, 딥러닝, optuna, lightgbm, xgboost, catboost, 캐글, 데이콘, kaggle, 하이퍼파라미터 튜닝]
comments: true
published: true
typora-copy-images-to: ../images/2021-12-31
---


경진대회에서 모델의 Hyperparameter 튜닝에 드는 노력과 시간을 절약하기 위하여 xgboost, lightgbm, catboost 3개의 라이브러리에 대하여 optuna 튜닝을 적용하여 예측 값을 산출해 내는 로직을 라이브러리 형태로 패키징 했습니다.

## 경진대회 BASELINE을 잡기 위한 optuna + [xgboost, lightgbm, catboost]


지원하는 예측 종류는

- 회귀(regression)
- 이진분류(binary classification)
- 다중분류(multi-class classification)


입니다.


앞으로 라이브러리 개선작업을 통해 더 빠르게 최적화할 수 있도록 개선해 나갈 계획입니다.



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


## 설치



```python
!pip install -U teddynote
```


```python
# 모듈 import 
from teddynote import models
```

## 샘플 데이터셋 로드



```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import warnings

from sklearn.datasets import load_iris, load_boston, load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error

import lightgbm as lgb
import xgboost as xgb
import catboost as cb

from lightgbm import LGBMRegressor, LGBMClassifier
from xgboost import XGBRegressor, XGBClassifier
from catboost import CatBoostRegressor, CatBoostClassifier

warnings.filterwarnings('ignore')

SEED = 2021
```


```python
# Binary Class Datasets
cancer = load_breast_cancer()
cancer_df = pd.DataFrame(cancer['data'], columns=cancer['feature_names'])
cancer_df['target'] = cancer['target']
cancer_df.head()
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
      <th>mean radius</th>
      <th>mean texture</th>
      <th>mean perimeter</th>
      <th>mean area</th>
      <th>mean smoothness</th>
      <th>mean compactness</th>
      <th>mean concavity</th>
      <th>mean concave points</th>
      <th>mean symmetry</th>
      <th>mean fractal dimension</th>
      <th>...</th>
      <th>worst texture</th>
      <th>worst perimeter</th>
      <th>worst area</th>
      <th>worst smoothness</th>
      <th>worst compactness</th>
      <th>worst concavity</th>
      <th>worst concave points</th>
      <th>worst symmetry</th>
      <th>worst fractal dimension</th>
      <th>target</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>17.99</td>
      <td>10.38</td>
      <td>122.80</td>
      <td>1001.0</td>
      <td>0.11840</td>
      <td>0.27760</td>
      <td>0.3001</td>
      <td>0.14710</td>
      <td>0.2419</td>
      <td>0.07871</td>
      <td>...</td>
      <td>17.33</td>
      <td>184.60</td>
      <td>2019.0</td>
      <td>0.1622</td>
      <td>0.6656</td>
      <td>0.7119</td>
      <td>0.2654</td>
      <td>0.4601</td>
      <td>0.11890</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>20.57</td>
      <td>17.77</td>
      <td>132.90</td>
      <td>1326.0</td>
      <td>0.08474</td>
      <td>0.07864</td>
      <td>0.0869</td>
      <td>0.07017</td>
      <td>0.1812</td>
      <td>0.05667</td>
      <td>...</td>
      <td>23.41</td>
      <td>158.80</td>
      <td>1956.0</td>
      <td>0.1238</td>
      <td>0.1866</td>
      <td>0.2416</td>
      <td>0.1860</td>
      <td>0.2750</td>
      <td>0.08902</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>19.69</td>
      <td>21.25</td>
      <td>130.00</td>
      <td>1203.0</td>
      <td>0.10960</td>
      <td>0.15990</td>
      <td>0.1974</td>
      <td>0.12790</td>
      <td>0.2069</td>
      <td>0.05999</td>
      <td>...</td>
      <td>25.53</td>
      <td>152.50</td>
      <td>1709.0</td>
      <td>0.1444</td>
      <td>0.4245</td>
      <td>0.4504</td>
      <td>0.2430</td>
      <td>0.3613</td>
      <td>0.08758</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>11.42</td>
      <td>20.38</td>
      <td>77.58</td>
      <td>386.1</td>
      <td>0.14250</td>
      <td>0.28390</td>
      <td>0.2414</td>
      <td>0.10520</td>
      <td>0.2597</td>
      <td>0.09744</td>
      <td>...</td>
      <td>26.50</td>
      <td>98.87</td>
      <td>567.7</td>
      <td>0.2098</td>
      <td>0.8663</td>
      <td>0.6869</td>
      <td>0.2575</td>
      <td>0.6638</td>
      <td>0.17300</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>20.29</td>
      <td>14.34</td>
      <td>135.10</td>
      <td>1297.0</td>
      <td>0.10030</td>
      <td>0.13280</td>
      <td>0.1980</td>
      <td>0.10430</td>
      <td>0.1809</td>
      <td>0.05883</td>
      <td>...</td>
      <td>16.67</td>
      <td>152.20</td>
      <td>1575.0</td>
      <td>0.1374</td>
      <td>0.2050</td>
      <td>0.4000</td>
      <td>0.1625</td>
      <td>0.2364</td>
      <td>0.07678</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 31 columns</p>
</div>



```python
# Multi Class Datasets
iris = load_iris()
iris_df = pd.DataFrame(iris['data'], columns=iris['feature_names'])
iris_df['target'] = iris['target']
iris_df.head()
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
      <th>sepal length (cm)</th>
      <th>sepal width (cm)</th>
      <th>petal length (cm)</th>
      <th>petal width (cm)</th>
      <th>target</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>5.1</td>
      <td>3.5</td>
      <td>1.4</td>
      <td>0.2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4.9</td>
      <td>3.0</td>
      <td>1.4</td>
      <td>0.2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>4.7</td>
      <td>3.2</td>
      <td>1.3</td>
      <td>0.2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4.6</td>
      <td>3.1</td>
      <td>1.5</td>
      <td>0.2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5.0</td>
      <td>3.6</td>
      <td>1.4</td>
      <td>0.2</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



```python
# Regression Datasets
boston = load_boston()
boston_df = pd.DataFrame(boston['data'], columns=boston['feature_names'])
boston_df['target'] = boston['target']
boston_df.head()
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


## 간단 사용법


### optimize()



```

optimize(

    x,

    y,

    test_data=None,

    cat_features=None,

    eval_metric='f1',

    cv=5,

    seed=None,

    n_rounds=3000,

    n_trials=100,

)

```


**입력 매개변수**



- `x`: Feature 데이터

- `y`: Target 데이터

- `test_data`: 예측 데이터 (test 데이터의 feature 데이터)

- `cat_features`: 카테고리형 컬럼

- `eval_metric`: 최적화할 메트릭 ('f1', 'accuracy', 'recall', 'precision', 'mse', 'rmse', 'rmsle')

- `cv`: cross validation fold 개수

- `seed`: 시드

- `n_rounds`: 학습시 최대 iteration 횟수

- `n_trials`: optuna 하이퍼파라미터 튜닝 시도 횟수



**return**

- `params`: best 하이퍼파라미터

- `preds`: `test_data` 매개변수에 데이터를 지정한 경우 이에 대한 예측 값


### 결과값 자동저장 기능


optimizer() 로 튜닝 + 예측한 결과는 `numpy array` 형식으로 자동 저장합니다.



- 저장 경로: `models` 폴더


## CatBoost + Optuna



```python
catboostoptuna = models.CatBoostClassifierOptuna(use_gpu=False)

params, preds = catboostoptuna.optimize(iris_df.drop('target', 1), 
                                        iris_df['target'], 
                                        test_data=iris_df.drop('target', 1),
                                        seed=321,
                                        eval_metric='recall', n_trials=3)

(np.squeeze(preds) == iris_df['target']).mean()
```

<pre>
[32m[I 2021-12-31 03:43:18,089][0m A new study created in memory with name: no-name-9e0d572d-958c-4a71-9797-8d3c51057317[0m
</pre>
<pre>
metric type: recall, score: 1.00000
metric type: recall, score: 0.90000
metric type: recall, score: 0.90000
metric type: recall, score: 0.96667
</pre>
<pre>
[32m[I 2021-12-31 03:43:19,862][0m Trial 0 finished with value: 0.9400000000000001 and parameters: {'bootstrap_type': 'MVS', 'boosting_type': 'Plain', 'od_type': 'Iter', 'colsample_bylevel': 0.06486819802222668, 'l2_leaf_reg': 0.0002951662171612853, 'learning_rate': 0.2804611004136478, 'iterations': 1893, 'min_child_samples': 5, 'depth': 9}. Best is trial 0 with value: 0.9400000000000001.[0m
</pre>
<pre>
metric type: recall, score: 0.93333
metric type: recall, score: 1.00000
metric type: recall, score: 0.93333
metric type: recall, score: 0.96667
metric type: recall, score: 0.96667
</pre>
<pre>
[32m[I 2021-12-31 03:43:21,781][0m Trial 1 finished with value: 0.96 and parameters: {'bootstrap_type': 'MVS', 'boosting_type': 'Ordered', 'od_type': 'IncToDec', 'colsample_bylevel': 0.09709757848571335, 'l2_leaf_reg': 6.972791682108428e-07, 'learning_rate': 0.4839437086735112, 'iterations': 878, 'min_child_samples': 27, 'depth': 9}. Best is trial 1 with value: 0.96.[0m
</pre>
<pre>
metric type: recall, score: 0.93333
metric type: recall, score: 1.00000
metric type: recall, score: 0.93333
metric type: recall, score: 0.96667
metric type: recall, score: 0.96667
</pre>
<pre>
[32m[I 2021-12-31 03:43:23,694][0m Trial 2 finished with value: 0.96 and parameters: {'bootstrap_type': 'Bernoulli', 'boosting_type': 'Ordered', 'od_type': 'Iter', 'colsample_bylevel': 0.0633327312007314, 'l2_leaf_reg': 2.208668993641365, 'learning_rate': 0.4010740839160681, 'iterations': 902, 'min_child_samples': 26, 'depth': 5, 'subsample': 0.8960199305353185}. Best is trial 1 with value: 0.96.[0m
</pre>
<pre>
metric type: recall, score: 0.93333
saving model...models/CatBoostClassifier-0.96000.npy
</pre>
<pre>
0.9733333333333334
</pre>

```python
catboostoptuna = models.CatBoostClassifierOptuna()

params, preds = catboostoptuna.optimize(cancer_df.drop('target', 1), 
                                        cancer_df['target'], 
                                        test_data=cancer_df.drop('target', 1),
                                        seed=321,
                                        eval_metric='recall', n_trials=3)

(np.squeeze(preds) == cancer_df['target']).mean()
```

<pre>
[32m[I 2021-12-31 03:44:05,031][0m A new study created in memory with name: no-name-7e6da76b-7aa2-43d2-a643-bb2f3f1eff91[0m
</pre>
<pre>
metric type: recall, score: 0.96923
metric type: recall, score: 1.00000
metric type: recall, score: 1.00000
metric type: recall, score: 0.98718
</pre>
<pre>
[32m[I 2021-12-31 03:44:07,003][0m Trial 0 finished with value: 0.9912820512820513 and parameters: {'bootstrap_type': 'Bernoulli', 'boosting_type': 'Plain', 'od_type': 'IncToDec', 'colsample_bylevel': 0.040899209292070075, 'l2_leaf_reg': 2.1814809587844156e-05, 'learning_rate': 0.08354646152391278, 'iterations': 988, 'min_child_samples': 29, 'depth': 7, 'subsample': 0.5562305039848767}. Best is trial 0 with value: 0.9912820512820513.[0m
</pre>
<pre>
metric type: recall, score: 1.00000
metric type: recall, score: 0.95385
metric type: recall, score: 1.00000
metric type: recall, score: 1.00000
metric type: recall, score: 0.98718
</pre>
<pre>
[32m[I 2021-12-31 03:44:11,668][0m Trial 1 finished with value: 0.9855735492577598 and parameters: {'bootstrap_type': 'MVS', 'boosting_type': 'Plain', 'od_type': 'Iter', 'colsample_bylevel': 0.03351971867096344, 'l2_leaf_reg': 0.11726953296818438, 'learning_rate': 0.01204480002353308, 'iterations': 1888, 'min_child_samples': 16, 'depth': 11}. Best is trial 0 with value: 0.9912820512820513.[0m
</pre>
<pre>
metric type: recall, score: 0.98684
metric type: recall, score: 0.95385
metric type: recall, score: 0.95522
metric type: recall, score: 0.98592
metric type: recall, score: 0.97436
</pre>
<pre>
[32m[I 2021-12-31 03:44:13,653][0m Trial 2 finished with value: 0.9712373214046094 and parameters: {'bootstrap_type': 'MVS', 'boosting_type': 'Ordered', 'od_type': 'IncToDec', 'colsample_bylevel': 0.04462669813698863, 'l2_leaf_reg': 2.7764295629202865e-08, 'learning_rate': 0.3129235892998792, 'iterations': 771, 'min_child_samples': 5, 'depth': 9}. Best is trial 0 with value: 0.9912820512820513.[0m
</pre>
<pre>
metric type: recall, score: 0.98684
saving model...models/CatBoostClassifier-0.99128.npy
</pre>
<pre>
0.9947275922671354
</pre>

```python
for col in ['CHAS', 'RAD', 'ZN']:
    boston_df[col] = boston_df[col].astype('int')
    
catboostoptuna_reg = models.CatBoostRegressorOptuna(use_gpu=False)
        
params, preds = catboostoptuna_reg.optimize(boston_df.drop('target', 1), 
                                            boston_df['target'], 
                                            test_data=boston_df.drop('target', 1),
                                            # int, str 타입 이어야 한다. float는 허용하지 않음
                                            cat_features=['CHAS', 'RAD', 'ZN'],
                                            eval_metric='rmse', n_trials=3)

mean_squared_error(boston_df['target'], preds)
```

<pre>
[32m[I 2021-12-31 03:44:56,368][0m A new study created in memory with name: no-name-1b621233-2666-4193-a589-2085da537825[0m
</pre>
<pre>
error type: rmse, error: 3.17323
error type: rmse, error: 2.86931
error type: rmse, error: 4.06081
error type: rmse, error: 3.75035
</pre>
<pre>
[32m[I 2021-12-31 03:44:58,418][0m Trial 0 finished with value: 3.5586318766499248 and parameters: {'bootstrap_type': 'Bernoulli', 'boosting_type': 'Ordered', 'od_type': 'IncToDec', 'colsample_bylevel': 0.08005280346616732, 'l2_leaf_reg': 2.5134291928531462e-08, 'learning_rate': 0.35770630387105873, 'iterations': 1819, 'min_child_samples': 11, 'depth': 3, 'subsample': 0.5095036468081915}. Best is trial 0 with value: 3.5586318766499248.[0m
</pre>
<pre>
error type: rmse, error: 3.93946
error type: rmse, error: 2.63963
error type: rmse, error: 2.47184
error type: rmse, error: 4.22292
error type: rmse, error: 3.35770
</pre>
<pre>
[32m[I 2021-12-31 03:45:01,760][0m Trial 1 finished with value: 3.1998452181464536 and parameters: {'bootstrap_type': 'MVS', 'boosting_type': 'Plain', 'od_type': 'Iter', 'colsample_bylevel': 0.09489731919902508, 'l2_leaf_reg': 2.5850673686532312e-05, 'learning_rate': 0.021516522548568846, 'iterations': 973, 'min_child_samples': 20, 'depth': 4}. Best is trial 1 with value: 3.1998452181464536.[0m
</pre>
<pre>
error type: rmse, error: 3.30714
error type: rmse, error: 3.39045
error type: rmse, error: 3.69054
error type: rmse, error: 2.78785
error type: rmse, error: 2.80355
</pre>
<pre>
[32m[I 2021-12-31 03:45:05,580][0m Trial 2 finished with value: 3.1224951774698733 and parameters: {'bootstrap_type': 'Bernoulli', 'boosting_type': 'Ordered', 'od_type': 'Iter', 'colsample_bylevel': 0.07229340860687768, 'l2_leaf_reg': 2.5811803971908034e-05, 'learning_rate': 0.07495793354303494, 'iterations': 1763, 'min_child_samples': 20, 'depth': 10, 'subsample': 0.60804921075639}. Best is trial 2 with value: 3.1224951774698733.[0m
</pre>
<pre>
error type: rmse, error: 2.94009
saving model...models/CatBoostRegressor-3.12250.npy
</pre>
<pre>
7.718443655973282
</pre>
### 저장한 파일로부터 예측 값 (prediction) 불러오기



```python
# 넘파이 array로 저장된 예측 결과를 로드할 수 있습니다.
models.load_prediction_from_file('models/CatBoostRegressor-0.87226.npy')
```

<pre>
array([28.76168717, 21.97469764, 33.91423778, 36.25317587, 34.89063327,
       30.36592103, 21.62216055, 21.67925239, 16.13744104, 18.55325167,
       19.19114681, 20.39200754, 20.4851822 , 20.18992755, 19.53332984,
       19.95333642, 21.90489984, 17.43089179, 19.28067897, 18.75662987,
       13.27196673, 17.43784243, 16.54706384, 14.6641719 , 15.98753177,
       14.55392224, 16.07654144, 15.15717605, 18.46626451, 19.14277466,
       13.42305337, 16.08031477, 13.88189742, 15.42776871, 13.93921857,
       21.76392661, 20.96989226, 22.05468906, 23.01954988, 30.38238318,
       35.86242058, 27.86047868, 24.46726054, 24.81965244, 21.93943212,
       20.97466042, 19.40221015, 17.69406529, 14.9838815 , 18.13447461,
       20.67717755, 22.8037252 , 27.00797342, 22.50247985, 18.38411847,
       34.59829013, 25.66841753, 34.24698692, 23.25394891, 20.56548366,
       18.08249006, 15.98063826, 23.92861079, 24.18700647, 31.40892682,
       25.84846134, 19.79075001, 20.42532382, 18.62746158, 20.80022091,
       23.33964199, 21.12974915, 22.61460761, 23.59166397, 23.77889816,
       22.56759439, 20.36601319, 21.90976033, 20.22201645, 20.79508199,
       26.11453205, 23.92772329, 24.00113404, 22.73930675, 23.72290053,
       26.13084916, 21.3290855 , 24.25999642, 28.84149579, 30.07779444,
       25.15881721, 25.06305693, 23.06077441, 24.28432971, 20.45356778,
       27.53869606, 25.76019718, 39.81858701, 41.84946703, 34.55262548,
       24.02980442, 25.65445863, 20.71075989, 20.2305375 , 19.82863103,
       16.79407357, 17.75558312, 18.35677353, 19.65660082, 18.0508654 ,
       21.5689087 , 23.06746945, 18.09671889, 18.42912872, 21.51601955,
       17.52104662, 21.19149237, 21.53741825, 18.60982263, 19.8353869 ,
       21.78394929, 20.82479114, 19.52986522, 16.34316023, 19.12320234,
       20.51817182, 15.84022485, 14.82196509, 17.39604813, 15.71638676,
       19.23800906, 19.38498764, 20.40981153, 17.61717099, 15.42971604,
       17.70507511, 16.60916137, 18.13055393, 12.97506937, 16.57567281,
       15.20248486, 14.23643501, 13.36728264, 14.72898506, 13.55049322,
       14.9755267 , 16.03064387, 14.98655171, 15.15773699, 15.42038297,
       19.80594139, 18.72855912, 16.47855863, 16.13431554, 17.39118588,
       18.95159967, 16.80484215, 36.44802584, 27.31847993, 24.42104749,
       33.32831742, 48.17558575, 48.10500758, 50.10220898, 21.6445183 ,
       24.25216144, 46.87931622, 22.3243491 , 23.54260782, 23.23930775,
       20.11795752, 20.55089244, 21.96288645, 25.19124179, 23.64260695,
       28.62909465, 24.51323548, 24.80628451, 30.42589992, 37.3450949 ,
       38.4181347 , 30.23559046, 38.05903337, 31.71650322, 26.26537372,
       28.50830185, 45.52756479, 30.25326372, 30.14612204, 32.84831893,
       29.96189048, 29.83769357, 35.86649294, 31.06581569, 29.52652706,
       47.51160949, 36.3245743 , 29.81679975, 33.0799321 , 32.54773576,
       34.19546892, 25.76115073, 41.09042432, 48.59485047, 48.31403964,
       21.86601009, 22.41873571, 19.98276713, 23.41414041, 18.99296122,
       20.94222734, 19.85599395, 22.46012421, 23.23118424, 22.33826844,
       24.35427176, 22.84754784, 26.78443297, 22.02070077, 25.00887251,
       29.11967995, 21.35142102, 28.4845406 , 28.13266249, 43.55809324,
       43.92528527, 41.41070297, 33.03739803, 43.98911308, 34.88425066,
       23.95836477, 35.73025736, 43.16032433, 43.04690079, 27.64386148,
       24.70308422, 25.4884944 , 37.47134395, 24.75982658, 24.46682263,
       24.01787678, 20.55522458, 21.81256414, 25.1210334 , 18.84767363,
       18.65530061, 23.31803976, 20.90605542, 23.2340228 , 25.26291264,
       24.24455301, 29.6144702 , 31.89752872, 40.56324634, 23.53199626,
       19.96194628, 40.74456114, 48.1240842 , 36.47112068, 31.95761281,
       35.22692603, 41.08284384, 43.59715004, 32.69785587, 38.395269  ,
       29.9962736 , 31.91708957, 40.03140873, 46.20098888, 21.80400282,
       20.18597404, 25.8267357 , 25.12578985, 35.62999617, 33.24609222,
       32.1246326 , 32.1276531 , 33.20775978, 26.22963653, 35.73998533,
       44.73786966, 36.20293923, 46.15322327, 50.76547855, 31.24164863,
       24.72412287, 20.28457479, 22.92577672, 22.80344633, 23.12369478,
       31.17422305, 35.1362746 , 26.74748661, 23.54393337, 22.04051644,
       26.52810061, 25.09489421, 19.48346588, 26.88560752, 32.68850504,
       27.88899813, 23.20912832, 24.87111363, 32.28653345, 33.91915569,
       28.80376445, 35.01262449, 29.21634021, 25.79724389, 22.05887928,
       21.3824104 , 23.18025825, 20.00625817, 23.00639761, 22.75589549,
       17.94145995, 18.06389734, 18.02561674, 22.79710775, 20.21203719,
       23.45896878, 23.04214565, 22.94954438, 18.56859949, 24.6756368 ,
       25.56719479, 24.084167  , 20.2480269 , 20.91046936, 24.25174757,
       21.23424581, 16.49834945, 19.66746909, 21.4557298 , 21.65723782,
       20.06222367, 19.22627356, 18.87736706, 20.04211261, 19.71010834,
       19.77379091, 32.5851722 , 24.65104583, 24.97530297, 30.10281989,
       19.2971915 , 17.20332405, 23.85532316, 25.69790452, 26.13244964,
       23.82816976, 24.07280403, 22.60158478, 31.12142614, 21.94114302,
       23.35171169, 18.76796541, 18.91663659, 23.34380777, 20.45138255,
       22.45630745, 17.74251749, 21.83864988, 18.43330579, 23.54134213,
       26.68331628, 19.25077592, 22.754818  , 38.81018216, 49.26446287,
       50.79271301, 39.70994055, 47.02221074, 12.5120863 , 13.44238312,
       16.03211618, 14.14478663, 12.77288871, 11.2105293 , 12.32364567,
       12.25072646, 10.34790415, 10.53523456, 10.7030971 , 11.42738056,
        8.88825104,  9.34983733,  9.12203832, 11.97584357, 11.17106292,
       14.56801675, 16.83874389, 10.02438036, 13.9523593 , 13.26336838,
       13.90404049, 12.99194972, 11.10259056,  7.3404075 ,  9.94517994,
        7.68810727, 10.44760646, 12.67179266, 10.04602704,  9.2217173 ,
        9.49584146, 18.29746443, 26.3683067 , 16.04251865, 20.71751946,
       27.65855805, 16.86487185, 14.54875179, 15.70205646,  8.96022422,
        9.18930385, 10.93764513,  9.52636606,  9.02340857,  9.99152837,
       15.03190469, 14.90398513, 17.58508063, 13.3390705 , 13.65630505,
        9.17099086, 13.15485696, 11.95532373, 11.0969807 , 10.75318325,
       15.2116026 , 15.75387832, 18.8499195 , 14.90319747, 13.90606762,
       11.24903563, 12.25064494, 10.36012359,  9.54165187, 11.81341828,
       10.84391803, 13.36466617, 15.57695542, 14.26152587, 10.23491255,
       10.70045996, 14.70878743, 14.79437752, 14.33805741, 13.99509979,
       13.91139729, 15.20039866, 16.1576856 , 18.10186486, 13.92352322,
       14.85029811, 14.2714253 , 15.14535685, 16.80094021, 18.69923671,
       16.33460786, 17.54055978, 19.44845554, 20.11537833, 21.70623678,
       19.35919475, 16.46347524, 15.96509858, 17.28791419, 19.37198404,
       20.14604739, 20.67226853, 21.52497603, 22.75428627, 16.2353488 ,
       15.04075596, 17.64296268, 13.079737  , 16.40755067, 20.24207015,
       22.28444162, 23.89979801, 25.88883777, 21.55801563, 20.88892453,
       22.86809854, 20.05936591, 21.45465288, 15.16904835,  9.95506956,
       10.62074076, 14.6694633 , 19.00900648, 21.3145516 , 22.52886541,
       21.62849666, 18.76080567, 21.24361604, 21.34419004, 18.83961699,
       20.54947447, 21.35132386, 17.93859277, 23.9005454 , 22.68316054,
       17.21506894])
</pre>
### 하이퍼파라미터 튜닝 시각화



```python
# 튜닝 결과 시각화
catboostoptuna_reg.visualize()
```

## XGBoost



```python
xgboptuna = models.XGBClassifierOptuna(use_gpu=False)
        
params, preds = xgboptuna.optimize(iris_df.drop('target', 1), 
                                   iris_df['target'], 
                                   test_data=iris_df.drop('target', 1),
                                   seed=321,
                                   eval_metric='recall', n_trials=3)

(preds == iris_df['target']).mean()
```

<pre>
[32m[I 2021-12-31 04:54:29,175][0m A new study created in memory with name: no-name-cede5431-45cd-4160-aae0-fe7db91b19d7[0m
</pre>
<pre>
metric type: recall, score: 0.23333
metric type: recall, score: 0.33333
metric type: recall, score: 0.20000
</pre>
<pre>
[32m[I 2021-12-31 04:54:29,533][0m Trial 0 finished with value: 0.2533333333333333 and parameters: {'lambda': 5.4433550844759385e-05, 'alpha': 0.16638324954592612, 'colsample_bytree': 0.5553611192935635, 'subsample': 0.6004881072333348, 'learning_rate': 0.016297922548371792, 'n_estimators': 3473, 'max_depth': 26, 'min_child_weight': 26}. Best is trial 0 with value: 0.2533333333333333.[0m
</pre>
<pre>
metric type: recall, score: 0.33333
metric type: recall, score: 0.16667
metric type: recall, score: 1.00000
metric type: recall, score: 0.90000
metric type: recall, score: 0.96667
metric type: recall, score: 0.96667
</pre>
<pre>
[32m[I 2021-12-31 04:55:00,617][0m Trial 1 finished with value: 0.9533333333333334 and parameters: {'lambda': 7.931779093115287e-05, 'alpha': 0.000629181856174543, 'colsample_bytree': 0.8339223988166906, 'subsample': 0.537448394497017, 'learning_rate': 0.00015104176676847454, 'n_estimators': 1763, 'max_depth': 21, 'min_child_weight': 6}. Best is trial 1 with value: 0.9533333333333334.[0m
</pre>
<pre>
metric type: recall, score: 0.93333
metric type: recall, score: 0.33333
metric type: recall, score: 0.30000
</pre>
<pre>
[32m[I 2021-12-31 04:55:00,956][0m Trial 2 finished with value: 0.3333333333333333 and parameters: {'lambda': 0.021888058724878718, 'alpha': 2.455454661763027, 'colsample_bytree': 0.8876267551765076, 'subsample': 0.5590629745422453, 'learning_rate': 2.4390047315019495e-05, 'n_estimators': 1956, 'max_depth': 24, 'min_child_weight': 157}. Best is trial 1 with value: 0.9533333333333334.[0m
</pre>
<pre>
metric type: recall, score: 0.20000
metric type: recall, score: 0.30000
metric type: recall, score: 0.53333
saving model...models/XGBClassifier-0.95333.npy
</pre>
<pre>
0.9666666666666667
</pre>

```python
xgboptuna_binary = models.XGBClassifierOptuna(use_gpu=False)
        
params, preds = xgboptuna_binary.optimize(cancer_df.drop('target', 1), 
                                          cancer_df['target'], 
                                          test_data=cancer_df.drop('target', 1), 
                                          eval_metric='accuracy', n_trials=3)

(preds == cancer_df['target']).mean()
```

<pre>
[32m[I 2021-12-31 04:55:12,490][0m A new study created in memory with name: no-name-621f0d57-3e1d-4b1e-b69e-669a8ee2a1a0[0m
[32m[I 2021-12-31 04:55:12,760][0m Trial 0 finished with value: 0.6274491538580965 and parameters: {'lambda': 0.1755235804334081, 'alpha': 0.10883393324492178, 'colsample_bytree': 0.5242360621379514, 'subsample': 0.5171796803756229, 'learning_rate': 1.231939166086572e-05, 'n_estimators': 3796, 'max_depth': 12, 'min_child_weight': 132}. Best is trial 0 with value: 0.6274491538580965.[0m
</pre>
<pre>
metric type: accuracy, score: 0.68421
metric type: accuracy, score: 0.64035
metric type: accuracy, score: 0.64035
metric type: accuracy, score: 0.52632
metric type: accuracy, score: 0.64602
metric type: accuracy, score: 0.91228
metric type: accuracy, score: 0.93860
metric type: accuracy, score: 0.94737
metric type: accuracy, score: 0.92105
</pre>
<pre>
[32m[I 2021-12-31 04:55:33,748][0m Trial 1 finished with value: 0.927930445582984 and parameters: {'lambda': 0.0004235240963201465, 'alpha': 0.08147722543722236, 'colsample_bytree': 0.7484187245898394, 'subsample': 0.5794381584864169, 'learning_rate': 0.00015027421815483563, 'n_estimators': 2818, 'max_depth': 9, 'min_child_weight': 10}. Best is trial 1 with value: 0.927930445582984.[0m
</pre>
<pre>
metric type: accuracy, score: 0.92035
metric type: accuracy, score: 0.68421
metric type: accuracy, score: 0.60526
metric type: accuracy, score: 0.61404
</pre>
<pre>
[32m[I 2021-12-31 04:55:34,010][0m Trial 2 finished with value: 0.6273870517000465 and parameters: {'lambda': 2.4410117385667154, 'alpha': 0.0008044447010598563, 'colsample_bytree': 0.6654006970565365, 'subsample': 0.689402404651076, 'learning_rate': 0.04552812279043075, 'n_estimators': 1920, 'max_depth': 17, 'min_child_weight': 110}. Best is trial 1 with value: 0.927930445582984.[0m
</pre>
<pre>
metric type: accuracy, score: 0.62281
metric type: accuracy, score: 0.61062
saving model...models/XGBClassifier-0.92793.npy
</pre>
<pre>
0.9543057996485061
</pre>

```python
xgboptuna_reg = models.XGBRegressorOptuna()
        
params, preds = xgboptuna_reg.optimize(boston_df.drop('target', 1), 
                                       boston_df['target'], 
                                       test_data=boston_df.drop('target', 1), 
                                       eval_metric='mse', n_trials=3)

mean_squared_error(boston_df['target'], preds)
```

<pre>
[32m[I 2021-12-31 04:57:04,459][0m A new study created in memory with name: no-name-869c364d-46ce-4f68-9d89-755a63ea1461[0m
</pre>
<pre>
error type: mse, error: 84.44991
error type: mse, error: 55.86387
error type: mse, error: 105.52391
error type: mse, error: 84.80251
</pre>
<pre>
[32m[I 2021-12-31 04:57:07,961][0m Trial 0 finished with value: 84.27665116287378 and parameters: {'lambda': 2.363845537360973, 'alpha': 0.009566592461706023, 'colsample_bytree': 0.7876083799338037, 'subsample': 0.6907389576018993, 'learning_rate': 0.006180430848980449, 'n_estimators': 1349, 'max_depth': 14, 'min_child_weight': 176}. Best is trial 0 with value: 84.27665116287378.[0m
</pre>
<pre>
error type: mse, error: 90.74306
error type: mse, error: 28.28641
error type: mse, error: 29.21717
error type: mse, error: 40.86397
error type: mse, error: 37.78767
</pre>
<pre>
[32m[I 2021-12-31 04:57:15,189][0m Trial 1 finished with value: 31.533895178654678 and parameters: {'lambda': 0.0007188493070002403, 'alpha': 0.0004582875894406261, 'colsample_bytree': 0.8337513520419544, 'subsample': 0.5970150301353495, 'learning_rate': 0.010786297739502288, 'n_estimators': 3318, 'max_depth': 18, 'min_child_weight': 89}. Best is trial 1 with value: 31.533895178654678.[0m
</pre>
<pre>
error type: mse, error: 21.51425
error type: mse, error: 373.51885
error type: mse, error: 419.46507
error type: mse, error: 379.93970
error type: mse, error: 362.89331
</pre>
<pre>
[32m[I 2021-12-31 04:57:31,826][0m Trial 2 finished with value: 395.8868985441321 and parameters: {'lambda': 0.00019875417009774664, 'alpha': 1.034258225709447e-05, 'colsample_bytree': 0.8091283877062585, 'subsample': 0.6108634598370167, 'learning_rate': 6.71611811113678e-05, 'n_estimators': 313, 'max_depth': 7, 'min_child_weight': 76}. Best is trial 1 with value: 31.533895178654678.[0m
</pre>
<pre>
error type: mse, error: 443.61756
saving model...models/XGBRegressor-31.53390.npy
</pre>
<pre>
32.92111688074596
</pre>
## LGBM


### 이진분류(binary classification)



```python
lgbmoptuna_binary = models.LGBMClassifierOptuna()
        
params, preds = lgbmoptuna_binary.optimize(cancer_df.drop('target', 1), 
                                           cancer_df['target'], 
                                           test_data=cancer_df.drop('target', 1),
                                           eval_metric='accuracy', n_trials=3)

(preds == cancer_df['target']).mean()
```

<pre>
[32m[I 2021-12-31 04:59:17,359][0m A new study created in memory with name: no-name-14b716e1-ecf8-4e49-b53e-2b08881efd50[0m
</pre>
<pre>
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[50]	training's binary_logloss: 0.397461	training's score: 0.936264	valid_1's binary_logloss: 0.436755	valid_1's score: 0.912281
metric type: accuracy, score: 0.91228
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[55]	training's binary_logloss: 0.392336	training's score: 0.940659	valid_1's binary_logloss: 0.403726	valid_1's score: 0.938596
metric type: accuracy, score: 0.93860
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[59]	training's binary_logloss: 0.376351	training's score: 0.953846	valid_1's binary_logloss: 0.405461	valid_1's score: 0.903509
metric type: accuracy, score: 0.90351
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 04:59:17,898][0m Trial 0 finished with value: 0.9297158826269213 and parameters: {'lambda_l1': 1.1876278035135512, 'lambda_l2': 9.933628478180302e-05, 'path_smooth': 1.3327058334487095e-05, 'learning_rate': 0.01036576389312941, 'feature_fraction': 0.6047911724419435, 'bagging_fraction': 0.6835566674824104, 'num_leaves': 22, 'min_data_in_leaf': 41, 'max_bin': 186, 'n_estimators': 2303, 'bagging_freq': 6, 'min_child_weight': 8}. Best is trial 0 with value: 0.9297158826269213.[0m
</pre>
<pre>
Early stopping, best iteration is:
[59]	training's binary_logloss: 0.386027	training's score: 0.949451	valid_1's binary_logloss: 0.370237	valid_1's score: 0.95614
metric type: accuracy, score: 0.95614
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[31]	training's binary_logloss: 0.48012	training's score: 0.901316	valid_1's binary_logloss: 0.480087	valid_1's score: 0.938053
metric type: accuracy, score: 0.93805
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.659107	training's score: 0.628571	valid_1's binary_logloss: 0.662164	valid_1's score: 0.622807
metric type: accuracy, score: 0.62281
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.666696	training's score: 0.613187	valid_1's binary_logloss: 0.633941	valid_1's score: 0.684211
metric type: accuracy, score: 0.68421
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 04:59:18,143][0m Trial 1 finished with value: 0.627278372923459 and parameters: {'lambda_l1': 3.471981097340538e-05, 'lambda_l2': 0.0024941632434138336, 'path_smooth': 6.202132331388559e-07, 'learning_rate': 0.000847906973349658, 'feature_fraction': 0.7326971248799636, 'bagging_fraction': 0.8427819709850706, 'num_leaves': 77, 'min_data_in_leaf': 63, 'max_bin': 181, 'n_estimators': 1319, 'bagging_freq': 3, 'min_child_weight': 18}. Best is trial 0 with value: 0.9297158826269213.[0m
</pre>
<pre>
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.657915	training's score: 0.630769	valid_1's binary_logloss: 0.66688	valid_1's score: 0.614035
metric type: accuracy, score: 0.61404
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.664587	training's score: 0.617582	valid_1's binary_logloss: 0.641168	valid_1's score: 0.666667
metric type: accuracy, score: 0.66667
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.648684	training's score: 0.64693	valid_1's binary_logloss: 0.708152	valid_1's score: 0.548673
metric type: accuracy, score: 0.54867
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.660555	training's score: 0.61978	valid_1's binary_logloss: 0.64273	valid_1's score: 0.657895
metric type: accuracy, score: 0.65789
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.654098	training's score: 0.632967	valid_1's binary_logloss: 0.668912	valid_1's score: 0.605263
metric type: accuracy, score: 0.60526
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 04:59:18,346][0m Trial 2 finished with value: 0.6274646793976091 and parameters: {'lambda_l1': 1.1674218504355693e-07, 'lambda_l2': 0.0001356731016994083, 'path_smooth': 1.2191389543727447e-08, 'learning_rate': 0.004815358299691926, 'feature_fraction': 0.6511836287488688, 'bagging_fraction': 0.6203004450169056, 'num_leaves': 76, 'min_data_in_leaf': 92, 'max_bin': 139, 'n_estimators': 113, 'bagging_freq': 3, 'min_child_weight': 11}. Best is trial 0 with value: 0.9297158826269213.[0m
</pre>
<pre>
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.65161	training's score: 0.637363	valid_1's binary_logloss: 0.679319	valid_1's score: 0.587719
metric type: accuracy, score: 0.58772
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.657332	training's score: 0.626374	valid_1's binary_logloss: 0.654849	valid_1's score: 0.631579
metric type: accuracy, score: 0.63158
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's binary_logloss: 0.660375	training's score: 0.620614	valid_1's binary_logloss: 0.643359	valid_1's score: 0.654867
metric type: accuracy, score: 0.65487
[LightGBM] [Warning] feature_fraction is set=0.6047911724419435, colsample_bytree=1.0 will be ignored. Current value: feature_fraction=0.6047911724419435
[LightGBM] [Warning] lambda_l2 is set=9.933628478180302e-05, reg_lambda=0.0 will be ignored. Current value: lambda_l2=9.933628478180302e-05
[LightGBM] [Warning] lambda_l1 is set=1.1876278035135512, reg_alpha=0.0 will be ignored. Current value: lambda_l1=1.1876278035135512
[LightGBM] [Warning] bagging_fraction is set=0.6835566674824104, subsample=1.0 will be ignored. Current value: bagging_fraction=0.6835566674824104
[LightGBM] [Warning] min_data_in_leaf is set=41, min_child_samples=20 will be ignored. Current value: min_data_in_leaf=41
[LightGBM] [Warning] bagging_freq is set=6, subsample_freq=0 will be ignored. Current value: bagging_freq=6
saving model...models/LGBMClassifier-0.92972.npy
</pre>
<pre>
0.9771528998242531
</pre>
### 다중분류(multi-class classification)



```python
lgbmoptuna = models.LGBMClassifierOptuna()
        
params, preds = lgbmoptuna.optimize(iris_df.drop('target', 1), 
                    iris_df['target'], 
                    seed=321,
                    eval_metric='recall', n_trials=3)


(preds == iris_df['target']).mean()
```

<pre>
[32m[I 2021-12-31 04:59:40,599][0m A new study created in memory with name: no-name-35618cd0-ec67-480a-9085-f037935413c3[0m
</pre>
<pre>
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.0986	training's score: 0.333333	valid_1's multi_logloss: 1.13617	valid_1's score: 0.333333
metric type: recall, score: 0.23333
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09861	training's score: 0.341667	valid_1's multi_logloss: 1.10278	valid_1's score: 0.3
metric type: recall, score: 0.30000
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09865	training's score: 0.366667	valid_1's multi_logloss: 1.15202	valid_1's score: 0.2
metric type: recall, score: 0.20000
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09861	training's score: 0.341667	valid_1's multi_logloss: 1.10278	valid_1's score: 0.3
metric type: recall, score: 0.30000
</pre>
<pre>
[32m[I 2021-12-31 04:59:40,855][0m Trial 0 finished with value: 0.24000000000000005 and parameters: {'lambda_l1': 2.8428410902993423e-08, 'lambda_l2': 1.8755673669382356e-08, 'path_smooth': 1.499386239297807e-05, 'learning_rate': 0.0001723949958936505, 'feature_fraction': 0.6272482811237631, 'bagging_fraction': 0.6243819967615671, 'num_leaves': 34, 'min_data_in_leaf': 94, 'max_bin': 187, 'n_estimators': 2383, 'bagging_freq': 13, 'min_child_weight': 14}. Best is trial 0 with value: 0.24000000000000005.[0m
</pre>
<pre>
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09833	training's score: 0.283333	valid_1's multi_logloss: 1.23072	valid_1's score: 0.533333
metric type: recall, score: 0.16667
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.0986	training's score: 0.333333	valid_1's multi_logloss: 1.13617	valid_1's score: 0.333333
metric type: recall, score: 0.23333
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09861	training's score: 0.341667	valid_1's multi_logloss: 1.10278	valid_1's score: 0.3
metric type: recall, score: 0.30000
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09865	training's score: 0.366667	valid_1's multi_logloss: 1.15202	valid_1's score: 0.2
metric type: recall, score: 0.20000
</pre>
<pre>
[32m[I 2021-12-31 04:59:41,109][0m Trial 1 finished with value: 0.24000000000000005 and parameters: {'lambda_l1': 2.540542056065238e-08, 'lambda_l2': 2.6224809909355183e-08, 'path_smooth': 0.0005024149876533159, 'learning_rate': 4.314144944817125e-05, 'feature_fraction': 0.7874658241183157, 'bagging_fraction': 0.6687779014797036, 'num_leaves': 39, 'min_data_in_leaf': 93, 'max_bin': 199, 'n_estimators': 2161, 'bagging_freq': 15, 'min_child_weight': 10}. Best is trial 0 with value: 0.24000000000000005.[0m
</pre>
<pre>
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09861	training's score: 0.341667	valid_1's multi_logloss: 1.10278	valid_1's score: 0.3
metric type: recall, score: 0.30000
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09833	training's score: 0.283333	valid_1's multi_logloss: 1.23072	valid_1's score: 0.533333
metric type: recall, score: 0.16667
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.0986	training's score: 0.333333	valid_1's multi_logloss: 1.13617	valid_1's score: 0.333333
metric type: recall, score: 0.23333
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09861	training's score: 0.341667	valid_1's multi_logloss: 1.10278	valid_1's score: 0.3
metric type: recall, score: 0.30000
</pre>
<pre>
[32m[I 2021-12-31 04:59:41,365][0m Trial 2 finished with value: 0.24000000000000005 and parameters: {'lambda_l1': 0.04524266799258891, 'lambda_l2': 0.00012453780435096626, 'path_smooth': 5.179052581353628e-05, 'learning_rate': 0.000360109595261492, 'feature_fraction': 0.651618296279452, 'bagging_fraction': 0.5637930567147633, 'num_leaves': 77, 'min_data_in_leaf': 81, 'max_bin': 182, 'n_estimators': 385, 'bagging_freq': 6, 'min_child_weight': 20}. Best is trial 0 with value: 0.24000000000000005.[0m
</pre>
<pre>
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09865	training's score: 0.366667	valid_1's multi_logloss: 1.15202	valid_1's score: 0.2
metric type: recall, score: 0.20000
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09861	training's score: 0.341667	valid_1's multi_logloss: 1.10278	valid_1's score: 0.3
metric type: recall, score: 0.30000
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[1]	training's multi_logloss: 1.09833	training's score: 0.283333	valid_1's multi_logloss: 1.23072	valid_1's score: 0.533333
metric type: recall, score: 0.16667
</pre>
<pre>
0.0
</pre>
### 회귀(regression)



```python
lgbmoptuna_reg = models.LGBMRegressorOptuna()
        
params, preds = lgbmoptuna_reg.optimize(boston_df.drop('target', 1), 
                                        boston_df['target'], 
                                        test_data=boston_df.drop('target', 1), 
                                        eval_metric='mse', n_trials=3)

mean_squared_error(boston_df['target'], preds)
```

<pre>
[32m[I 2021-12-31 05:02:38,481][0m A new study created in memory with name: no-name-a52d56ee-9355-4e7d-b201-b5c65be55685[0m
</pre>
<pre>
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[351]	training's l2: 7.21849	training's score: 7.21849	valid_1's l2: 10.9472	valid_1's score: 10.9472
error type: mse, error: 10.94717
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[140]	training's l2: 11.5192	training's score: 11.5192	valid_1's l2: 17.4302	valid_1's score: 17.4302
error type: mse, error: 17.43018
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[160]	training's l2: 10.1893	training's score: 10.1893	valid_1's l2: 13.2345	valid_1's score: 13.2345
error type: mse, error: 13.23448
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[504]	training's l2: 5.85066	training's score: 5.85066	valid_1's l2: 14.7516	valid_1's score: 14.7516
error type: mse, error: 14.75157
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 05:02:40,577][0m Trial 0 finished with value: 15.763873396044715 and parameters: {'lambda_l1': 0.014943467602056983, 'lambda_l2': 2.757972944666076e-06, 'path_smooth': 2.0400290053042333e-05, 'learning_rate': 0.08201290433175552, 'feature_fraction': 0.8061018189212343, 'bagging_fraction': 0.790970205275671, 'num_leaves': 42, 'min_data_in_leaf': 55, 'max_bin': 150, 'n_estimators': 1271, 'bagging_freq': 4, 'min_child_weight': 5}. Best is trial 0 with value: 15.763873396044715.[0m
</pre>
<pre>
Early stopping, best iteration is:
[348]	training's l2: 6.85593	training's score: 6.85593	valid_1's l2: 22.456	valid_1's score: 22.456
error type: mse, error: 22.45597
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2534]	training's l2: 13.8422	training's score: 13.8422	valid_1's l2: 10.8093	valid_1's score: 10.8093
error type: mse, error: 10.80932
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2534]	training's l2: 12.0607	training's score: 12.0607	valid_1's l2: 23.1419	valid_1's score: 23.1419
error type: mse, error: 23.14186
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2534]	training's l2: 13.4055	training's score: 13.4055	valid_1's l2: 12.2618	valid_1's score: 12.2618
error type: mse, error: 12.26183
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2534]	training's l2: 11.8017	training's score: 11.8017	valid_1's l2: 33.396	valid_1's score: 33.396
error type: mse, error: 33.39595
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 05:03:13,952][0m Trial 1 finished with value: 18.66965930852682 and parameters: {'lambda_l1': 0.00021540411697144112, 'lambda_l2': 1.0524026538378448, 'path_smooth': 4.7664370537123035e-05, 'learning_rate': 0.0007886826266967147, 'feature_fraction': 0.5877216485721609, 'bagging_fraction': 0.6781964882397304, 'num_leaves': 81, 'min_data_in_leaf': 17, 'max_bin': 104, 'n_estimators': 2534, 'bagging_freq': 5, 'min_child_weight': 17}. Best is trial 0 with value: 15.763873396044715.[0m
</pre>
<pre>
Did not meet early stopping. Best iteration is:
[2534]	training's l2: 13.2798	training's score: 13.2798	valid_1's l2: 13.7393	valid_1's score: 13.7393
error type: mse, error: 13.73934
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2487]	training's l2: 56.2925	training's score: 56.2925	valid_1's l2: 72.2599	valid_1's score: 72.2599
error type: mse, error: 72.25994
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2487]	training's l2: 55.5484	training's score: 55.5484	valid_1's l2: 81.9251	valid_1's score: 81.9251
error type: mse, error: 81.92508
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2487]	training's l2: 61.7124	training's score: 61.7124	valid_1's l2: 52.0736	valid_1's score: 52.0736
error type: mse, error: 52.07363
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[2487]	training's l2: 62.0956	training's score: 62.0956	valid_1's l2: 50.3062	valid_1's score: 50.3062
error type: mse, error: 50.30623
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 05:03:26,581][0m Trial 2 finished with value: 60.90457070023608 and parameters: {'lambda_l1': 1.4658913883067469e-08, 'lambda_l2': 0.373582519992502, 'path_smooth': 1.035939357852813e-05, 'learning_rate': 0.00015706230744771008, 'feature_fraction': 0.8488171841431198, 'bagging_fraction': 0.5832771148910988, 'num_leaves': 87, 'min_data_in_leaf': 65, 'max_bin': 225, 'n_estimators': 2487, 'bagging_freq': 14, 'min_child_weight': 3}. Best is trial 0 with value: 15.763873396044715.[0m
</pre>
<pre>
Did not meet early stopping. Best iteration is:
[2487]	training's l2: 62.619	training's score: 62.619	valid_1's l2: 47.958	valid_1's score: 47.958
error type: mse, error: 47.95798
[LightGBM] [Warning] feature_fraction is set=0.8061018189212343, colsample_bytree=1.0 will be ignored. Current value: feature_fraction=0.8061018189212343
[LightGBM] [Warning] lambda_l2 is set=2.757972944666076e-06, reg_lambda=0.0 will be ignored. Current value: lambda_l2=2.757972944666076e-06
[LightGBM] [Warning] lambda_l1 is set=0.014943467602056983, reg_alpha=0.0 will be ignored. Current value: lambda_l1=0.014943467602056983
[LightGBM] [Warning] bagging_fraction is set=0.790970205275671, subsample=1.0 will be ignored. Current value: bagging_fraction=0.790970205275671
[LightGBM] [Warning] min_data_in_leaf is set=55, min_child_samples=20 will be ignored. Current value: min_data_in_leaf=55
[LightGBM] [Warning] bagging_freq is set=4, subsample_freq=0 will be ignored. Current value: bagging_freq=4
saving model...models/LGBMRegressor-15.76387.npy
</pre>
<pre>
15.349830521063373
</pre>
## 하이퍼파라미터 범위 수정 (custom)



```python
lgbmoptuna = models.LGBMRegressorOptuna()

# 기본 값으로 설정된 하이퍼파라미터 출력
lgbmoptuna.print_params()
```

<pre>
name: verbose, fixed_value: -1, type: fixed
name: lambda_l1, low: 1e-08, high: 5, type: loguniform
name: lambda_l2, low: 1e-08, high: 5, type: loguniform
name: path_smooth, low: 1e-08, high: 0.001, type: loguniform
name: learning_rate, low: 1e-05, high: 0.1, type: loguniform
name: feature_fraction, low: 0.5, high: 0.9, type: uniform
name: bagging_fraction, low: 0.5, high: 0.9, type: uniform
name: num_leaves, low: 15, high: 90, type: int
name: min_data_in_leaf, low: 10, high: 100, type: int
name: max_bin, low: 100, high: 255, type: int
name: n_estimators, low: 100, high: 3000, type: int
name: bagging_freq, low: 0, high: 15, type: int
name: min_child_weight, low: 1, high: 20, type: int
</pre>
**`param_type`에 관하여**



`param_type`은 `int`, `uniform`, `loguniform`, `categorical`, `fixed` 가 있습니다.



- `int`, `uniform`, `loguniform`은 optuna의 search range 정의하는 파라미터와 같습니다.



```

예시)

- int 범위(int)

lgbmoptuna.set_param(models.OptunaParam('num_leaves', low=10, high=25, param_type='int'))



- 카테고리(categorical)

cboptuna.set_param(models.OptunaParam('bootstrap_type', categorical_value=['Bayesian', 'Bernoulli', 'MVS'], param_type='categorical'))



- 고정된 값(fixed)

cboptuna.set_param(models.OptunaParam('one_hot_max_size', fixed_value=1024, param_type='fixed'))

```



```python
# 하이퍼파라미터 범위 정의
lgbmoptuna.set_param(models.OptunaParam('num_leaves', low=10, high=25, param_type='int'))
lgbmoptuna.set_param(models.OptunaParam('n_estimators', low=0, high=500, param_type='int'))
# 출력
lgbmoptuna.print_params()
```

<pre>
name: verbose, fixed_value: -1, type: fixed
name: lambda_l1, low: 1e-08, high: 5, type: loguniform
name: lambda_l2, low: 1e-08, high: 5, type: loguniform
name: path_smooth, low: 1e-08, high: 0.001, type: loguniform
name: learning_rate, low: 1e-05, high: 0.1, type: loguniform
name: feature_fraction, low: 0.5, high: 0.9, type: uniform
name: bagging_fraction, low: 0.5, high: 0.9, type: uniform
name: num_leaves, low: 10, high: 25, type: int
name: min_data_in_leaf, low: 10, high: 100, type: int
name: max_bin, low: 100, high: 255, type: int
name: n_estimators, low: 0, high: 500, type: int
name: bagging_freq, low: 0, high: 15, type: int
name: min_child_weight, low: 1, high: 20, type: int
</pre>

```python
# 달라진 결과값 확인
params, preds = lgbmoptuna.optimize(boston_df.drop('target', 1), 
                                    boston_df['target'], 
                                    test_data=boston_df.drop('target', 1), 
                                    eval_metric='mse', n_trials=3)
```

<pre>
[32m[I 2021-12-31 05:14:28,951][0m A new study created in memory with name: no-name-e3f20d56-3f4a-4b86-92c4-ff15c6b65b25[0m
</pre>
<pre>
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[272]	training's l2: 79.9832	training's score: 79.9832	valid_1's l2: 98.325	valid_1's score: 98.325
error type: mse, error: 98.32504
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[272]	training's l2: 87.9725	training's score: 87.9725	valid_1's l2: 66.8189	valid_1's score: 66.8189
error type: mse, error: 66.81888
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[272]	training's l2: 81.8587	training's score: 81.8587	valid_1's l2: 91.2521	valid_1's score: 91.2521
error type: mse, error: 91.25208
Training until validation scores don't improve for 30 rounds
Did not meet early stopping. Best iteration is:
[272]	training's l2: 86.2988	training's score: 86.2988	valid_1's l2: 73.4895	valid_1's score: 73.4895
error type: mse, error: 73.48952
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 05:14:30,364][0m Trial 0 finished with value: 83.99098893365942 and parameters: {'lambda_l1': 4.63862070811483, 'lambda_l2': 0.39932937331692514, 'path_smooth': 3.109872573969194e-08, 'learning_rate': 3.725712434040597e-05, 'feature_fraction': 0.5238436360336499, 'bagging_fraction': 0.637588919667432, 'num_leaves': 24, 'min_data_in_leaf': 75, 'max_bin': 101, 'n_estimators': 272, 'bagging_freq': 2, 'min_child_weight': 11}. Best is trial 0 with value: 83.99098893365942.[0m
</pre>
<pre>
Did not meet early stopping. Best iteration is:
[272]	training's l2: 82.2362	training's score: 82.2362	valid_1's l2: 90.0694	valid_1's score: 90.0694
error type: mse, error: 90.06942
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[90]	training's l2: 17.9149	training's score: 17.9149	valid_1's l2: 44.3623	valid_1's score: 44.3623
error type: mse, error: 44.36231
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[307]	training's l2: 16.1878	training's score: 16.1878	valid_1's l2: 15.0268	valid_1's score: 15.0268
error type: mse, error: 15.02681
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[72]	training's l2: 22.4192	training's score: 22.4192	valid_1's l2: 20.3597	valid_1's score: 20.3597
error type: mse, error: 20.35968
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[173]	training's l2: 16.6091	training's score: 16.6091	valid_1's l2: 23.1558	valid_1's score: 23.1558
error type: mse, error: 23.15582
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 05:14:31,477][0m Trial 1 finished with value: 23.619569791630962 and parameters: {'lambda_l1': 1.1674781538425141e-05, 'lambda_l2': 0.013511457441167798, 'path_smooth': 1.710982805948588e-07, 'learning_rate': 0.06864604996492914, 'feature_fraction': 0.5712544917709119, 'bagging_fraction': 0.720693018081249, 'num_leaves': 23, 'min_data_in_leaf': 68, 'max_bin': 136, 'n_estimators': 373, 'bagging_freq': 7, 'min_child_weight': 1}. Best is trial 1 with value: 23.619569791630962.[0m
</pre>
<pre>
Early stopping, best iteration is:
[214]	training's l2: 18.1608	training's score: 18.1608	valid_1's l2: 15.1932	valid_1's score: 15.1932
error type: mse, error: 15.19322
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[170]	training's l2: 9.81192	training's score: 9.81192	valid_1's l2: 10.0374	valid_1's score: 10.0374
error type: mse, error: 10.03742
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[151]	training's l2: 10.1451	training's score: 10.1451	valid_1's l2: 10.1609	valid_1's score: 10.1609
error type: mse, error: 10.16094
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[184]	training's l2: 8.83106	training's score: 8.83106	valid_1's l2: 11.5792	valid_1's score: 11.5792
error type: mse, error: 11.57918
Training until validation scores don't improve for 30 rounds
Early stopping, best iteration is:
[256]	training's l2: 7.47399	training's score: 7.47399	valid_1's l2: 10.7423	valid_1's score: 10.7423
error type: mse, error: 10.74227
Training until validation scores don't improve for 30 rounds
</pre>
<pre>
[32m[I 2021-12-31 05:14:33,494][0m Trial 2 finished with value: 14.714960780892792 and parameters: {'lambda_l1': 2.1025137712294667e-08, 'lambda_l2': 0.0026336954500641987, 'path_smooth': 7.463963953158119e-08, 'learning_rate': 0.030485356557551014, 'feature_fraction': 0.7212541765212778, 'bagging_fraction': 0.890458792615886, 'num_leaves': 20, 'min_data_in_leaf': 35, 'max_bin': 169, 'n_estimators': 364, 'bagging_freq': 15, 'min_child_weight': 12}. Best is trial 2 with value: 14.714960780892792.[0m
</pre>
<pre>
Early stopping, best iteration is:
[285]	training's l2: 5.56969	training's score: 5.56969	valid_1's l2: 31.055	valid_1's score: 31.055
error type: mse, error: 31.05498
[LightGBM] [Warning] feature_fraction is set=0.7212541765212778, colsample_bytree=1.0 will be ignored. Current value: feature_fraction=0.7212541765212778
[LightGBM] [Warning] lambda_l2 is set=0.0026336954500641987, reg_lambda=0.0 will be ignored. Current value: lambda_l2=0.0026336954500641987
[LightGBM] [Warning] lambda_l1 is set=2.1025137712294667e-08, reg_alpha=0.0 will be ignored. Current value: lambda_l1=2.1025137712294667e-08
[LightGBM] [Warning] bagging_fraction is set=0.890458792615886, subsample=1.0 will be ignored. Current value: bagging_fraction=0.890458792615886
[LightGBM] [Warning] min_data_in_leaf is set=35, min_child_samples=20 will be ignored. Current value: min_data_in_leaf=35
[LightGBM] [Warning] bagging_freq is set=15, subsample_freq=0 will be ignored. Current value: bagging_freq=15
saving model...models/LGBMRegressor-14.71496.npy
</pre>
trial에 대한 결과를 출력합니다.



```python
# trial에 대한 결과 출력
lgbmoptuna.study.trials_dataframe()
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
      <th>number</th>
      <th>value</th>
      <th>datetime_start</th>
      <th>datetime_complete</th>
      <th>duration</th>
      <th>params_bagging_fraction</th>
      <th>params_bagging_freq</th>
      <th>params_feature_fraction</th>
      <th>params_lambda_l1</th>
      <th>params_lambda_l2</th>
      <th>params_learning_rate</th>
      <th>params_max_bin</th>
      <th>params_min_child_weight</th>
      <th>params_min_data_in_leaf</th>
      <th>params_n_estimators</th>
      <th>params_num_leaves</th>
      <th>params_path_smooth</th>
      <th>state</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>83.990989</td>
      <td>2021-12-31 05:14:28.953061</td>
      <td>2021-12-31 05:14:30.364356</td>
      <td>0 days 00:00:01.411295</td>
      <td>0.637589</td>
      <td>2</td>
      <td>0.523844</td>
      <td>4.638621e+00</td>
      <td>0.399329</td>
      <td>0.000037</td>
      <td>101</td>
      <td>11</td>
      <td>75</td>
      <td>272</td>
      <td>24</td>
      <td>3.109873e-08</td>
      <td>COMPLETE</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>23.619570</td>
      <td>2021-12-31 05:14:30.365300</td>
      <td>2021-12-31 05:14:31.477065</td>
      <td>0 days 00:00:01.111765</td>
      <td>0.720693</td>
      <td>7</td>
      <td>0.571254</td>
      <td>1.167478e-05</td>
      <td>0.013511</td>
      <td>0.068646</td>
      <td>136</td>
      <td>1</td>
      <td>68</td>
      <td>373</td>
      <td>23</td>
      <td>1.710983e-07</td>
      <td>COMPLETE</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>14.714961</td>
      <td>2021-12-31 05:14:31.478094</td>
      <td>2021-12-31 05:14:33.494045</td>
      <td>0 days 00:00:02.015951</td>
      <td>0.890459</td>
      <td>15</td>
      <td>0.721254</td>
      <td>2.102514e-08</td>
      <td>0.002634</td>
      <td>0.030485</td>
      <td>169</td>
      <td>12</td>
      <td>35</td>
      <td>364</td>
      <td>20</td>
      <td>7.463964e-08</td>
      <td>COMPLETE</td>
    </tr>
  </tbody>
</table>
</div>


하이퍼파라미터 튜닝 결과 시각화



```python
lgbmoptuna.visualize()
```

Best 하이퍼파라미터 출력



```python
lgbmoptuna.get_best_params()
```

<pre>
{'lambda_l1': 2.1025137712294667e-08,
 'lambda_l2': 0.0026336954500641987,
 'path_smooth': 7.463963953158119e-08,
 'learning_rate': 0.030485356557551014,
 'feature_fraction': 0.7212541765212778,
 'bagging_fraction': 0.890458792615886,
 'num_leaves': 20,
 'min_data_in_leaf': 35,
 'max_bin': 169,
 'n_estimators': 364,
 'bagging_freq': 15,
 'min_child_weight': 12}
</pre>