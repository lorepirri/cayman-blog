---
layout: page
title: "#05-Pandas(판다스) DataFrame의 복사(Copy)와 결측치(NaN values) 처리"
description: "#05-Pandas(판다스) DataFrame의 복사(Copy)와 결측치(NaN values) 처리에 대해 알아보겠습니다."
headline: "#05-Pandas(판다스) DataFrame의 복사(Copy)와 결측치(NaN values) 처리에 대해 알아보겠습니다."
categories: pandas
tags: [python, pandas, dataframe, series, pandas tutorial, 결측치, nan, np.nan, 판다스, 판다스 자료구조, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-01-23
---

이번 에피소드에서는 Pandas 데이터프레임(DataFrame) 의 **복사(Copy)**와 중요한 전처리 Task 중의 하나인 **결측치 처리** 에 대해서 알아보겠습니다.

DataFrame을 활용하여 새로운 Feature(특성)을 만들어 추가하거나, 필요 없는 컬럼을 제거했을 때 **원본 DataFrame이 손상되었기 때문에 다시 파일로부터 불러와야하는 불상사가 생기게 됩니다.** 그래서 저는 DataFrame의 복사 기능을 잘 활용합니다. (물론 용량이 큰 DataFrame은 복사 할 때마다 용량이 늘어나 RAM이 터질 수 있습니다.)

복사한 후 특성 추출을 해서 추가 EDA를 해보고 아니다 싶으면 버리는 거죠.

그리고, 결측치 처리 주제 또한 이번 에피소드에서 다루는 데요.

결측치 처리는 **데이터 전처리 프로세스 중 가장 중요하다고 생각하는 프로세스 중 하나**입니다.

결측치를 어떻게 처리해 주느냐에 따라 나중에 머신러닝 모델에 데이터를 주입하고 예측한 결과가 달라지는 경우도 많습니다.

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
<h2 id="copy">copy</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>DataFrame을 <strong>복제</strong>합니다. 복제한 DataFrame을 수정해도 <strong>원본에는 영향을 미치지 않습니다.</strong></p>
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
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>copy()</code>로 DataFrame을 복제합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_copy</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">copy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>id 값을 확인하면 두 DataFrame의 <strong>메모리 주소가 다름</strong>을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">id</span><span class="p">(</span><span class="n">df</span><span class="p">),</span> <span class="nb">id</span><span class="p">(</span><span class="n">df_copy</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(140082615351616, 140082615351952)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_copy</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<p><code>df_copy</code>의 <code>age</code>를 99999로 임의 수정하도록 하겠습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_copy</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="mi">0</span><span class="p">,</span> <span class="s1">'age'</span><span class="p">]</span> <span class="o">=</span> <span class="mi">99999</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>수정사항이 반영된 것을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df_copy</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
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
<td>99999.0</td>
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
<p>하지만, 원본 DataFrame의 <strong>데이터는 변경되지 않고 그대로 남아</strong> 있습니다.</p>
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
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h1 id="결측치">결측치</h1>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>결측치는 <strong>비어있는 데이터</strong>를 의미합니다.</p>
<p>결측치에 대한 처리는 매우 중요합니다.</p>
<p>결측치에 대한 처리를 해주려면 <strong>다음의 내용</strong>을 반드시 알아야 합니다.</p>
<ol>
<li>결측 데이터 확인</li>
<li>결측치가 <strong>아닌</strong> 데이터 확인</li>
<li>결측 데이터 <strong>채우기</strong></li>
<li>결측 데이터 <strong>제거하기</strong></li>
</ol>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="결측치-확인---isnull(),-isnan()">결측치 확인 - isnull(), isnan()</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>컬럼(column)별 결측치의 갯수를 확인하기 위해서는 <code>sum()</code> 함수를 붙혀주면 됩니다.</p>
<p><code>sum()</code>은 Pandas의 통계 관련 함수이며, 통계 관련 함수는 추후에 더 자세히 알아볼 예정입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>isnull()</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">isnull</span><span class="p">()</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived         0
pclass           0
sex              0
age            177
sibsp            0
parch            0
fare             0
embarked         2
class            0
who              0
adult_male       0
deck           688
embark_town      2
alive            0
alone            0
dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>isna()</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>isnull() 과 동작이 완전 같습니다. 편한 것으로 써주세요. (심지어 도큐먼트도 같습니다)</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">isna</span><span class="p">()</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>survived         0
pclass           0
sex              0
age            177
sibsp            0
parch            0
fare             0
embarked         2
class            0
who              0
adult_male       0
deck           688
embark_town      2
alive            0
alone            0
dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>DataFrame 전체 결측 데이터의 갯수를 합산하기 위해서는 <code>sum()</code>을 두 번 사용하면 됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">isnull</span><span class="p">()</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>869</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="결측치가-아닌-데이터-확인---notnull()">결측치가 아닌 데이터 확인 - notnull()</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>notnull()</code>은 <code>isnull()</code>과 정확히 <strong>반대</strong> 개념입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">notnull</span><span class="p">()</span><span class="o">.</span><span class="n">sum</span><span class="p">()</span>
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
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="결측-데이터-필터링">결측 데이터 필터링</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>isnull()</code> 함수가 결측 데이터를 찾는 <strong>boolean index</strong> 입니다.</p>
<p>즉, <code>loc</code>에 적용하여 조건 필터링을 걸 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">df</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">isnull</span><span class="p">()]</span>
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
</tr>
<tr>
<th>17</th>
<td>1</td>
<td>2</td>
<td>male</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>13.0000</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
</tr>
<tr>
<th>19</th>
<td>1</td>
<td>3</td>
<td>female</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>7.2250</td>
<td>C</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Cherbourg</td>
<td>yes</td>
<td>True</td>
</tr>
<tr>
<th>26</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>7.2250</td>
<td>C</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Cherbourg</td>
<td>no</td>
<td>True</td>
</tr>
<tr>
<th>28</th>
<td>1</td>
<td>3</td>
<td>female</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>7.8792</td>
<td>Q</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Queenstown</td>
<td>yes</td>
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
</tr>
<tr>
<th>859</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>7.2292</td>
<td>C</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Cherbourg</td>
<td>no</td>
<td>True</td>
</tr>
<tr>
<th>863</th>
<td>0</td>
<td>3</td>
<td>female</td>
<td>NaN</td>
<td>8</td>
<td>2</td>
<td>69.5500</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
</tr>
<tr>
<th>868</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>9.5000</td>
<td>S</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
</tr>
<tr>
<th>878</th>
<td>0</td>
<td>3</td>
<td>male</td>
<td>NaN</td>
<td>0</td>
<td>0</td>
<td>7.8958</td>
<td>S</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
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
</tr>
</tbody>
</table>
<p>177 rows × 15 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="결측치-채우기---fillna()">결측치 채우기 - fillna()</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>fillna()</code>를 활용하면 결측치에 대하여 <strong>일괄적으로 값을 채울 수</strong> 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 원본을 copy하여 df1 변수에 </span>
<span class="n">df1</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">copy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
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
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.00</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
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
<td>30.00</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>B</td>
<td>Southampton</td>
<td>yes</td>
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
<td>23.45</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.00</td>
<td>C</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
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
<td>7.75</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
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
<p>888번 index의 <strong>결측치가 700으로 채워</strong>진 것을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="mi">700</span><span class="p">)</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>886     27.0
887     19.0
888    700.0
889     26.0
890     32.0
Name: age, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span> <span class="o">=</span> <span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="mi">700</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
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
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.00</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
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
<td>30.00</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>B</td>
<td>Southampton</td>
<td>yes</td>
<td>True</td>
</tr>
<tr>
<th>888</th>
<td>0</td>
<td>3</td>
<td>female</td>
<td>700.0</td>
<td>1</td>
<td>2</td>
<td>23.45</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.00</td>
<td>C</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
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
<td>7.75</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
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
<p><strong>카테고리 형 데이터</strong>을 채워주기 위해서는 다음과 같은 과정을 거쳐야 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>이미 카테고리가 추가된 'A'나 'B'는 바로 fillna() 할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'deck'</span><span class="p">]</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="s1">'A'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0      A
1      C
2      A
3      C
4      A
      ..
886    A
887    B
888    A
889    C
890    A
Name: deck, Length: 891, dtype: category
Categories (7, object): [A, B, C, D, E, F, G]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>하지만, 없는 카테고리로 채워주고자 할 때는 먼저 <code>add_categories</code>로 카테고리를 추가한 후 채워야 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># add_categories (카테고리 추가)</span>
<span class="c1"># cat은 category의 지정자</span>
<span class="n">df1</span><span class="p">[</span><span class="s1">'deck'</span><span class="p">]</span><span class="o">.</span><span class="n">cat</span><span class="o">.</span><span class="n">add_categories</span><span class="p">(</span><span class="s1">'No Data'</span><span class="p">)</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="s1">'No Data'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>0      No Data
1            C
2      No Data
3            C
4      No Data
        ...   
886    No Data
887          B
888    No Data
889          C
890    No Data
Name: deck, Length: 891, dtype: category
Categories (8, object): [A, B, C, D, E, F, G, No Data]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="통계값으로-채우기">통계값으로 채우기</h2>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
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
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.00</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
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
<td>30.00</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>B</td>
<td>Southampton</td>
<td>yes</td>
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
<td>23.45</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.00</td>
<td>C</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
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
<td>7.75</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
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
<h3 id="평균으로-채우기">평균으로 채우기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">())</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>886    27.000000
887    19.000000
888    29.699118
889    26.000000
890    32.000000
Name: age, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="중앙값으로-채우기">중앙값으로 채우기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="n">df1</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span><span class="o">.</span><span class="n">median</span><span class="p">())</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>886    27.0
887    19.0
888    28.0
889    26.0
890    32.0
Name: age, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="최빈값으로-채우기">최빈값으로 채우기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'deck'</span><span class="p">]</span><span class="o">.</span><span class="n">mode</span><span class="p">()</span>
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
<p><strong>최빈값(mode)</strong>으로 채울 때에는 반드시 <strong>0번째 index 지정</strong>하여 값을 추출한 후 채워야 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'deck'</span><span class="p">]</span><span class="o">.</span><span class="n">mode</span><span class="p">()[</span><span class="mi">0</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'C'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="p">[</span><span class="s1">'deck'</span><span class="p">]</span><span class="o">.</span><span class="n">fillna</span><span class="p">(</span><span class="n">df1</span><span class="p">[</span><span class="s1">'deck'</span><span class="p">]</span><span class="o">.</span><span class="n">mode</span><span class="p">()[</span><span class="mi">0</span><span class="p">])</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>886    C
887    B
888    C
889    C
890    C
Name: deck, dtype: category
Categories (7, object): [A, B, C, D, E, F, G]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="NaN-값이-있는-데이터-제거하기-(dropna)">NaN 값이 있는 데이터 제거하기 (dropna)</h2>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">tail</span><span class="p">()</span>
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
<th>886</th>
<td>0</td>
<td>2</td>
<td>male</td>
<td>27.0</td>
<td>0</td>
<td>0</td>
<td>13.00</td>
<td>S</td>
<td>Second</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
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
<td>30.00</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>B</td>
<td>Southampton</td>
<td>yes</td>
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
<td>23.45</td>
<td>S</td>
<td>Third</td>
<td>woman</td>
<td>False</td>
<td>NaN</td>
<td>Southampton</td>
<td>no</td>
<td>False</td>
</tr>
<tr>
<th>889</th>
<td>1</td>
<td>1</td>
<td>male</td>
<td>26.0</td>
<td>0</td>
<td>0</td>
<td>30.00</td>
<td>C</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>C</td>
<td>Cherbourg</td>
<td>yes</td>
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
<td>7.75</td>
<td>Q</td>
<td>Third</td>
<td>man</td>
<td>True</td>
<td>NaN</td>
<td>Queenstown</td>
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
<p><code>dropna()</code>로 <strong>1개 라도 NaN 값이 있는 행</strong>은 제거할 수 있스빈다. (<code>how='any'</code>)</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">dropna</span><span class="p">()</span>
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
</tr>
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
</tr>
<tr>
<th>871</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>47.0</td>
<td>1</td>
<td>1</td>
<td>52.5542</td>
<td>S</td>
<td>First</td>
<td>woman</td>
<td>False</td>
<td>D</td>
<td>Southampton</td>
<td>yes</td>
<td>False</td>
</tr>
<tr>
<th>872</th>
<td>0</td>
<td>1</td>
<td>male</td>
<td>33.0</td>
<td>0</td>
<td>0</td>
<td>5.0000</td>
<td>S</td>
<td>First</td>
<td>man</td>
<td>True</td>
<td>B</td>
<td>Southampton</td>
<td>no</td>
<td>True</td>
</tr>
<tr>
<th>879</th>
<td>1</td>
<td>1</td>
<td>female</td>
<td>56.0</td>
<td>0</td>
<td>1</td>
<td>83.1583</td>
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
</tr>
</tbody>
</table>
<p>182 rows × 15 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>기본 옵션 값은 <code>how=any</code>로 설정되어 있으며, 다음과 같이 변경할 수 있습니다.</p>
<ul>
<li><strong>any</strong>: 1개 라도 NaN값이 존재시 drop</li>
<li><strong>all</strong>: 모두 NaN값이 존재시 drop</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span><span class="o">.</span><span class="n">dropna</span><span class="p">(</span><span class="n">how</span><span class="o">=</span><span class="s1">'all'</span><span class="p">)</span>
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
</tr>
</tbody>
</table>
<p>891 rows × 15 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>