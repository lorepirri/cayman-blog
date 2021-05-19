---
layout: page
title: "#03-파이썬(Python) 세트(set)와 딕셔너리(dictionary)"
description: "파이썬(Python) 세트(set)와 딕셔너리(dictionary)을 알아보고 튜토리얼을 진행합니다."
headline: "파이썬(Python) 세트(set)와 딕셔너리(dictionary)을 알아보고 튜토리얼을 진행합니다."
categories: python
tags: [python, pandas, numpy, 세트, 딕셔너리, set, dictionary, 파이썬, 자료구조, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-05-20
---

본 포스팅은 **파이썬(Python) 코딩 입문자를 위한 튜토리얼** 시리즈 연재 중 일부입니다. 이번 튜토리얼에서는 파이썬 **세트(set)**와 **딕셔너리(dictionary)**를 다룹니다.

<h2 id="코드">코드</h2>

<p><img src="../images/2020-09-24/colab_logo_32px.png" alt="Colab으로 열기" /> <a href="http://colab.research.google.com/github/teddylee777/machine-learning/blob/master/00-Python/03-%ED%8C%8C%EC%9D%B4%EC%8D%AC-%EC%84%B8%ED%8A%B8-%EB%94%95%EC%85%94%EB%84%88%EB%A6%AC.ipynb" target="_blank">Colab으로 열기</a></p>

<p><img src="../images/2020-09-24/GitHub-Mark-32px.png" alt="GitHub" /> <a href="https://github.com/teddylee777/machine-learning/blob/master/00-Python/03-%ED%8C%8C%EC%9D%B4%EC%8D%AC-%EC%84%B8%ED%8A%B8-%EB%94%95%EC%85%94%EB%84%88%EB%A6%AC.ipynb" target="_blank">GitHub에서 소스보기</a></p>

<p><br /></p>

<br/>

<body class="jp-Notebook" data-jp-theme-light="true" data-jp-theme-name="JupyterLab Light">
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h1 id="시퀀스,-집합형-자료구조">시퀀스, 집합형 자료구조</h1>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<table>
<thead><tr>
<th>분류</th>
<th>타입</th>
<th>특징</th>
<th>예시</th>
</tr>
</thead>
<tbody>
<tr>
<td>시퀀스(sequence)</td>
<td>리스트(list)</td>
<td>순서가 있고, 가변(mutable)</td>
<td>[1, 2, 3]</td>
</tr>
<tr>
<td>시퀀스(sequence)</td>
<td>튜플(tuple)</td>
<td>순서가 있고, 불변(immutable)</td>
<td>(1, 2, 3)</td>
</tr>
<tr>
<td>세트(set)</td>
<td>세트(set)</td>
<td>순서가 없고, 중복을 허용하지 않음</td>
<td>{1, 2, 3}</td>
</tr>
<tr>
<td>맵(map)</td>
<td>딕셔너리(dictionary)</td>
<td>순서가 없고, key/value 쌍으로 이루어짐</td>
<td>{'a': 1, 'b': 2, 'c': 3}</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="세트(set)">세트(set)</h2><ul>
<li>세트는 순서가 보장 되지 않습니다.</li>
<li>세트는 요소의 <strong>중복을 허용하지 않습니다.</strong></li>
<li>세트는 <strong>{}</strong>를 활용하여 생성할 수 있습니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="생성">생성</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span> <span class="o">=</span> <span class="nb">set</span><span class="p">()</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>set()</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span> <span class="o">=</span> <span class="nb">set</span><span class="p">([</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">3</span><span class="p">])</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span> <span class="o">=</span> <span class="nb">set</span><span class="p">((</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">5</span><span class="p">))</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3, 4, 5}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span> <span class="o">=</span> <span class="p">{</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">3</span><span class="p">}</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="add()-:-값-추가">add() : 값 추가</h3><ul>
<li>set에 요소를 추가합니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>빈 set를 생성합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span> <span class="o">=</span> <span class="nb">set</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>add() 로 요소를 추가합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">2</span><span class="p">)</span>
<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">3</span><span class="p">)</span>

<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">2</span><span class="p">)</span>
<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">3</span><span class="p">)</span>

<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">2</span><span class="p">)</span>
<span class="n">myset</span><span class="o">.</span><span class="n">add</span><span class="p">(</span><span class="mi">3</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>요소를 중복하여 추가하였지만, 중복을 허용하지 않는 set의 특성상 {1, 2, 3} 으로 <strong>중복이 제거된 요소만 출력</strong>됩니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="update()-:-여러개-값-추가">update() : 여러개 값 추가</h3><ul>
<li>여러개의 값을 한꺼번에 추가하고자 할 때는 update() 메서드를 사용합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span> <span class="o">=</span> <span class="p">{</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">}</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>list의 요소들을 <strong>한꺼번에 update</strong></p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span><span class="o">.</span><span class="n">update</span><span class="p">([</span><span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">])</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3, 4, 5, 6}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>tuple의 요소들을 <strong>한꺼번에 update</strong></p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span><span class="o">.</span><span class="n">update</span><span class="p">((</span><span class="mi">7</span><span class="p">,</span> <span class="mi">8</span><span class="p">,</span> <span class="mi">9</span><span class="p">))</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3, 4, 5, 6, 7, 8, 9}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>set의 요소들을 <strong>한꺼번에 update</strong></p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span><span class="o">.</span><span class="n">update</span><span class="p">({</span><span class="mi">10</span><span class="p">,</span> <span class="mi">11</span><span class="p">,</span> <span class="mi">12</span><span class="p">})</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="remove()-:-값-제거">remove() : 값 제거</h3><ul>
<li>단일 요소를 제거합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span> <span class="o">=</span> <span class="p">{</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">}</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">myset</span><span class="o">.</span><span class="n">remove</span><span class="p">(</span><span class="mi">2</span><span class="p">)</span>
<span class="n">myset</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 3, 4, 5}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="교집합-(intersection)">교집합 (intersection)</h3><ul>
<li>교집합은 집합 A와 B가 주어졌을 때 <strong>공통된 요소</strong>를 말합니다.</li>
<li><code>&amp;</code> 기호나 <code>intersection()</code> 메서드를 활용하여 교집합을 구할 수 있습니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="p">{</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">}</span>
<span class="n">b</span> <span class="o">=</span> <span class="p">{</span><span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">,</span> <span class="mi">7</span><span class="p">}</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">&amp;</span> <span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{3, 4, 5}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="o">.</span><span class="n">intersection</span><span class="p">(</span><span class="n">b</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{3, 4, 5}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="합집합-(union)">합집합 (union)</h3><ul>
<li>합집합은 집합 A와 B가 주어졌을 때 집합 A, B 요소 모두를 포함하는 것을 말합니다.</li>
<li><code>|</code>기호나 <code>union()</code> 메서드를 활용하여 합집합을 구할 수 있습니다. </li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="p">{</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">}</span>
<span class="n">b</span> <span class="o">=</span> <span class="p">{</span><span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">,</span> <span class="mi">7</span><span class="p">}</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">|</span> <span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3, 4, 5, 6, 7}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="o">.</span><span class="n">union</span><span class="p">(</span><span class="n">b</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3, 4, 5, 6, 7}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="차집합-(difference)">차집합 (difference)</h3><ul>
<li>두 집합에서, 하나의 집합에 포함되고 다른 집합에는 포함되지 않는 모든 원소의 집합.</li>
<li><code>-</code>연산자를 활용하거나 <code>difference()</code> 메서드를 활용하여 구할 수 있습니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="p">{</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">}</span>
<span class="n">b</span> <span class="o">=</span> <span class="p">{</span><span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">,</span> <span class="mi">6</span><span class="p">,</span> <span class="mi">7</span><span class="p">}</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>a 집합에서 b 집합을 뺀 차집합</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">-</span> <span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="o">.</span><span class="n">difference</span><span class="p">(</span><span class="n">b</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>b 집합에서 a 집합을 뺀 차집합</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b</span> <span class="o">-</span> <span class="n">a</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{6, 7}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b</span><span class="o">.</span><span class="n">difference</span><span class="p">(</span><span class="n">a</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{6, 7}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="집합의-타입-변환">집합의 타입 변환</h3>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="set를-list로-변환">set를 list로 변환</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="p">{</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">}</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">type</span><span class="p">(</span><span class="n">a</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>set</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b</span> <span class="o">=</span> <span class="nb">list</span><span class="p">(</span><span class="n">a</span><span class="p">)</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>[1, 2, 3, 4, 5]</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">type</span><span class="p">(</span><span class="n">b</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>list</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="list를-set로-변환">list를 set로 변환</h3><ul>
<li>중복을 제거할 때 많이 활용합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">3</span><span class="p">]</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>[1, 1, 1, 2, 2, 2, 3, 3, 3]</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">type</span><span class="p">(</span><span class="n">a</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>list</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b</span> <span class="o">=</span> <span class="nb">set</span><span class="p">(</span><span class="n">a</span><span class="p">)</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{1, 2, 3}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">type</span><span class="p">(</span><span class="n">b</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>set</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>b를 다시 list 자료형으로 변환</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">b</span> <span class="o">=</span> <span class="nb">list</span><span class="p">(</span><span class="n">b</span><span class="p">)</span>
<span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>[1, 2, 3]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="딕셔너리(dictionary)">딕셔너리(dictionary)</h2><ul>
<li>순서를 가지지 않습니다.</li>
<li>키(key)와 값(value)의 쌍으로 이루어져 있습니다.</li>
<li>type은 <code>dict</code>로 표시 됩니다.</li>
<li>key를 사용하여 값을 조회할 수 있습니다.</li>
<li>딕셔너리는 <strong>수정, 삭제, 추가가 가능</strong>합니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="생성">생성</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="nb">dict</span><span class="p">()</span>
<span class="nb">print</span><span class="p">(</span><span class="nb">type</span><span class="p">(</span><span class="n">mydict</span><span class="p">))</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>&lt;class 'dict'&gt;
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'a'</span><span class="p">:</span> <span class="mi">1</span><span class="p">,</span> <span class="s1">'b'</span><span class="p">:</span> <span class="mi">2</span><span class="p">,</span> <span class="s1">'c'</span><span class="p">:</span> <span class="mi">3</span><span class="p">}</span>
<span class="nb">print</span><span class="p">(</span><span class="nb">type</span><span class="p">(</span><span class="n">mydict</span><span class="p">))</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>&lt;class 'dict'&gt;
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 1, 'b': 2, 'c': 3}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>딕셔너리는 여러 타입의 key를 가질 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'a'</span><span class="p">:</span> <span class="mi">1</span><span class="p">,</span> <span class="s1">'가'</span><span class="p">:</span><span class="mi">2</span><span class="p">,</span> <span class="mi">100</span><span class="p">:</span> <span class="mi">3</span><span class="p">,</span> <span class="mf">3.14</span><span class="p">:</span> <span class="mi">4</span><span class="p">,</span> <span class="kc">True</span><span class="p">:</span> <span class="mi">5</span><span class="p">}</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 1, '가': 2, 100: 3, 3.14: 4, True: 5}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="값-조회">값 조회</h3><ul>
<li>key 값으로 값을 조회할 수 있습니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'a'</span><span class="p">:</span> <span class="mi">1</span><span class="p">,</span> <span class="s1">'가'</span><span class="p">:</span><span class="mi">2</span><span class="p">,</span> <span class="mi">100</span><span class="p">:</span> <span class="mi">3</span><span class="p">,</span> <span class="mf">3.14</span><span class="p">:</span> <span class="mi">4</span><span class="p">,</span> <span class="kc">True</span><span class="p">:</span> <span class="mi">5</span><span class="p">}</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 1, '가': 2, 100: 3, 3.14: 4, True: 5}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>key를 지정하여 값을 조회할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="p">[</span><span class="s1">'a'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>1</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>key가 없는 경우 Error가 발생합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="p">[</span><span class="s1">'b'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="application/vnd.jupyter.stderr">
<pre>
<span class="ansi-red-fg">---------------------------------------------------------------------------</span>
<span class="ansi-red-fg">KeyError</span>                                  Traceback (most recent call last)
<span class="ansi-green-fg">&lt;ipython-input-50-a8dfdc4bddd9&gt;</span> in <span class="ansi-cyan-fg">&lt;module&gt;</span>
<span class="ansi-green-fg">----&gt; 1</span><span class="ansi-red-fg"> </span>mydict<span class="ansi-blue-fg">[</span><span class="ansi-blue-fg">'b'</span><span class="ansi-blue-fg">]</span>

<span class="ansi-red-fg">KeyError</span>: 'b'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>get()</code> 메서드를 활용하여 값을 조회할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s1">'a'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>1</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>get()</code>을 사용하면 key가 없는 경우라도 Error가 발생하지 않습니다. 단지 None이 반환됩니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s1">'b'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="keys()-:-모든-key-조회">keys() : 모든 key 조회</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'a'</span><span class="p">:</span> <span class="mi">100</span><span class="p">,</span> <span class="s1">'b'</span><span class="p">:</span> <span class="mi">200</span><span class="p">,</span> <span class="s1">'c'</span><span class="p">:</span> <span class="mi">300</span><span class="p">,</span> <span class="s1">'d'</span><span class="p">:</span> <span class="mi">400</span><span class="p">,</span> <span class="s1">'e'</span><span class="p">:</span> <span class="mi">500</span><span class="p">}</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 100, 'b': 200, 'c': 300, 'd': 400, 'e': 500}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">keys</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>dict_keys(['a', 'b', 'c', 'd', 'e'])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>[참고]</strong> <code>dict_keys</code></p>
<ul>
<li><code>dict_keys</code>는 리스트(list)가 아닙니다.</li>
<li>객체(object)로 생성되는데, 이를 list로 변경하기 위해서는 list()로 타입 변환을 하면 됩니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">list</span><span class="p">(</span><span class="n">mydict</span><span class="o">.</span><span class="n">keys</span><span class="p">())</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>['a', 'b', 'c', 'd', 'e']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="values()-:-모든-value-조회">values() : 모든 value 조회</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">values</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>dict_values([100, 200, 300, 400, 500])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="items()-:-모든-key,-value-조회">items() : 모든 key, value 조회</h3><ul>
<li>key, value가 튜플로 묶여서 조회됩니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">items</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>dict_items([('a', 100), ('b', 200), ('c', 300), ('d', 400), ('e', 500)])</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">list</span><span class="p">(</span><span class="n">mydict</span><span class="o">.</span><span class="n">items</span><span class="p">())</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>[('a', 100), ('b', 200), ('c', 300), ('d', 400), ('e', 500)]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="key-값의-존재-유무-확인">key 값의 존재 유무 확인</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="s1">'a'</span> <span class="ow">in</span> <span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>True</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="s1">'f'</span> <span class="ow">in</span> <span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>False</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="값을-추가하기">값을 추가하기</h3><ul>
<li>새로운 key에 값을 대입하여 추가</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="nb">dict</span><span class="p">()</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="p">[</span><span class="s1">'apple'</span><span class="p">]</span> <span class="o">=</span> <span class="mi">123</span>
<span class="n">mydict</span><span class="p">[</span><span class="s1">'apple'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>123</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">=</span> <span class="mi">2</span>
<span class="n">mydict</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>2</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="update()-:-다중-업데이트">update() : 다중 업데이트</h3><ul>
<li>값을 한꺼번에 업데이트 합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'파인애플'</span><span class="p">:</span> <span class="mi">1500</span><span class="p">,</span> <span class="s1">'망고'</span><span class="p">:</span> <span class="mi">3500</span><span class="p">,</span> <span class="s1">'배'</span><span class="p">:</span> <span class="mi">1000</span><span class="p">}</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'파인애플': 1500, '망고': 3500, '배': 1000}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">fruit</span> <span class="o">=</span> <span class="p">{</span>
    <span class="s1">'사과'</span><span class="p">:</span> <span class="mi">2000</span><span class="p">,</span> 
    <span class="s1">'딸기'</span><span class="p">:</span> <span class="mi">3000</span><span class="p">,</span> 
    <span class="s1">'수박'</span><span class="p">:</span> <span class="mi">5000</span><span class="p">,</span> 
<span class="p">}</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">update</span><span class="p">(</span><span class="n">fruit</span><span class="p">)</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'파인애플': 1500, '망고': 3500, '배': 1000, '사과': 2000, '딸기': 3000, '수박': 5000}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="값-변경">값 변경</h3><ul>
<li>key 값에 새로운 값(value)를 대입하여 값을 변경할 수 있습니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'a'</span><span class="p">:</span> <span class="mi">100</span><span class="p">,</span> <span class="s1">'b'</span><span class="p">:</span> <span class="mi">200</span><span class="p">,</span> <span class="s1">'c'</span><span class="p">:</span> <span class="mi">300</span><span class="p">,</span> <span class="s1">'d'</span><span class="p">:</span> <span class="mi">400</span><span class="p">,</span> <span class="s1">'e'</span><span class="p">:</span> <span class="mi">500</span><span class="p">}</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 100, 'b': 200, 'c': 300, 'd': 400, 'e': 500}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="p">[</span><span class="s1">'a'</span><span class="p">]</span> <span class="o">=</span> <span class="mi">900</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 900, 'b': 200, 'c': 300, 'd': 400, 'e': 500}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="제거하기-/-key-제거">제거하기 / key 제거</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'a'</span><span class="p">:</span> <span class="mi">100</span><span class="p">,</span> <span class="s1">'b'</span><span class="p">:</span> <span class="mi">200</span><span class="p">,</span> <span class="s1">'c'</span><span class="p">:</span> <span class="mi">300</span><span class="p">,</span> <span class="s1">'d'</span><span class="p">:</span> <span class="mi">400</span><span class="p">,</span> <span class="s1">'e'</span><span class="p">:</span> <span class="mi">500</span><span class="p">}</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 100, 'b': 200, 'c': 300, 'd': 400, 'e': 500}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>del</code> 값을 제거할 수 있습니다.</p>
<p><code>del</code>에 딕셔너리 key를 지정합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">del</span> <span class="n">mydict</span><span class="p">[</span><span class="s1">'a'</span><span class="p">]</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'b': 200, 'c': 300, 'd': 400, 'e': 500}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>pop()</code> 에 key를 지정하여 값을 제거할 수 있습니다.</p>
<p>제거되는 값의 value를 반환합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">pop</span><span class="p">(</span><span class="s1">'b'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>200</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'c': 300, 'd': 400, 'e': 500}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="len()-:-요소의-개수-파악">len() : 요소의 개수 파악</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">len</span><span class="p">(</span><span class="n">mydict</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>3</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="clear()---전부-삭제">clear() - 전부 삭제</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'a'</span><span class="p">:</span> <span class="mi">100</span><span class="p">,</span> <span class="s1">'b'</span><span class="p">:</span> <span class="mi">200</span><span class="p">,</span> <span class="s1">'c'</span><span class="p">:</span> <span class="mi">300</span><span class="p">,</span> <span class="s1">'d'</span><span class="p">:</span> <span class="mi">400</span><span class="p">,</span> <span class="s1">'e'</span><span class="p">:</span> <span class="mi">500</span><span class="p">}</span>
<span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'a': 100, 'b': 200, 'c': 300, 'd': 400, 'e': 500}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span><span class="o">.</span><span class="n">clear</span><span class="p">()</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mydict</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{}</pre>
</div>
</div>
</div>
</div>
</div>
</body>