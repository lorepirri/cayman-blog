---
layout: page
title: "#04-Pandas(판다스) 통계"
description: "#04-Pandas(판다스) 통계에 대해 알아보겠습니다."
headline: "#04-Pandas(판다스) 통계에 대해 알아보겠습니다."
categories: pandas
tags: [python, pandas, dataframe, series, pandas tutorial, 통계, 판다스 자료구조, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-01-22
---

이번 에피소드에서는 Pandas 데이터프레임(DataFrame)의 가장 유용하면서 탐색적 데이터 분석(Exploratory Data Analysis)에서 가장 유용하게 사용되는 기능인 **통계** 입니다. 

`numpy`를 이미 익히셨다면, Pandas의 통계 함수를 사용함에 있어 크게 이질감이 없을 겁니다. 거의 사용방법이 같거든요.

왜냐하면 Pandas가 `numpy` 패키지 기반으로 만들어졌기 때문에 그렇습니다.

Pandas에서 제공하는 모든 통계 함수에 대해서는 굳이 알 필요없습니다. 자주 사용되는 **통계 함수**를 위주로 알아보겠습니다.

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="모듈-import">모듈 import</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">IPython.display</span> <span class="kn">import</span> <span class="n">Image</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">pandas</span> <span class="k">as</span> <span class="nn">pd</span>
<span class="kn">import</span> <span class="nn">seaborn</span> <span class="k">as</span> <span class="nn">sns</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="데이터셋-로드">데이터셋 로드</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span> <span class="o">=</span> <span class="n">sns</span><span class="o">.</span><span class="n">load_dataset</span><span class="p">(</span><span class="s1">'titanic'</span><span class="p">)</span>
<span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>survived</th>
<th>pclass</th>
<th>sex</th>
<th>age</th>
<th>sibsp</th>
<th>parch</th>
<th>fare</th>
<th>embarked</th>
<th>class</th>
<th>who</th>
<th>adult_male</th>
<th>deck</th>
<th>embark_town</th>
<th>alive</th>
<th>alone</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>22.0</td>
<td>1</td>
<td>0</td>
<td>7.2500</td>
<td>S</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
</tr>
<tr>
<th>1</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>38.0</td>
<td>1</td>
<td>0</td>
<td>71.2833</td>
<td>C</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
<td>False</td>
</tr>
<tr>
<th>2</th>
<td>1</td>
<td>3</td>
<td>female</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>7.9250</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
</tr>
<tr>
<th>3</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>35.0</td>
<td>1</td>
<td>0</td>
<td>53.1000</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Southampton</td>
<td>yes</td>
<td>False</td>
</tr>
<tr>
<th>4</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>35.0</td>
<td>0</td>
<td>0</td>
<td>8.0500</td>
<td>S</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>컬럼(columns) 설명</strong></p>
<ul>
<li>survivied: 생존여부 (1: 생존, 0: 사망)</li>
<li>pclass: 좌석 등급 (1등급, 2등급, 3등급)</li>
<li>sex: 성별</li>
<li>age: 나이</li>
<li>sibsp: 형제 + 배우자 수</li>
<li>parch: 부모 + 자녀 수</li>
<li>fare: 좌석 요금</li>
<li>embarked: 탑승 항구 (S, C, Q)</li>
<li>class: pclass와 동일</li>
<li>who: 성별과 동일</li>
<li>adult_male: 성인 남자 여부</li>
<li>deck: 데크 번호 (알파벳 + 숫자 혼용)</li>
<li>embark_town: 탑승 항구 이름</li>
<li>alive: 생존여부 (yes, no)</li>
<li>alone: 혼자 탑승 여부</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h1 id="통계">통계</h1><p><strong>통계</strong>는 데이터 분석에서 굉장히 <strong>중요한 요소</strong>입니다.</p>
<p>데이터에 대한 통계 계산식을 Pandas 함수로 제공하기 때문에 어렵지 않게 통계 값을 산출할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="describe()---요약통계">describe() - 요약통계</h2><p>전반적인 주요 통계를 확인할 수 있습니다.</p>
<p>기본 값으로 <strong>수치형(Numerical) 컬럼</strong>에 대한 통계표를 보여줍니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li><strong>count</strong>: 데이터 개수</li>
<li><strong>mean</strong>: 평균</li>
<li><strong>std</strong>: 표준편차</li>
<li><strong>min</strong>: 최솟값</li>
<li><strong>max</strong>: 최대값</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">describe</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>survived</th>
<th>pclass</th>
<th>age</th>
<th>sibsp</th>
<th>parch</th>
<th>fare</th>
</tr>
</thead>
<tbody>
<tr>
<th>count</th>
<td>891.000000</td>
<td>891.000000</td>
<td>714.000000</td>
<td>891.000000</td>
<td>891.000000</td>
<td>891.000000</td>
</tr>
<tr>
<th>mean</th>
<td>0.383838</td>
<td>2.308642</td>
<td>29.699118</td>
<td>0.523008</td>
<td>0.381594</td>
<td>32.204208</td>
</tr>
<tr>
<th>std</th>
<td>0.486592</td>
<td>0.836071</td>
<td>14.526497</td>
<td>1.102743</td>
<td>0.806057</td>
<td>49.693429</td>
</tr>
<tr>
<th>min</th>
<td>0.000000</td>
<td>1.000000</td>
<td>0.420000</td>
<td>0.000000</td>
<td>0.000000</td>
<td>0.000000</td>
</tr>
<tr>
<th>25%</th>
<td>0.000000</td>
<td>2.000000</td>
<td>20.125000</td>
<td>0.000000</td>
<td>0.000000</td>
<td>7.910400</td>
</tr>
<tr>
<th>50%</th>
<td>0.000000</td>
<td>3.000000</td>
<td>28.000000</td>
<td>0.000000</td>
<td>0.000000</td>
<td>14.454200</td>
</tr>
<tr>
<th>75%</th>
<td>1.000000</td>
<td>3.000000</td>
<td>38.000000</td>
<td>1.000000</td>
<td>0.000000</td>
<td>31.000000</td>
</tr>
<tr>
<th>max</th>
<td>1.000000</td>
<td>3.000000</td>
<td>80.000000</td>
<td>8.000000</td>
<td>6.000000</td>
<td>512.329200</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>문자열 컬럼에 대한 통계표</strong>도 확인할 수 있습니다.</p>
<ul>
<li><strong>count</strong>: 데이터 개수</li>
<li><strong>unique</strong>: 고유 데이터의 값 개수</li>
<li><strong>top</strong>: 가장 많이 출현한 데이터 개수</li>
<li><strong>freq</strong>: 가장 많이 출현한 데이터의 빈도수</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">describe</span><span class="p">(</span><span class="n">include</span><span class="o">=</span><span class="s1">'object'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>sex</th>
<th>embarked</th>
<th>who</th>
<th>embark_town</th>
<th>alive</th>
</tr>
</thead>
<tbody>
<tr>
<th>count</th>
<td>891</td>
<td>889</td>
<td>891</td>
<td>889</td>
<td>891</td>
</tr>
<tr>
<th>unique</th>
<td>2</td>
<td>3</td>
<td>3</td>
<td>3</td>
<td>2</td>
</tr>
<tr>
<th>top</th>
<td>male</td>
<td>S</td>
<td>man</td>
<td>Southampton</td>
<td>no</td>
</tr>
<tr>
<th>freq</th>
<td>577</td>
<td>644</td>
<td>537</td>
<td>644</td>
<td>549</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="count()---개수">count() - 개수</h2><p>데이터의 개수</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># DataFrame 전체의 개수를 구하는 경우</span>
<span class="n">df</span><span class="o">.</span><span class="n">count</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived       891
pclass         891
sex            891
age            714
sibsp          891
parch          891
fare           891
embarked       889
class          891
who            891
adult_male     891
deck           203
embark_town    889
alive          891
alone          891
dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 단일 column의 데이터 개수를 구하는 경우</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">count</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>714</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="mean()---평균">mean() - 평균</h2><p>데이터의 <strong>평균</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># DataFrame 평균</span>
<span class="n">df</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived       0.383838
pclass         2.308642
age           29.699118
sibsp          0.523008
parch          0.381594
fare          32.204208
adult_male     0.602694
alone          0.602694
dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># Column 평균</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>29.69911764705882</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Mean---조건별-평균">Mean - 조건별 평균</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>성인 남성의 나이의 평균 구하기</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">condition</span> <span class="o">=</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s1">'adult_male'</span><span class="p">]</span> <span class="o">==</span> <span class="kc">True</span><span class="p">)</span>
<span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">condition</span><span class="p">,</span> <span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>33.17312348668281</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="연습문제">연습문제</h3><p>다음 조건을 만족하는 승객의 <strong>나이 평균</strong>과 조건을 만족하는 <strong>데이터의 개수</strong>를 구하세요.</p>
<ul>
<li><code>fare</code>를 30 이상 40 미만 지불한 승객</li>
<li><code>pclass</code>는 1등급</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>survived</th>
<th>pclass</th>
<th>sex</th>
<th>age</th>
<th>sibsp</th>
<th>parch</th>
<th>fare</th>
<th>embarked</th>
<th>class</th>
<th>who</th>
<th>adult_male</th>
<th>deck</th>
<th>embark_town</th>
<th>alive</th>
<th>alone</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>22.0</td>
<td>1</td>
<td>0</td>
<td>7.2500</td>
<td>S</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
</tr>
<tr>
<th>1</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>38.0</td>
<td>1</td>
<td>0</td>
<td>71.2833</td>
<td>C</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
<td>False</td>
</tr>
<tr>
<th>2</th>
<td>1</td>
<td>3</td>
<td>female</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>7.9250</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
</tr>
<tr>
<th>3</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>35.0</td>
<td>1</td>
<td>0</td>
<td>53.1000</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Southampton</td>
<td>yes</td>
<td>False</td>
</tr>
<tr>
<th>4</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>35.0</td>
<td>0</td>
<td>0</td>
<td>8.0500</td>
<td>S</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 코드를 입력해 주세요 (데이터 개수 구하기)</span>
<span class="n">condition1</span> <span class="o">=</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span> <span class="o">&gt;=</span> <span class="mi">30</span><span class="p">)</span> <span class="o">&amp;</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span> <span class="o">&lt;</span> <span class="mi">40</span><span class="p">)</span>
<span class="n">condition2</span> <span class="o">=</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s1">'pclass'</span><span class="p">]</span> <span class="o">==</span> <span class="mi">1</span><span class="p">)</span>

<span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">condition1</span> <span class="o">&amp;</span> <span class="n">condition2</span><span class="p">,</span> <span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">count</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>21</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 코드를 입력해 주세요 (나이 평균 구하기)</span>
<span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">condition1</span> <span class="o">&amp;</span> <span class="n">condition2</span><span class="p">,</span> <span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>44.095238095238095</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="skipna=True-옵션"><code>skipna=True</code> 옵션</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>기술 통계 함수에서는 <code>skipna=True</code>가 <strong>기본으로 설정</strong> 되어 있습니다.</p>
<p>만약, <code>skipna=False</code>로 설정하게 된다면, <strong>NaN 값이 있는 column은 NaN 값으로 출력</strong> 됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># skipna=False를 지정한 경우</span>
<span class="n">df</span><span class="o">.</span><span class="n">mean</span><span class="p">(</span><span class="n">skipna</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived       0.383838
pclass         2.308642
age                 NaN
sibsp          0.523008
parch          0.381594
fare          32.204208
adult_male     0.602694
alone          0.602694
dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># skipna=True를 지정한 경우</span>
<span class="n">df</span><span class="o">.</span><span class="n">mean</span><span class="p">(</span><span class="n">skipna</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived       0.383838
pclass         2.308642
age           29.699118
sibsp          0.523008
parch          0.381594
fare          32.204208
adult_male     0.602694
alone          0.602694
dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="median()---중앙값">median() - 중앙값</h2><p>데이터의 중앙 값을 출력 합니다. 데이터를 <strong>오름차순 정렬하여 중앙에 위치한 값</strong>입니다.</p>
<p>이상치(outlier)가 존재하는 경우, <code>mean()</code>보다 <code>median()</code>을 대표값으로 더 <strong>선호</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">Series</span><span class="p">([</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">])</span><span class="o">.</span><span class="n">median</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>3.0</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">Series</span><span class="p">([</span><span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">])</span><span class="o">.</span><span class="n">median</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>3.0</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>짝수</strong>개의 데이터가 있는 경우에는 <strong>가운데 2개 중앙 데이터의 평균 값을 출력</strong> 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">Series</span><span class="p">([</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">])</span><span class="o">.</span><span class="n">median</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>3.5</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>나이의 평균(mean)과 중앙값(median)은 약간의 <strong>차이가 있음</strong>을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s2">"나이 평균: {df['age'].mean():.5f}</span><span class="se">\n</span><span class="s2">나이 중앙값: {df['age'].median()}</span><span class="se">\n</span><span class="s2">차이: {df['age'].mean() - df['age'].median():.5f}"</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>나이 평균: 29.69912
나이 중앙값: 28.0
차이: 1.69912
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="sum()---합계">sum() - 합계</h2><p>데이터의 <strong>합계</strong>입니다. 문자열 column은 모든 데이터가 붙어서 출력될 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived                                                    342
pclass                                                     2057
sex           malefemalefemalefemalemalemalemalemalefemalefe...
age                                                     21205.2
sibsp                                                       466
parch                                                       340
fare                                                    28693.9
class         ThirdFirstThirdFirstThirdThirdFirstThirdThirdS...
who           manwomanwomanwomanmanmanmanchildwomanchildchil...
adult_male                                                  537
alive         noyesyesyesnonononoyesyesyesyesnononoyesnoyesn...
alone                                                       537
dtype: object</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>단일 column에 대한 <strong>합계 출력</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>28693.9493</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="cumsum()---누적합,-cumprod()---누적곱">cumsum() - 누적합, cumprod() - 누적곱</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>누적되는 합계를 구할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">cumsum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0         22.00
1         60.00
2         86.00
3        121.00
4        156.00
         ...   
886    21128.17
887    21147.17
888         NaN
889    21173.17
890    21205.17
Name: age, Length: 891, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>누적되는 곱도 구할 수 있으나, 일반적으로 <strong>값이 너무 커지므로 잘 활용하지는 않습니다.</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">cumprod</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="output_text output_subarea output_execute_result">
<pre>0            22.0
1           836.0
2         21736.0
3        760760.0
4      26626600.0
          ...    
886           inf
887           inf
888           NaN
889           inf
890           inf
Name: age, Length: 891, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="var()---분산">var() - 분산</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 평균</span>
<span class="n">fare_mean</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span><span class="o">.</span><span class="n">values</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>

<span class="c1"># 분산</span>
<span class="n">my_var</span> <span class="o">=</span> <span class="p">((</span><span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span><span class="o">.</span><span class="n">values</span> <span class="o">-</span> <span class="n">fare_mean</span><span class="p">)</span> <span class="o">**</span> <span class="mi">2</span><span class="p">)</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span> <span class="o">/</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span><span class="o">.</span><span class="n">count</span><span class="p">()</span> <span class="o">-</span> <span class="mi">1</span><span class="p">)</span>
<span class="n">my_var</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>2469.436845743116</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span><span class="o">.</span><span class="n">var</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>2469.436845743117</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="std()---표준편차">std() - 표준편차</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>분산(var)의 제곱근</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">np</span><span class="o">.</span><span class="n">sqrt</span><span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span><span class="o">.</span><span class="n">var</span><span class="p">())</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>49.693428597180905</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">np</span><span class="o">.</span><span class="n">sqrt</span><span class="p">(</span><span class="n">my_var</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>49.6934285971809</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="min()---최소값,-max()---최대값">min() - 최소값, max() - 최대값</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 최소값</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">min</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0.42</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 최대값</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">max</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>80.0</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="quantile()---분위">quantile() - 분위</h2><p><strong>Quantile이란 주어진 데이터를 동등한 크기로 분할하는 지점</strong>을 말합니다</p>
<p>10%의 경우 0.1을, 80%의 경우 0.8을 대입하여 값을 구합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 10% quantile</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">quantile</span><span class="p">(</span><span class="mf">0.1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>14.0</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 60% quantile</span>
<span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">quantile</span><span class="p">(</span><span class="mf">0.8</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>41.0</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="unique()---고유값,-nunique()---고유값-개수">unique() - 고유값, nunique() - 고유값 개수</h2><p>고유값과 고유값의 개수를 구하고자 할 때 사용합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>unique()</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">unique</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>array(['man', 'woman', 'child'], dtype=object)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>nunique()</strong>: 고유값의 개수를 출력합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">nunique</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>3</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="mode()---최빈값">mode() - 최빈값</h2><p>최빈값은 <strong>가장 많이 출현한 데이터</strong>를 의미합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">mode</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    man
dtype: object</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>카테고리형 데이터에도 적용 가능합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'deck'</span><span class="p">]</span><span class="o">.</span><span class="n">mode</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    C
Name: deck, dtype: category
Categories (7, object): [A, B, C, D, E, F, G]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="corr()---상관관계">corr() - 상관관계</h2><p><code>corr()</code>로 컬럼(column)별 <strong>상관관계</strong>를 확인할 수 있습니다.</p>
<ul>
<li><strong>-1~1 사이의 범위</strong>를 가집니다.</li>
<li><strong>-1에 가까울 수록 반비례</strong> 관계, <strong>1에 가까울수록 정비례</strong> 관계를 의미합니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">corr</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>survived</th>
<th>pclass</th>
<th>age</th>
<th>sibsp</th>
<th>parch</th>
<th>fare</th>
<th>adult_male</th>
<th>alone</th>
</tr>
</thead>
<tbody>
<tr>
<th>survived</th>
<td>1.000000</td>
<td>-0.338481</td>
<td>-0.077221</td>
<td>-0.035322</td>
<td>0.081629</td>
<td>0.257307</td>
<td>-0.557080</td>
<td>-0.203367</td>
</tr>
<tr>
<th>pclass</th>
<td>-0.338481</td>
<td>1.000000</td>
<td>-0.369226</td>
<td>0.083081</td>
<td>0.018443</td>
<td>-0.549500</td>
<td>0.094035</td>
<td>0.135207</td>
</tr>
<tr>
<th>age</th>
<td>-0.077221</td>
<td>-0.369226</td>
<td>1.000000</td>
<td>-0.308247</td>
<td>-0.189119</td>
<td>0.096067</td>
<td>0.280328</td>
<td>0.198270</td>
</tr>
<tr>
<th>sibsp</th>
<td>-0.035322</td>
<td>0.083081</td>
<td>-0.308247</td>
<td>1.000000</td>
<td>0.414838</td>
<td>0.159651</td>
<td>-0.253586</td>
<td>-0.584471</td>
</tr>
<tr>
<th>parch</th>
<td>0.081629</td>
<td>0.018443</td>
<td>-0.189119</td>
<td>0.414838</td>
<td>1.000000</td>
<td>0.216225</td>
<td>-0.349943</td>
<td>-0.583398</td>
</tr>
<tr>
<th>fare</th>
<td>0.257307</td>
<td>-0.549500</td>
<td>0.096067</td>
<td>0.159651</td>
<td>0.216225</td>
<td>1.000000</td>
<td>-0.182024</td>
<td>-0.271832</td>
</tr>
<tr>
<th>adult_male</th>
<td>-0.557080</td>
<td>0.094035</td>
<td>0.280328</td>
<td>-0.253586</td>
<td>-0.349943</td>
<td>-0.182024</td>
<td>1.000000</td>
<td>0.404744</td>
</tr>
<tr>
<th>alone</th>
<td>-0.203367</td>
<td>0.135207</td>
<td>0.198270</td>
<td>-0.584471</td>
<td>-0.583398</td>
<td>-0.271832</td>
<td>0.404744</td>
<td>1.000000</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>특정 컬럼에 대한 상관관계</strong>를 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">corr</span><span class="p">()[</span><span class="s1">'survived'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived      1.000000
pclass       -0.338481
age          -0.077221
sibsp        -0.035322
parch         0.081629
fare          0.257307
adult_male   -0.557080
alone        -0.203367
Name: survived, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>