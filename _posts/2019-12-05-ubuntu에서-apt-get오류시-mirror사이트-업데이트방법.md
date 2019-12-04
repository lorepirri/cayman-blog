---
layout: page
title: "ubuntu에서 패키지 설치시 mirror를 kakao로 변경하는 방법"
description: "ubuntu에서 패키지 설치시 mirror를 kakao로 변경하는 방법에 대하여 알아보겠습니다"
headline: "ubuntu에서 패키지 설치시 mirror를 kakao로 변경하는 방법"
tags: [ubuntu, mirror, kakao]
comments: true
published: true
categories: linux
typora-copy-images-to: ../images/2019-12-05
---



ubuntu 환경에서 패키지 설치시 (특히 apt-get을 이용한 패키지 설치시) 에러가 나는 경우가 있는데, 이는 보통 mirror 사이트를 변경해주는 것으로 해결할 수 있다.



## STEP 1. sources.list 파일 열기

```bash
sudo vi /etc/apt/sources.list
```



## STEP 2. Replace 를 활용하여 일괄 변경

Kakao에서 제공해주는 mirror 사이트로 변경해주도록 합니다.

**kakao mirror**: `mirror.kakao.com`



vi 혹은 vim 에디터에서 일괄 변경하는 방법은

`%s/(찾는 문자열)/(바꿀 문자열)`

입니다.



> 일괄 변경하기

```bash
:%s/kr.archive.ubuntu.com/mirror.kakao.com
```



변경 후 저장하고 닫습니다.

## STEP 3. apt-get 업데이트

apt-get 업데이트 명령어를 통해 package를 다시 다운로드 받습니다.

```bash
sudo apt-get update
```



<br>

<br>



<hr>


## 끝!



읽어 주셔서 감사합니다.



##### #ubuntu #mirror #kakao #apt-get