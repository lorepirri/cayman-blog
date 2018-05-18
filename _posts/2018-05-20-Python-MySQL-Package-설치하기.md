---
layout: page
title: "파이썬(Python) - MySQL 패키지 (Client) 설치"
description: "Python 용 MySQL 패키지 (Client) 설치"
headline: "Python 용 MySQL 패키지 (Client) 설치방법에 대해 알아보겠습니다."
tags: [python, MySQL, package, mysqlclient]
comments: true
published: true
categories:
  - python
---

Python(파이썬) 개발시 MySQL Client 설치 방법에 대해 알아보겠다.

나와 같은 경우는, remote PC에 설치된 MySQL DB 에 Client 로 붙어야하는데, 이때 필요한 패키지가 바로 이 포스팅에 소개할 **mysqlclient** 패키지 이다.

## [Windows] mysqlclient 패키지 설치

아나콘다 (Anaconda3)가 설치되어 있지 않다면, [여기](https://teddylee777.github.io/python/Python-%EA%B0%80%EC%83%81%ED%99%98%EA%B2%BD-%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0)를 참고하여 가상환경까지 셋팅 완료 후, 설치하도록 하자.

Anaconda3가 설치되었고, 가상환경도 셋팅된 상태라면 PowerShell 이나, cmd 창에서 아래 코드를 실행하면 된다.

<code>
conda install -c bioconda mysqlclient
</code>

## [Mac OS] Anaconda를 활용한 가상환경 설치 (Windows)

Pip를 이용해 간단히 설치해보자.

<code>
pip install mysqlclient
</code>

만약 다음과 같은 에러 발생시

<code>
IndexError: string index out of range
</code>

mysql_config의 위치를 찾고

<code>
$ which mysql_config
/usr/local/bin/mysql_config
</code>

해당의 내용을 찾은 뒤,

<code>
# Create options 
libs="-L$pkglibdir"
libs="$libs -l "
</code>

다음과 같이 바꿔준다

<code>
# Create options
libs="-L$pkglibdir"
libs="$libs -lmysqlclient -lssl -lcrypto"
</code>

>
>
>
>
>


### #python #mysqlclient #mysql
