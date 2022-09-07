---
layout: page
title: "AlexNet Implementation(구현) by PyTorch"
description: "PyTorch로 AlexNet을 구현하는 방법에 대하여 알아보겠습니다."
headline: "PyTorch로 AlexNet을 구현하는 방법에 대하여 알아보겠습니다."
categories: pytorch
tags: [ILSVRC, AlexNet, python, 파이썬, pytorch, 파이토치, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2022-09-02
---

AlexNet(2012) 의 PyTorch 구현 입니다. 논문에 대한 세부 인사이트는 생략하며, 오직 코드 구현만 다룹니다.

**논문**
- ImageNet Classification with Deep Convolutional Neural Networks [**(링크)**](https://proceedings.neurips.cc/paper/2012/file/c399862d3b9d6b76c8436e924a68c45b-Paper.pdf)


![](https://sushscience.files.wordpress.com/2016/12/alexnet6.jpg)

출처: https://sushscience.wordpress.com/2016/12/04/understanding-alexnet/


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


## 설정

```python
# Hyper Parameter 설정

IMAGE_SIZE = 227 # AlexNet의 이미지 입력 크기는 (3, 227, 227) 입니다.
NUM_EPOCHS = 10
LR = 0.0001 # Learning Rate

MODEL_NAME = 'AlexNet'
```

## 학습에 활용할 데이터셋 준비



```python
from torchvision import transforms
import sample_datasets as sd


train_transform = transforms.Compose([
    transforms.Resize((256, 256)),          # 개와 고양이 사진 파일의 크기가 다르므로, Resize로 맞춰줍니다.
    transforms.CenterCrop((IMAGE_SIZE, IMAGE_SIZE)),      # 중앙 Crop
    transforms.RandomHorizontalFlip(0.5),   # 50% 확률로 Horizontal Flip
    transforms.ToTensor(), 
    transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225)), # 이미지 정규화
])

test_transform = transforms.Compose([
    transforms.Resize((IMAGE_SIZE, IMAGE_SIZE)),      # 개와 고양이 사진 파일의 크기가 다르므로, Resize로 맞춰줍니다.
    transforms.ToTensor(), 
    transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225)), # 이미지 정규화
])

train_loader, test_loader = sd.cats_and_dogs(train_transform, test_transform)
```


<pre>
['tmp/PetImages/Dog', 'tmp/PetImages/Cat']
==============================
train images: 20000
train labels: 20000
test images: 4998
test labels: 4998
</pre>

```python
# 1개의 배치를 추출합니다.
images, labels = next(iter(train_loader))
```


```python
# 이미지의 shape을 확인합니다. 224 X 224 RGB 이미지 임을 확인합니다.
images[0].shape
```

<pre>
torch.Size([3, 227, 227])
</pre>
## AlexNet Architecture


![](https://cdn.analyticsvidhya.com/wp-content/uploads/2021/03/Screenshot-from-2021-03-19-16-01-03.png)



출처: https://www.datasciencecentral.com/alexnet-implementation-using-keras/


CUDA 설정이 되어 있다면 `cuda`를! 그렇지 않다면 `cpu`로 학습합니다.



(제 PC에는 GPU가 2대 있어서 `cuda:0`로 GPU 장비의 index를 지정해 주었습니다. 만약 다른 장비를 사용하고 싶다면 `cuda:1` 이런식으로 지정해 주면 됩니다)



```python
from tqdm import tqdm  # Progress Bar 출력
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim

# device 설정 (cuda:0 혹은 cpu)
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print(device)
```

<pre>
cuda
</pre>

```python
class AlexNet(nn.Module):
    def __init__(self):
        super(AlexNet, self).__init__()
        # Image input_size=(3, 227, 227)
        self.layers = nn.Sequential(
            # input_size=(96, 55, 55)
            nn.Conv2d(in_channels=3, out_channels=96, kernel_size=(11, 11), stride=4, padding=0), 
            nn.ReLU(), 
            # input_size=(96, 27, 27)
            nn.MaxPool2d(kernel_size=3, stride=2),
            # input_size=(256, 27, 27)
            nn.Conv2d(in_channels=96, out_channels=256, kernel_size=(5, 5), stride=1, padding=2),
            nn.ReLU(),
            # input_size=(256, 13, 13)
            nn.MaxPool2d(kernel_size=3, stride=2), 
            # input_size=(384, 13, 13)
            nn.Conv2d(in_channels=256, out_channels=384, kernel_size=(3, 3), stride=1, padding=1),
            nn.ReLU(),
            # input_size=(384, 13, 13)
            nn.Conv2d(in_channels=384, out_channels=384, kernel_size=(3, 3), stride=1, padding=1),
            nn.ReLU(),
            # input_size=(256, 13, 13)
            nn.Conv2d(in_channels=384, out_channels=256, kernel_size=(3, 3), stride=1, padding=1),
            nn.ReLU(),
            # input_size=(256, 6, 6)
            nn.MaxPool2d(kernel_size=3, stride=2), 
        )
        self.classifier = nn.Sequential(
            nn.Dropout(p=0.5),
            nn.Linear(in_features=256*6*6, out_features=4096),
            nn.ReLU(),
            nn.Dropout(p=0.5),
            nn.Linear(in_features=4096, out_features=4096),
            nn.ReLU(),
            nn.Linear(in_features=4096, out_features=1000),
        )
    
    def forward(self, x):
        x = self.layers(x)
        x = x.view(-1, 256*6*6)
        x = self.classifier(x)
        return x
```


```python
import torchsummary

model = AlexNet()
model.to(device)

# AlexNet의 Image 입력 사이즈는 (3, 227, 227) 입니다.
torchsummary.summary(model, input_size=(3, 227, 227), device='cuda')
```

<pre>
----------------------------------------------------------------
        Layer (type)               Output Shape         Param #
================================================================
            Conv2d-1           [-1, 96, 55, 55]          34,944
              ReLU-2           [-1, 96, 55, 55]               0
         MaxPool2d-3           [-1, 96, 27, 27]               0
            Conv2d-4          [-1, 256, 27, 27]         614,656
              ReLU-5          [-1, 256, 27, 27]               0
         MaxPool2d-6          [-1, 256, 13, 13]               0
            Conv2d-7          [-1, 384, 13, 13]         885,120
              ReLU-8          [-1, 384, 13, 13]               0
            Conv2d-9          [-1, 384, 13, 13]       1,327,488
             ReLU-10          [-1, 384, 13, 13]               0
           Conv2d-11          [-1, 256, 13, 13]         884,992
             ReLU-12          [-1, 256, 13, 13]               0
        MaxPool2d-13            [-1, 256, 6, 6]               0
          Dropout-14                 [-1, 9216]               0
           Linear-15                 [-1, 4096]      37,752,832
             ReLU-16                 [-1, 4096]               0
          Dropout-17                 [-1, 4096]               0
           Linear-18                 [-1, 4096]      16,781,312
             ReLU-19                 [-1, 4096]               0
           Linear-20                 [-1, 1000]       4,097,000
================================================================
Total params: 62,378,344
Trainable params: 62,378,344
Non-trainable params: 0
----------------------------------------------------------------
Input size (MB): 0.59
Forward/backward pass size (MB): 11.09
Params size (MB): 237.95
Estimated Total Size (MB): 249.63
----------------------------------------------------------------
</pre>

```python
# 옵티마이저를 정의합니다. 옵티마이저에는 model.parameters()를 지정해야 합니다.
optimizer = optim.Adam(model.parameters(), lr=LR)

# 손실함수(loss function)을 지정합니다. Multi-Class Classification 이기 때문에 CrossEntropy 손실을 지정하였습니다.
loss_fn = nn.CrossEntropyLoss()
```

## 훈련(Train)



```python
def model_train(model, data_loader, loss_fn, optimizer, device):
    # 모델을 훈련모드로 설정합니다. training mode 일 때 Gradient 가 업데이트 됩니다. 반드시 train()으로 모드 변경을 해야 합니다.
    model.train()
    
    # loss와 accuracy 계산을 위한 임시 변수 입니다. 0으로 초기화합니다.
    running_size = 0
    running_loss = 0
    corr = 0
    
    # 예쁘게 Progress Bar를 출력하면서 훈련 상태를 모니터링 하기 위하여 tqdm으로 래핑합니다.
    prograss_bar = tqdm(data_loader)
    
    # mini-batch 학습을 시작합니다.
    for batch_idx, (img, lbl) in enumerate(prograss_bar, start=1):
        # image, label 데이터를 device에 올립니다.
        img, lbl = img.to(device), lbl.to(device)
        
        # 누적 Gradient를 초기화 합니다.
        optimizer.zero_grad()
        
        # Forward Propagation을 진행하여 결과를 얻습니다.
        output = model(img)
        
        # 손실함수에 output, label 값을 대입하여 손실을 계산합니다.
        loss = loss_fn(output, lbl)
        
        # 오차역전파(Back Propagation)을 진행하여 미분 값을 계산합니다.
        loss.backward()
        
        # 계산된 Gradient를 업데이트 합니다.
        optimizer.step()
        
        # output의 max(dim=1)은 max probability와 max index를 반환합니다.
        # max probability는 무시하고, max index는 pred에 저장하여 label 값과 대조하여 정확도를 도출합니다.
        _, pred = output.max(dim=1)
        
        # pred.eq(lbl).sum() 은 정확히 맞춘 label의 합계를 계산합니다. item()은 tensor에서 값을 추출합니다.
        # 합계는 corr 변수에 누적합니다.
        corr += pred.eq(lbl).sum().item()
        
        # loss 값은 1개 배치의 평균 손실(loss) 입니다. img.size(0)은 배치사이즈(batch size) 입니다.
        # loss 와 img.size(0)를 곱하면 1개 배치의 전체 loss가 계산됩니다.
        # 이를 누적한 뒤 Epoch 종료시 전체 데이터셋의 개수로 나누어 평균 loss를 산출합니다.
        running_loss += loss.item() * img.size(0)
        running_size += img.size(0)
        prograss_bar.set_description(f'[Training] loss: {running_loss / running_size:.4f}, accuracy: {corr / running_size:.4f}')
        
    # 누적된 정답수를 전체 개수로 나누어 주면 정확도가 산출됩니다.
    acc = corr / len(data_loader.dataset)
    
    # 평균 손실(loss)과 정확도를 반환합니다.
    # train_loss, train_acc
    return running_loss / len(data_loader.dataset), acc
```

## 평가(Evaluate)



```python
def model_evaluate(model, data_loader, loss_fn, device):
    # model.eval()은 모델을 평가모드로 설정을 바꾸어 줍니다. 
    # dropout과 같은 layer의 역할 변경을 위하여 evaluation 진행시 꼭 필요한 절차 입니다.
    model.eval()
    
    # Gradient가 업데이트 되는 것을 방지 하기 위하여 반드시 필요합니다.
    with torch.no_grad():
        # loss와 accuracy 계산을 위한 임시 변수 입니다. 0으로 초기화합니다.
        corr = 0
        running_loss = 0
        
        # 배치별 evaluation을 진행합니다.
        for img, lbl in data_loader:
            # device에 데이터를 올립니다.
            img, lbl = img.to(device), lbl.to(device)
            
            # 모델에 Forward Propagation을 하여 결과를 도출합니다.
            output = model(img)
            
            # output의 max(dim=1)은 max probability와 max index를 반환합니다.
            # max probability는 무시하고, max index는 pred에 저장하여 label 값과 대조하여 정확도를 도출합니다.
            _, pred = output.max(dim=1)
            
            # pred.eq(lbl).sum() 은 정확히 맞춘 label의 합계를 계산합니다. item()은 tensor에서 값을 추출합니다.
            # 합계는 corr 변수에 누적합니다.
            corr += torch.sum(pred.eq(lbl)).item()
            
            # loss 값은 1개 배치의 평균 손실(loss) 입니다. img.size(0)은 배치사이즈(batch size) 입니다.
            # loss 와 img.size(0)를 곱하면 1개 배치의 전체 loss가 계산됩니다.
            # 이를 누적한 뒤 Epoch 종료시 전체 데이터셋의 개수로 나누어 평균 loss를 산출합니다.
            running_loss += loss_fn(output, lbl).item() * img.size(0)
        
        # validation 정확도를 계산합니다.
        # 누적한 정답숫자를 전체 데이터셋의 숫자로 나누어 최종 accuracy를 산출합니다.
        acc = corr / len(data_loader.dataset)
        
        # 결과를 반환합니다.
        # val_loss, val_acc
        return running_loss / len(data_loader.dataset), acc
```

## 모델 훈련(training) & 검증



```python
min_loss = np.inf

# Epoch 별 훈련 및 검증을 수행합니다.
for epoch in range(NUM_EPOCHS):
    # Model Training
    # 훈련 손실과 정확도를 반환 받습니다.
    train_loss, train_acc = model_train(model, train_loader, loss_fn, optimizer, device)

    # 검증 손실과 검증 정확도를 반환 받습니다.
    val_loss, val_acc = model_evaluate(model, test_loader, loss_fn, device)   
    
    # val_loss 가 개선되었다면 min_loss를 갱신하고 model의 가중치(weights)를 저장합니다.
    if val_loss < min_loss:
        print(f'[INFO] val_loss has been improved from {min_loss:.5f} to {val_loss:.5f}. Saving Model!')
        min_loss = val_loss
        torch.save(model.state_dict(), f'{MODEL_NAME}.pth')
    
    # Epoch 별 결과를 출력합니다.
    print(f'epoch {epoch+1:02d}, loss: {train_loss:.5f}, acc: {train_acc:.5f}, val_loss: {val_loss:.5f}, val_accuracy: {val_acc:.5f}')
```

<pre>
[Training] loss: 0.7168, accuracy: 0.5879: 100% 625/625 [00:13<00:00, 45.53it/s]
</pre>
<pre>
[INFO] val_loss has been improved from inf to 0.59215. Saving Model!
epoch 01, loss: 0.71677, acc: 0.58790, val_loss: 0.59215, val_accuracy: 0.68808
</pre>
<pre>
[Training] loss: 0.5303, accuracy: 0.7320: 100% 625/625 [00:13<00:00, 45.44it/s]
</pre>
<pre>
[INFO] val_loss has been improved from 0.59215 to 0.44437. Saving Model!
epoch 02, loss: 0.53033, acc: 0.73200, val_loss: 0.44437, val_accuracy: 0.79872
</pre>
<pre>
[Training] loss: 0.4009, accuracy: 0.8185: 100% 625/625 [00:13<00:00, 45.44it/s]
</pre>
<pre>
[INFO] val_loss has been improved from 0.44437 to 0.33342. Saving Model!
epoch 03, loss: 0.40090, acc: 0.81850, val_loss: 0.33342, val_accuracy: 0.85894
</pre>
<pre>
[Training] loss: 0.3189, accuracy: 0.8611: 100% 625/625 [00:13<00:00, 45.19it/s]
</pre>
<pre>
[INFO] val_loss has been improved from 0.33342 to 0.30023. Saving Model!
epoch 04, loss: 0.31886, acc: 0.86115, val_loss: 0.30023, val_accuracy: 0.87255
</pre>
<pre>
[Training] loss: 0.2662, accuracy: 0.8877: 100% 625/625 [00:13<00:00, 45.36it/s]
</pre>
<pre>
[INFO] val_loss has been improved from 0.30023 to 0.28450. Saving Model!
epoch 05, loss: 0.26623, acc: 0.88765, val_loss: 0.28450, val_accuracy: 0.87915
</pre>
<pre>
[Training] loss: 0.2256, accuracy: 0.9054: 100% 625/625 [00:13<00:00, 45.37it/s]
</pre>
<pre>
[INFO] val_loss has been improved from 0.28450 to 0.24105. Saving Model!
epoch 06, loss: 0.22556, acc: 0.90540, val_loss: 0.24105, val_accuracy: 0.90016
</pre>
<pre>
[Training] loss: 0.2018, accuracy: 0.9167: 100% 625/625 [00:13<00:00, 45.27it/s]
</pre>
<pre>
[INFO] val_loss has been improved from 0.24105 to 0.23280. Saving Model!
epoch 07, loss: 0.20185, acc: 0.91670, val_loss: 0.23280, val_accuracy: 0.90496
</pre>
<pre>
[Training] loss: 0.1785, accuracy: 0.9265: 100% 625/625 [00:13<00:00, 45.30it/s]
</pre>
<pre>
epoch 08, loss: 0.17853, acc: 0.92655, val_loss: 0.25248, val_accuracy: 0.90056
</pre>
<pre>
[Training] loss: 0.1611, accuracy: 0.9338: 100% 625/625 [00:13<00:00, 45.38it/s]
</pre>
<pre>
epoch 09, loss: 0.16107, acc: 0.93385, val_loss: 0.24603, val_accuracy: 0.90416
</pre>
<pre>
[Training] loss: 0.1426, accuracy: 0.9411: 100% 625/625 [00:13<00:00, 45.52it/s]
</pre>
<pre>
epoch 10, loss: 0.14265, acc: 0.94105, val_loss: 0.23530, val_accuracy: 0.90796
</pre>
## 저장한 가중치 로드 후 검증 성능 측정



```python
# 모델에 저장한 가중치를 로드합니다.
model.load_state_dict(torch.load(f'{MODEL_NAME}.pth'))
```

```python
# 최종 검증 손실(validation loss)와 검증 정확도(validation accuracy)를 산출합니다.
final_loss, final_acc = model_evaluate(model, test_loader, loss_fn, device)
print(f'evaluation loss: {final_loss:.5f}, evaluation accuracy: {final_acc:.5f}')
```

<pre>
evaluation loss: 0.23280, evaluation accuracy: 0.90496
</pre>