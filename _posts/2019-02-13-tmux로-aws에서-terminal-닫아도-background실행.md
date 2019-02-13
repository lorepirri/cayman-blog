---
layout: page
title: "[Linux] tmux로 terminal을 닫아도 서비스 백그라운드 실행"
description: "tmux로 terminal을 닫아도 서비스 백그라운드 실행하는 방법에 대해 알아보겠습니다."
tags: [aws]
comments: true
published: true
categories: aws
typora-copy-images-to: ..\images\2019-02-11
---



django 서버를 임시로 AWS에서 띄워놓고 테스트하고자 할 때, AWS EC2 instance에 접속한 터미널을 닫더라도 계속 서버가 돌아가게끔 하고 싶을 때가 있습니다.

> Terminal에서 돌린 서버를 Terminal을 닫아도 유지하고 싶다

그렇다면, **tmux**가 좋은 해결책이 될 것 같습니다.



### tmux 문법



tmux 문법은 심플 합니다. (사용법이 복잡하지 않아요)

몇 가지만 기억한다면, service를 background 돌릴 때 매우 유용합니다.

여기서 **세션**은 '새로운 백그라운드 돌릴 서비스를 연다'로 이해하시면 됩니다.



새로운 세션을 시작:

`tmux` 

세션 이름을 'myname' **지정**하여 세션을 시작:

`tmux new -s myname`

마지막 세션 열기 (attach):

`tmux a `

'myname'이라는 이름의 세션 열기:

`tmux a -t myname`

돌고 있는 세션 리스트 보기:

`tmux ls`

'myname'이라는 이름의 세션 끝내기:

`tmux kill-session -t myname`



### tmux 단축키

`ctrl+b, $` 세션의 이름 rename

`ctrl+b, s` 세션 리스트 보기 (윈도우 이동시)

`ctrl+b, d` tmux 창에서 빠져나와 원래 터미널로 돌아가기





이 정도면, 가볍게 tmux를 활용하기에는 충분할 것 같습니다^^







##### #amazon_aws #ec2instance #linux #tmux