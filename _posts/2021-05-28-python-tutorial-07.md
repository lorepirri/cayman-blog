---
layout: page
title: "#07-파이썬(Python) 반복문"
description: "파이썬(Python) 반복문을 알아보고 튜토리얼을 진행합니다."
headline: "파이썬(Python) 반복문을 알아보고 튜토리얼을 진행합니다."
categories: python
tags: [python, pandas, 반복문, while, for in, 파이썬, 자료구조, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-05-27
---

본 포스팅은 **파이썬(Python) 코딩 입문자를 위한 튜토리얼** 시리즈 연재 중 일부입니다. 

이번 튜토리얼에서는 파이썬의 **반복문**을 다룹니다.

<h2 id="코드">코드</h2>

<p><img src="../images/2020-09-24/colab_logo_32px.png" alt="Colab으로 열기" /> <a href="https://colab.research.google.com/github/teddylee777/machine-learning/blob/master/00-Python/07-%ED%8C%8C%EC%9D%B4%EC%8D%AC-%EB%B0%98%EB%B3%B5%EB%AC%B8.ipynb" target="_blank">Colab으로 열기</a></p>

<p><img src="../images/2020-09-24/GitHub-Mark-32px.png" alt="GitHub" /> <a href="https://github.com/teddylee777/machine-learning/blob/master/00-Python/07-%ED%8C%8C%EC%9D%B4%EC%8D%AC-%EB%B0%98%EB%B3%B5%EB%AC%B8.ipynb" target="_blank">GitHub에서 소스보기</a></p>

<br/>


<body class="jp-Notebook" data-jp-theme-light="true" data-jp-theme-name="JupyterLab Light">
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h1 id="반복문">반복문</h1>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<ul>
<li>1회 이상 반복해서 수행하는 일을 반복문으로 통해 쉽게 해결할 수 있습니다.</li>
<li>반드시 list, tuple, dict, set 등 집합에 대한 순회를 돌며 일을 처리할 때 많이 쓰입니다.</li>
<li>list, tuple, dict, set, 문자열까지 모두 <strong>순회가능한(iterable) 객체</strong> 입니다.</li>
<li>순회가능한(iterable) 객체는 반복문을 통해 순회할 수 있습니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mylist</span> <span class="o">=</span> <span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">,</span> <span class="mi">7</span><span class="p">,</span> <span class="mi">8</span><span class="p">,</span> <span class="mi">9</span><span class="p">,</span> <span class="mi">10</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>mylist에 들어 있는 모든 값들을 출력하려고 한다면?</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="n">mylist</span><span class="p">[</span><span class="mi">0</span><span class="p">])</span>
<span class="nb">print</span><span class="p">(</span><span class="n">mylist</span><span class="p">[</span><span class="mi">1</span><span class="p">])</span>
<span class="nb">print</span><span class="p">(</span><span class="n">mylist</span><span class="p">[</span><span class="mi">2</span><span class="p">])</span>
<span class="nb">print</span><span class="p">(</span><span class="s1">'...'</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="n">mylist</span><span class="p">[</span><span class="mi">8</span><span class="p">])</span>
<span class="nb">print</span><span class="p">(</span><span class="n">mylist</span><span class="p">[</span><span class="mi">9</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>1
2
3
...
9
10
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>노가다를 획기적으로 줄여주는 방법!!!</p>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="for-와-in-구문-(반복문)">for 와 in 구문 (반복문)</h2>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>[기본 문법]</strong><br/>
for 하나씩 꺼내올 때 변수 in [꺼내올 집합]:<br>
(indent)</br></p>
<ul>
<li>list, tuple, set, dictionary, 문자열 형태 모두 가능</li>
<li>range와 결합하여 사용 가능</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="리스트(list)">리스트(list)</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mylist</span> <span class="o">=</span> <span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">]</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">mylist</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>1
2
3
4
5
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="튜플(tuple)">튜플(tuple)</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>1
2
3
4
5
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="tuple-+-list">tuple + list</h3>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>tuple을 전체로 받아주는 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">person</span> <span class="o">=</span> <span class="p">(</span><span class="s1">'제이콥스'</span><span class="p">,</span> <span class="mi">10</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="n">person</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="n">person</span><span class="p">[</span><span class="mi">0</span><span class="p">])</span>
<span class="nb">print</span><span class="p">(</span><span class="n">person</span><span class="p">[</span><span class="mi">1</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>('제이콥스', 10)
제이콥스
10
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>tuple의 요소를 개별로 받아주는 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">name</span><span class="p">,</span> <span class="n">age</span> <span class="o">=</span> <span class="p">(</span><span class="s1">'제이콥스'</span><span class="p">,</span> <span class="mi">10</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="n">name</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="n">age</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>제이콥스
10
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>반복문에서의 응용</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mytuplelist</span> <span class="o">=</span> <span class="p">[(</span><span class="s1">'제이콥스'</span><span class="p">,</span> <span class="mi">10</span><span class="p">),</span> <span class="p">(</span><span class="s1">'피터'</span><span class="p">,</span> <span class="mi">20</span><span class="p">),</span> <span class="p">(</span><span class="s1">'타이거'</span><span class="p">,</span> <span class="mi">30</span><span class="p">)]</span>

<span class="k">for</span> <span class="n">mytuple</span> <span class="ow">in</span> <span class="n">mytuplelist</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">mytuple</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span> <span class="n">mytuple</span><span class="p">[</span><span class="mi">1</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>제이콥스 10
피터 20
타이거 30
</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mytuplelist</span> <span class="o">=</span> <span class="p">[(</span><span class="s1">'제이콥스'</span><span class="p">,</span> <span class="mi">10</span><span class="p">),</span> <span class="p">(</span><span class="s1">'피터'</span><span class="p">,</span> <span class="mi">20</span><span class="p">),</span> <span class="p">(</span><span class="s1">'타이거'</span><span class="p">,</span> <span class="mi">30</span><span class="p">)]</span>

<span class="k">for</span> <span class="n">name</span><span class="p">,</span> <span class="n">age</span> <span class="ow">in</span> <span class="n">mytuplelist</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">age</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>제이콥스 10
피터 20
타이거 30
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="딕셔너리(dictionary)">딕셔너리(dictionary)</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'헐크'</span><span class="p">:</span> <span class="mi">50</span><span class="p">,</span> <span class="s1">'아이언맨'</span><span class="p">:</span> <span class="mi">60</span><span class="p">,</span> <span class="s1">'펭수'</span><span class="p">:</span> <span class="mi">70</span><span class="p">}</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">key</span> <span class="ow">in</span> <span class="n">mydict</span><span class="o">.</span><span class="n">keys</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">key</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>헐크
아이언맨
펭수
</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">value</span> <span class="ow">in</span> <span class="n">mydict</span><span class="o">.</span><span class="n">values</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">value</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>50
60
70
</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">name</span><span class="p">,</span> <span class="n">age</span> <span class="ow">in</span> <span class="n">mydict</span><span class="o">.</span><span class="n">items</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">age</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>헐크 50
아이언맨 60
펭수 70
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="문자열(str)">문자열(str)</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">c</span> <span class="ow">in</span> <span class="s2">"Hello"</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">c</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>H
e
l
l
o
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="range()">range()</h3><ul>
<li><code>range()</code> 함수는 별도의 list, tuple 생성 없이 range() 에서 정의한 범위를 반복는데 활용할 수 있습니다.</li>
<li><code>range(start, stop, step)</code> 형식을 사용합니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>stop</code>: 단일 값을 지정하는 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">10</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>0
1
2
3
4
5
6
7
8
9
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>start</code>, <code>stop</code>: 두 개의 값을 지정한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">2</span><span class="p">,</span> <span class="mi">9</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>2
3
4
5
6
7
8
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>start</code>, <code>stop</code>, <code>step</code>: 세 개의 값을 지정한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">10</span><span class="p">,</span> <span class="mi">2</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>1
3
5
7
9
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="반복문의-중첩">반복문의 중첩</h2>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">4</span><span class="p">):</span>
    <span class="k">for</span> <span class="n">j</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">4</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'(i=</span><span class="si">{</span><span class="n">i</span><span class="si">}</span><span class="s1">) + (j=</span><span class="si">{</span><span class="n">j</span><span class="si">}</span><span class="s1">) = </span><span class="si">{</span><span class="n">i</span> <span class="o">*</span> <span class="n">j</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'==='</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>(i=1) + (j=1) = 1
(i=1) + (j=2) = 2
(i=1) + (j=3) = 3
===
(i=2) + (j=1) = 2
(i=2) + (j=2) = 4
(i=2) + (j=3) = 6
===
(i=3) + (j=1) = 3
(i=3) + (j=2) = 6
(i=3) + (j=3) = 9
===
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="제어문">제어문</h2>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="continue">continue</h3><ul>
<li>반복문 내부에서 <code>continue</code> 구문은 해당 루프(loop)를 건너뛰게 합니다.</li>
<li><code>continue</code> 라는 구문을 만나면, 반복문에서 <code>continue</code> 아래 작성된 코드는 <strong>실행되지 않고 건너뜁니다.</strong></li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mylist</span> <span class="o">=</span> <span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">,</span> <span class="mi">7</span><span class="p">,</span> <span class="mi">8</span><span class="p">,</span> <span class="mi">9</span><span class="p">,</span> <span class="mi">10</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>반복문</strong>과 <strong>조건문</strong> 그리고 <code>continue</code>를 활용하여 <strong>짝수만 출력</strong>해 주세요</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">mylist</span><span class="p">:</span>
    <span class="k">if</span> <span class="n">i</span> <span class="o">%</span> <span class="mi">2</span> <span class="o">==</span> <span class="mi">1</span><span class="p">:</span>
        <span class="k">continue</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>2
4
6
8
10
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="break">break</h3><ul>
<li><strong>break</strong> 구문을 만나면, <strong>반복 루프(loop)는 즉시 종료</strong>됩니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mylist</span> <span class="o">=</span> <span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">,</span> <span class="mi">7</span><span class="p">,</span> <span class="mi">8</span><span class="p">,</span> <span class="mi">9</span><span class="p">,</span> <span class="mi">10</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>break</code>를 사용하여 i가 6 이상이면 STOP</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">mylist</span><span class="p">:</span>
    <span class="k">if</span> <span class="n">i</span> <span class="o">&gt;=</span> <span class="mi">6</span><span class="p">:</span>
        <span class="k">break</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>1
2
3
4
5
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="break,-continue-차이">break, continue 차이</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">10</span><span class="p">):</span>
    <span class="k">if</span> <span class="n">i</span> <span class="o">==</span> <span class="mi">5</span><span class="p">:</span>
        <span class="k">break</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>0
1
2
3
4
</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">10</span><span class="p">):</span>
    <span class="k">if</span> <span class="n">i</span> <span class="o">==</span> <span class="mi">5</span><span class="p">:</span>
        <span class="k">continue</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">i</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>0
1
2
3
4
6
7
8
9
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="While">While</h2><ul>
<li>while 문은 while문과 함께 정의한 <strong>조건이 참이 동안 반복 루프를 수행</strong>합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">count</span> <span class="o">=</span> <span class="mi">5</span>

<span class="k">while</span> <span class="n">count</span> <span class="o">&gt;</span> <span class="mi">0</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">count</span><span class="p">)</span>
    <span class="n">count</span> <span class="o">-=</span> <span class="mi">1</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>5
4
3
2
1
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>많은 사용하는 방법 중 하나는 <code>while True</code>로 지정하여 무한 루프를 생성 후, <strong>탈출 구문 루프 내에서 설정</strong>하는 것입니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">count</span> <span class="o">=</span> <span class="mi">1</span>

<span class="k">while</span> <span class="kc">True</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">count</span><span class="p">)</span>
    <span class="n">count</span> <span class="o">+=</span> <span class="mi">1</span>
    <span class="c1"># 탈출 구문(break)</span>
    <span class="k">if</span> <span class="n">count</span> <span class="o">&gt;</span> <span class="mi">5</span><span class="p">:</span>
        <span class="k">break</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>1
2
3
4
5
</pre>
</div>
</div>
</div>
</div>
</div>
</body>