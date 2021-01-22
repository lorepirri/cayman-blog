---
layout: page
title: "에피소드#06 - Pandas 데이터 전처리, 추가, 삭제, 데이터 type 변환"
description: "에피소드#06 - 에피소드#06 - Pandas 데이터 전처리, 추가, 삭제, 데이터 type 변환 방법에 대해 알아보겠습니다."
headline: "에피소드#06 - 에피소드#06 - Pandas 데이터 전처리, 추가, 삭제, 데이터 type 변환 방법에 대해 알아보겠습니다."
categories: pandas
tags: [python, pandas, dataframe, series, pandas tutorial, 통계, 판다스 자료구조, 데이터 추가, 데이터 삭제, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-01-24
---

이번 에피소드에서는 Pandas DataFrame의 **row, column의 추가, 삭제, 컬럼간 연산, 타입의 변환 그리고 데이터 전처리 방법**에 대하여 다뤄 보도록 하겠습니다.

전처리 방법 파트에서는 `datetime` 데이터 타입을 활용하여 시간 데이터의 전처리 방법 그리고 Pandas에서 제공하는 유용한 기능에 대하여 알아보도록 하겠습니다.

타입 변환에서는 `to_numeric`을 사용하여 **수치형(numerical) 데이터로 변환하는 방법**과 자주 발생하는 오류에 대하여 알아보겠습니다.

그리고 마지막으로 `cut`과 `qcut`의 차이점에 대하여 살펴보고 이를 활용하여 **연속된 수치형 데이터를 binning 하여 카테고리화 하는 방법**에 대해서도 다뤄보겠습니다.


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
<h2 id="새로운-컬럼-추가">새로운 컬럼 추가</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">copy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<p>임의의 값을 <strong>대입</strong>하여 새로운 컬럼을 추가할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'VIP'</span><span class="p">]</span> <span class="o">=</span> <span class="kc">True</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>VIP</th>
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
<td>True</td>
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
<td>True</td>
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
<td>True</td>
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
<h2 id="삭제">삭제</h2><p>삭제는 <strong>행(row) 삭제와 열(column) 삭제</strong>로 구분할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="행-(row)-삭제">행 (row) 삭제</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>행 삭제시 <strong>index를 지정하여 삭제</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">drop</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
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
<th>VIP</th>
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
<td>True</td>
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
<td>True</td>
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
<td>True</td>
</tr>
<tr>
<th>5</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>8.4583</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.0000</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>887</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>19.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>B</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>888</th>
<td>0</td>
<td>3</td>
<td>female</td>
<td>NaN</td>
<td>1</td>
<td>2</td>
<td>23.4500</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
<td>True</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>C</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>890</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>32.0</td>
<td>0</td>
<td>0</td>
<td>7.7500</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
</tbody>
</table>
<p>890 rows × 16 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>행 삭제시 <strong>범위를 지정하여 삭제</strong>할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">drop</span><span class="p">(</span><span class="n">df1</span><span class="o">.</span><span class="n">index</span><span class="p">[</span><span class="mi">0</span><span class="p">:</span><span class="mi">10</span><span class="p">])</span>
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
<th>VIP</th>
</tr>
</thead>
<tbody>
<tr>
<th>10</th>
<td>1</td>
<td>3</td>
<td>female</td>
<td>4.0</td>
<td>1</td>
<td>1</td>
<td>16.7000</td>
<td>S</td>
<td>Third</td>
<td>child</td>
<td>False</td>
<td>G</td>
<td>Southampton</td>
<td>yes</td>
<td>False</td>
<td>True</td>
</tr>
<tr>
<th>11</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>58.0</td>
<td>0</td>
<td>0</td>
<td>26.5500</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>12</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>20.0</td>
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
<td>True</td>
</tr>
<tr>
<th>13</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>39.0</td>
<td>1</td>
<td>5</td>
<td>31.2750</td>
<td>S</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
<td>True</td>
</tr>
<tr>
<th>14</th>
<td>0</td>
<td>3</td>
<td>female</td>
<td>14.0</td>
<td>0</td>
<td>0</td>
<td>7.8542</td>
<td>S</td>
<td>Third</td>
<td>child</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.0000</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>887</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>19.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>B</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>888</th>
<td>0</td>
<td>3</td>
<td>female</td>
<td>NaN</td>
<td>1</td>
<td>2</td>
<td>23.4500</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
<td>True</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>C</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>890</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>32.0</td>
<td>0</td>
<td>0</td>
<td>7.7500</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
</tbody>
</table>
<p>881 rows × 16 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>fancy indexing</strong>을 활용하여 삭제할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">drop</span><span class="p">(</span><span class="n">df1</span><span class="o">.</span><span class="n">index</span><span class="p">[[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">7</span><span class="p">,</span> <span class="mi">9</span><span class="p">]])</span>
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
<th>VIP</th>
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
<td>True</td>
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
<td>True</td>
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
<td>True</td>
</tr>
<tr>
<th>6</th>
<td>0</td>
<td>1</td>
<td>male</td>
<td>54.0</td>
<td>0</td>
<td>0</td>
<td>51.8625</td>
<td>S</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>E</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>8</th>
<td>1</td>
<td>3</td>
<td>female</td>
<td>27.0</td>
<td>0</td>
<td>2</td>
<td>11.1333</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>yes</td>
<td>False</td>
<td>True</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.0000</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>887</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>19.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>B</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>888</th>
<td>0</td>
<td>3</td>
<td>female</td>
<td>NaN</td>
<td>1</td>
<td>2</td>
<td>23.4500</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
<td>True</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>C</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>890</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>32.0</td>
<td>0</td>
<td>0</td>
<td>7.7500</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
<td>no</td>
<td>True</td>
<td>True</td>
</tr>
</tbody>
</table>
<p>886 rows × 16 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="열-(column)-삭제">열 (column) 삭제</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>VIP</th>
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
<td>True</td>
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
<td>True</td>
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
<td>True</td>
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
<p>열 삭제시 <strong>반드시 <code>axis=1</code> 옵션을 지정</strong>해야 합니다. 2번째 위치에 지정시 <code>axis=</code>을 생략할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">drop</span><span class="p">(</span><span class="s1">'class'</span><span class="p">,</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>who</th>
<th>adult_male</th>
<th>deck</th>
<th>embark_town</th>
<th>alive</th>
<th>alone</th>
<th>VIP</th>
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
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
<td>True</td>
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
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
<td>False</td>
<td>True</td>
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
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
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
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Southampton</td>
<td>yes</td>
<td>False</td>
<td>True</td>
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
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">drop</span><span class="p">(</span><span class="s1">'class'</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>who</th>
<th>adult_male</th>
<th>deck</th>
<th>embark_town</th>
<th>alive</th>
<th>alone</th>
<th>VIP</th>
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
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
<td>True</td>
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
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
<td>False</td>
<td>True</td>
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
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
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
<td>woman</td>
<td>False</td>
<td>C</td>
<td>Southampton</td>
<td>yes</td>
<td>False</td>
<td>True</td>
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
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
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
<p><strong>다수의 컬럼(column) 삭제</strong>도 가능합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">drop</span><span class="p">([</span><span class="s1">'who'</span><span class="p">,</span> <span class="s1">'deck'</span><span class="p">,</span> <span class="s1">'alive'</span><span class="p">],</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
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
<th>adult_male</th>
<th>embark_town</th>
<th>alone</th>
<th>VIP</th>
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
<td>True</td>
<td>Southampton</td>
<td>False</td>
<td>True</td>
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
<td>False</td>
<td>Cherbourg</td>
<td>False</td>
<td>True</td>
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
<td>False</td>
<td>Southampton</td>
<td>True</td>
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
<td>False</td>
<td>Southampton</td>
<td>False</td>
<td>True</td>
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
<td>True</td>
<td>Southampton</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.0000</td>
<td>S</td>
<td>Second</td>
<td>True</td>
<td>Southampton</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>887</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>19.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>S</td>
<td>First</td>
<td>False</td>
<td>Southampton</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>888</th>
<td>0</td>
<td>3</td>
<td>female</td>
<td>NaN</td>
<td>1</td>
<td>2</td>
<td>23.4500</td>
<td>S</td>
<td>Third</td>
<td>False</td>
<td>Southampton</td>
<td>False</td>
<td>True</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.0000</td>
<td>C</td>
<td>First</td>
<td>True</td>
<td>Cherbourg</td>
<td>True</td>
<td>True</td>
</tr>
<tr>
<th>890</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>32.0</td>
<td>0</td>
<td>0</td>
<td>7.7500</td>
<td>Q</td>
<td>Third</td>
<td>True</td>
<td>Queenstown</td>
<td>True</td>
<td>True</td>
</tr>
</tbody>
</table>
<p>891 rows × 13 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>삭제된 내용을 바로 적용하려면 <code>inplace=True</code>를 지정합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">drop</span><span class="p">([</span><span class="s1">'who'</span><span class="p">,</span> <span class="s1">'deck'</span><span class="p">,</span> <span class="s1">'alive'</span><span class="p">],</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">inplace</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>adult_male</th>
<th>embark_town</th>
<th>alone</th>
<th>VIP</th>
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
<td>True</td>
<td>Southampton</td>
<td>False</td>
<td>True</td>
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
<td>False</td>
<td>Cherbourg</td>
<td>False</td>
<td>True</td>
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
<td>False</td>
<td>Southampton</td>
<td>True</td>
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
<td>False</td>
<td>Southampton</td>
<td>False</td>
<td>True</td>
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
<td>True</td>
<td>Southampton</td>
<td>True</td>
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
<h2 id="컬럼간-연산">컬럼간 연산</h2><p><strong>컬럼(column) 과 컬럼 사이의 연산을 매우 쉽게 적용</strong>할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">copy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>family(가족)</strong>의 총합은 <strong>sibsp</strong>컬럼과 <strong>parch</strong>의 합산으로 구할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'family'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'sibsp'</span><span class="p">]</span> <span class="o">+</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'parch'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>family</th>
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
<td>1</td>
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
<td>1</td>
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
<td>0</td>
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
<td>1</td>
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
<td>0</td>
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
<p><strong>문자열의 합 (이어붙히기)도 가능</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'gender'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span> <span class="o">+</span> <span class="s1">'-'</span> <span class="o">+</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'sex'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>family</th>
<th>gender</th>
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
<td>1</td>
<td>man-male</td>
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
<td>1</td>
<td>woman-female</td>
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
<td>0</td>
<td>woman-female</td>
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
<td>1</td>
<td>woman-female</td>
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
<td>0</td>
<td>man-male</td>
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
<p>컬럼간 연산시 <code>round()</code>를 사용하여 소수점 자릿수를 지정할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>round(숫자, 소수 몇 째자리)</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'round'</span><span class="p">]</span> <span class="o">=</span> <span class="nb">round</span><span class="p">(</span><span class="n">df1</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span> <span class="o">/</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">],</span> <span class="mi">2</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>family</th>
<th>gender</th>
<th>round</th>
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
<td>1</td>
<td>man-male</td>
<td>0.33</td>
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
<td>1</td>
<td>woman-female</td>
<td>1.88</td>
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
<td>0</td>
<td>woman-female</td>
<td>0.30</td>
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
<td>1</td>
<td>woman-female</td>
<td>1.52</td>
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
<td>0</td>
<td>man-male</td>
<td>0.23</td>
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
<p>연산시 1개의 컬럼이라도 <strong>NaN 값을 포함하고 있다면 결과는 NaN</strong> 이 됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">isnull</span><span class="p">(),</span> <span class="s1">'deck'</span><span class="p">:]</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>deck</th>
<th>embark_town</th>
<th>alive</th>
<th>alone</th>
<th>family</th>
<th>gender</th>
<th>round</th>
</tr>
</thead>
<tbody>
<tr>
<th>5</th>
<td>NaN</td>
<td>Queenstown</td>
<td>no</td>
<td>True</td>
<td>0</td>
<td>man-male</td>
<td>NaN</td>
</tr>
<tr>
<th>17</th>
<td>NaN</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
<td>0</td>
<td>man-male</td>
<td>NaN</td>
</tr>
<tr>
<th>19</th>
<td>NaN</td>
<td>Cherbourg</td>
<td>yes</td>
<td>True</td>
<td>0</td>
<td>woman-female</td>
<td>NaN</td>
</tr>
<tr>
<th>26</th>
<td>NaN</td>
<td>Cherbourg</td>
<td>no</td>
<td>True</td>
<td>0</td>
<td>man-male</td>
<td>NaN</td>
</tr>
<tr>
<th>28</th>
<td>NaN</td>
<td>Queenstown</td>
<td>yes</td>
<td>True</td>
<td>0</td>
<td>woman-female</td>
<td>NaN</td>
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
<h2 id="타입-변환-(astype)">타입 변환 (astype)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">copy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">info</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>&lt;class 'pandas.core.frame.DataFrame'&gt;
RangeIndex: 891 entries, 0 to 890
Data columns (total 15 columns):
survived       891 non-null int64
pclass         891 non-null int64
sex            891 non-null object
age            714 non-null float64
sibsp          891 non-null int64
parch          891 non-null int64
fare           891 non-null float64
embarked       889 non-null object
class          891 non-null category
who            891 non-null object
adult_male     891 non-null bool
deck           203 non-null category
embark_town    889 non-null object
alive          891 non-null object
alone          891 non-null bool
dtypes: bool(2), category(2), float64(2), int64(4), object(5)
memory usage: 80.6+ KB
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>int32</code>로 변경</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'pclass'</span><span class="p">]</span><span class="o">.</span><span class="n">astype</span><span class="p">(</span><span class="s1">'int32'</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    3
1    1
2    3
3    1
4    3
Name: pclass, dtype: int32</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>float32</code>로 변경</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'pclass'</span><span class="p">]</span><span class="o">.</span><span class="n">astype</span><span class="p">(</span><span class="s1">'float32'</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    3.0
1    1.0
2    3.0
3    1.0
4    3.0
Name: pclass, dtype: float32</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>object</code>로 변경</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'pclass'</span><span class="p">]</span><span class="o">.</span><span class="n">astype</span><span class="p">(</span><span class="s1">'str'</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    3
1    1
2    3
3    1
4    3
Name: pclass, dtype: object</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>category</code>로 변경.</p>
<p><code>category</code>로 변경시에는 Categories가 같이 출력 됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>man      537
woman    271
child     83
Name: who, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">dtype</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>dtype('O')</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">astype</span><span class="p">(</span><span class="s1">'category'</span><span class="p">)</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0      man
1    woman
2    woman
3    woman
4      man
Name: who, dtype: category
Categories (3, object): [child, man, woman]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>타입을 <code>category</code>로 변환했다면 <strong>.cat</strong>으로 접근하여 category 타입이 제공하는 <strong>attribute를 사용</strong>할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">astype</span><span class="p">(</span><span class="s1">'category'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">dtype</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>CategoricalDtype(categories=['child', 'man', 'woman'], ordered=False)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">cat</span><span class="o">.</span><span class="n">codes</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0      1
1      2
2      2
3      2
4      1
      ..
886    1
887    2
888    2
889    1
890    1
Length: 891, dtype: int8</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>카테고리 이름 변경</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="p">[</span><span class="s2">"Group (</span><span class="si">%s</span><span class="s2">)"</span> <span class="o">%</span> <span class="n">g</span> <span class="k">for</span> <span class="n">g</span> <span class="ow">in</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">cat</span><span class="o">.</span><span class="n">categories</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>['Group (child)', 'Group (man)', 'Group (woman)']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">cat</span><span class="o">.</span><span class="n">categories</span> <span class="o">=</span> <span class="p">[</span><span class="s2">"Group (</span><span class="si">%s</span><span class="s2">)"</span> <span class="o">%</span> <span class="n">g</span> <span class="k">for</span> <span class="n">g</span> <span class="ow">in</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">cat</span><span class="o">.</span><span class="n">categories</span><span class="p">]</span>
<span class="n">df1</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>Group (man)      537
Group (woman)    271
Group (child)     83
Name: who, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="datetime---날짜,-시간">datetime - 날짜, 시간</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="data_range">data_range</h3><p>주요 옵션 값</p>
<ul>
<li><strong>start</strong>: 시작 날짜</li>
<li><strong>end</strong>: 끝 날짜</li>
<li><strong>periods</strong>: 생성할 데이터 개수</li>
<li><strong>freq</strong>: 주기</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dates</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">date_range</span><span class="p">(</span><span class="s1">'20210101'</span><span class="p">,</span> <span class="n">periods</span><span class="o">=</span><span class="n">df</span><span class="o">.</span><span class="n">shape</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span> <span class="n">freq</span><span class="o">=</span><span class="s1">'15H'</span><span class="p">)</span>
<span class="n">dates</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(891,)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">copy</span><span class="p">()</span>
<span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<p><strong>date의 컬럼</strong>을 만들어 생성한 <strong>date 를 대입</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'date'</span><span class="p">]</span> <span class="o">=</span> <span class="n">dates</span>
<span class="n">df1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>date</th>
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
<td>2021-01-01 00:00:00</td>
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
<td>2021-01-01 15:00:00</td>
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
<td>2021-01-02 06:00:00</td>
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
<td>2021-01-02 21:00:00</td>
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
<td>2021-01-03 12:00:00</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">info</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>&lt;class 'pandas.core.frame.DataFrame'&gt;
RangeIndex: 891 entries, 0 to 890
Data columns (total 16 columns):
survived       891 non-null int64
pclass         891 non-null int64
sex            891 non-null object
age            714 non-null float64
sibsp          891 non-null int64
parch          891 non-null int64
fare           891 non-null float64
embarked       889 non-null object
class          891 non-null category
who            891 non-null object
adult_male     891 non-null bool
deck           203 non-null category
embark_town    889 non-null object
alive          891 non-null object
alone          891 non-null bool
date           891 non-null datetime64[ns]
dtypes: bool(2), category(2), datetime64[ns](1), float64(2), int64(4), object(5)
memory usage: 87.6+ KB
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>date</strong>의 컬럼에 <code>datetime64</code>라는 데이터 타입이 표기됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="datetime-타입">datetime 타입</h3><p><code>datetime</code> 타입에서는 <strong>dt</strong> 접근자로 다음과 같은 날짜 속성에 쉽게 접근할 수 있습니다.</p>
<p>Pandas의 <strong>dt (datetime) 날짜 관련 변수</strong>는 다음과 같습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><a href="https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DatetimeIndex.year.html">도큐먼트</a></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>pandas.Series.dt.year: 연도</li>
<li>pandas.Series.dt.month: 월</li>
<li>pandas.Series.dt.day: 일</li>
<li>pandas.Series.dt.hour: 시</li>
<li>pandas.Series.dt.minute: 분</li>
<li>pandas.Series.dt.second: 초</li>
<li>pandas.Series.dt.microsecond: micro 초</li>
<li>pandas.Series.dt.nanosecond: nano 초</li>
<li>pandas.Series.dt.week: 주</li>
<li>pandas.Series.dt.weekofyear: 연중 몇 째주</li>
<li>pandas.Series.dt.dayofweek: 요일</li>
<li>pandas.Series.dt.weekday: 요일 (dayofweek과 동일)</li>
<li>pandas.Series.dt.dayofyear: 연중 몇 번째 날</li>
<li>pandas.Series.dt.quarter: 분기</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 연도</span>
<span class="n">df1</span><span class="p">[</span><span class="s1">'date'</span><span class="p">]</span><span class="o">.</span><span class="n">dt</span><span class="o">.</span><span class="n">year</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    2021
1    2021
2    2021
3    2021
4    2021
Name: date, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 월</span>
<span class="n">df1</span><span class="p">[</span><span class="s1">'date'</span><span class="p">]</span><span class="o">.</span><span class="n">dt</span><span class="o">.</span><span class="n">month</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    1
1    1
2    1
3    1
4    1
Name: date, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 일</span>
<span class="n">df1</span><span class="p">[</span><span class="s1">'date'</span><span class="p">]</span><span class="o">.</span><span class="n">dt</span><span class="o">.</span><span class="n">day</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    1
1    1
2    2
3    2
4    3
Name: date, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>dayofweek</strong>는 숫자로 요일이 표기 됩니다.</p>
<ul>
<li>월요일: 0, 일요일: 6</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'date'</span><span class="p">]</span><span class="o">.</span><span class="n">dt</span><span class="o">.</span><span class="n">dayofweek</span><span class="o">.</span><span class="n">head</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0    4
1    4
2    5
3    5
4    6
5    0
6    0
7    1
8    2
9    2
Name: date, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="to_datetime">to_datetime</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># e notation 표현 방식 변경</span>
<span class="n">pd</span><span class="o">.</span><span class="n">options</span><span class="o">.</span><span class="n">display</span><span class="o">.</span><span class="n">float_format</span> <span class="o">=</span> <span class="s1">'</span><span class="si">{:.2f}</span><span class="s1">'</span><span class="o">.</span><span class="n">format</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>샘플용 <strong>서울시 공공자전거 데이터를 로드</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'http://bit.ly/seoul_bicycle'</span><span class="p">)</span>
<span class="n">df2</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대여일자</th>
<th>대여소번호</th>
<th>대여소명</th>
<th>대여구분코드</th>
<th>성별</th>
<th>연령대코드</th>
<th>이용건수</th>
<th>운동량</th>
<th>탄소량</th>
<th>이동거리</th>
<th>이용시간</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>Jan-20-2020</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_003</td>
<td>3</td>
<td>61.82</td>
<td>0.52</td>
<td>2230.00</td>
<td>75</td>
</tr>
<tr>
<th>1</th>
<td>Jan-20-2020</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_004</td>
<td>1</td>
<td>39.62</td>
<td>0.28</td>
<td>1220.00</td>
<td>15</td>
</tr>
<tr>
<th>2</th>
<td>Jan-20-2020</td>
<td>3</td>
<td>중랑센터</td>
<td>정기</td>
<td>M</td>
<td>AGE_005</td>
<td>3</td>
<td>430.85</td>
<td>4.01</td>
<td>17270.00</td>
<td>53</td>
</tr>
<tr>
<th>3</th>
<td>Jan-20-2020</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>일일(회원)</td>
<td>\N</td>
<td>AGE_005</td>
<td>2</td>
<td>1.79</td>
<td>0.02</td>
<td>90.00</td>
<td>33</td>
</tr>
<tr>
<th>4</th>
<td>Jan-20-2020</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>정기</td>
<td>F</td>
<td>AGE_003</td>
<td>1</td>
<td>4501.96</td>
<td>45.47</td>
<td>196010.00</td>
<td>64</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">info</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>&lt;class 'pandas.core.frame.DataFrame'&gt;
RangeIndex: 327231 entries, 0 to 327230
Data columns (total 11 columns):
대여일자      327231 non-null object
대여소번호     327231 non-null int64
대여소명      327231 non-null object
대여구분코드    327231 non-null object
성별        272841 non-null object
연령대코드     327231 non-null object
이용건수      327231 non-null int64
운동량       327231 non-null object
탄소량       327231 non-null object
이동거리      327231 non-null float64
이용시간      327231 non-null int64
dtypes: float64(1), int64(3), object(7)
memory usage: 27.5+ MB
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>대여일자</strong> 컬럼은 날짜 관련 컬럼처럼 보이나 <code>info()</code>는 object로 인식하였습니다.</p>
<p><code>datetime</code>타입으로 변경해야 .dt 접근자를 사용할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong><code>pd.to_datetime()</code></strong>: datetime type으로 변환합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">to_datetime</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'대여일자'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0        2020-01-20
1        2020-01-20
2        2020-01-20
3        2020-01-20
4        2020-01-20
            ...    
327226   2020-05-20
327227   2020-05-20
327228   2020-05-20
327229   2020-05-20
327230   2020-05-20
Name: 대여일자, Length: 327231, dtype: datetime64[ns]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>재대입하여 <strong>컬럼에 적용</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'대여일자'</span><span class="p">]</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">to_datetime</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'대여일자'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">info</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>&lt;class 'pandas.core.frame.DataFrame'&gt;
RangeIndex: 327231 entries, 0 to 327230
Data columns (total 11 columns):
대여일자      327231 non-null datetime64[ns]
대여소번호     327231 non-null int64
대여소명      327231 non-null object
대여구분코드    327231 non-null object
성별        272841 non-null object
연령대코드     327231 non-null object
이용건수      327231 non-null int64
운동량       327231 non-null object
탄소량       327231 non-null object
이동거리      327231 non-null float64
이용시간      327231 non-null int64
dtypes: datetime64[ns](1), float64(1), int64(3), object(6)
memory usage: 27.5+ MB
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>적용된 후 <code>.dt</code>접근자를 활용하여 datetime 속성에 접근할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'대여일자'</span><span class="p">]</span><span class="o">.</span><span class="n">dt</span><span class="o">.</span><span class="n">dayofweek</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0         0
1         0
2         0
3         0
4         0
         ..
327226    2
327227    2
327228    2
327229    2
327230    2
Name: 대여일자, Length: 327231, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'대여일자'</span><span class="p">]</span><span class="o">.</span><span class="n">dt</span><span class="o">.</span><span class="n">weekday</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0         0
1         0
2         0
3         0
4         0
         ..
327226    2
327227    2
327228    2
327229    2
327230    2
Name: 대여일자, Length: 327231, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'대여일자'</span><span class="p">]</span><span class="o">.</span><span class="n">dt</span><span class="o">.</span><span class="n">dayofweek</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0         0
1         0
2         0
3         0
4         0
         ..
327226    2
327227    2
327228    2
327229    2
327230    2
Name: 대여일자, Length: 327231, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="pd.to_numeric()---수치형-변환">pd.to_numeric() - 수치형 변환</h2><p>object나 numerical type이 아닌 컬럼을 <strong>수치형(numerical) 컬럼으로 변환</strong>할 때 사용합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대여일자</th>
<th>대여소번호</th>
<th>대여소명</th>
<th>대여구분코드</th>
<th>성별</th>
<th>연령대코드</th>
<th>이용건수</th>
<th>운동량</th>
<th>탄소량</th>
<th>이동거리</th>
<th>이용시간</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_003</td>
<td>3</td>
<td>61.82</td>
<td>0.52</td>
<td>2230.00</td>
<td>75</td>
</tr>
<tr>
<th>1</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_004</td>
<td>1</td>
<td>39.62</td>
<td>0.28</td>
<td>1220.00</td>
<td>15</td>
</tr>
<tr>
<th>2</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>정기</td>
<td>M</td>
<td>AGE_005</td>
<td>3</td>
<td>430.85</td>
<td>4.01</td>
<td>17270.00</td>
<td>53</td>
</tr>
<tr>
<th>3</th>
<td>2020-01-20</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>일일(회원)</td>
<td>\N</td>
<td>AGE_005</td>
<td>2</td>
<td>1.79</td>
<td>0.02</td>
<td>90.00</td>
<td>33</td>
</tr>
<tr>
<th>4</th>
<td>2020-01-20</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>정기</td>
<td>F</td>
<td>AGE_003</td>
<td>1</td>
<td>4501.96</td>
<td>45.47</td>
<td>196010.00</td>
<td>64</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">info</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>&lt;class 'pandas.core.frame.DataFrame'&gt;
RangeIndex: 327231 entries, 0 to 327230
Data columns (total 11 columns):
대여일자      327231 non-null datetime64[ns]
대여소번호     327231 non-null int64
대여소명      327231 non-null object
대여구분코드    327231 non-null object
성별        272841 non-null object
연령대코드     327231 non-null object
이용건수      327231 non-null int64
운동량       327231 non-null object
탄소량       327231 non-null object
이동거리      327231 non-null float64
이용시간      327231 non-null int64
dtypes: datetime64[ns](1), float64(1), int64(3), object(6)
memory usage: 27.5+ MB
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>운동량</strong> 컬럼은 숫자형 컬럼 처럼 보이지만, <strong>object 타입으로 지정</strong>되어 있습니다.</p>
<p>종종 이런 현상이 발생하는데, 이런 현상을 만들어낸 이유는 분명 존재합니다!</p>
<p>원인 파악을 위해서 일단 <code>pd.to_numeric()</code>으로 <strong>변환을 시도</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">to_numeric</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_text output_error">
<pre>
<span class="ansi-red-fg">---------------------------------------------------------------------------</span>
<span class="ansi-red-fg">ValueError</span>                                Traceback (most recent call last)
<span class="ansi-green-fg">pandas/_libs/lib.pyx</span> in <span class="ansi-cyan-fg">pandas._libs.lib.maybe_convert_numeric</span><span class="ansi-blue-fg">()</span>

<span class="ansi-red-fg">ValueError</span>: Unable to parse string "\N"

During handling of the above exception, another exception occurred:

<span class="ansi-red-fg">ValueError</span>                                Traceback (most recent call last)
<span class="ansi-green-fg">&lt;ipython-input-172-39aff29f75a7&gt;</span> in <span class="ansi-cyan-fg">&lt;module&gt;</span>
<span class="ansi-green-fg">----&gt; 1</span><span class="ansi-red-fg"> </span>pd<span class="ansi-blue-fg">.</span>to_numeric<span class="ansi-blue-fg">(</span>df2<span class="ansi-blue-fg">[</span><span class="ansi-blue-fg">'운동량'</span><span class="ansi-blue-fg">]</span><span class="ansi-blue-fg">)</span>

<span class="ansi-green-fg">/opt/conda/lib/python3.6/site-packages/pandas/core/tools/numeric.py</span> in <span class="ansi-cyan-fg">to_numeric</span><span class="ansi-blue-fg">(arg, errors, downcast)</span>
<span class="ansi-green-intense-fg ansi-bold">    149</span>             coerce_numeric <span class="ansi-blue-fg">=</span> errors <span class="ansi-green-fg">not</span> <span class="ansi-green-fg">in</span> <span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">"ignore"</span><span class="ansi-blue-fg">,</span> <span class="ansi-blue-fg">"raise"</span><span class="ansi-blue-fg">)</span>
<span class="ansi-green-intense-fg ansi-bold">    150</span>             values = lib.maybe_convert_numeric(
<span class="ansi-green-fg">--&gt; 151</span><span class="ansi-red-fg">                 </span>values<span class="ansi-blue-fg">,</span> set<span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">)</span><span class="ansi-blue-fg">,</span> coerce_numeric<span class="ansi-blue-fg">=</span>coerce_numeric
<span class="ansi-green-intense-fg ansi-bold">    152</span>             )
<span class="ansi-green-intense-fg ansi-bold">    153</span> 

<span class="ansi-green-fg">pandas/_libs/lib.pyx</span> in <span class="ansi-cyan-fg">pandas._libs.lib.maybe_convert_numeric</span><span class="ansi-blue-fg">()</span>

<span class="ansi-red-fg">ValueError</span>: Unable to parse string "\N" at position 2344</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>2344 position</strong>에 무언가 에러가 발생하였습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="mi">2344</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>대여일자      2020-01-20 00:00:00
대여소번호                     165
대여소명              165. 중앙근린공원
대여구분코드                 일일(회원)
성별                         \N
연령대코드                 AGE_003
이용건수                        1
운동량                        \N
탄소량                        \N
이동거리                     0.00
이용시간                       40
Name: 2344, dtype: object</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>운동량에 숫자형이 아닌 개행 (\N)이 들어가 있기 때문에 이러한 에러가 발생하였습니다.</p>
<p>숫자형으로 바꿀 때 <strong>NaN값이나 숫자로 변환이 불가능한 문자열이 존재할 때 변환에 실패</strong>하게 됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>errors=</code> 옵션 값을 바꾸어 해결할 수 있습니다.</p>
<p>errors : {'ignore', 'raise', 'coerce'}, default 'raise'</p>
<pre><code>- If 'raise', then invalid parsing will raise an exception
- If 'coerce', then invalid parsing will be set as NaN
- If 'ignore', then invalid parsing will return the input</code></pre>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>errors='coerce'</code>로 지정하면 잘못된 문자열은 <strong>NaN 값으로 치환하여 변환</strong>합니다.</p>
<p>그리고, 결과 확인시 잘 변환이 된 것을 볼 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">to_numeric</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">],</span> <span class="n">errors</span><span class="o">=</span><span class="s1">'coerce'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0          61.82
1          39.62
2         430.85
3           1.79
4        4501.96
           ...  
327226    689.57
327227      0.00
327228     19.96
327229     43.77
327230   4735.63
Name: 운동량, Length: 327231, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">to_numeric</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">],</span> <span class="n">errors</span><span class="o">=</span><span class="s1">'coerce'</span><span class="p">)</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="mi">2344</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>nan</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>errors='ignore'</code>로 지정하게 되면 잘못된 문자열이 숫자로 <strong>변환이 안되고 무시</strong>하기 때문에 전체 컬럼의 dtype이 <strong>object로 그대로 남아있습니다.</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">to_numeric</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">],</span> <span class="n">errors</span><span class="o">=</span><span class="s1">'ignore'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0           61.82
1           39.62
2          430.85
3            1.79
4         4501.96
           ...   
327226     689.57
327227          0
327228      19.96
327229      43.77
327230    4735.63
Name: 운동량, Length: 327231, dtype: object</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">to_numeric</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">],</span> <span class="n">errors</span><span class="o">=</span><span class="s1">'ignore'</span><span class="p">)</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="mi">2344</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'\\N'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>재대입까지 마무리 해야 DataFrame에 적용됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">]</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">to_numeric</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">],</span> <span class="n">errors</span><span class="o">=</span><span class="s1">'coerce'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">info</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>&lt;class 'pandas.core.frame.DataFrame'&gt;
RangeIndex: 327231 entries, 0 to 327230
Data columns (total 11 columns):
대여일자      327231 non-null datetime64[ns]
대여소번호     327231 non-null int64
대여소명      327231 non-null object
대여구분코드    327231 non-null object
성별        272841 non-null object
연령대코드     327231 non-null object
이용건수      327231 non-null int64
운동량       326830 non-null float64
탄소량       327231 non-null object
이동거리      327231 non-null float64
이용시간      327231 non-null int64
dtypes: datetime64[ns](1), float64(2), int64(3), object(5)
memory usage: 27.5+ MB
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="pd.cut()---구간-나누기(binning)">pd.cut() - 구간 나누기(binning)</h2><p>연속된 수치(continuous values)를 <strong>구간으로 나누어 카테고리화</strong> 할 때 사용합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대여일자</th>
<th>대여소번호</th>
<th>대여소명</th>
<th>대여구분코드</th>
<th>성별</th>
<th>연령대코드</th>
<th>이용건수</th>
<th>운동량</th>
<th>탄소량</th>
<th>이동거리</th>
<th>이용시간</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_003</td>
<td>3</td>
<td>61.82</td>
<td>0.52</td>
<td>2230.00</td>
<td>75</td>
</tr>
<tr>
<th>1</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_004</td>
<td>1</td>
<td>39.62</td>
<td>0.28</td>
<td>1220.00</td>
<td>15</td>
</tr>
<tr>
<th>2</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>정기</td>
<td>M</td>
<td>AGE_005</td>
<td>3</td>
<td>430.85</td>
<td>4.01</td>
<td>17270.00</td>
<td>53</td>
</tr>
<tr>
<th>3</th>
<td>2020-01-20</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>일일(회원)</td>
<td>\N</td>
<td>AGE_005</td>
<td>2</td>
<td>1.79</td>
<td>0.02</td>
<td>90.00</td>
<td>33</td>
</tr>
<tr>
<th>4</th>
<td>2020-01-20</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>정기</td>
<td>F</td>
<td>AGE_003</td>
<td>1</td>
<td>4501.96</td>
<td>45.47</td>
<td>196010.00</td>
<td>64</td>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">describe</span><span class="p">()</span>
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
<th>대여소번호</th>
<th>이용건수</th>
<th>운동량</th>
<th>이동거리</th>
<th>이용시간</th>
</tr>
</thead>
<tbody>
<tr>
<th>count</th>
<td>327231.00</td>
<td>327231.00</td>
<td>326830.00</td>
<td>327231.00</td>
<td>327231.00</td>
</tr>
<tr>
<th>mean</th>
<td>1288.41</td>
<td>23.62</td>
<td>6921.37</td>
<td>106881.09</td>
<td>752.81</td>
</tr>
<tr>
<th>std</th>
<td>1012.65</td>
<td>59.92</td>
<td>656482.34</td>
<td>463495.54</td>
<td>2647.38</td>
</tr>
<tr>
<th>min</th>
<td>3.00</td>
<td>1.00</td>
<td>0.00</td>
<td>0.00</td>
<td>0.00</td>
</tr>
<tr>
<th>25%</th>
<td>562.00</td>
<td>2.00</td>
<td>138.05</td>
<td>5290.00</td>
<td>66.00</td>
</tr>
<tr>
<th>50%</th>
<td>1204.00</td>
<td>6.00</td>
<td>601.71</td>
<td>22900.00</td>
<td>207.00</td>
</tr>
<tr>
<th>75%</th>
<td>1933.00</td>
<td>22.00</td>
<td>2481.17</td>
<td>93460.00</td>
<td>670.00</td>
</tr>
<tr>
<th>max</th>
<td>99999.00</td>
<td>7451.00</td>
<td>163936052.30</td>
<td>56709052.94</td>
<td>458960.00</td>
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
<p>운동량은 범위가 굉장히 넓습니다. <strong>최소값은 0인데, 최대값은 엄청 큰 값</strong>이 존재합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>어쨌든, 운동향을 기준으로 데이터를 10개 그룹으로 분류하고 싶습니다.</p>
<p><code>pd.cut()</code>을 활용하여 쉽게 그룹을 나눌 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<th>대여일자</th>
<th>대여소번호</th>
<th>대여소명</th>
<th>대여구분코드</th>
<th>성별</th>
<th>연령대코드</th>
<th>이용건수</th>
<th>운동량</th>
<th>탄소량</th>
<th>이동거리</th>
<th>이용시간</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_003</td>
<td>3</td>
<td>61.82</td>
<td>0.52</td>
<td>2230.00</td>
<td>75</td>
</tr>
<tr>
<th>1</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>일일(회원)</td>
<td>M</td>
<td>AGE_004</td>
<td>1</td>
<td>39.62</td>
<td>0.28</td>
<td>1220.00</td>
<td>15</td>
</tr>
<tr>
<th>2</th>
<td>2020-01-20</td>
<td>3</td>
<td>중랑센터</td>
<td>정기</td>
<td>M</td>
<td>AGE_005</td>
<td>3</td>
<td>430.85</td>
<td>4.01</td>
<td>17270.00</td>
<td>53</td>
</tr>
<tr>
<th>3</th>
<td>2020-01-20</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>일일(회원)</td>
<td>\N</td>
<td>AGE_005</td>
<td>2</td>
<td>1.79</td>
<td>0.02</td>
<td>90.00</td>
<td>33</td>
</tr>
<tr>
<th>4</th>
<td>2020-01-20</td>
<td>5</td>
<td>상암센터 정비실</td>
<td>정기</td>
<td>F</td>
<td>AGE_003</td>
<td>1</td>
<td>4501.96</td>
<td>45.47</td>
<td>196010.00</td>
<td>64</td>
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
<p><code>bins</code> 옵션에 나누고자 하는 <strong>구간의 개수</strong>를 설정합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량_cut'</span><span class="p">]</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">cut</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">],</span> <span class="n">bins</span><span class="o">=</span><span class="mi">10</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량_cut'</span><span class="p">]</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(-163936.052, 16393605.23]      326816
(98361631.38, 114755236.61]          9
(32787210.46, 49180815.69]           2
(147542447.07, 163936052.3]          1
(114755236.61, 131148841.84]         1
(16393605.23, 32787210.46]           1
(131148841.84, 147542447.07]         0
(81968026.15, 98361631.38]           0
(65574420.92, 81968026.15]           0
(49180815.69, 65574420.92]           0
Name: 운동량_cut, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>분포를 보니 첫 구간에 대부분의 데이터가 쏠려 있습니다. 딱봐도 올바르지 않은 방법 같아 보입니다.</p>
<p><code>pd.cut()</code>은 <strong>최소에서 최대 구간을 지정한 bin만큼 동일하게 분할</strong> 하기 때문에 이런 현상이 발생할 수 있습니다.</p>
<p>고르게 분포한 데이터라면 괜찮지만, 튀는 <strong>이상치(outlier)가 있는 경우에는 안 좋은 결과</strong>를 초래 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="pd.qcut()---동일한-갯수를-갖도록-구간-분할">pd.qcut() - 동일한 갯수를 갖도록 구간 분할</h2><p><code>pd.cut()</code>과 유사하지만, <strong>quantity 즉 데이터의 분포를 최대한 비슷하게 유지</strong>하는 구간을 분할 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량_qcut'</span><span class="p">]</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">qcut</span><span class="p">(</span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량'</span><span class="p">],</span> <span class="n">q</span><span class="o">=</span><span class="mi">10</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span><span class="p">[</span><span class="s1">'운동량_qcut'</span><span class="p">]</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(93.414, 192.02]           32690
(6805.188, 163936052.3]    32683
(3328.186, 6805.188]       32683
(1889.606, 3328.186]       32683
(1079.744, 1889.606]       32683
(601.705, 1079.744]        32683
(24.737, 93.414]           32683
(-0.001, 24.737]           32683
(344.45, 601.705]          32680
(192.02, 344.45]           32679
Name: 운동량_qcut, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>구간도 예쁘게 분할(<strong>균등하게 분할</strong>)이 된 것 처럼 보입니다. 하지만, <strong>간격은 일정하지 않습니다.</strong></p>
</div>
</div>
</div>
</div>
</div>
</body>