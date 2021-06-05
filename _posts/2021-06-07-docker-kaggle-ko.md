---
layout: page
title: "캐글 노트북(Kaggle Notebook) 도커에 한글 자연어처리 패키지를 추가한 딥러닝 도커 배포, 설치 및 실행"
description: "캐글 노트북(Kaggle Notebook) 도커에 한글 자연어처리 패키지를 추가한 도커 배포, 설치 및 실행에 대해 알아보겠습니다."
headline: "캐글 노트북(Kaggle Notebook) 도커에 한글 자연어처리 패키지를 추가한 도커 배포, 설치 및 실행에 대해 알아보겠습니다."
categories: kaggle
tags: [python, 파이썬, docker, 도커, kaggle, 캐글, 캐글 노트북, 캐글 도커, 딥러닝 도커, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-06-07
---

캐글 노트북(Kaggle Notebook) 커널로도 유명한 도커인 [Kaggle/docker-python](https://github.com/Kaggle/docker-python)의 **GPU Docker**(gpu.Dockerfile)를 기반으로 구성하였습니다. Kaggle에서 공개한 도커 이미지는 한글 폰트, 자연어처리 패키지, 형태소 분석기 등이 누락되어 있습니다.

**docker-kaggle-ko**를 만들게 된 계기는 안정적으로 업데이트 되고 있는 **캐글 GPU 도커**에 기반하여 **한글 폰트, 한글 자연어처리 패키지(konlpy), 형태소 분석기(mecab), Timezone 등의 설정을 추가**하여 별도의 한글 관련 패키지와 설정을 해줘야 하는 번거로움을 줄이기 위함입니다.

- 도커 **Hub** 주소: [teddylee777/docker-kaggle-ko](https://hub.docker.com/repository/docker/teddylee777/docker-kaggle-ko)
- **GitHub** 주소: [teddylee777/docker-kaggle-ko](https://github.com/teddylee777/docker-kaggle-ko)

## 도커 환경

- OS: Ubuntu18.04
- GPU: RTX3090 x 2way
- CUDA11
- Python (anaconda): 3.7.10



## 추가 설치된 항목과 Python 패키지

- apt 패키지 인스톨러 **카카오 mirror 서버** 추가
- 나눔고딕 폰트 설치
- matplotlib 에 나눔고딕 폰트 추가
- mecab 형태소 분석기 설치 및 파이썬 패키지 설치
- [konlpy](https://konlpy-ko.readthedocs.io/ko/v0.4.3/): 한국어 정보처리를 위한 파이썬 패키지
- [py-hanspell](https://github.com/ssut/py-hanspell): 네이버 맞춤법 검사기를 이용한 파이썬용 한글 맞춤법 검사 라이브러리
- [soynlp](https://github.com/lovit/soynlp): 한국어 자연어처리를 위한 파이썬 라이브러리
- [soyspacing](https://github.com/lovit/soyspacing): 띄어쓰기 오류 교정 라이브러리
- [KR-WordRank](https://github.com/lovit/KR-WordRank)비지도학습 방법으로 한국어 텍스트에서 단어/키워드를 자동으로 추출하는 라이브러리
- `jupyter_notebook_config.py` : Jupyter Notebook 설정 파일 추가



## 설치된 주요 라이브러리

```
catboost                       0.25.1
cudf                           0.16.0
fastai                         2.2.7
fasttext                       0.9.2
fbprophet                      0.7.1
gensim                         4.0.1
huggingface-hub                0.0.9
hyperopt                       0.2.5
kaggle                         1.5.12
Keras                          2.4.3
Keras-Preprocessing            1.1.2
konlpy                         0.5.2
krwordrank                     1.0.3
lightgbm                       3.2.0
matplotlib                     3.4.2
mecab-python                   0.996-ko-0.9.2
missingno                      0.4.2
mlxtend                        0.18.0
nltk                           3.2.4
numpy                          1.19.5
opencv-python                  4.5.2.52
pandas                         1.1.5
plotly                         4.14.3
plotly-express                 0.4.1
py-hanspell                    1.1
scikit-image                   0.18.1
scikit-learn                   0.24.2
scikit-surprise                1.1.1
scipy                          1.6.2
seaborn                        0.11.1
sentencepiece                  0.1.95
soynlp                         0.0.493
soyspacing                     1.0.17
spacy                          2.3.5
SQLAlchemy                     1.4.3
statsmodels                    0.12.2
tensorboard                    2.4.1
tensorflow                     2.4.1
tensorflow-datasets            3.0.0
Theano                         1.0.5
torch                          1.7.0
torchaudio                     0.7.0a0+ac17b64
torchmetrics                   0.3.2
torchtext                      0.8.0a0+cd6902d
torchvision                    0.8.1
wordcloud                      1.8.1
xgboost                        1.4.2
```



## 빠른 설치 및 실행

### STEP 1: Docker가 사전에 설치되어 있어야 합니다.

도커의 설치 및 사용법에 대하여 궁금하신 분들은 [Docker를 활용하여 딥러닝/머신러닝 환경 구성하기](https://teddylee777.github.io/linux/docker%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%98%EC%97%AC-%EB%94%A5%EB%9F%AC%EB%8B%9D-%ED%99%98%EA%B2%BD%EA%B5%AC%EC%84%B1.md) 글을 참고해 주세요.

```bash
# step 1: apt-get 업데이트
sudo apt-get update

# step 2: 이전 버젼 제거
sudo apt-get remove docker docker-engine docker.io

# step 3: 도커(Docker) 설치 
sudo apt install docker.io

# step 4: 도커 서비스 시작
sudo systemctl start docker
sudo systemctl enable docker

# step 5: 잘 설치 되어있는지 버젼 체크
docker --version
```

### STEP 2: docker-kaggle-ko 이미지 pull 하여 서버 실행

- `--rm`: 도커가 종료될 때 컨테이너 삭제
- `-it`: 인터랙티브 TTY 모드 (디폴트로 설정)
- `-d`: 도커를 백그라운드로 실행
- `-p`: 포트 설정. **local 포트:도커 포트**
- `-v`: local 볼륨 마운트. **local 볼륨:도커 볼륨**
- `--name`: 도커의 별칭(name) 설정



**DockerHub에서 이미지 다운로드**

DockerHub에 미리 빌드된 이미지를 다운로드 받은 후 실행합니다.

(스트레스가 없다는 것이 장점입니다. 다만, 다운로드 시간은 오래 걸립니다.)

**[참고]**

`jupyter_notebook_config.py` 을 기본 값으로 사용하셔도 좋지만, 보안을 위해서 **비밀번호 설정**은 해주시는 것이 좋습니다.

**비밀번호 설정** 방법, **방화벽 설정** 방법은 [Docker를 활용하여 딥러닝/머신러닝 환경 구성하기](https://teddylee777.github.io/linux/docker%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%98%EC%97%AC-%EB%94%A5%EB%9F%AC%EB%8B%9D-%ED%99%98%EA%B2%BD%EA%B5%AC%EC%84%B1.md) 글의 STEP 5, 7을 참고해 주세요.



> jupyter notebook 서버 실행, port는 8888번 포트 사용

```bash
docker run --runtime nvidia --rm -it -p 8888:8888 teddylee777/docker-kaggle-ko:latest
```

> jupyter notebook 서버 실행, 로컬 volume 마운트

```bash
docker run --runtime nvidia --rm -it -p 8888:8888 -v /data/jupyter_data:/home/jupyter teddylee777/docker-kaggle-ko:latest
```

> 도커를 background에서 실행

```bash
docker run --runtime nvidia --rm -itd -p 8888:8888 teddylee777/docker-kaggle-ko:latest
```

> bash shell 진입

```bash
docker run --runtime nvidia --rm -it -p 8888:8888 teddylee777/docker-kaggle-ko:latest /bin/bash
```

> 현재 컨테이너 접속 (container ID 입력)

```bash
docker exec -it c456623003b1 /bin/bash
```



## 빌드

DockerHub에서 다운로드 받은 도커 이미지로 실행시 **빌드 과정은 생략** 가능합니다.

### DockerHub 다운로드

DockerHub에 미리 만들어 놓은 이미지를 다운로드 받습니다.

스트레스가 없다는 것이 장점입니다. 다운로드 시간은 오래 걸립니다.

```bash
docker run --runtime nvidia --rm -it -p 8888:8888 teddylee777/docker-kaggle-ko:latest
```



### Dockerfile을 수정하여 직접 빌드

커스텀이 가능합니다. 필요한 추가 패키지가 있다면 추가 구성이 가능합니다.

추가 패키지 설치를 위해서는 Dockerfile을 수정하시면 됩니다.

**참고**

- DockerHub 유저 아이디: teddylee777
- 도커명: docker-kaggle-ko
- 태그: latest

```bash
git clone https://github.com/teddylee777/docker-kaggle-ko.git
cd docker-kaggle-ko
docker build -t teddylee777/docker-kaggle-ko:latest .
```



## 도커 실행

- `--rm`: 도커가 종료될 때 컨테이너 삭제
- `-it`: 인터랙티브 TTY 모드 (디폴트로 설정)
- `-d`: 도커를 백그라운드로 실행
- `-p`: 포트 설정. **local 포트:도커 포트**
- `-v`: local 볼륨 마운트. **local 볼륨:도커 볼륨**
- `--name`: 도커의 별칭(name) 설정

```bash
docker run --runtime nvidia --rm -itd -p 8888:8888 -v /data/jupyter_data:/home/jupyter --name kaggle-ko teddylee777/docker-kaggle-ko
```



## .bashrc에 단축 커멘드 지정

`~/.bashrc`의 파일에 아래 커멘드를 추가하여 단축키로 Docker 실행

```bash
kjupyter{
    docker run --runtime nvidia --rm -itd -p 8888:8888 -v /data/jupyter_data:/home/jupyter --name kaggle-ko teddylee777/docker-kaggle-ko
}
```

터미널에 다음과 같이 입력하여 도커 실행

```bash
kjupyter
```



## 설치 완료 후 테스트

`test.ipynb` 파일을 실행하여 잘 설치가 되었는지 확인할 수 있습니다.

> NVIDIA

```bash
!nvidia-smi
```

> TensorFlow

```python
import tensorflow as tf

print(f'tf.__version__: {tf.__version__}')

gpus = tf.config.experimental.list_physical_devices('GPU')
print(gpus)
```

> PyTorch

```python
import torch

print(f'torch.__version__: {torch.__version__}')

print(f'GPU 사용여부: {torch.cuda.is_available()}')
gpu_count = torch.cuda.device_count()
print(f'GPU count: {gpu_count}')
if gpu_count > 0:
    print(f'GPU name: {torch.cuda.get_device_name(0)}')
```

> 한글 자연어처리 패키지

```python
from konlpy.tag import Okt, Kkma, Hannanum

sample_sentence = '아버지가방에들어가신다.'

okt = Okt()
print(f'okt: {okt.pos(sample_sentence)}')

kkma = Kkma()
print(f'kkma: {okt.pos(sample_sentence)}')

hannanum = Hannanum()
print(f'hannanum: {hannanum.pos(sample_sentence)}')
```

> Mecab 설치 확인

```python
from konlpy.tag import Mecab

sample_sentence = '아버지가방에들어가신다.'

mecab = Mecab()
print(f'mecab: {mecab.pos(sample_sentence)}')
```

> 머신러닝 패키지

```python
import sklearn
import lightgbm
import xgboost

print(f'lightgbm: {lightgbm.__version__}\nxgboost: {xgboost.__version__}\nsklearn: {sklearn.__version__}')
```

