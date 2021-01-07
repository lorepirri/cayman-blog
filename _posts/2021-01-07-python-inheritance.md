---
layout: page
title: "Python 클래스의 상속 (inheritance)"
description: "Python 클래스의 상속 (inheritance) 방법에 대하여 알아보겠습니다."
headline: "Python 클래스의 상속 (inheritance) 방법에 대하여 알아보겠습니다."
categories: python
tags: [python, inheritance, class, 상속, 클래스, 텐서플로우, 텐서플로우 강의, 텐서플로우 튜토리얼, TensorFlow Tutorial, data science, 데이터 분석, 딥러닝]
comments: true
published: true
typora-copy-images-to: ../images/2021-01-07
---

텐서플로의 Model Subclassing 구현을 위해서는 python의 상속(inheritance) 개념을 필히 알고 있어야 합니다. 
그래서, 이번 포스팅에서는 python의 클래스 그리고 상속에 대한 내용을 다뤄 보도록 하겠습니다.

다만, Python의 클래스 기능은 이번 포스팅에서 모두 다루지 않고, TensorFlow에서 Model Subclassing 구현을 위한 가장 기본적인 내용만 다루도록 하겠습니다.
본 내용만 확실히 익혀도 Model Subclassing에는 큰 문제가 없을겁니다.

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Python의-Class와-상속(inheritance)의-개념">Python의 Class와 상속(inheritance)의 개념</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>Python 문법에서의 상속(inheritance)란, <strong>부모 클래스(Super Class)</strong>의 속성(property)과 함수(method)를 그대로 물려 받는 개념입니다.</li>
<li>Super Class의 내용을 <strong>자식 클래스(Child Class)</strong>가 물려 받게 되면, <strong>Super Class의 속성과 함수를 자식 클래스에서 사용</strong>할 수 있습니다.</li>
<li>자식클래스의 함수를 재정의하게 되면, <strong>재정의된 함수로 실행</strong>되게 됩니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Person</span><span class="p">:</span>
    <span class="sd">"""Super Class"""</span>

    <span class="n">name</span> <span class="o">=</span> <span class="s1">'홍길동'</span>
    <span class="n">age</span> <span class="o">=</span> <span class="mi">1</span>
    
    <span class="c1"># class내 정의된 함수(method)</span>
    <span class="k">def</span> <span class="nf">introduce</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 이름은 </span><span class="si">{self.name}</span><span class="s1"> 이고, 나이는 </span><span class="si">{self.age}</span><span class="s1">살 입니다.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Student</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Child Class"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">name</span><span class="p">,</span> <span class="n">age</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">name</span> <span class="o">=</span> <span class="n">name</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="n">age</span>

    <span class="k">def</span> <span class="nf">print_name</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 이름은 </span><span class="si">{self.name}</span><span class="s1"> 입니다.'</span><span class="p">)</span>
        
    <span class="k">def</span> <span class="nf">print_age</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 나이는 </span><span class="si">{self.age}</span><span class="s1"> 입니다.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">person</span> <span class="o">=</span> <span class="n">Person</span><span class="p">()</span>
<span class="n">person</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>제 이름은 홍길동 이고, 나이는 1살 입니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Child-Class-에서의-오류">Child Class 에서의 오류</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Student 클래스는 Person 클래스를 상속받아 구현하게 되면서, 생성자 (<strong>init</strong>) 함수에서 <code>name</code>, <code>age</code> argument를 요구합니다. 이 Rule을 지켜주지 못하면 에러가 발생합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span> <span class="o">=</span> <span class="n">Student</span><span class="p">()</span>
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
<span class="ansi-red-fg">TypeError</span>                                 Traceback (most recent call last)
<span class="ansi-green-fg">&lt;ipython-input-23-dad15f7b6673&gt;</span> in <span class="ansi-cyan-fg">&lt;module&gt;</span><span class="ansi-blue-fg">()</span>
<span class="ansi-green-fg">----&gt; 1</span><span class="ansi-red-fg"> </span>student <span class="ansi-blue-fg">=</span> Student<span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">)</span>

<span class="ansi-red-fg">TypeError</span>: __init__() missing 2 required positional arguments: 'name' and 'age'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span> <span class="o">=</span> <span class="n">Student</span><span class="p">(</span><span class="s1">'피터'</span><span class="p">,</span> <span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span><span class="o">.</span><span class="n">print_name</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>제 이름은 피터 입니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span><span class="o">.</span><span class="n">print_age</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>제 나이는 20 입니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Student 클래스에서 introduce() 함수를 구현한 적이 없지만, 실행이 가능한 이유는 Super Class에서 이미 <code>introduce()</code>가 구현되어 있기 때문입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>제 이름은 피터 이고, 나이는 20살 입니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Teacher</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Child Claselfself"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">name</span><span class="p">,</span> <span class="n">age</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">name</span> <span class="o">=</span> <span class="n">name</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="n">age</span>

    <span class="k">def</span> <span class="nf">print_name</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 이름은 </span><span class="si">{self.name}</span><span class="s1"> 입니다.'</span><span class="p">)</span>
        
    <span class="k">def</span> <span class="nf">print_age</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 나이는 </span><span class="si">{self.age}</span><span class="s1"> 입니다.'</span><span class="p">)</span>
        
    <span class="k">def</span> <span class="nf">introduce</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">selfubject</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'저는 선생님입니다. 전공과목은 </span><span class="si">{selfubject}</span><span class="s1"> 입니다.'</span><span class="p">)</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 이름은 </span><span class="si">{self.name}</span><span class="s1"> 이고, 나이는 </span><span class="si">{self.age}</span><span class="s1">살 입니다.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>class 에 속한 함수 (method)는 첫 번째 인자로 <code>self</code>를 입력합니다. (사실 self가 아니어도 상관없지만, 일반적으로 self를 많이 사용합니다.)</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">teacher</span> <span class="o">=</span> <span class="n">Teacher</span><span class="p">(</span><span class="s1">'해리'</span><span class="p">,</span> <span class="mi">50</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">teacher</span><span class="o">.</span><span class="n">introduce</span><span class="p">(</span><span class="s1">'수학'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>저는 선생님입니다. 전공과목은 수학 입니다.
제 이름은 해리 이고, 나이는 50살 입니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="상속-구조-확인">상속 구조 확인</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">Teacher</span><span class="o">.</span><span class="n">mro</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>[__main__.Teacher, __main__.Person, object]</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>