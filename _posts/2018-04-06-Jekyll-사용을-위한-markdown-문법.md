---
layout: page
title: "편안한 Jekyll 사용을 위한 마크다운(markdown) 문법"
description: "Github을 한다면 피해갈 수 없고, 편안한 Jekyll 사용을 위한 마크다운(markdown) 문법 간단 요약"
headline: 편안한 Jekyll 사용을 위한 마크다운(markdown) 문법
tags: [markdown, githubpages, syntax, md, jekyll]
comments: true
published: true
categories:
  - markdown
---

Github Pages 운용을 위해서는 **markdown** 문법에 대한 이해도가 요구되며, [[공통] 마크다운 markdown 작성법](https://gist.github.com/ihoneymon/652be052a0727ad59601)을 참고하여 작성하였습니다.

~~제가 주로 사용하는 Syntax 위주로 작성하였습니다.~~

## 1. Header & Sub-Header

### - Header
##### Syntax
	이것은 헤더입니다.
	===

##### Example
이것은 Header입니다.
===

### - Sub-Header
##### Syntax
	이것은 부제목입니다.
	---

##### Example
이것은 Sub-Header입니다.
---

### - H1 ~ H6 Tags

##### Syntax
	# H1입니다.
	## H2입니다.
	### H3입니다.
	#### H4입니다.
	##### H5입니다.
	###### H6입니다.


##### Example
# H1입니다.
## H2입니다.
### H3입니다.
#### H4입니다.
##### H5입니다.
###### H6입니다.

## 2. Links

링크를 넣고 싶은 경우는 2가지 방법이 있다. (첫번째 방법이 개인적으로 좀 특이했다..)

##### Syntax
	Link: [참조 키워드][링크변수]
	[링크변수]: WebAddress "Descriptions"

##### Example
Link: [구글로 이동][a]
[a]: https://google.com "Go google"

##### Syntax
	[구글로 이동](https://google.com)

##### Example
[구글로 이동](https://google.com)


## 3. BlockQuote

##### Syntax
	> 이것은 BlockQuote 입니다.
	> 이것은 BlockQuote 입니다.
		> 이것은 BlockQuote 입니다.
		> 이것은 BlockQuote 입니다.
		> 이것은 BlockQuote 입니다.
			> 이것은 BlockQuote 입니다.
			> 이것은 BlockQuote 입니다.
			> 이것은 BlockQuote 입니다.
			> 이것은 BlockQuote 입니다.

##### Example
> 이것은 BlockQuote 입니다.
> 
> 이것은 BlockQuote 입니다.
>> 이것은 BlockQuote 입니다.
>> 
>> 이것은 BlockQuote 입니다.
>> 
>> 이것은 BlockQuote 입니다.
>>> 이것은 BlockQuote 입니다.
>>> 
>>> 이것은 BlockQuote 입니다.
>>> 
>>> 이것은 BlockQuote 입니다.
>>> 
>>> 이것은 BlockQuote 입니다.

## 4. Ordered List

##### Syntax
	1. 순서가 있는 목록
	2. 순서가 있는 목록
	3. 순서가 있는 목록

##### Example
1. 순서가 있는 목록
2. 순서가 있는 목록
3. 순서가 있는 목록

## 5. Unordered List

##### Syntax
	* 순서가 없는 목록
	* 순서가 없는 목록
	* 순서가 없는 목록

	* 순서가 없는 목록
		* 순서가 없는 목록
			* 순서가 없는 목록

	+ 순서가 없는 목록
		- 순서가 없는 목록
			* 순서가 없는 목록

##### Example
* 순서가 없는 목록
* 순서가 없는 목록
* 순서가 없는 목록

* 순서가 없는 목록
	* 순서가 없는 목록
		* 순서가 없는 목록

+ 순서가 없는 목록
	- 순서가 없는 목록
		* 순서가 없는 목록


## 6. Code Block

### - General

##### Syntax
	<pre>코드 블락 열기 전 
	<code> 이곳에 코드를 삽입</code> 
	코드 블락 닫은 후</pre>

##### Example
<pre>코드 블락 열기 전 
	<code> 이곳에 코드를 삽입</code> 
코드 블락 닫은 후</pre>


### - Syntax Highlight

##### Syntax
	```python
	# change this code
	number = 10
	second_number = 10
	first_array = []
	second_array = [1,2,3]
	```

##### Example
```python
# change this code
number = 10
second_number = 10
first_array = []
second_array = [1,2,3]
```

## 7. Strikethrough (취소선)

##### Syntax
	~~ 이것은 취소선 입니다. ~~

##### Example
~~이것은 취소선 입니다.~~

## 8. Bold, Italic

##### Syntax
	[Italic]          * 강조와 기울임 *
	[Bold]           ** 강조와 기울임 **
	[Bold & Italic] *** 강조와 기울임 ***
	               **** 강조와 기울임 ****


*강조와 기울임*

**강조와 기울임**

***강조와 기울임***

****강조와 기울임****


## 9. Image

##### Syntax
	![Alt text]({{site.baseurl}}/images/logo.png)
	![Alt text]({{site.baseurl}}/images/logo.png "Optional title")

##### Example
![Alt text]({{site.baseurl}}/images/logo.png)
![Alt text]({{site.baseurl}}/images/logo.png "Optional title")







### #markdown #githubpages #syntax #md #jekyll
