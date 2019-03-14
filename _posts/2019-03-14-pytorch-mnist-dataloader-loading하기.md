---
layout: page
title: "[pytorch] MNIST dataset loading 하기"
description: "MNIST dataset loading 하는 방법에 대하여 알아보겠습니다"
tags: [pytorch]
comments: true
published: true
categories: linux
typora-copy-images-to: ../images/2019-03-14
---



pytorch 에서 각 종 Datasets에 대하여 제공해줍니다.

이러한 datasets는 ```torch.utils.data.Dataset```에 있습니다.



> torch에서 제공해 주는 Datasets 종류는 다음과 같습니다.

- [MNIST](https://pytorch.org/docs/stable/torchvision/datasets.html#mnist)

- [Fashion-MNIST](https://pytorch.org/docs/stable/torchvision/datasets.html#fashion-mnist)

- [KMNIST](https://pytorch.org/docs/stable/torchvision/datasets.html#kmnist)

- [EMNIST](https://pytorch.org/docs/stable/torchvision/datasets.html#emnist)

- COCO

  - [Captions](https://pytorch.org/docs/stable/torchvision/datasets.html#captions)
  - [Detection](https://pytorch.org/docs/stable/torchvision/datasets.html#detection)

- [LSUN](https://pytorch.org/docs/stable/torchvision/datasets.html#lsun)

- [ImageFolder](https://pytorch.org/docs/stable/torchvision/datasets.html#imagefolder)

- [DatasetFolder](https://pytorch.org/docs/stable/torchvision/datasets.html#datasetfolder)

- [Imagenet-12](https://pytorch.org/docs/stable/torchvision/datasets.html#imagenet-12)

- [CIFAR](https://pytorch.org/docs/stable/torchvision/datasets.html#cifar)

- [STL10](https://pytorch.org/docs/stable/torchvision/datasets.html#stl10)

- [SVHN](https://pytorch.org/docs/stable/torchvision/datasets.html#svhn)

- [PhotoTour](https://pytorch.org/docs/stable/torchvision/datasets.html#phototour)

- [SBU](https://pytorch.org/docs/stable/torchvision/datasets.html#sbu)

- [Flickr](https://pytorch.org/docs/stable/torchvision/datasets.html#flickr)

- [VOC](https://pytorch.org/docs/stable/torchvision/datasets.html#voc)

- [Cityscapes](https://pytorch.org/docs/stable/torchvision/datasets.html#cityscapes)

  

그리고 ```torch.utils.data.DataLoader```를 통하여 위에 나열된 datasets를 로딩할 수 있고 ```batch_size```를 정하여 한 번 학습시킬 때의 ```batch_size```만큼 학습시킬 수 있습니다.

뿐만아니라, ```transforms```를 정의할 수 있고, ```shuffle```, ```num_workers```를 정의하는 등 다양한 option 값으로 매우 손 쉽게 datasets를 컨트롤 할 수 있습니다.



## MNIST datasets transforms 정의

> MNIST datasets 에 transforms 정의

```python
import torchvision.transforms as transforms

# Normalize data with mean=0.5, std=1.0
mnist_transform = transforms.Compose([
    transforms.ToTensor(), 
    transforms.Normalize((0.5,), (1.0,))
])
```



transforms에는 다양한 option을 적용할 수 있습니다. 위에서는 ```mean=0.5```, ```std=1.0```를 기준으로 transforms 시키겠다는 의미입니다.

이 외에도 CenterCrop을 한다던지, 좌우 Flip, GreyScale 적용등의 옵션을 줄 수 있습니다. 자세한 사항은 [TORCHVISION.TRANSFORMS](https://pytorch.org/docs/stable/torchvision/transforms.html) 에서 확인할 수 있습니다.



## MNIST datasets Download

> MNIST Download

```python
from torchvision.datasets import MNIST

# download path 정의
download_root = './MNIST_DATASET'

train_dataset = MNIST(download_root, transform=mnist_transform, train=True, download=True)
valid_dataset = MNIST(download_root, transform=mnist_transform, train=False, download=True)
test_dataset = MNIST(download_root, transform=mnist_transform, train=False, download=True)

```



## Dataloader를 이용한 MNIST datasets 로딩

> DataLoader 활용

```python
# option 값 정의
batch_size = 64

train_loader = DataLoader(dataset=train_dataset, 
                         batch_size=batch_size,
                         shuffle=True)

valid_loader = DataLoader(dataset=test_dataset, 
                         batch_size=batch_size,
                         shuffle=True)

test_loader = DataLoader(dataset=test_dataset, 
                         batch_size=batch_size,
                         shuffle=True)
```



## DataLoader를 통한 Datasets 로딩 예제

```python
# batch_idx = batch의 index
# tuple형으로 x와 target을 return 받음
for batch_idx, (x, target) in enumerate(train_loader):
    if batch_idx % 10 == 0:
        print(x.shape, target.shape)
        print(len(train_loader.dataset))
```



##### #pytorch #datasets #MNIST #dataloader