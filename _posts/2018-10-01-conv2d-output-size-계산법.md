---
layout: page
title: "Conv2d layer를 겹겹이 쌓을 때 최종 output volume 계산법"
description: "Conv2d layer를 겹겹이 쌓을 때 최종 output volume 계산법을 알아보겠습니다."
tags: [torch, conv2d, machine-learning]
categories: pytorch
redirect_from:
  - machine-learning/conv2d-output-size-계산법
comments: true
published: true
---

이번 포스팅에서는 torch 를 이용하여 CNN(Convolution Neural Network) 에서 convolution layer를 겹겹이 쌓았을 때 최종 output volume size를 구하는 방법에 대하여 알아 보겠습니다.


## 이미지 출력 자동 계산기 웹앱 배포(2022.08.12)

PyTorch에서 Conv2d와 MaxPool2d 레이어를 쌓을 때 **이미지 출력 값을 자동으로 계산해주는 웹앱을 만들어 배포** 했습니다!!

- [Conv2d, MaxPool2d 계산기 바로가기](https://bit.ly/torch-calc)


![torch-calculator](../images/2018-10-01/demo.gif)



위의 링크에서 자동으로 계산하여 최종 출력 이미지의 shape을 계산할 수 있습니다.


최종 출력 이미지의 Shape를 우리가 계산하여 알아야 하는 이유는 Convolution Layer 를 겹겹이 쌓고 중간중간 maxpooling 을 거친 후, Fully-connected layer로 넣기 전 output size 를 계산해주어 node수에 맞게 삽입해 줘야 하는데, 이때 shape을 찍어보고 넣어줄 수도 있겠지만, 이를 미리 계산하고 smart(?)하게 넣어 주는 방법에 대하여 공유 드리고자 합니다.



### PyTorch를 이용한 CNN빌드업 예시

아래는, 심플한 Convolution Network를 빌드업하는 예제 코드입니다.

Input Image데이터는 32 * 32 pixel 사이즈 이며, RGB를 가지고 있는 depth=3 인 이미지가 되겠습니다.

(여기서 batch_size는 배제하겠습니다.)

```python
import torch.nn as nn
import torch.nn.functional as F

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(3, 32, 3, padding=1)
        self.conv2 = nn.Conv2d(32, 64, 5, padding=0)
        self.pool = nn.MaxPool2d(2, 2)
        self.fc1 = nn.Linear(64*6*6, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        # add sequence of convolutional and max pooling layers
        x = self.pool(F.relu(self.conv1(x)))
        x = self.pool(F.relu(self.conv2(x)))
        x = x.view(-1, 64*6*6)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x
```



먼저, torch의 nn.Conv2d에 대하여 간략히 짚고 넘어가보자 합니다.

```python
nn.Conv2d(3, 32, 3, padding=1)
```



첫번째 parameter 인 **3**은 input_channel_size가 되겠습니다. 여기서 input_channel_size는 Input Image의 RGB depth 인 3이 되겠습니다. (즉, 32*32 Image 3장이 들어간다고 보면 되겠습니다.)



두번째 parameter 인 **32**는 output_volume_size입니다. 즉, conv1 layer를 거쳐 몇장의 필터를 만들어 내고 싶은가? 입니다. 32장의 필터를 만들어 내고 싶으므로, 32가 되겠습니다.



세번째 parameter는 kernel_size입니다. Filter_size라고도 불리기도 하는데, 말 그대로 filter의 사이즈를 정의하는 것입니다. 3*3 filter를 사용하고 싶기 때문에 3을 기입했습니다. 



네번째 parameter 인 padding=1은 padding을 줄지 말지 여부와 padding 사이즈를 지정해 줍니다. 저는 padding 을 임의로 1 주었습니다.



마지막으로, stride는 따로 주지는 않았지만, 따로 주지 않으면 default로 stride=1 속성이 지정됩니다.



### Fully-Connected 레이어로 전달하기 전 Node 계산법

Conv2d에 적는 hyperparameter 의 값들에 따라 output size가 달라지게 됩니다. 즉, padding 을 얼만큼 주는가 혹은 stride는 얼마인가에 따라 output size가 달라지게 되는데 이를 반드시 알아야 Fully-connected layer로 알맞는 node수를 전달할 수 있게 됩니다.



우선, 공식부터 적어보자면

**Output Size = (W - F + 2P) / S + 1**



W: input_volume_size

F: kernel_size

P: padding_size

S: strides



```python
nn.Conv2d(3, 32, 3, padding=1)
```

로 다시 돌아가서 output_size를 계산한다면,

<32*32 Image 의 width인 32가 W의 input_volume_size가 되게 됩니다.>

output_size = (32 - 3 + 2*1) / 1 + 1 = **32**



즉, output_filter_size는 32*32 Image가 되겠고, depth는 32가 됩니다. (2번째 parameter: filter사이즈 입력 값)

위의 공식을 활용하면, 어떤 output 값이라도 편하게 구할 수 있게 됩니다!!



### Maxpooling을 하면 그 값으로 나눈 값이 Output Size 다!



maxpooling 을 2로 하게 되면 input_filter_size의 값을 2로 나눈 값이 output_filter_size가 되게 됩니다.

가령, maxpooling 을 4로 하게 되면, output_filter_size는 4로 나눈 값이 되겠죠?

