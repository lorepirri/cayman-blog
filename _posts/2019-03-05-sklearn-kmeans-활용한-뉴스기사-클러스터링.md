---
layout: page
title: "sklearn의 KMeans 모듈을 활용한 뉴스 클러스터링"
description: "sklearn의 KMeans 모듈을 활용한 뉴스 클러스터링에 대하여 알아보겠습니다."
tags: [machine-learning, sklearn, kmeans]
comments: true
published: true
categories: scikit-learn
redirect_from:
  - machine-learning/sklearn-kmeans-활용한-뉴스기사-클러스터링
typora-copy-images-to: ../images/2019-03-05
---







하루에도 수만개의 뉴스기사가 쏟아져 나옵니다. 수많은 뉴스기사들을 중복되거나 매우 유사도가 높은 기사들은 구독자에게 중복되게 노출시키지 않기 위해서 뉴스기사를 서비스 하고 있는 포털 사이트나 언론사에서도 뉴스기사 클러스터링 기법을 사용하고 있습니다.

물론, 수많은 데이터를 기반으로 더욱 정교한 뉴스기사 클러스터링 알고리즘을 사용하고 있겠지만, 이번 포스팅에서는 sklearn으로 간략하게 구현해 보도록 하겠습니다.



원본 소스에 대한 repo는 [여기](https://github.com/teddylee777/korean_news_categorization)에서 보실 수 있습니다.



## 뉴스기사 Dataset (sklearn.datasets)

sklearn 라이브러리에서 뉴스기사 dataset을 제공합니다.

> 20newsgroups dataset fetch

```python
import sklearn.datasets
all_data = sklearn.datasets.fetch_20newsgroups(subset='all')

# all_data의 data 갯수 출력
print(len(all_data.data))
# 출력: 18846
```



all_data의 data는 18846개가 있습니다. 학습하는데에 오래 걸릴 수도 있고, 동작원리만 보고자 함이니 이 중에서 특정 그룹을 선택해서 data 갯수를 줄여보도록 하겠습니다.

> all_data.target_names를 출력하여 그룹 출력

```python
print(all_data.target_names)
# 출력
# ['alt.atheism',
# 'comp.graphics',
# 'comp.os.ms-windows.misc',
# 'comp.sys.ibm.pc.hardware',
# 'comp.sys.mac.hardware',
# 'comp.windows.x',
# 'misc.forsale',
# 'rec.autos',
# 'rec.motorcycles',
# 'rec.sport.baseball',
# 'rec.sport.hockey',
# 'sci.crypt',
# 'sci.electronics',
# 'sci.med',
# 'sci.space',
# 'soc.religion.christian',
# 'talk.politics.guns',
# 'talk.politics.mideast',
# 'talk.politics.misc',
# 'talk.religion.misc']
```



보시면 다양한 뉴스기사들이 속한 그룹의 이름들이 보입니다.

이중에서 저는 처음 6개 그룹의 뉴스들만 뽑아서 train / test 해보겠습니다.

> 처음 6개 그룹만 뽑겠습니다.

```python
print(all_data.target_names[:6])
# 출력
# ['alt.atheism',
#  'comp.graphics',
#  'comp.os.ms-windows.misc',
#  'comp.sys.ibm.pc.hardware',
#  'comp.sys.mac.hardware',
#  'comp.windows.x']
```



그럼 train / test dataset을 만들어 보겠습니다. 편의상 validation set은 만들지 않겠습니다.

```python
train_data = sklearn.datasets.fetch_20newsgroups(subset='train', categories=all_data.target_names[:6])

test_data = sklearn.datasets.fetch_20newsgroups(subset='test', categories=all_data.target_names[:6])

print(len(train_data['data']), len(test_data['data']))
# (3416, 2274)
```



## 한글 뉴스기사 Dataset

위에서는 sklearn.dataset에서 제공해 주는 기사들을 활용해 볼 수 있겠지만, 나는 한글 기사에서의 동작을 확인해 보고 싶어서 한글 뉴스 기사를 크롤링 한 후 이것을 .csv 파일로 만들었다. 그리고 pandas로 import 해서 한글 기사들을 가져오겠습니다.

한글 뉴스기사 데이터는 [여기](https://github.com/teddylee777/korean_news_categorization)의 data 폴더에서 다운로드 받을 수 있습니다.

```python
import pandas as pd
df = pd.read_csv('./data/news.csv')
```



이 중  category==1 인 뉴스기사만 추출해 보도록 하겠습니다.

category==1인 뉴스기사는 '교육'과 관련된 기사입니다.

> 교육 관련 기사 (category ==1) select

```python
df = df[df['category']==1]
```



> preprocessing (특수문자 제거)

```python
import re

def preprocessing(sentence):
    sentence =re.sub('[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]', ' ', sentence)
    return sentence

df['content_cleaned'] = df['content'].apply(preprocessing)
content = df['content_cleaned'].tolist()
```



content에는 preprocessing이 완료된 교육 기사들이 담겼습니다.



## sklearn 라이브러리 활용

```python
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.preprocessing import normalize
from sklearn.cluster import KMeans

# 군집화 할 그룹의 갯수 정의
n_clusters = 100

# CountVectrizer로 토큰화
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(content)

# l2 정규화
X = normalize(X)

# k-means 알고리즘 적용
kmeans = KMeans(n_clusters=n_clusters).fit(X)

# trained labels and cluster centers
labels = kmeans.labels_
centers = kmeans.cluster_centers_

# labels에 merge
df['labels'] = labels
```

간단히 코드 몇 줄 만으로 뉴스기사에대한 clustering이 완료되었습니다.



```python
df.loc[df['labels']==7,['content_cleaned', 'labels']]

# 출력

# 		content_cleaned													labels
# 7925	공립유치원 육아지원센터 활용키로 개학 연기 없는 것으로 파악 이덕선 한국유치...	7
# 8043	교육당국 엄정 대응 방침 긴급 돌봄 서비스 제공해 공백 최소화 검찰 고발 땐 ...	7
# 8110	개학 연기 사립유치원 명단 오늘 정오 시도교육청 홈피 공개 머니투데이 세종 ...	7
# 8228	일부 사립유치원의 개학연기와 관련해 교육 당국이 개학 연기 유치원 명단을 공개하기로...	7
# 8285	돌봄 신청 교육지원청 연락처 서울시교육청은 관내에서 개학 연기를 결정한 유치원...	7
# 8286	충북교육청 전경 한국유치원총연합회의 개학 연기 방침에 동참하는 충북 사립유치원은 ...	7
# 8527	개학 연기 유치원 수 맞습니꺼 우리 동네는 더 많다 카든데 머니투데이 세종 ...	7
# 8636	개학 연기 통보받았다면 긴급돌봄 신청하세요 머니투데이 이해인 기자 한국유...	7
# 8660	일러스트 연합뉴스 전국 사립 유치원에서 집단 개학 연기를 선언한 가운데 대구에...	7
# 8661	한국유치원총연합회 한유총 의 개학 연기 결정에 대한 반발 비난 여론이 고조되고 있다...	7
# 8729	천안 아산에 집중 비상 돌봄서비스 준비 마쳐 홍성 연합뉴스 정찬욱 기자 한국...	7
# 8733	교육부 개학 연기 유치원 재집계 결과 곳으로 늘어 머니투데이 세종 문영...	7
# 8757	내일 개학 연기 유치원 곳 전체 수준 뉴스 제공 유은혜 사회부...	7
# 8788	유치원 학부모들과 아이들이 일 경기도 용인시 수지구청 앞에서 한국유치원총연합회를 ...	7
# 8816	교육당국 일부터 긴급돌봄체계 가동 보육서비스만 제공 뉴스 제공 일 오후 경...	7
# 8862	개학 연기 앞둔 유치원 서울 연합뉴스 김인철 기자 정부가 한국유치원총연합회 ...	7
# 8864	한국유치원총연합회 한유총 의 유치원 개학 연기 투쟁에 정부가 무관용 원칙 을 고수...	7
# 8883	사립유치원 개학연기 사태에 용인시 학부모 여명이 일 오후 경기도 용인시 수지...	7
# 8954	오늘 우리 동네 문 닫는 유치원은 어디 머니투데이 세종 문영재 기자 조희연...	7
# 8955	서울 종로구 서울시교육청에서 조희연 서울교육감 오른쪽부터 이재정 경기교육감 도...	7
# 8956	오늘 유치원 개학일 개학 연기 땐 엄정대응 돌봄강화 뉴스 제공 일 오후 ...	7
# 9024	돌봄 공백 우려 시교육청 돌봄 거점 유치원 곳 지정 일 사립유치원단체 한국...	7
# 9031	교육당국 일부 유치원 개학연기 철회 한유총 교육부에 달려 개학연기 유치원 전날...	7
# 9057	유치원 개학 연기 철회 현장에선 혼란만 머니투데이 이동우 기자 이해진 기...	7
# 9068	일방적 개학 연기와 갑작스런 철회까지 학부모 근심 분통 앵커 사립유치원단체의...	7
# 9071	사진 경북교육청 경북 NSP통신 강신윤 기자 경북교육청 교육감 임종...	7
# 9096	노원구 도봉구 일대 유치원 막판에 잇단 개학 연기 철회 시교육청 일부 유치원 ...	7
# 9105	이미지 크게보기 이미지 크게보기 한국유치원총연합회 한유총 가 유치원 법 등...	7
# 9107	충남지역 사립유치원 여곳이 일 한국유치원총연합회 한유총 방침에 동참해 개학 ...	7
# 9115	한국유치원총연합회가 개학 연기를 강행한 일 오전 서울 동대문구 장안동의 한 유치원...	7
# 9139	도내 전체의 인 곳 돌봄서비스 제공 보육대란은 피해 도교육청 교육과정...	7
# 9153	자체돌봄 제공해도 개학연기하면 시정명령 대상 개학 연기 무응답 유치원에 대한 ...	7
# 9155	미응답 곳 곳 변동 돌봄 거점 유치원 곳 지정사립유치원단체 한국유치원총연합...	7
# 9178	학부모들의 성난 목소리가 예상보다 커지면서 개학 연기를 강행한 사립유치원 숫자가 줄...	7
# 9185	개학 연기 발생 때 대처 방안은 이미 마련돼 있다 김승환 전북도 교육감이 한국사립...	7
# 9278	한국유치원총연합회 한유총 이 무기한 개학 연기 투쟁을 시작한 일 서울의 한 유치원...	7
# 9306	한유총 유아 볼모로 개학 연기 강행 참여 유치원은 곳 뉴스 제공 유은혜...	7
# 9348	경상남도교육청 사진 연합뉴스 한국유치원총연합회의 개학 연기 결정에 동참한 경남지...	7
# 9356	일부 학부모 불편 불가피 천안 아산 사립유치원 일부터 정상운영 홍성 연합뉴스...	7
# 9364	정부 강공 여론 밀려 휴업 급감 문 닫은 유치원에 시정명령서 한국유치원총연...	7
# 9365	부정 여론 정부 강경대응에 개학연기 철회 늘어 긴급돌봄체계 가동개학 연기 유치원에 ...	7
# 9459	유치원대란 없었다 끝내 무릎 꿇은 한유총 앵커 한국유치원총연합회가 예고한...	7
# 9477	유치원대란 없었다 끝내 무릎 꿇은 한유총 뉴스리뷰 앵커 한국유치원총...	7
# 9494	사립유치원 단체인 한국유치원총연합회가 유치원 법 철회 등을 요구하며 결국 개학...	7
# 9572	경기도 평택의 한 유치원은 개학 무기한 연기 를 선언했다가 일 예정대로 입학식을...	7
# 9584	한국유치원총연합회 한유총 가 유치원 법 등 철회를 요구하며 개학 연기 투쟁 ...	7
```



유치원 관련 데이터들이 군집화 된 결과 입니다.



## 정리

1. 한글에 대한 Token화

   sklearn에서 제공해 주는 KMeans를 활용하면 간단하게 군집화 하는 원리 정도는 이해하기에 도움이 되지만, 정교한 군집화를 위해서는 preprocessing 작업을 더 정교하게 해 주어야 합니다. 가령, 한글 문장에 대한 토큰화를 미리 해준다면 성능을 개선 시킬 수 있습니다.

   한글 토큰화는 **[konlpy](http://konlpy.org/ko/latest/)**를 활용하거나, 최근 카카오에서 공개한 **[khaiii](https://github.com/kakao/khaiii)** 라이브러리를 활용할 수 있습니다.

2. KMeans 알고리즘의 최대 약점 중의 하나는 n_cluster를 미리 알고 정의해 줘야한다는 점입니다. 방대한 뉴스기사의 데이터가 몇 개의 그룹으로 정의되어야 하는지 미리 알기는 어렵습니다. 또한 중심점(center)의 이 global optimum 이 아닌 local optimum에 빠질 수도 있습니다. 이렇게 되면, 군집화 퍼포먼스가 엉터리로 될 수 있습니다.


