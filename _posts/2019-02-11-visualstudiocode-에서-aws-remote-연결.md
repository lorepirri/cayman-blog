---
layout: page
title: "Visual Studio Code에서 ftp-simple 플러그인을 활용하여 AWS 인스턴스 code 원격(remote) 작업"
description: "Visual Studio Code에서 ftp-simple 플러그인을 활용하여 AWS 인스턴스 code 원격(remote) 작업하는 방법에 대하여 알아보도록 하겠습니다."
tags: [aws]
comments: true
published: true
categories: aws
typora-copy-images-to: ..\images\2019-02-11
---









요즘 AWS의 EC2인스턴스에 원격으로 작업할 일이 많아졌다. 기존에는 git에 소스코드를 push한 뒤 EC2인스턴스에서 업데이트 된 소스코드를 pull해서 작업하는 원시적인 방법을 사용했었다. 근데 **Visual Studio Code + ftp-simple** 플러그인을 활용하여 이 번거로움을 쉽게 해결할 수 있었다! 

즉, Visual Studio Code에서 sftp를 통해 Remote 접속을 하고 소스코드를 수정하면, 바로 적용이 가능하고, 브라우져를 통해 이를 바로 확인해 볼 수 있게 되었다.



### ftp-simple 플러그인 설치



자주쓰는 editor인 Visual Studio Code 기준으로 **ftp-simple** 플러그인을 설치해 보도록 하겠다. **atom** 에디터 또한 remote 서버를 ftp 연결해 주는 플러그인 또한 있고, 다음에는 atom 에디터 기준으로 플러그인 설치 및 셋팅 방법을 포스팅 해 보겠다.

그럼, 먼저 Visual Studio Code가 설치 되어 있다는 가정하에, ftp-simple 플러그인을 설치해보고, 셋팅하는 방법을 알아보자.

(windows 기준) Ctrl+Shift+X의 단축키를 입력하거나, 왼쪽 4번째 탭 (Extension)을 클릭하고, 상단 검색창에 ftp-simple 을 입력하면 플러그인이 뜬다.

**install** 버튼을 눌러 설치 해 주도록 하자.

설치가 완료되었다면, 다음과 같이 뜬다.



![1549780091754](C:\Users\Teddy-SAMSUNG\Documents\teddylee777.github.io\images\2019-02-11\1549780091754.png)

 



### ftp-simple Config 셋팅하기



Command Pallette (Ctrl+Shift+P)를 열고, **ftp-simple: Config** 라고 입력하면 setting 파일이 뜨게 된다.



![1549780336881](C:\Users\Teddy-SAMSUNG\Documents\teddylee777.github.io\images\2019-02-11\1549780336881.png)



먼저, windows 환겨에서 접속한다면, privatekey를 .ppk 파일로 변환하는 작업이 필요하다. 

이는 puttyGen에서 변환해주므로, .ppk 파일로 먼저 변환한 뒤 해당 경로를 잘 복사해 두자.



AWS 의 EC2 인스턴스가 2개일 경우, 다음과 같이 json 형태의 설정 값들을 list로 입력해 두면 자신이 remote workspace를 바꿔가면서 열 때 편하다. 

일단, test1과 test2 인스턴스를 임의로 셋팅해 봤다.

![1549780556553](C:\Users\Teddy-SAMSUNG\Documents\teddylee777.github.io\images\2019-02-11\1549780556553.png)



```json
[
	{
		"name": "test1",
		"host": "123,456,789,012",
		"port": 22,
		"type": "sftp",
		"username": "root",
		"password": "",
		"privateKey": "C:/Users/Teddy/Documents/my_aws_key/test1_key.ppk",
		"path": "/",
		"autosave": true,
		"confirm": true
	},
	{
		"name": "test2",
		"host": "111,222,333,444",
		"port": 22,
		"type": "sftp",
		"username": "root",
		"password": "",
		"privateKey": "C:/Users/Teddy/Documents/my_aws_key/test2_key.ppk",
		"path": "/",
		"autosave": true,
		"confirm": true
	}
]
```



**"name"** 필드에는 내가 임의로 입력한 remote 서버의 이름을 지정해주자.

**"host"** 필드에는 EC2 instance의 ip주소를 입력해주자.

**"port"** 에는 ssh 연결인 **22**를 입력해주자. AWS EC2 instance의 security group에서 22번 포트는 당연히 열어주었다고 가정하겠다.

**"username"**에 AWS에 연결할 계정을 입력해 주는데, ubuntu가 될 수도 있고, root계정으로 접속한다면 root가 되겠다

**"privatekey"**에는 .ppk파일의 경로를 입력해주면 된다. seperator는 윈도우(windows) 환경에서도 **'/'** 로 경로 구분을 해주면 된다.



### ftp-simple 에서 Workspace 오픈하기



앞선 단계까지 셋팅을 완료했다면, 다시 Command Pallette를 열고, Remote directory open to workspace를 선택하여, 해단 remote workspace를 열어주면 된다!



![1549781014549](C:\Users\Teddy-SAMSUNG\Documents\teddylee777.github.io\images\2019-02-11\1549781014549.png)



앞으로는 Visual Studio Code를 열고 remote workspace에서 직접 코드 수정을 하면, 로컬에서 git push한 다음에 AWS EC2 instance에서 pull해서 코드 업데이트를 하는 멍청한 번거로움은 없앨 수 있겠다.



##### #amazon_aws #ec2instance #ftpsimple #visual_studio_code