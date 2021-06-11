---
layout: page
title: "#07-Pandas(판다스) Groupby와 Pivot table"
description: "Pandas(판다스) Groupby와 Pivot table 활용 방법에 대한 튜토리얼입니다."
headline: "Pandas(판다스) Groupby와 Pivot table 활용 방법에 대한 튜토리얼입니다."
categories: data_science
tags: [python, pandas, groupby, pivot_table, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-06-11
---

이번 에피소드에서는 Pandas DataFrame의 `groupby()`, `pivot_table()`을 활용한 데이터 분석 방법에 대하여 다뤄 보도록 하겠습니다. 

`groupby()`는 데이터를 피봇팅하여 통계량을 볼 수 있도록 도와주는 메서드이면서, 데이터를 **특정 조건에 맞게 전처리**해 줄 때로 용이합니다.

`pivot_table()`은 데이터를 특정 조건에 따라 행(row)과 열(column)을 기준으로 데이터를 펼쳐서 그에 대한 통계량을 볼 때 활용합니다. 

<body class="jp-Notebook" data-jp-theme-light="true" data-jp-theme-name="JupyterLab Light">
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="모듈-import">모듈 import</h2>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">IPython.display</span> <span class="kn">import</span> <span class="n">Image</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">pandas</span> <span class="k">as</span> <span class="nn">pd</span>
<span class="kn">import</span> <span class="nn">seaborn</span> <span class="k">as</span> <span class="nn">sns</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="데이터셋-로드">데이터셋 로드</h2>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span> <span class="o">=</span> <span class="n">sns</span><span class="o">.</span><span class="n">load_dataset</span><span class="p">(</span><span class="s1">'titanic'</span><span class="p">)</span>
<span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
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
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="apply()---함수를-적용">apply() - 함수를 적용</h2><p><code>apply()</code>는 데이터 전처리시 굉장히 많이 활용하는 기능입니다.</p>
<p>좀 더 복잡한 <strong>logic을 컬럼 혹은 DataFrame에 적용</strong>하고자 할 때 사용합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>who</strong> 컬럼에 대하여 man은 남자, woman은 여자, child는 아이로 변경하고자 한다면 apply를 활용하여 해결할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>man      537
woman    271
child     83
Name: who, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="함수(function)-정의">함수(function) 정의</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">transform_who</span><span class="p">(</span><span class="n">x</span><span class="p">):</span>
    <span class="k">if</span> <span class="n">x</span> <span class="o">==</span> <span class="s1">'man'</span><span class="p">:</span>
        <span class="k">return</span> <span class="s1">'남자'</span>
    <span class="k">elif</span> <span class="n">x</span> <span class="o">==</span> <span class="s1">'woman'</span><span class="p">:</span>
        <span class="k">return</span> <span class="s1">'여자'</span>
    <span class="k">else</span><span class="p">:</span>
        <span class="k">return</span> <span class="s1">'아이'</span>
</pre></div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="n">transform_who</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>0      남자
1      여자
2      여자
3      여자
4      남자
       ..
886    남자
887    여자
888    여자
889    남자
890    남자
Name: who, Length: 891, dtype: object</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>분포를 확인하면 다음과 같습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'who'</span><span class="p">]</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="n">transform_who</span><span class="p">)</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>남자    537
여자    271
아이     83
Name: who, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">transform_who</span><span class="p">(</span><span class="n">x</span><span class="p">):</span>
    <span class="k">return</span> <span class="n">x</span><span class="p">[</span><span class="s1">'fare'</span><span class="p">]</span> <span class="o">/</span> <span class="n">x</span><span class="p">[</span><span class="s1">'age'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="n">transform_who</span><span class="p">,</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>0      0.329545
1      1.875876
2      0.304808
3      1.517143
4      0.230000
         ...   
886    0.481481
887    1.578947
888         NaN
889    1.153846
890    0.242188
Length: 891, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="apply()---lambda-함수">apply() - lambda 함수</h2>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>간단한 logic은 함수를 굳이 정의하지 않고, lambda 함수로 쉽게 해결할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'survived'</span><span class="p">]</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>0    549
1    342
Name: survived, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>0: 사망, 1: 생존</strong> 으로 변경하도록 하겠습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'survived'</span><span class="p">]</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="s1">'생존'</span> <span class="k">if</span> <span class="n">x</span> <span class="o">==</span> <span class="mi">1</span> <span class="k">else</span> <span class="s1">'사망'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>0      사망
1      생존
2      생존
3      생존
4      사망
       ..
886    사망
887    생존
888    사망
889    생존
890    사망
Name: survived, Length: 891, dtype: object</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="p">[</span><span class="s1">'survived'</span><span class="p">]</span><span class="o">.</span><span class="n">apply</span><span class="p">(</span><span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="s1">'생존'</span> <span class="k">if</span> <span class="n">x</span> <span class="o">==</span> <span class="mi">1</span> <span class="k">else</span> <span class="s1">'사망'</span><span class="p">)</span><span class="o">.</span><span class="n">value_counts</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>사망    549
생존    342
Name: survived, dtype: int64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="groupby()---그룹">groupby() - 그룹</h2><p>데이터를 특정 기준으로 그룹핑할 때 활용합니다. 엑셀의 피봇테이블과 유사합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>타이타닉 호의 생존자와 사망자를 <strong>성별</strong> 기준으로 그룹핑하여 <strong>평균</strong>을 살펴보겠습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">(</span><span class="s1">'sex'</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<tr>
<th>sex</th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th>female</th>
<td>0.742038</td>
<td>2.159236</td>
<td>27.915709</td>
<td>0.694268</td>
<td>0.649682</td>
<td>44.479818</td>
<td>0.000000</td>
<td>0.401274</td>
</tr>
<tr>
<th>male</th>
<td>0.188908</td>
<td>2.389948</td>
<td>30.726645</td>
<td>0.429809</td>
<td>0.235702</td>
<td>25.523893</td>
<td>0.930676</td>
<td>0.712305</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>groupby()</code>를 사용할 때는 반드시 aggregate 하는 <strong>통계함수와 일반적으로 같이 적용</strong>합니다.</p>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="2개-이상의-컬럼으로-그룹">2개 이상의 컬럼으로 그룹</h3><p>2개 이상의 컬럼으로 그룹핑할 때도 list로 묶어서 지정하면 됩니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 성별, 좌석등급 별 통계</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th></th>
<th>survived</th>
<th>age</th>
<th>sibsp</th>
<th>parch</th>
<th>fare</th>
<th>adult_male</th>
<th>alone</th>
</tr>
<tr>
<th>sex</th>
<th>pclass</th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th rowspan="3" valign="top">female</th>
<th>1</th>
<td>0.968085</td>
<td>34.611765</td>
<td>0.553191</td>
<td>0.457447</td>
<td>106.125798</td>
<td>0.000000</td>
<td>0.361702</td>
</tr>
<tr>
<th>2</th>
<td>0.921053</td>
<td>28.722973</td>
<td>0.486842</td>
<td>0.605263</td>
<td>21.970121</td>
<td>0.000000</td>
<td>0.421053</td>
</tr>
<tr>
<th>3</th>
<td>0.500000</td>
<td>21.750000</td>
<td>0.895833</td>
<td>0.798611</td>
<td>16.118810</td>
<td>0.000000</td>
<td>0.416667</td>
</tr>
<tr>
<th rowspan="3" valign="top">male</th>
<th>1</th>
<td>0.368852</td>
<td>41.281386</td>
<td>0.311475</td>
<td>0.278689</td>
<td>67.226127</td>
<td>0.975410</td>
<td>0.614754</td>
</tr>
<tr>
<th>2</th>
<td>0.157407</td>
<td>30.740707</td>
<td>0.342593</td>
<td>0.222222</td>
<td>19.741782</td>
<td>0.916667</td>
<td>0.666667</td>
</tr>
<tr>
<th>3</th>
<td>0.135447</td>
<td>26.507589</td>
<td>0.498559</td>
<td>0.224784</td>
<td>12.661633</td>
<td>0.919308</td>
<td>0.760807</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="1개의-특정-컬럼에-대한-결과-도출">1개의 특정 컬럼에 대한 결과 도출</h3>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>우리의 주요 관심사는 <code>survived</code> 컬럼입니다. 만약 <code>survived</code>컬럼에 대한 결과만 도출하고 싶다면 컬럼을 맨 끝에 지정합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 성별, 좌석등급 별 통계</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[</span><span class="s1">'survived'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>sex     pclass
female  1         0.968085
        2         0.921053
        3         0.500000
male    1         0.368852
        2         0.157407
        3         0.135447
Name: survived, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>예쁘게 출력하려면 <code>pd.DataFrame()</code>으로 감싸주거나, <code>survived</code> 컬럼을 []로 한 번 더 감싸주면 됩니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 성별, 좌석등급 별 통계</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[</span><span class="s1">'survived'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>sex     pclass
female  1         0.968085
        2         0.921053
        3         0.500000
male    1         0.368852
        2         0.157407
        3         0.135447
Name: survived, dtype: float64</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># DataFrame으로 출력</span>
<span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">(</span><span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[</span><span class="s1">'survived'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">())</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th></th>
<th>survived</th>
</tr>
<tr>
<th>sex</th>
<th>pclass</th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th rowspan="3" valign="top">female</th>
<th>1</th>
<td>0.968085</td>
</tr>
<tr>
<th>2</th>
<td>0.921053</td>
</tr>
<tr>
<th>3</th>
<td>0.500000</td>
</tr>
<tr>
<th rowspan="3" valign="top">male</th>
<th>1</th>
<td>0.368852</td>
</tr>
<tr>
<th>2</th>
<td>0.157407</td>
</tr>
<tr>
<th>3</th>
<td>0.135447</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># DataFrame으로 출력</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[[</span><span class="s1">'survived'</span><span class="p">]]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th></th>
<th>survived</th>
</tr>
<tr>
<th>sex</th>
<th>pclass</th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th rowspan="3" valign="top">female</th>
<th>1</th>
<td>0.968085</td>
</tr>
<tr>
<th>2</th>
<td>0.921053</td>
</tr>
<tr>
<th>3</th>
<td>0.500000</td>
</tr>
<tr>
<th rowspan="3" valign="top">male</th>
<th>1</th>
<td>0.368852</td>
</tr>
<tr>
<th>2</th>
<td>0.157407</td>
</tr>
<tr>
<th>3</th>
<td>0.135447</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="reset_index():-인덱스-초기화">reset_index(): 인덱스 초기화</h3><p><code>reset_index()</code>: 그룹핑된 데이터프레임의 <strong>index를 초기화</strong>하여 새로운 데이터프레임을 생성합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># index 초기화</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[</span><span class="s1">'survived'</span><span class="p">]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span><span class="o">.</span><span class="n">reset_index</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th>pclass</th>
<th>survived</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>female</td>
<td>1</td>
<td>0.968085</td>
</tr>
<tr>
<th>1</th>
<td>female</td>
<td>2</td>
<td>0.921053</td>
</tr>
<tr>
<th>2</th>
<td>female</td>
<td>3</td>
<td>0.500000</td>
</tr>
<tr>
<th>3</th>
<td>male</td>
<td>1</td>
<td>0.368852</td>
</tr>
<tr>
<th>4</th>
<td>male</td>
<td>2</td>
<td>0.157407</td>
</tr>
<tr>
<th>5</th>
<td>male</td>
<td>3</td>
<td>0.135447</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="다중-컬럼에-대한-결과-도출">다중 컬럼에 대한 결과 도출</h3><p>끝에 단일 컬럼이 아닌 여러 개의 컬럼을 지정합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 성별, 좌석등급 별 통계</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[[</span><span class="s1">'survived'</span><span class="p">,</span> <span class="s1">'age'</span><span class="p">]]</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th></th>
<th>survived</th>
<th>age</th>
</tr>
<tr>
<th>sex</th>
<th>pclass</th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th rowspan="3" valign="top">female</th>
<th>1</th>
<td>0.968085</td>
<td>34.611765</td>
</tr>
<tr>
<th>2</th>
<td>0.921053</td>
<td>28.722973</td>
</tr>
<tr>
<th>3</th>
<td>0.500000</td>
<td>21.750000</td>
</tr>
<tr>
<th rowspan="3" valign="top">male</th>
<th>1</th>
<td>0.368852</td>
<td>41.281386</td>
</tr>
<tr>
<th>2</th>
<td>0.157407</td>
<td>30.740707</td>
</tr>
<tr>
<th>3</th>
<td>0.135447</td>
<td>26.507589</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="다중-통계-함수-적용">다중 통계 함수 적용</h3><p>여러 가지의 통계 값을 적용할 때는 <code>agg()</code>를 사용합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 성별, 좌석등급 별 통계</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[[</span><span class="s1">'survived'</span><span class="p">,</span> <span class="s1">'age'</span><span class="p">]]</span><span class="o">.</span><span class="n">agg</span><span class="p">([</span><span class="s1">'mean'</span><span class="p">,</span> <span class="s1">'sum'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr>
<th></th>
<th></th>
<th colspan="2" halign="left">survived</th>
<th colspan="2" halign="left">age</th>
</tr>
<tr>
<th></th>
<th></th>
<th>mean</th>
<th>sum</th>
<th>mean</th>
<th>sum</th>
</tr>
<tr>
<th>sex</th>
<th>pclass</th>
<th></th>
<th></th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th rowspan="3" valign="top">female</th>
<th>1</th>
<td>0.968085</td>
<td>91</td>
<td>34.611765</td>
<td>2942.00</td>
</tr>
<tr>
<th>2</th>
<td>0.921053</td>
<td>70</td>
<td>28.722973</td>
<td>2125.50</td>
</tr>
<tr>
<th>3</th>
<td>0.500000</td>
<td>72</td>
<td>21.750000</td>
<td>2218.50</td>
</tr>
<tr>
<th rowspan="3" valign="top">male</th>
<th>1</th>
<td>0.368852</td>
<td>45</td>
<td>41.281386</td>
<td>4169.42</td>
</tr>
<tr>
<th>2</th>
<td>0.157407</td>
<td>17</td>
<td>30.740707</td>
<td>3043.33</td>
</tr>
<tr>
<th>3</th>
<td>0.135447</td>
<td>47</td>
<td>26.507589</td>
<td>6706.42</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>numpy 의 통계 함수도 적용 가능</strong>합니다. (결과는 동일합니다)</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 성별, 좌석등급 별 통계</span>
<span class="n">df</span><span class="o">.</span><span class="n">groupby</span><span class="p">([</span><span class="s1">'sex'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">])[[</span><span class="s1">'survived'</span><span class="p">,</span> <span class="s1">'age'</span><span class="p">]]</span><span class="o">.</span><span class="n">agg</span><span class="p">([</span><span class="n">np</span><span class="o">.</span><span class="n">mean</span><span class="p">,</span> <span class="n">np</span><span class="o">.</span><span class="n">sum</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr>
<th></th>
<th></th>
<th colspan="2" halign="left">survived</th>
<th colspan="2" halign="left">age</th>
</tr>
<tr>
<th></th>
<th></th>
<th>mean</th>
<th>sum</th>
<th>mean</th>
<th>sum</th>
</tr>
<tr>
<th>sex</th>
<th>pclass</th>
<th></th>
<th></th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th rowspan="3" valign="top">female</th>
<th>1</th>
<td>0.968085</td>
<td>91</td>
<td>34.611765</td>
<td>2942.00</td>
</tr>
<tr>
<th>2</th>
<td>0.921053</td>
<td>70</td>
<td>28.722973</td>
<td>2125.50</td>
</tr>
<tr>
<th>3</th>
<td>0.500000</td>
<td>72</td>
<td>21.750000</td>
<td>2218.50</td>
</tr>
<tr>
<th rowspan="3" valign="top">male</th>
<th>1</th>
<td>0.368852</td>
<td>45</td>
<td>41.281386</td>
<td>4169.42</td>
</tr>
<tr>
<th>2</th>
<td>0.157407</td>
<td>17</td>
<td>30.740707</td>
<td>3043.33</td>
</tr>
<tr>
<th>3</th>
<td>0.135447</td>
<td>47</td>
<td>26.507589</td>
<td>6706.42</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="pivot_table()">pivot_table()</h2><p>피벗테이블은 엑셀의 피벗과 동작이 유사하며, <code>groupby()</code>와도 동작이 유사합니다.</p>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>기본 동작 원리는 <code>index</code>, <code>columns</code>, <code>values</code>를 지정하여 피벗합니다.</p>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="1개-그룹에-대한-단일-컬럼-결과">1개 그룹에 대한 단일 컬럼 결과</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># index에 그룹을 표기</span>
<span class="n">df</span><span class="o">.</span><span class="n">pivot_table</span><span class="p">(</span><span class="n">index</span><span class="o">=</span><span class="s1">'who'</span><span class="p">,</span> <span class="n">values</span><span class="o">=</span><span class="s1">'survived'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
</tr>
<tr>
<th>who</th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th>child</th>
<td>0.590361</td>
</tr>
<tr>
<th>man</th>
<td>0.163873</td>
</tr>
<tr>
<th>woman</th>
<td>0.756458</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># columns에 그룹을 표기</span>
<span class="n">df</span><span class="o">.</span><span class="n">pivot_table</span><span class="p">(</span><span class="n">columns</span><span class="o">=</span><span class="s1">'who'</span><span class="p">,</span> <span class="n">values</span><span class="o">=</span><span class="s1">'survived'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th>who</th>
<th>child</th>
<th>man</th>
<th>woman</th>
</tr>
</thead>
<tbody>
<tr>
<th>survived</th>
<td>0.590361</td>
<td>0.163873</td>
<td>0.756458</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="다중-그룹에-대한-단일-컬럼-결과">다중 그룹에 대한 단일 컬럼 결과</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">pivot_table</span><span class="p">(</span><span class="n">index</span><span class="o">=</span><span class="p">[</span><span class="s1">'who'</span><span class="p">,</span> <span class="s1">'pclass'</span><span class="p">],</span> <span class="n">values</span><span class="o">=</span><span class="s1">'survived'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th></th>
<th>survived</th>
</tr>
<tr>
<th>who</th>
<th>pclass</th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th rowspan="3" valign="top">child</th>
<th>1</th>
<td>0.833333</td>
</tr>
<tr>
<th>2</th>
<td>1.000000</td>
</tr>
<tr>
<th>3</th>
<td>0.431034</td>
</tr>
<tr>
<th rowspan="3" valign="top">man</th>
<th>1</th>
<td>0.352941</td>
</tr>
<tr>
<th>2</th>
<td>0.080808</td>
</tr>
<tr>
<th>3</th>
<td>0.119122</td>
</tr>
<tr>
<th rowspan="3" valign="top">woman</th>
<th>1</th>
<td>0.978022</td>
</tr>
<tr>
<th>2</th>
<td>0.909091</td>
</tr>
<tr>
<th>3</th>
<td>0.491228</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="index에-컬럼을-중첩하지-않고-행과-열로-펼친-결과">index에 컬럼을 중첩하지 않고 행과 열로 펼친 결과</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">pivot_table</span><span class="p">(</span><span class="n">index</span><span class="o">=</span><span class="s1">'who'</span><span class="p">,</span> <span class="n">columns</span><span class="o">=</span><span class="s1">'pclass'</span><span class="p">,</span> <span class="n">values</span><span class="o">=</span><span class="s1">'survived'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
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
<th>pclass</th>
<th>1</th>
<th>2</th>
<th>3</th>
</tr>
<tr>
<th>who</th>
<th></th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th>child</th>
<td>0.833333</td>
<td>1.000000</td>
<td>0.431034</td>
</tr>
<tr>
<th>man</th>
<td>0.352941</td>
<td>0.080808</td>
<td>0.119122</td>
</tr>
<tr>
<th>woman</th>
<td>0.978022</td>
<td>0.909091</td>
<td>0.491228</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="다중-통계함수-적용">다중 통계함수 적용</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df</span><span class="o">.</span><span class="n">pivot_table</span><span class="p">(</span><span class="n">index</span><span class="o">=</span><span class="s1">'who'</span><span class="p">,</span> <span class="n">columns</span><span class="o">=</span><span class="s1">'pclass'</span><span class="p">,</span> <span class="n">values</span><span class="o">=</span><span class="s1">'survived'</span><span class="p">,</span> <span class="n">aggfunc</span><span class="o">=</span><span class="p">[</span><span class="s1">'sum'</span><span class="p">,</span> <span class="s1">'mean'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr>
<th></th>
<th colspan="3" halign="left">sum</th>
<th colspan="3" halign="left">mean</th>
</tr>
<tr>
<th>pclass</th>
<th>1</th>
<th>2</th>
<th>3</th>
<th>1</th>
<th>2</th>
<th>3</th>
</tr>
<tr>
<th>who</th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<th>child</th>
<td>5</td>
<td>19</td>
<td>25</td>
<td>0.833333</td>
<td>1.000000</td>
<td>0.431034</td>
</tr>
<tr>
<th>man</th>
<td>42</td>
<td>8</td>
<td>38</td>
<td>0.352941</td>
<td>0.080808</td>
<td>0.119122</td>
</tr>
<tr>
<th>woman</th>
<td>89</td>
<td>60</td>
<td>56</td>
<td>0.978022</td>
<td>0.909091</td>
<td>0.491228</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
</body>