---
layout: page
title: "python django 프로젝트를 아마존(aws) ec2 인스턴스에 생성 및 원격접속"
description: "python django 프로젝트를 아마존(aws) ec2 인스턴스에 생성 및 원격접속 방법을 알아보겠습니다."
tags: [aws]
comments: true
published: true
categories: aws
typora-copy-images-to: ..\images\2019-02-10
---





python 으로 django 프로젝트를 생성해서 작업할 일이 생겼다. 로컬에서 작업하는 것보다 amazon aws에 ec2 인스턴스에 셋팅을 한 뒤에 Visual Studio Code의 ftp-simple 플러그인을 활용해서 remote workplace에서 작업을 해보기로 결정했다! 

~~원래 정석은 로컬에서 django 프로젝트를 작업한 뒤 amazon 서버 셋팅 후 정식으로 deploy하는 것이 올바른 방법이겠다..~~



### EC2 인스턴스에서 django 설치



django 패키지를 설치해야하는데, 가상환경을 설치하여 진행해 보도록 하겠다. 

<가상 환경 설치는 [Anaconda 가상환경설정 편](https://teddylee777.github.io/python/anaconda-%EA%B0%80%EC%83%81%ED%99%98%EA%B2%BD%EC%84%A4%EC%A0%95-%ED%8C%81-%EA%B0%95%EC%A2%8C) 를 참고하여 진행하면 되겠다>

```bash
conda create -n django_env
source activate django_env
```



가상 환경으로 진입했다면, django 패키지를 설치 해보자!

```bash
conda install -c anaconda django
```



django 설치를 완료했다면, sample_project를 생성하고, 해당 dir로 이동한다.

```bash
django-admin startproject sample_project
cd sample_project
```



여기까지 완료했다면, 인바인드 규칙 편집을 해준 뒤 runserver를 하기 위한 간단한 셋팅만 해주면 된다.



### 인바운드 규칙 편집



Security Group 에서 인바운드 규칙 설정을 잘 해줘야 한다.

우선, 

**80**포트와 **443** 포트는 **HTTP / HTTPS**를 위해 미리 설정해 둔 포트,

**22**포트는 **SSH** 연결을 위한 포트,

**8000**포트가 바로 **django**를 위해 열어둔 포트가 되겠다.



![1549751525114]({{site.baseurl}}\images\2019-02-10\1549751525114.png)



### django 프로젝트에서 ALLOWED_HOST 설정



django 프로젝트를 localhost에서 runserver를 하게 되면, EC2 instance 외에 <u>외부에서 접속이 안된다</u>!

그렇기 때문에, runserver를 할 때 ip 주소를 0.0.0.0.:8000이렇게 parameter 값을 넘겨서 runserver해야하고,

**settings.py에서 ALLOWED_HOST를 추가**해 줘야 한다!!



먼저, EC2인스턴스의 I.P. 주소를 잘 복사 해둔 다음에...



settings.py

```python
ALLOWED_HOSTS = ['110.123.456.789'] # EC2인스턴스 ip address
```



위와 같이, EC2인스턴스의 ip 주소를 추가해 주도록 한다.



### EC2 인스턴스에서 django 프로젝트 만들고 runserver



EC2 인스턴스에서 django 프로젝트의  manage.py가 있는 dir로 이동한 뒤, runserver 해준다.

```bash
python manage.py runserver 0.0.0.0:8000
```



그리고, 브라우져에서 EC2 instance의 ip 주소와 포트번호를 입력하면, django 프로젝트가 잘 떠있는 것을 볼 수 있다.



![1549752922963]({{site.baseurl}}\images\2019-02-10\1549752922963.png)





##### #amazon_aws #ec2instance #domain #django #python