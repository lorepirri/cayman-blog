---
layout: page
title: "[Linux] Python(.py)을 가상환경(virtualenv)에서 주기별로 실행하기"
description: "[Linux] Python(.py)을 가상환경(virtualenv)에서 주기별로 실행하는 방법에 대하여 알아보도록 하겠습니다."
tags: [linux, crontab, python, virtualenv]
comments: true
published: true
categories: linux
redirect_from:
  - aws/python-가상환경-crontab-주기마다-실행
typora-copy-images-to: ..\images\2019-02-11
---



python으로 주기적으로 크롤링 작업을 하거나, 또는 기타 여러가지 상황때문에 .py 파일을 리눅스 환경에서 **주기적으로 실행**하고 싶은 경우가 있을 겁니다. 그리고 대부분 .py 파일별로 다른 가상환경에서 .py를 실행시켜야 하는 경우도 있을 겁니다.

그래서 이번에는 Linux 환경에서 가상환경을 포함하여 .py 파일을 실행할 수 있도록 **crontab**을 활용하여 어떻게 주기적으로 파일을 실행하는지 정리해보려 합니다.



### crontab 문법 (주기)



기본이 되는 **'*'** 만 잘 익히면 됩니다.

```bash
*        *        *       *        *
분(0-59) 시(0-23) 일(1-31) 월(1-12) 요일(0-7)
```

요일에서 **0 - 일요일**  입니다.



#### 예제

`test.py` 파일을 실행한다고 가정

command는 `python test.py` 

1. 매분 실행

   ```
   * * * * * python test.py
   ```

   

2. 1시간마다 실행

   ```
   * */1 * * * python test.py
   ```

   

3. 매시 10분에 실행

   ```
   10 * * * * python test.py
   ```

   

4. 매시 0, 10, 20, 30, 40, 50분에 실행

   ```
   0,10,20,30,40,50 * * * * python test.py
   ```

   

5. 5분마다 실행

   ```
   */5 * * * python test.py
   ```

   

6. 10일~15일, 1시, 5시, 9시에 15분마다 실행

   ```
   */15 1,5,9 10-15 * * python test.py
   ```

   



### crotab 기본 명령어



`crontab -e`  편집

`crontab -l`  리스트 보기

`crontab -r`  삭제 



### crontab으로 실행되는 파일의 로그 출력



```bash
#         명령어 파일이름 > 로그가 저장될 path 2>&1
* * * * * python test.py > /home/log/test.log 2>&1

#    [누적]     명령어 파일이름 >> 로그가 저장될 path 2>&1
* * * * * python test.py > /home/log/test.log 2>&1

#         로그 출력 안함
* * * * * python test.py > /dev/null 2>&1
```



### Anaconda 가상환경에서 .py 파일 실행



가상환경의 python을 먼저 입력해 주고 그 다음에는 .py 파일이 위치한 경로와 파일명을 적어줍니다.

```bash
# 매시 10분, (가상환경 경로)                     (파일 경로)
10 * * * * ~/anaconda3/envs/my_env/bin/python ~/workspace/test.py
```


