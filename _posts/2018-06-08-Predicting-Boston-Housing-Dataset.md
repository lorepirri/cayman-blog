---
layout: page
title: "Simple Gradient Descent on predicting Boston Housing"
description: "Let's practice on predicting Bostong Housing prices (Gradient Descent)"
headline: "Let's practice on predicting Bostong Housing prices (Gradient Descent)"
categories: machine-learning
tags: boston-housing-dataset
comments: true
published: true

---

SImple  Gradient Descent implementations Examples

Here we are using Boston Housing Dataset which is provided by sklearn package.

If you don't have sklearn installed, you may install via pip

```bash
pip install -U scikit-learn
```



### Load Boston Housing Dataset

```python
import numpy as np
from sklearn.datasets import load_boston

boston = load_boston()
print(X.shape)
# (506, 13)
```



### Load Feature Data

```python
boston['feature_names']
# array(['CRIM', 'ZN', 'INDUS', 'CHAS', 'NOX', 'RM', 'AGE', 'DIS', 'RAD',
# 'TAX', 'PTRATIO', 'B', 'LSTAT'], dtype='<U7')
```



### Load Target Data

```python
actual = boston["target"]
print(y.shape)
# (506, )
```



### Wrap Data with Pandas

```python
import pandas as pd

data = pd.DataFrame(X, columns=boston["feature_names"])
data["RealData"] = actual  # for comparison of predictions
```



### Apply Gradient Descent 

```python
num_epoch = 100000
num_data = X.shape[0]
learning_rate = 0.000003

w = np.random.uniform(low=-1.0, high=1.0, size=13)
b = np.random.uniform(low=-1.0, high=1.0)


for epoch in range(num_epoch):
    predict = X.dot(w) + b
    error = np.abs(predict - actual).mean()
    
    # Assume that error < 5 will be enough
    if error < 5:
        break
        
    if epoch % 10000 == 0:    
        print("{0} epoch, error={1}".format(epoch, error))
        
    w = w - learning_rate * (predict-actual).dot(X) / num_data
    b = b - learning_rate * (predict-actual).mean()
    
print("{0} epoch, error={1}".format(epoch, error))

```

##### Results

```
0 epoch, error=44.21782491690112
10000 epoch, error=5.465574626842506
20000 epoch, error=5.080520144919618
25569 epoch, error=4.999989852544409
```

