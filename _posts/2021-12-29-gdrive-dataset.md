---
layout: page
title:  "Colab에서 구글 드라이브(Google Drive) 압축파일 다운로드 쉽게하기 (코드 3줄!)"
description: "Colab에서 구글 드라이브(Google Drive) 압축파일 다운로드 쉽게하는 방법에 대하여 알아보겠습니다."
headline: "Colab에서 구글 드라이브(Google Drive) 압축파일 다운로드 쉽게하는 방법에 대하여 알아보겠습니다."
categories: colab
tags: [python, 인공지능 책, 테디노트 책, 테디노트, 파이썬, 딥러닝 책 추천, 파이썬 책 추천, 머신러닝 책 추천, 파이썬 딥러닝 텐서플로, 텐서플로우 책 추천, 텐서플로 책, 인공지능 서적, data science, 데이터 분석, 딥러닝, 구글 드라이브, 폴더 다운로드]
comments: true
published: true
typora-copy-images-to: ../images/2021-12-29
---



데이콘(dacon.io) 경진대회 데이터셋은 아래 이미지와 같이 대부분 **구글 드라이브 download** 링크로 제공합니다.



![image-20211229221041120](../images/2021-12-29/image-20211229221041120.png)



Google Colab을 활용하시는 분들은 데이터셋 업로드 하실 때 번거로움을 느끼는 분도 있을껍니다.

(대부분 dataset.zip 파일을 다운로드 받은 후 Google Colab에 재 업로드하여 압축을 해제해야하는 작업을 수행해야합니다. 혹은 Google Drive 로부터 마운트를 할 수 도 있습니다)



그래서 간단한 google drive 링크로 데이터셋을 직접 다운로드 받는 **간단한 라이브러리 형태**로 만들었습니다.
**코드 몇 줄**이면 쉽게 다운받을 수 있습니다.



## STEP 1. 데이터셋 링크에서 `file_id` 추출하기

예를 들어: `https://drive.google.com/file/d/abcdefgABCDEFG1234567/view` 가 데이터셋 URL(혹은 구글 드라이브 URL)이라면

**abcdefgABCDEFG1234567** 이 위치가 **file_id** 입니다.



## STEP 2. gdrive_dataset 설치

Google Colab에서 다음의 명령어로 라이브러리를 설치합니다.

```python
# 라이브러리 설치
!pip install gdrive_dataset
```



## STEP 3. 파일 다운로드

```python
from gdrivedataset import loader

file_id = # 이곳에 file_id 를 입력
loader.load_from_google_drive(file_id)
```



> Google Colab에서 실행한 예시

![image-20211229222034411](../images/2021-12-29/image-20211229222034411.png)



> Google Colab의 data 폴더 하위에 데이터셋이 다운로드 받아졌습니다.

![image-20211229222129938](../images/2021-12-29/image-20211229222129938.png)



감사합니다.



### 참고 (References)

- [python 3.x 한글 압축 파일 풀기](https://gldmg.tistory.com/141)

