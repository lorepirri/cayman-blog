---
layout: page
title: "#09-파이썬(Python) 함수, lambda 함수, 인수(arguments), 매개변수(parameters)"
description: "파이썬(Python) 함수를 알아보고 튜토리얼을 진행합니다."
headline: "파이썬(Python) 함수를 알아보고 튜토리얼을 진행합니다."
categories: python
tags: [python, 함수, function, 파이썬, 자료구조, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-06-01
---

본 포스팅은 **파이썬(Python) 코딩 입문자를 위한 튜토리얼** 시리즈 연재 중 일부입니다. 이번 튜토리얼에서는 파이썬의 **함수(function)**, **lambda 함수**, **인수(arguments)**와 **매개변수(parameters)**를 다룹니다.

<h2 id="코드">코드</h2>

<p><img src="../images/2020-09-24/colab_logo_32px.png" alt="Colab으로 열기" /> <a href="https://colab.research.google.com/github/teddylee777/machine-learning/blob/master/00-Python/09-%ED%8C%8C%EC%9D%B4%EC%8D%AC-%ED%95%A8%EC%88%98.ipynb" target="_blank">Colab으로 열기</a></p>

<p><img src="../images/2020-09-24/GitHub-Mark-32px.png" alt="GitHub" /> <a href="https://github.com/teddylee777/machine-learning/blob/master/00-Python/09-%ED%8C%8C%EC%9D%B4%EC%8D%AC-%ED%95%A8%EC%88%98.ipynb" target="_blank">GitHub에서 소스보기</a></p>

<br/>

<body class="jp-Notebook" data-jp-theme-light="true" data-jp-theme-name="JupyterLab Light">
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h1 id="함수(function)">함수(function)</h1><ul>
<li>자주 사용되는 코드 및 <strong>반복되는 코드를 모아 하나의 기능</strong>으로 만들고 이름을 붙인 것입니다.</li>
<li>즉, 함수의 가장 중요한 기능은 바로 <strong>코드의 재사용성</strong>입니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="함수의-기본-구조">함수의 기본 구조</h2><ul>
<li><code>def</code> 키워드로 시작합니다.</li>
<li>함수명을 기입합니다.</li>
<li>() 안에 매개변수를 지정할 수 있고, 생략도 가능합니다.</li>
<li>끝에는 <code>:</code>으로 끝납니다.</li>
<li>함수의 범위 안에서는 <strong>들여쓰기</strong>를 합니다. 들여쓰기가 끝난 지점이 함수의 범위가 끝나는 지점입니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>(예시)</strong></p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="n">b</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span>
    <span class="k">return</span> <span class="n">result</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="함수의-다양한-형태">함수의 다양한 형태</h2>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="일반-형태">일반 형태</h3><ul>
<li>입력 매개변수: O</li>
<li>return: O</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">sample_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="n">b</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span>
    <span class="k">return</span> <span class="n">result</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="입력-매개변수가-없는-형태">입력 매개변수가 없는 형태</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">sample_function</span><span class="p">():</span>
    <span class="n">a</span> <span class="o">=</span> <span class="mi">1</span>
    <span class="n">b</span> <span class="o">=</span> <span class="mi">2</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span>
    <span class="k">return</span> <span class="n">result</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="return-이-없는-형태">return 이 없는 형태</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">sample_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="n">b</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'result: </span><span class="si">{</span><span class="n">result</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="입력-매개변수,-return-모두-없는-형태">입력 매개변수, return 모두 없는 형태</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">sample_function</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'Hello, World!'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="함수의-이름-및-호출">함수의 이름 및 호출</h2><ul>
<li>함수의 이름은 알파벳이나 <code>_</code>로 시작해야 합니다.</li>
<li>함수의 지정된 이름과 () 로 <strong>호출</strong> 할 수 있습니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">sample_function</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'함수가 호출 되었습니다!'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>함수의 이름만 출력시</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">sample_function</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>&lt;function __main__.sample_function()&gt;</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>호출(call)</strong>: 함수의 이름과 함께 <code>()</code>를 같이 실행</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">sample_function</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>함수가 호출 되었습니다!
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>함수의 이름을 별도의 변수에 대입한 후 변수에 <code>()</code>를 같이 실행한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="n">sample_function</span>
<span class="n">a</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>함수가 호출 되었습니다!
</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># return 이 존재하는 경우</span>
<span class="k">def</span> <span class="nf">sample_function</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'함수가 호출 되었습니다!'</span><span class="p">)</span>
    <span class="k">return</span> <span class="mi">123</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>return 값이 존재</strong>하는 경우 함수는 결과 값을 <strong>반환</strong> 하며 반환된 결과를 변수에 대입할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">result</span> <span class="o">=</span> <span class="n">sample_function</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>함수가 호출 되었습니다!
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">result</span>
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
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>하지만, 함수가 아무런 결과 값을 반환하지 않는다면 함수로부터 반환된 결과는 <code>None</code>입니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># return 이 없는 경우</span>
<span class="k">def</span> <span class="nf">sample_function</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'함수가 호출 되었습니다!'</span><span class="p">)</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">result</span> <span class="o">=</span> <span class="n">sample_function</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>함수가 호출 되었습니다!
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
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="n">result</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>None
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="docstring">docstring</h2><ul>
<li>함수에 대한 설명을 기록</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">sample_function</span><span class="p">():</span>
    <span class="sd">"""</span>
<span class="sd">    함수에 대한 설명을 기록합니다.</span>
<span class="sd">    sample_function은 함수를 설명하기 위한 예제 함수 입니다.</span>
<span class="sd">    </span>
<span class="sd">    (예시)</span>
<span class="sd">    호출의 예.</span>
<span class="sd">    sample_function()</span>
<span class="sd">    """</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'함수가 호출 되었습니다.'</span><span class="p">)</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">sample_function</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>함수가 호출 되었습니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>함수명.__doc__</code>로 docstring을 출력할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="n">sample_function</span><span class="o">.</span><span class="vm">__doc__</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>
    함수에 대한 설명을 기록합니다.
    sample_function은 함수를 설명하기 위한 예제 함수 입니다.
    
    (예시)
    호출의 예.
    sample_function()
    
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="함수의-인수(매개변수)">함수의 인수(매개변수)</h2><p><strong>[참고]</strong></p>
<ul>
<li><strong>인수(argument)</strong>: 값, 변수, 참조 등 전달되는 값</li>
<li><strong>매개변수(parameter)</strong>: 함수 등에서 사용되는 전달된 값을 받는 변수</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<ul>
<li><code>10</code>, <code>20</code> 이라는 값은 인수(argument)</li>
<li><code>a</code>, <code>b</code>는 매개변수(parameter)</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">some_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="n">b</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span>
    <span class="k">return</span> <span class="n">result</span>

<span class="n">some_function</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>30</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="위치-인수(positional-arguments)">위치 인수(positional arguments)</h3><ul>
<li>가장 보편적인 인수입니다.</li>
<li>변수명을 인수로 지정합니다.</li>
<li>위치가 중요합니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>a</code>, <code>b</code>, <code>c</code>를 위치인수로 지정한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="n">b</span><span class="p">,</span> <span class="n">c</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span> <span class="o">+</span> <span class="n">c</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'a: </span><span class="si">{</span><span class="n">a</span><span class="si">}</span><span class="s1">, b: </span><span class="si">{</span><span class="n">b</span><span class="si">}</span><span class="s1">, c: </span><span class="si">{</span><span class="n">c</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'sum: </span><span class="si">{</span><span class="n">result</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">result</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">5</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 1, b: 3, c: 5
sum: 9
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>9</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="키워드-인수(keyword-arguments)">키워드 인수(keyword arguments)</h3><ul>
<li>위치 인수의 위치를 정확히 기억 하지 못하고 혼란을 야기할 수 있기 때문에 <strong>인수명에 값을 직접 지정</strong>합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="n">b</span><span class="p">,</span> <span class="n">c</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span> <span class="o">+</span> <span class="n">c</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'a: </span><span class="si">{</span><span class="n">a</span><span class="si">}</span><span class="s1">, b: </span><span class="si">{</span><span class="n">b</span><span class="si">}</span><span class="s1">, c: </span><span class="si">{</span><span class="n">c</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'sum: </span><span class="si">{</span><span class="n">result</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">result</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>아래의 예제는 키워드로 매개변수에 대한 값을 지정하는 예시입니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="n">b</span><span class="o">=</span><span class="mi">3</span><span class="p">,</span> <span class="n">c</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">a</span><span class="o">=</span><span class="mi">5</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 5, b: 3, c: 1
sum: 9
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>9</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="기본-매개변수(default-parameter)">기본 매개변수(default parameter)</h3><ul>
<li>매개변수에 <strong>기본 값을 지정</strong>할 수 있습니다.</li>
<li>기본 값을 지정시 인수에 값을 <strong>생략 가능</strong>합니다.</li>
<li>단, 기본 값이 지정된 인수는 위치 인수보다 다음에 위치해야 합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="n">b</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">c</span><span class="o">=</span><span class="mi">0</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span> <span class="o">+</span> <span class="n">c</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'a: </span><span class="si">{</span><span class="n">a</span><span class="si">}</span><span class="s1">, b: </span><span class="si">{</span><span class="n">b</span><span class="si">}</span><span class="s1">, c: </span><span class="si">{</span><span class="n">c</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'sum: </span><span class="si">{</span><span class="n">result</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">result</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 1, b: 0, c: 0
sum: 1
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>1</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">3</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 1, b: 3, c: 0
sum: 4
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>4</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">5</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 1, b: 3, c: 5
sum: 9
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>9</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="n">c</span><span class="o">=</span><span class="mi">5</span><span class="p">,</span> <span class="n">b</span><span class="o">=</span><span class="mi">3</span><span class="p">,</span> <span class="n">a</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 1, b: 3, c: 5
sum: 9
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>9</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>기본 매개변수가 <strong>위치 인수보다 앞 쪽에 위치한 경우 Error</strong>가 발생합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="n">a</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">b</span><span class="p">,</span> <span class="n">c</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="n">a</span> <span class="o">+</span> <span class="n">b</span> <span class="o">+</span> <span class="n">c</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'a: </span><span class="si">{</span><span class="n">a</span><span class="si">}</span><span class="s1">, b: </span><span class="si">{</span><span class="n">b</span><span class="si">}</span><span class="s1">, c: </span><span class="si">{</span><span class="n">c</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'sum: </span><span class="si">{</span><span class="n">result</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">result</span>
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
<span class="ansi-cyan-fg">  File </span><span class="ansi-green-fg">"&lt;ipython-input-29-8487cf0d9f78&gt;"</span><span class="ansi-cyan-fg">, line </span><span class="ansi-green-fg">1</span>
<span class="ansi-red-fg">    def add_function(a=0, b, c):</span>
                    ^
<span class="ansi-red-fg">SyntaxError</span><span class="ansi-red-fg">:</span> non-default argument follows default argument
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="*tuple-인수">*tuple 인수</h3><ul>
<li>여러 개의 인수를 전달 받을 수 있습니다.</li>
<li>여러 개의 인수를 전달 받은 <code>*args</code>에는 튜플(tuple) 형식으로 데이터가 저장됩니다.</li>
<li><code>*args</code>로 받은 인수는 반복문으로 처리하는 것이 일반 적입니다.</li>
<li>대체적으로 <code>*args</code> 변수가 많이 사용됩니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="o">*</span><span class="n">args</span><span class="p">):</span>
    <span class="n">result</span> <span class="o">=</span> <span class="mi">0</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'args의 타입: </span><span class="si">{</span><span class="nb">type</span><span class="p">(</span><span class="n">args</span><span class="p">)</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">for</span> <span class="n">arg</span> <span class="ow">in</span> <span class="n">args</span><span class="p">:</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">arg</span><span class="p">)</span>
        <span class="n">result</span> <span class="o">+=</span> <span class="n">arg</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'==='</span><span class="o">*</span> <span class="mi">5</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'sum: </span><span class="si">{</span><span class="n">result</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>아무런 값을 전달하지 않은 경우(생략 가능)</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>args의 타입: &lt;class 'tuple'&gt;
===============
sum: 0
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>1개의 값을 전달한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>args의 타입: &lt;class 'tuple'&gt;
1
===============
sum: 1
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>복수의 값을 전달한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>args의 타입: &lt;class 'tuple'&gt;
1
2
3
4
5
===============
sum: 15
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="위치-매개변수와-*tuple-매개변수의-혼용">위치 매개변수와 *tuple 매개변수의 혼용</h3><ul>
<li>*tuple 매개변수는 위치 매개변수의 뒤에 위치해야 합니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="n">a</span><span class="p">,</span> <span class="o">*</span><span class="n">args</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'a: </span><span class="si">{</span><span class="n">a</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'==='</span><span class="o">*</span> <span class="mi">5</span><span class="p">)</span>
    <span class="n">result</span> <span class="o">=</span> <span class="mi">0</span>
    <span class="k">for</span> <span class="n">arg</span> <span class="ow">in</span> <span class="n">args</span><span class="p">:</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">arg</span><span class="p">)</span>
        <span class="n">result</span> <span class="o">+=</span> <span class="n">arg</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'==='</span><span class="o">*</span> <span class="mi">5</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'sum: </span><span class="si">{</span><span class="n">result</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>아무런 값을 지정하지 않은 경우</p>
<ul>
<li>위치 매개변수 미지정으로 인한 Error 발생</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">()</span>
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
<span class="ansi-red-fg">TypeError</span>                                 Traceback (most recent call last)
<span class="ansi-green-fg">&lt;ipython-input-35-1553848aed78&gt;</span> in <span class="ansi-cyan-fg">&lt;module&gt;</span>
<span class="ansi-green-fg">----&gt; 1</span><span class="ansi-red-fg"> </span>add_function<span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">)</span>

<span class="ansi-red-fg">TypeError</span>: add_function() missing 1 required positional argument: 'a'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>단일 값을 지정한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 1
===============
===============
sum: 0
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>복수의 값을 지정한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>a: 1
===============
2
3
4
5
===============
sum: 14
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="**dict-인수">**dict 인수</h3><ul>
<li>여러 개의 인수를 전달 받을 수 있습니다.</li>
<li>여러 개의 인수를 전달 받은 <code>**kwargs</code>에는 딕셔너리(dict) 형식으로 데이터가 저장됩니다.</li>
<li><code>**kwargs</code>로 받은 인수 역시 반복문으로 처리하는 것이 일반 적입니다.</li>
<li>대체적으로 <code>**kwargs</code> 변수가 많이 사용됩니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">add_function</span><span class="p">(</span><span class="o">**</span><span class="n">kwargs</span><span class="p">):</span>
    <span class="n">total_age</span> <span class="o">=</span> <span class="mi">0</span>
    <span class="k">for</span> <span class="n">name</span><span class="p">,</span> <span class="n">age</span> <span class="ow">in</span> <span class="n">kwargs</span><span class="o">.</span><span class="n">items</span><span class="p">():</span>
        <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'이름: </span><span class="si">{</span><span class="n">name</span><span class="si">}</span><span class="s1">, 나이: </span><span class="si">{</span><span class="n">age</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
        <span class="n">total_age</span> <span class="o">+=</span> <span class="n">age</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'==='</span><span class="o">*</span> <span class="mi">5</span><span class="p">)</span>
    <span class="nb">print</span><span class="p">(</span><span class="sa">f</span><span class="s1">'전체 나이의 합계: </span><span class="si">{</span><span class="n">total_age</span><span class="si">}</span><span class="s1">'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>아무런 값을 지정하지 않은 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>===============
전체 나이의 합계: 0
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>단일 값을 지정한 경우</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="n">lee</span><span class="o">=</span><span class="mi">5</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>이름: lee, 나이: 5
===============
전체 나이의 합계: 5
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="n">john</span><span class="o">=</span><span class="mi">10</span><span class="p">,</span> <span class="n">peter</span><span class="o">=</span><span class="mi">12</span><span class="p">,</span> <span class="n">lee</span><span class="o">=</span><span class="mi">5</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>이름: john, 나이: 10
이름: peter, 나이: 12
이름: lee, 나이: 5
===============
전체 나이의 합계: 27
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>딕셔너리(dictionary)를 인수로 지정하는 경우 <code>**</code>를 앞에 붙혀 줍니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">person</span> <span class="o">=</span> <span class="p">{</span><span class="s1">'john'</span><span class="p">:</span> <span class="mi">10</span><span class="p">,</span> <span class="s1">'peter'</span><span class="p">:</span> <span class="mi">12</span><span class="p">,</span> <span class="s1">'lee'</span><span class="p">:</span> <span class="mi">5</span><span class="p">}</span>
<span class="n">person</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>{'john': 10, 'peter': 12, 'lee': 5}</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">add_function</span><span class="p">(</span><span class="o">**</span><span class="n">person</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>이름: john, 나이: 10
이름: peter, 나이: 12
이름: lee, 나이: 5
===============
전체 나이의 합계: 27
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="lambda-:-익명-함수(annonymous-function)">lambda : 익명 함수(annonymous function)</h2><ul>
<li>이름 없이 정의된 함수 입니다.</li>
<li><strong>단일 문장(1줄)</strong>의 코드로 작성되어야 합니다.</li>
<li>함수 내부에서는 return문이 포함하지 않지만 값을 반환합니다.</li>
</ul>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>단일 인수</strong>를 가지는 lambda 함수</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="n">x</span> <span class="o">*</span> <span class="mi">2</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="mi">4</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>8</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>2개의 인수</strong>를 가지는 lambda 함수</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="k">lambda</span> <span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="p">:</span> <span class="n">x</span> <span class="o">*</span> <span class="n">y</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="mi">4</span><span class="p">,</span> <span class="mi">8</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>32</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>기본 값이 지정된 인수</strong>를 가지는 lambda 함수</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="k">lambda</span> <span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="o">=</span><span class="mi">10</span><span class="p">:</span> <span class="n">x</span> <span class="o">*</span> <span class="n">y</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="mi">3</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>30</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>키워드 인수</strong>를 지정하는 lambda 함수</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="n">y</span><span class="o">=</span><span class="mi">5</span><span class="p">,</span> <span class="n">x</span><span class="o">=</span><span class="mi">3</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>15</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>lambda 함수 내부에서 <strong>조건문</strong> 사용</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="k">lambda</span> <span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="p">:</span> <span class="n">x</span> <span class="o">*</span> <span class="n">y</span> <span class="k">if</span> <span class="n">x</span> <span class="o">&gt;</span> <span class="mi">0</span> <span class="k">else</span> <span class="n">y</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="mi">4</span><span class="p">,</span> <span class="mi">8</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>32</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="o">-</span><span class="mi">1</span><span class="p">,</span> <span class="mi">8</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>8</pre>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>다음과 같이 <code>elif</code> 구문을 억지로 생성할 수 있습니다.</p>
<p>하지만, 복잡한 조건문을 사용하기 위해서는 일반적인 함수 사용을 권장합니다. (코드의 가독성이 떨어집니다.)</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="n">x</span> <span class="o">*</span> <span class="mi">10</span> <span class="k">if</span> <span class="n">x</span> <span class="o">&lt;</span> <span class="mi">2</span> <span class="k">else</span> <span class="p">(</span><span class="n">x</span><span class="o">**</span><span class="mi">2</span> <span class="k">if</span> <span class="n">x</span> <span class="o">&lt;</span> <span class="mi">4</span> <span class="k">else</span> <span class="n">x</span> <span class="o">+</span> <span class="mi">10</span><span class="p">)</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>10</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="mi">3</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>9</pre>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span><span class="p">(</span><span class="mi">4</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/plain">
<pre>14</pre>
</div>
</div>
</div>
</div>
</div>
</body>