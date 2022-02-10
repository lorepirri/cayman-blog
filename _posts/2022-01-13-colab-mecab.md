---
layout: page
title:  "구글 코랩(Google Colab)에서 Mecab 형태소 분석기, konlpy 쉽게 설치하기"
description: "구글 코랩(Google Colab)에서 Mecab 형태소 분석기, konlpy 쉽게 설치하는 방법에 대하여 알아보겠습니다."
headline: "구글 코랩(Google Colab)에서 Mecab 형태소 분석기, konlpy 쉽게 설치하는 방법에 대하여 알아보겠습니다."
categories: colab
tags: [python, 인공지능 책, 테디노트 책, 테디노트, 파이썬, 파이썬 딥러닝 텐서플로, data science, 데이터 분석, 딥러닝, Google Colab, 형태소 분석기, mecab, konlpy, 구글 코랩, mecab 설치]
comments: true
published: true
typora-copy-images-to: ../images/2021-01-13
---

Google Colab (구글 코랩) 에서 Mecab 형태소 분석기 설치 과정이 복잡하기 때문에 배시 스크립트(bash script)로 만들어 **코드 1줄** 실행으로 복잡한 설치 과정을 건너뛸 수 있도록 만들었습니다. 

아래와 같이 1줄만 실행하면 **Google Colab에서 mecab 형태소 분석기를 설치 및 사용**할 수 있습니다.

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


## Mecab 형태소 분석기 설치 (konlpy도 같이 설치) 

```python
# konlpy, Mecab 형태소 분석기 설치 스크립트 실행
!curl -s https://raw.githubusercontent.com/teddylee777/machine-learning/master/99-Misc/01-Colab/mecab-colab.sh | bash
```

> 아래의 코드를 실행하여 정상 설치 및 동작함을 확인하였습니다.

```python
# 정상 동작 확인
from konlpy.tag import Okt, Mecab

okt = Okt()
mecab = Mecab()
```

> Okt 형태소 분석기

```python
okt.morphs('한글 형태소 분석기(오케이티)로 테스트를 해보았습니다. 정상 설치 및 동작이 잘 됩니다.')
```

<pre>
['한글',
 '형태소',
 '분석',
 '기',
 '(',
 '오',
 '케이티',
 ')',
 '로',
 '테스트',
 '를',
 '해보았습니다',
 '.',
 '정상',
 '설치',
 '및',
 '동작',
 '이',
 '잘',
 '됩니다',
 '.']
</pre>

> Mecab 형태소 분석기

```python
mecab.morphs('한글 형태소 분석기(미켑)로 테스트를 해보았습니다. 정상 설치 및 동작이 잘 됩니다.')
```

<pre>
['한글',
 '형태소',
 '분석기',
 '(',
 '미',
 '켑',
 ')',
 '로',
 '테스트',
 '를',
 '해',
 '보',
 '았',
 '습니다',
 '.',
 '정상',
 '설치',
 '및',
 '동작',
 '이',
 '잘',
 '됩니다',
 '.']
</pre>