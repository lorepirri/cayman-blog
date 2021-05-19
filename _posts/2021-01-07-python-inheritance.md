---
layout: page
title: "Python 클래스의 상속 (inheritance)"
description: "Python 클래스의 상속 (inheritance) 방법에 대하여 알아보겠습니다."
headline: "Python 클래스의 상속 (inheritance) 방법에 대하여 알아보겠습니다."
categories: python
tags: [python, inheritance, class, 상속, 클래스, 텐서플로우, 텐서플로우 강의, 텐서플로우 튜토리얼, TensorFlow Tutorial, data science, 데이터 분석, 딥러닝]
comments: true
published: true
typora-copy-images-to: ../images/2021-01-08
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
<li>Super Class의 내용을 <strong>자식 클래스(Sub Class)</strong>가 물려 받게 되면, <strong>Super Class의 속성과 함수를 자식 클래스에서 사용</strong>할 수 있습니다.</li>
<li>class 에 속한 함수 (method)는 첫 번째 인자로 <code>self</code>를 입력합니다. (사실 self가 아니어도 상관없지만, 일반적으로 self를 많이 사용합니다.)</li>
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
    <span class="c1"># 클래스 변수</span>
    <span class="n">total_count</span> <span class="o">=</span> <span class="mi">0</span>
    
    <span class="c1"># 생성자 메서드(method)</span>
    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">name</span> <span class="o">=</span> <span class="s1">'홍길동'</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="mi">1</span>
        <span class="n">Person</span><span class="o">.</span><span class="n">total_count</span><span class="o">+=</span><span class="mi">1</span>
    
    <span class="c1"># class내 정의된 메서드(method)</span>
    <span class="k">def</span> <span class="nf">introduce</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 이름은 </span><span class="si">{self.name}</span><span class="s1"> 이고, 나이는 </span><span class="si">{self.age}</span><span class="s1">살 입니다.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="인스턴스(instance)-생성과-객체(object)">인스턴스(instance) 생성과 객체(object)</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>객체는 바로 밑의 예시에서 p1, p2, p3를 일컫습니다.</p>
<p>정의된 클래스(class)로부터 생성된 녀석을 <strong>인스턴스(instance) 혹은 객체(object)</strong>라고 합니다.</p>
<p>하지만, 용어의 온도차(?)는 존재합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">p1</span> <span class="o">=</span> <span class="n">Person</span><span class="p">()</span>
<span class="n">p2</span> <span class="o">=</span> <span class="n">Person</span><span class="p">()</span>
<span class="n">p3</span> <span class="o">=</span> <span class="n">Person</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">p1</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
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
<h3 id="객체와-인스턴스의-차이">객체와 인스턴스의 차이</h3><p><strong><a href="https://wikidocs.net/28">점프투 파이썬</a>의 좋은 설명을 인용하도록 하겠습니다.</strong></p>
<hr/>
<p>클래스로 만든 객체를 인스턴스라고도 한다.</p>
<p>그렇다면 객체와 인스턴스의 차이는 무엇일까?</p>
<p>이렇게 생각해 보자. <code>p1 = Person()</code> 이렇게 만든 <code>p1</code>는 <strong>객체</strong>이다.</p>
<p>그리고 <code>p1</code> 객체는 Person의 <strong>인스턴스</strong>이다.</p>
<p>즉 <strong>인스턴스</strong>라는 말은 특정 객체(p1)가 어떤 클래스(Person)의 객체인지를 관계 위주로 설명할 때 사용한다.</p>
<p><strong>"p1는 인스턴스"</strong>보다는 <strong>"p1은 객체"</strong>라는 표현이 어울리며 <strong>"p1는 Person의 객체"</strong>보다는 <strong>"p1은 Person의 인스턴스"</strong>라는 표현이 훨씬 잘 어울린다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="클래스-변수의-출력">클래스 변수의 출력</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>클래스 변수는 모든 클래스가 공유하게 됩니다. 클래스의 객체가 <strong>3번</strong> 만들어 졌기 때문에 <strong>3이 출력</strong>되는 것을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">p1</span><span class="o">.</span><span class="vm">__class__</span><span class="o">.</span><span class="n">total_count</span>
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
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Person</span><span class="p">:</span>
    <span class="sd">"""Super Class"""</span>
    <span class="c1"># 클래스 변수</span>
    <span class="n">total_count</span> <span class="o">=</span> <span class="mi">0</span>
    
    <span class="c1"># 생성자 메서드</span>
    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">name</span><span class="p">,</span> <span class="n">age</span><span class="p">):</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">name</span> <span class="o">=</span> <span class="n">name</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="n">age</span>
        <span class="n">Person</span><span class="o">.</span><span class="n">total_count</span><span class="o">+=</span><span class="mi">1</span>
    
    <span class="c1"># class내 정의된 함수(method)</span>
    <span class="k">def</span> <span class="nf">introduce</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'제 이름은 </span><span class="si">{self.name}</span><span class="s1"> 이고, 나이는 </span><span class="si">{self.age}</span><span class="s1">살 입니다.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>다음을 실행시 <em>오류</em>가 발생합니다.</p>
<p><strong>생성자 메서드가 재정의</strong> 되었기 때문입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">p4</span> <span class="o">=</span> <span class="n">Person</span><span class="p">()</span>
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
<span class="ansi-green-fg">&lt;ipython-input-6-1e96c1bf9b60&gt;</span> in <span class="ansi-cyan-fg">&lt;module&gt;</span><span class="ansi-blue-fg">()</span>
<span class="ansi-green-fg">----&gt; 1</span><span class="ansi-red-fg"> </span>p4 <span class="ansi-blue-fg">=</span> Person<span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">)</span>

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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">p5</span> <span class="o">=</span> <span class="n">Person</span><span class="p">(</span><span class="s1">'김철수'</span><span class="p">,</span> <span class="mi">22</span><span class="p">)</span>
<span class="n">p5</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>제 이름은 김철수 이고, 나이는 22살 입니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="클래스-상속-(inheritance)-받기">클래스 상속 (inheritance) 받기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Student</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Sub Class"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>

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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">s1</span> <span class="o">=</span> <span class="n">Student</span><span class="p">()</span>
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
<span class="ansi-green-fg">&lt;ipython-input-9-906bfe3cbabc&gt;</span> in <span class="ansi-cyan-fg">&lt;module&gt;</span><span class="ansi-blue-fg">()</span>
<span class="ansi-green-fg">----&gt; 1</span><span class="ansi-red-fg"> </span>s1 <span class="ansi-blue-fg">=</span> Student<span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">)</span>

<span class="ansi-green-fg">&lt;ipython-input-8-ed9ff6a99777&gt;</span> in <span class="ansi-cyan-fg">__init__</span><span class="ansi-blue-fg">(self)</span>
<span class="ansi-green-intense-fg ansi-bold">      3</span> 
<span class="ansi-green-intense-fg ansi-bold">      4</span>     <span class="ansi-green-fg">def</span> __init__<span class="ansi-blue-fg">(</span>self<span class="ansi-blue-fg">)</span><span class="ansi-blue-fg">:</span>
<span class="ansi-green-fg">----&gt; 5</span><span class="ansi-red-fg">         </span>super<span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">)</span><span class="ansi-blue-fg">.</span>__init__<span class="ansi-blue-fg">(</span><span class="ansi-blue-fg">)</span>
<span class="ansi-green-intense-fg ansi-bold">      6</span> 
<span class="ansi-green-intense-fg ansi-bold">      7</span>     <span class="ansi-green-fg">def</span> print_name<span class="ansi-blue-fg">(</span>self<span class="ansi-blue-fg">)</span><span class="ansi-blue-fg">:</span>

<span class="ansi-red-fg">TypeError</span>: __init__() missing 2 required positional arguments: 'name' and 'age'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>오류를 어떻게 해결할 수 있을까?</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Sub-Class-에서의-오류">Sub Class 에서의 오류</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Student 클래스는 Person 클래스를 상속받아 구현하게 되면서, 생성자 (<strong>init</strong>) 함수에서 <code>name</code>, <code>age</code> argument를 요구합니다. 이 Rule을 지켜주지 못하면 에러가 발생합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="첫-번째-해결책">첫 번째 해결책</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>super().__init__()</code> 호출시 name과 age argument를 넘겨줍니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Student</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Sub Class"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">(</span><span class="s1">'테디'</span><span class="p">,</span> <span class="mi">30</span><span class="p">)</span>
</pre></div>
</div>
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
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="두-번재-해결책">두 번재 해결책</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Student 클래스의 <code>__init__()</code>을 <code>.__init__(name, age)</code> 인자를 받는 생성자 메서드로 <strong>재정의</strong>할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Student</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Sub Class"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">name</span><span class="p">,</span> <span class="n">age</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">age</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span> <span class="o">=</span> <span class="n">Student</span><span class="p">(</span><span class="s1">'테디'</span><span class="p">,</span> <span class="mi">30</span><span class="p">)</span>
<span class="n">student</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>제 이름은 테디 이고, 나이는 30살 입니다.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="메서드-오버라이딩">메서드 오버라이딩</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>메서드 오버라이딩은 부모로부터 물려받은(상속받은) 메서드를 재정의하여 사용할 때 사용합니다.</li>
<li>부모로부터 물려받은 다른 기능은 그대로 사용하되, 몇몇 메서드만 수정하여 활용하고 싶을 때 사용합니다.</li>
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
    
    <span class="c1"># PErson의 생성자 메서드</span>
    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="s1">'홍길동'</span><span class="p">,</span> <span class="n">age</span><span class="o">=</span><span class="mi">20</span><span class="p">):</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">name</span> <span class="o">=</span> <span class="n">name</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">age</span> <span class="o">=</span> <span class="n">age</span>
    
    <span class="c1"># Person의 메서드</span>
    <span class="k">def</span> <span class="nf">introduce</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'난 Person이야. 내 이름은 </span><span class="si">{self.name}</span><span class="s1"> 이고, 나이는 </span><span class="si">{self.age}</span><span class="s1">살이야.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="케이스-1.-클래스-메서드-오버라이딩을-안-하는-경우">케이스 1. 클래스 메서드 오버라이딩을 안 하는 경우</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Student</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Sub Class"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>다음과 같이 부모클래스 (Super Class)의 <code>introduce()</code>가 실행됨을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span> <span class="o">=</span> <span class="n">Student</span><span class="p">()</span>
<span class="n">student</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>난 Person이야. 내 이름은 홍길동 이고, 나이는 20살이야.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="케이스-2.-클래스-메서드-오버라이딩을-한-경우">케이스 2. 클래스 메서드 오버라이딩을 한 경우</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Student</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Sub Class"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>

    <span class="c1"># 메서드 오버라이딩</span>
    <span class="k">def</span> <span class="nf">introduce</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'난 Student야. 내 이름은 </span><span class="si">{self.name}</span><span class="s1">이고, 나이는 비밀이야.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>메서드 오버라이딩을 하게 되면, <strong>자식클래스 (Sub Class)에서 재정의 한 메서드가 호출</strong> 되게 됩니다. (부모클래스의 메서드는 무시됩니다.)</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span> <span class="o">=</span> <span class="n">Student</span><span class="p">()</span>
<span class="n">student</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>난 Student야. 내 이름은 홍길동이고, 나이는 비밀이야.
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="케이스-3.-클래스-메서드-오버라이딩을-하고-그-안에서-super()를-호출한-경우">케이스 3. 클래스 메서드 오버라이딩을 하고 그 안에서 <code>super()</code>를 호출한 경우</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Student</span><span class="p">(</span><span class="n">Person</span><span class="p">):</span>
    <span class="sd">"""Sub Class"""</span>

    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>

    <span class="c1"># 메서드 오버라이딩</span>
    <span class="k">def</span> <span class="nf">introduce</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span>
        <span class="c1"># 부모의 메서드 호출</span>
        <span class="nb">super</span><span class="p">()</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'난 Student야. 내 이름은 </span><span class="si">{self.name}</span><span class="s1">이고, 나이는 비밀이야.'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>만약, 부모클래스의 메서드를 호출하고 싶다면, <code>super().introduce()</code> 형식으로 호출 할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">student</span> <span class="o">=</span> <span class="n">Student</span><span class="p">()</span>
<span class="n">student</span><span class="o">.</span><span class="n">introduce</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>난 Person이야. 내 이름은 홍길동 이고, 나이는 20살이야.
난 Student야. 내 이름은 홍길동이고, 나이는 비밀이야.
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
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>상속의 구조는 <code>클래스명.mro()</code>로 확인할 수 있습니다.</li>
<li>구조는 상속 받은 순서대로 표시됩니다.</li>
<li>모든 class는 object를 상속받기 때문에 <em>항상 object가 마지막에 표기</em> 됩니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">Student</span><span class="o">.</span><span class="n">mro</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>[__main__.Student, __main__.Person, object]</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>