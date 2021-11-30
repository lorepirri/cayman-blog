---
layout: page
title:  "뽀로로(PORORO) 자연어처리 라이브러리 활용기 (dev. and maintained by 카카오 브레인(Kakao Brain) PORORO팀)"
description: "뽀로로(PORORO) 자연어처리 라이브러리 활용기 (dev. and maintained by 카카오 브레인(Kakao Brain) PORORO팀)에 대해 알아 보도록 하겠습니다."
headline: "뽀로로(PORORO) 자연어처리 라이브러리 활용기 (dev. and maintained by 카카오 브레인(Kakao Brain) PORORO팀)에 대해 알아 보도록 하겠습니다."
categories: visualization
tags: [python, 인공지능 책, 테디노트 책, 테디노트, 파이썬, 딥러닝 책 추천, 파이썬 책 추천, 머신러닝 책 추천, 파이썬 딥러닝 텐서플로, 텐서플로우 책 추천, 텐서플로 책, 인공지능 서적, data science, 데이터 분석, 딥러닝, 뽀로로, PORORO, Kakao Brain, 자연어처리, 딥러닝 자연어, 한글 자연어]
comments: true
published: true
typora-copy-images-to: ../images/2021-11-30
---

카카오 브레인(Kakao Brain) 에서 개발한 **자연어처리 종합 선물 세트**

> PORORO: Platform Of neuRal mOdels for natuRal language prOcessing (일명: 뽀로로)

를 활용하여 쉽고 간단한 실험 및 적용해 볼 수 있는 자연어 처리 예제를 소개합니다.

아쉽게도 2021년 2월 18일 이후 commit이 없어서 issue tracking이 되고 있지 않아 몇몇 기능에 대해서는 Bug가 발생할 수 있습니다.
그럼에도 불구하고 매우 손쉬운 사용성 덕에 별다른 큰 노력 없이 성능 좋은 자연어처리를 실험해 볼 수 있습니다.

한글 자연어처리에서 빠질 수 없는 `konlpy` 형태소 분석 예제도 초반부에 있습니다.

다음의 코랩 튜토리얼에서 샘플 코드를 직접 실행해 볼 수 있습니다.
- [코랩 튜토리얼 예제](https://colab.research.google.com/drive/1CHXLv6EakV93-dnBJm3vRi_znERtOFML?usp=sharing)

본 튜토리얼 코드는 공식 도큐먼트에 게재되어 있는 예제를 활용하였으며, 다시 한 번 좋은 라이브러리를 공개한 **카카오브레인 PORORO Project 팀에게 감사**의 말씀을 드립니다.

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


## 필요한 모듈



`konlpy`: 한글 형태소 분석기

  - [공식문서](https://konlpy.org/ko/latest/)

  - 한글 자연어처리를 위한 필수 설치 라이브러리



`pororo`: 카카오브레인에서 만든 한글 자연어처리 라이브러리

  - [Github 주소](https://github.com/kakaobrain/pororo)

  - [공식문서](https://kakaobrain.github.io/pororo/)



```python
# konlpy 설치
!pip install konlpy
```


```python
# Pororo 설치
!pip install git+https://github.com/kakaobrain/pororo.git
```


```python
# mecab 형태소 분석기 설치
!pip install python-mecab-ko
```


```python
# 예제 실행을 위한 사전 import
from pororo import Pororo

# 빈칸 채우기
fib = Pororo(task="fib", lang="ko")

# 이미지 캡셔닝
caption = Pororo(task="caption", lang="en")

# 자동 에세이 채점
aes = Pororo(task="aes", lang="en")

# 기계번역
mt = Pororo(task="translation", lang="multi")

# 한글 맞춤법(띄어쓰기) 수정
spacing = Pororo(task="gec", lang="ko")

# 영어 알파벳 수정
gec = Pororo(task="gec", lang="en")

# 요약
bullet_summ = Pororo(task="text_summarization", lang="ko", model="bullet")
ext_summ = Pororo(task="text_summarization", lang="ko", model="extractive")
abs_summ = Pororo(task="text_summarization", lang="ko", model="abstractive")
```


## 형태소 분석기 `konlpy` 예제



```python
input_text = '''그룹 방탄소년단(BTS)이 두 번째 영어 곡 '버터'(Butter)로 미국 빌보드 메인 싱글 차트에서 2주 연속 정상에 올랐습니다.
빌보드는 지난달 21일 발매된 BTS의 '버터'가 메인 싱글 차트인 '핫 100'에서 지난주에 이어 1위를 기록했다고 7일(현지시간) 밝혔습니다.
'''
input_text
```

<pre>
"그룹 방탄소년단(BTS)이 두 번째 영어 곡 '버터'(Butter)로 미국 빌보드 메인 싱글 차트에서 2주 연속 정상에 올랐습니다.\n빌보드는 지난달 21일 발매된 BTS의 '버터'가 메인 싱글 차트인 '핫 100'에서 지난주에 이어 1위를 기록했다고 7일(현지시간) 밝혔습니다.\n"
</pre>

```python
# 형태소 분석기 가져오기
from konlpy.tag import Okt
```


```python
# 객체 생성
okt = Okt()
```


```python
okt.pos(input_text)[:10]
```

<pre>
[('그룹', 'Noun'),
 ('방탄소년단', 'Noun'),
 ('(', 'Punctuation'),
 ('BTS', 'Alpha'),
 (')', 'Punctuation'),
 ('이', 'Noun'),
 ('두', 'Noun'),
 ('번째', 'Suffix'),
 ('영어', 'Noun'),
 ('곡', 'Noun')]
</pre>

```python
okt.morphs(input_text)[:20]
```

<pre>
['그룹',
 '방탄소년단',
 '(',
 'BTS',
 ')',
 '이',
 '두',
 '번째',
 '영어',
 '곡',
 "'",
 '버터',
 "'(",
 'Butter',
 ')',
 '로',
 '미국',
 '빌보드',
 '메인',
 '싱글']
</pre>
## 문서 요약 (Text Summerization)



- [문서링크](https://kakaobrain.github.io/pororo/seq2seq/summary.html)


샘플 데이터 생성



```python
input_text1 = """가수 김태연은 걸 그룹 소녀시대, 소녀시대-태티서 및 소녀시대-Oh!GG의 리더이자 메인보컬이다. 2004년 SM에서 주최한 청소년 베스트 선발 대회에서 노래짱 대상을 수상하며 SM 엔터테인먼트에 캐스팅되었다. 이후 3년간의 연습생을 거쳐 2007년 소녀시대의 멤버로 데뷔했다. 태연은 1989년 3월 9일 대한민국 전라북도 전주시 완산구에서 아버지 김종구, 어머니 김희자 사이의 1남 2녀 중 둘째로 태어났다. 가족으로는 오빠 김지웅, 여동생 김하연이 있다. 어릴 적부터 춤을 좋아했고 특히 명절 때는 친척들이 춤을 시키면 곧잘 추었다던 태연은 TV에서 보아를 보고 가수의 꿈을 갖게 되었다고 한다. 전주양지초등학교를 졸업하였고 전주양지중학교 2학년이던 2003년 SM아카데미 스타라이트 메인지방보컬과 4기에 들어가게 되면서 아버지와 함께 주말마다 전주에서 서울로 이동하며 가수의 꿈을 키웠다. 2004년에 당시 보컬 트레이너였던 더 원의 정규 2집 수록곡 〈You Bring Me Joy (Part 2)〉에 피처링으로 참여했다. 당시 만 15세였던 태연은 현재 활동하는 소속사 SM 엔터테인먼트에 들어가기 전이었다. 이후 태연은 2004년 8월에 열린 제8회 SM 청소년 베스트 선발 대회에서 노래짱 부문에 출전해 1위(대상)를 수상하였고 SM 엔터테인먼트에 정식 캐스팅되어 연습생 생활을 시작하게 되었다. 2005년 청담고등학교에 입학하였으나, 학교 측에서 연예계 활동을 용인하지 않아 전주예술고등학교 방송문화예술과로 전학하였고 2008년 졸업하면서 학교를 빛낸 공로로 공로상을 수상했다. 태연은 연습생 생활이 힘들어 숙소에서 몰래 뛰쳐나갔다가 하루 만에 다시 돌아오기도 했다고 이야기하기도 했다. 이후 SM엔터테인먼트에서 3년여의 연습생 기간을 거쳐 걸 그룹 소녀시대의 멤버로 정식 데뷔하게 되었다."""
input_text2 = """목성과 토성이 약 400년 만에 가장 가까이 만났습니다. 국립과천과학관 등 천문학계에 따르면 21일 저녁 목성과 토성은 1623년 이후 397년 만에 가장 가까워졌는데요. 크리스마스 즈음까지 남서쪽 하늘을 올려다보면 목성과 토성이 가까워지는 현상을 관측할 수 있습니다. 목성의 공전주기는 11.9년, 토성의 공전주기는 29.5년인데요. 공전주기의 차이로 두 행성은 약 19.9년에 한 번 가까워집니다. 이번 근접 때  목성과 토성 사이 거리는 보름달 지름의 5분의 1 정도로 가까워졌습니다. 맨눈으로 보면 두 행성이 겹쳐져 하나의 별처럼 보이는데요. 지난 21일 이후 목성과 토성의 대근접은 2080년 3월 15일로 예측됩니다. 과천과학관 측은 우리가 대근접을 볼 수 있는 기회는 이번이 처음이자 마지막이 될 가능성이 크다라고 설명했 습니다."""
```


```python
input_text1
```

<pre>
'가수 김태연은 걸 그룹 소녀시대, 소녀시대-태티서 및 소녀시대-Oh!GG의 리더이자 메인보컬이다. 2004년 SM에서 주최한 청소년 베스트 선발 대회에서 노래짱 대상을 수상하며 SM 엔터테인먼트에 캐스팅되었다. 이후 3년간의 연습생을 거쳐 2007년 소녀시대의 멤버로 데뷔했다. 태연은 1989년 3월 9일 대한민국 전라북도 전주시 완산구에서 아버지 김종구, 어머니 김희자 사이의 1남 2녀 중 둘째로 태어났다. 가족으로는 오빠 김지웅, 여동생 김하연이 있다. 어릴 적부터 춤을 좋아했고 특히 명절 때는 친척들이 춤을 시키면 곧잘 추었다던 태연은 TV에서 보아를 보고 가수의 꿈을 갖게 되었다고 한다. 전주양지초등학교를 졸업하였고 전주양지중학교 2학년이던 2003년 SM아카데미 스타라이트 메인지방보컬과 4기에 들어가게 되면서 아버지와 함께 주말마다 전주에서 서울로 이동하며 가수의 꿈을 키웠다. 2004년에 당시 보컬 트레이너였던 더 원의 정규 2집 수록곡 〈You Bring Me Joy (Part 2)〉에 피처링으로 참여했다. 당시 만 15세였던 태연은 현재 활동하는 소속사 SM 엔터테인먼트에 들어가기 전이었다. 이후 태연은 2004년 8월에 열린 제8회 SM 청소년 베스트 선발 대회에서 노래짱 부문에 출전해 1위(대상)를 수상하였고 SM 엔터테인먼트에 정식 캐스팅되어 연습생 생활을 시작하게 되었다. 2005년 청담고등학교에 입학하였으나, 학교 측에서 연예계 활동을 용인하지 않아 전주예술고등학교 방송문화예술과로 전학하였고 2008년 졸업하면서 학교를 빛낸 공로로 공로상을 수상했다. 태연은 연습생 생활이 힘들어 숙소에서 몰래 뛰쳐나갔다가 하루 만에 다시 돌아오기도 했다고 이야기하기도 했다. 이후 SM엔터테인먼트에서 3년여의 연습생 기간을 거쳐 걸 그룹 소녀시대의 멤버로 정식 데뷔하게 되었다.'
</pre>

```python
# supports various decoding strategies 
abs_summ(
    input_text1, 
    beam=5, 
    len_penalty=0.6,
    no_repeat_ngram_size=3,
    top_k=50,
    top_p=0.7
)
```

<pre>
'가수 김태연은 2004년 SM 청소년 베스트 선발 대회에서 노래짱 대상을 수상하여 SM 엔터테인먼트에 캐스팅되어 3년간의 연습생 생활을 거쳐 2007년 소녀시대의 멤버로 데뷔했다.'
</pre>

```python
input_text2
```

<pre>
'목성과 토성이 약 400년 만에 가장 가까이 만났습니다. 국립과천과학관 등 천문학계에 따르면 21일 저녁 목성과 토성은 1623년 이후 397년 만에 가장 가까워졌는데요. 크리스마스 즈음까지 남서쪽 하늘을 올려다보면 목성과 토성이 가까워지는 현상을 관측할 수 있습니다. 목성의 공전주기는 11.9년, 토성의 공전주기는 29.5년인데요. 공전주기의 차이로 두 행성은 약 19.9년에 한 번 가까워집니다. 이번 근접 때  목성과 토성 사이 거리는 보름달 지름의 5분의 1 정도로 가까워졌습니다. 맨눈으로 보면 두 행성이 겹쳐져 하나의 별처럼 보이는데요. 지난 21일 이후 목성과 토성의 대근접은 2080년 3월 15일로 예측됩니다. 과천과학관 측은 우리가 대근접을 볼 수 있는 기회는 이번이 처음이자 마지막이 될 가능성이 크다라고 설명했 습니다.'
</pre>

```python
# supports various decoding strategies 
abs_summ(
    input_text2, 
    beam=5, 
    len_penalty=0.6,
    no_repeat_ngram_size=3,
    top_k=50,
    top_p=0.7
)
```

<pre>
'천과과천과학관 등 천문학계에 따르면 21일 저녁 목성과 토성은 1623년 이후 397년 만에 약 400년 만에 가장 가까워졌으며 2080년 3월 15일은 될 것으로 예측된다.'
</pre>
### 3개의 주요 문장 추출



```python
output_text1 = ext_summ(input_text1)
for line in output_text1.split('.'):
    print(line)
```

<pre>
2004년 SM에서 주최한 청소년 베스트 선발 대회에서 노래짱 대상을 수상하며 SM 엔터테인먼트에 캐스팅되었다
 이후 태연은 2004년 8월에 열린 제8회 SM 청소년 베스트 선발 대회에서 노래짱 부문에 출전해 1위(대상)를 수상하였고 SM 엔터테인먼트에 정식 캐스팅되어 연습생 생활을 시작하게 되었다
 이후 SM엔터테인먼트에서 3년여의 연습생 기간을 거쳐 걸 그룹 소녀시대의 멤버로 정식 데뷔하게 되었다

</pre>

```python
output_text2 = ext_summ(input_text2)
for line in output_text2.split('.'):
    print(line)
```

<pre>
국립과천과학관 등 천문학계에 따르면 21일 저녁 목성과 토성은 1623년 이후 397년 만에 가장 가까워졌는데요
 크리스마스 즈음까지 남서쪽 하늘을 올려다보면 목성과 토성이 가까워지는 현상을 관측할 수 있습니다
 지난 21일 이후 목성과 토성의 대근접은 2080년 3월 15일로 예측됩니다

</pre>
### Bullet 포인트



```python
# supports various decoding strategies 
bullet_summ(
    input_text1, 
    beam=5, 
    len_penalty=0.6,
    no_repeat_ngram_size=3,
    top_k=50,
    top_p=0.7
)
```

<pre>
['태연, 2004년 청소년 베스트 선발 대회 노래짱 대상 수상', ' 이후 SM 엔터테인먼트에 캐스팅되어 연습생 생활 시작']
</pre>
### 신문기사 요약



```python
# 신문기사의 URL
url = 'https://news.naver.com/main/read.naver?mode=LSD&mid=shm&sid1=101&oid=009&aid=0004886133'
```

뉴스 기사 내용 받아오기



```python
from bs4 import BeautifulSoup
import requests

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"}
req = requests.get(url, headers=headers)
soup = BeautifulSoup(req.text, 'html.parser')
body = soup.find_all(id='articleBodyContents')
body[0].text
```

<pre>
'\n\n\n\n\n// flash 오류를 우회하기 위한 함수 추가\nfunction _flash_removeCallback() {}\n\n\t\n\t◆ 삼성 인사제도 혁신 ◆삼성전자가 \'이재용의 뉴 삼성\'을 뒷받침하는 인사 혁신을 단행했다. 직급별 표준 체류기간과 승격 포인트를 폐지해 과감한 발탁 승진이 가능하도록 한 것이 특징이다. 삼성전자는 29일 연공서열을 타파하 는 인사 제도 혁신안을 마련하고 내년부터 시행한다고 밝혔다. 젊은 경영진을 조기에 육성하는 삼성형 패스트트랙이 시행되면 30대 임원, 40대 최고경영자(CEO)가 탄생할 것으로 예상된다.직급표기 삭제·승진연한 폐지…삼성, 실리콘밸리식 조직 탈바꿈이재용의 \'뉴삼성\' 인사혁신직급 대신 전문성으로만 평가능력 있으면 빠르게 발탁 승진전무 없애고 부사장으로 통합제조업식 연공서열 문화 없애유연·수평적인 기업문화 구축다른부서 이동 \'사내FA\'로다양한 직무경험 기회 제공  이재용 삼성전자 부회장이 \'뉴 삼성\'을 선언한 뒤 처음으로 단행된 이번 삼성전자 인사제도 개편은 연공서열을 없애고 수평적이고 유연한 기업문화를 조성하는 것이 핵심이다. 삼성전자가 제조업에 총력을 기울이던 시기에 만들어진 기업문화를 세계적인 정보통신기술(ICT) 기업에 맞게 새롭게 개편하는 것이다. 이번 인사제도 혁신안에서 눈에 띄는 것은 삼성형 패스트트랙이다. 부사장·전무 직급을 부사장으로 통합해 임원 직급 단계를 축소하고 직급별 표준 체류기간이나 근무 연한을 없앤 것이 핵심이다. 여기에는 나이와 상관없이 젊고 유능한 인재를 발탁하고 능력 있는 경영자를 조기에 배출하겠다는 의지가 담겨 있다. 지난 9월 말 기준 삼성전자 임원은 모두 1080명이다. 이 가운데 부사장은 67명, 전무는 129명이다. 부사장·전무 직급을 통합하면 삼성전자에는 200여 명에 가까운 차기 최고경영자(CEO) 후보군이 생기게 된다.이경묵 서울대 경영대학원 교수는 "전무나 부사장 등 특정 직급과 연봉에 국한하지 않고 파격적으로 외부 인사를 스카우트할 수 있는 기반을 마련한 것"이라며 "인재 영입 전쟁에서 유리한 고지를 선점할 수 있게 됐다"고 말했다.특히 직급별 근무 연한을 폐지하는 대신 \'승격 세션\'을 도입해 젊은 임원 탄생 가능성도 높였다. 삼성전자 직급 제도는 CL(Career Level) 4단계로 이뤄져 있고 한 단계씩 올라가려면 8~10년이 걸린다. 앞으로 직급 연한이 사라지면 30대 임원이나 40대 CEO 배출도 가능해질 전망이다. 삼성전자는 이번 인사에서 임원뿐 아니라 일반 직원 평가체제도 바꿨다. 그동안 실시됐던 상대평가를 절대평가로 바꾸기로 했다. 절대평가를 원칙으로 하지만 5개 평가등급 가운데 최상위 등급인 EM을 줄 수 있는 한도는 10%로 제한하기로 했다. 절대평가에 따라 과거와 달리 정해진 상위 고과를 획득하기 위한 부서 내 과당경쟁은 줄어들고 협력은 늘어날 전망이다.삼성전자는 또 부서장 1인이 평가하는 체제를 보완해 경쟁보다는 임직원 협력을 강화하기 위해 동료 평가인 \'피어리뷰\'를 도입한다. 여기서 더 나아가 삼성은 직원 간에는 존댓말을 사용하기로 했다. 또 직급을 알 수 없도록 내부 직급 표기를 삭제해 서열화를 탈피하고 전문성으로만 평가받을 수 있게 했다.삼성전자는 직원들의 승진 허들뿐 아니라 부서 간 이동을 자유롭게 하면서 근무 환경 울타리도 없애기로 했다. 이번 개편을 통해 도입되는 \'사내 FA(Free Agent) 제도\'는 같은 부서에서 5년 이상 근무한 직원에게 다른 부서로 이동할 수 있는 자격을 부여한다. 한 분야에서만 경력을 쌓는 것이 아니라 다양한 직무 경험 기회를 줄 수 있다.해외와 국내법인 간 인력 교류도 자유로워진다. \'STEP(Samsung Talent Exchange Program) 제도\'를 새롭게 도입하고 국내와 해외법인의 젊고 우수한 인력을 선발해 교환 근무하는 시스템을 만들었다. 이 교수는 "최근 스타트업(창업 초기 기업)이 스톡옵션과 같은 파격적인 대우를 제시해 대기업에서 이탈하는 젊은 인재가 많았다"며 "이번 개편으로 빠르게 내부 승진이 가능해지고 업무 간 장벽도 허물 수 있게 되면서 인재 유출을 막는 데 기여할 수 있을 것"이라고 평가했다.이번 개편은 MZ세대(밀레니얼·Z세대) 근무 환경 개선에만 초점을 맞춘 것이 아니다. 정년이 지난 숙련 근무자도 계속 회사에서 능력을 발휘할 수 있도록 했다. 이를 위해 정년 외에 \'시니어 트랙\'을 별도로 만든다. 현재 삼성은 직군별로 이르면 55세부터 임금을 일부 삭감하고 60세를 정년으로 은퇴하도록 돼 있다. 하지만 앞으로는 임원이 아니더라도 60세 이상이 시니어 트랙을 이용해 근무할 수 있게 된다.이 밖에 직원들이 업무에 몰입할 수 있도록 주요 거점에 공유오피스를 설치하고 사내 자율근무존을 마련한다. 삼성전자는 이번 인사제도 혁신안 도출을 위해 임직원 온라인 대토론회와 계층별 의견을 청취해왔다. 임원 직급 통합은 삼성그룹 내 다른 관계사도 검토 중인 것으로 알려졌다.\n\n'
</pre>

```python
abs_summ(
    body[0].text, 
    beam=5, 
    len_penalty=0.6,
    no_repeat_ngram_size=3,
    top_k=50,
    top_p=0.7
)
```

<pre>
"삼성전자는 삼성전자가 '뉴 삼성'을 선언한 뒤 직급별 표준 체류기간과 승격 포인트를 폐지해 과감한 발탁 승진이 가능하도록 한 인사 제도를 혁신안을 마련하고 내년부터 시행한다고 밝혔다."
</pre>

```python
def summerize_news(url):
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"}
    req = requests.get(url, headers=headers)
    soup = BeautifulSoup(req.text, 'html.parser')
    body = soup.find_all(id='articleBodyContents')
    if len(body) > 0:
        text = body[0].text
        output_bullet = bullet_summ(text, 
                                    beam=5, 
                                    len_penalty=0.6,
                                    no_repeat_ngram_size=3,
                                    top_k=50,
                                    top_p=0.7)
        summary_output = abs_summ(text, 
                                  beam=5, 
                                  len_penalty=0.6,
                                  no_repeat_ngram_size=3,
                                  top_k=50,
                                  top_p=0.7
                                  )
        print('[주요]')
        for line in output_bullet:
            print(f'- {line}')
        print('[요약]')
        print(summary_output)
    else:
        return "에러ㅜ"
```


```python
summerize_news('https://news.naver.com/main/read.naver?mode=LSD&mid=shm&sid1=101&oid=009&aid=0004886133')
```

<pre>
[주요]
- 연공서열 타파 인사혁신안 마련
-  30대 임원·40대 최고경영자 탄생 예상
[요약]
삼성전자는 삼성전자가 '뉴 삼성'을 선언한 뒤 직급별 표준 체류기간과 승격 포인트를 폐지해 과감한 발탁 승진이 가능하도록 한 인사 제도를 혁신안을 마련하고 내년부터 시행한다고 밝혔다.
</pre>
## 맞춤법 수정 (Grammar Correction)


### 문법 오류 수정



```python
# 오류 문장 입력
gec("This apple are so sweet.")
```

<pre>
'This apple is so sweet.'
</pre>
### 한글 띄어쓰기 오류 수정



```python
# 오류 문장 입력
spacing("아버지가방에들어간다.")
```

<pre>
'아버지가 방에 들어간다.'
</pre>
## 기계번역 Machine Translation



```python
# mt = Pororo(task="translation", lang="multi")
mt("케빈은 아직도 일을 하고 있다.", src="ko", tgt="en")
```

<pre>
'Kevin is still working.'
</pre>
## 자동 에세이 채점 Automated Essay Scoring



```python
# aes = Pororo(task="aes", lang="en")
aes('''
The lecturer talks about research conducted by a firm that used the group system to handle their work. He says that the theory stated in the passage was very different and somewhat inaccurate when compared to what happened for real.
First, some members got free rides. That is, some didn’t work hard but gotrecognition for the success nontheless. This also indicates that people who worked hard was not given recognition they should have got. In other words, they weren’t given the oppotunity to “shine”. This derectly contradicts what the passage indicates.
Second, groups were slow in progress. The passage says that groups are nore responsive than individuals because of the number of people involved and their aggregated resources. However, the speaker talks about how the firm found out that groups were slower than individuals in dicision making. Groups needed more time for meetings, which are neccesary procceedures in decision making. This was another part where experience contradicted theory.
Third, influetial people might emerge, and lead the group towards glory or failure. If the influent people are going in the right direction there would be no problem. But in cases where they go in the wrong direction, there is nobody that has enough influence to counter the decision made. In other words, the group might turn into a dictatorship, with the influential party as the leader, and might be less flexible in thinking. They might become one-sided, and thus fail to succeed.
''')
```

<pre>
64.47
</pre>

```python
aes('''
Throw out the bottles and boxes of drugs in your house. A new theory suggests that medicine could be bad for your health, which should at least come as good news to people who cannot afford to buy expensive medicine. However, it is a blow to the medicine industry, and an even bigger blow to our confidence in the progress of science. This new theory argues that healing is at our fingertips: we can be healthy by doing Reiki on on a regular basis.
''')
```

<pre>
35.21
</pre>

```python
aes('''
Online games aren't just a diversion, but a unique way to meet other people. As millions of gamers demonstrate, playing online is about friendship and cooperation, not just killing monsters. These games are a viable social network because players focus on teamwork, form groups with like-minded people and have romantic relationships with other players. Massively Multiplayer Online Games (MMOGs) feature millions of players interacting in the same environment. The games are social in nature as they allow players to band together and complete missions based on a story line, or test their skills by fighting against each other. At the start of the game, the user creates a fictional character, and customizes its physical appearance. Since many games involve combat, players also outfit their characters with armor and weapons, as well as choose their "profession." Many popular game titles like World of Warcraft and Everquest follow a fantasy theme, so most professions have magical abilities like healing other players or raising undead minions. While the process seems simple, players may spend hours agonizing over the perfect look for their character, from their armor color to the type of skills to use in battle. Once their character is created, the player is free to explore the vast, digital world and interact with other players; however they must pay on average $15 a month for game content. MMOG users are mostly male - usually between the ages of 18-34 - although titles like World of Warcraft have a healthy population of female players as well. With millions of players, there are plenty of people to adventure with.
''')
```

<pre>
67.14
</pre>
## Fill in the blank



```python
fib("손흥민은 __의 축구선수이다.")
```

<pre>
['대한민국',
 '잉글랜드',
 '독일',
 '스웨덴',
 '네덜란드',
 '덴마크',
 '미국',
 '웨일스',
 '노르웨이',
 '벨기에',
 '프랑스',
 '국적',
 '일본',
 '한국']
</pre>

```python
fib("대한민국의 수도는 __이다.")
```

<pre>
['서울', '대한민국', '시', '광역시', '리', '베이징', '직할시', '평양직할시', '1', '부산']
</pre>
## 이미지 캡션 (Image Captioning)



```python
from IPython.display import Image
```


```python
url = 'https://i.pinimg.com/originals/b9/de/80/b9de803706fb2f7365e06e688b7cc470.jpg'
Image(url, width=750)

```

이미지 캡션 출력

```python
caption(url)
```

<pre>
'Two men sitting at a table with plates of food.'
</pre>


## 참고 Reference

- [https://github.com/kakaobrain/pororo](https://github.com/kakaobrain/pororo)

- [https://kakaobrain.github.io/pororo/](https://kakaobrain.github.io/pororo/)

