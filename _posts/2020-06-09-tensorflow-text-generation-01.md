---
layout: page
title: "TensorFlow RNN Text 생성 (셰익스피어 글 생성)"
description: "TensorFlow RNN Text 생성 (셰익스피어 글 생성) 방법에 대해 알아보겠습니다."
headline: "TensorFlow RNN Text 생성 (셰익스피어 글 생성) 방법에 대해 알아보겠습니다."
categories: tensorflow
tags: [python, tensorflow, rnn, text_generation, 텐서플로우, 텐서플로우 강의, 텐서플로우 튜토리얼, TensorFlow Tutorial, TensorFlow Shakespear, data science, 데이터 분석, 딥러닝]
comments: true
published: true
typora-copy-images-to: ../images/2020-06-09
---

텐서플로우 공식 튜토리얼인 **순환 신경망을 활용한 문자열 생성**에 대한 클론 코드입니다. 셰익스피어 글 데이터셋을 활용하여 인공지능 모델을 학습시키고, 셰익스피어 스타일의 글을 생성할 수 있는 모델을 만들어 보도록 하겠습니다.

데이터셋은 **Windowed Dataset**으로 구성하며, 모델은 Embedding Layer와 LSTM Layer를 사용하여 구성합니다.

> 튜토리얼 영상
<iframe width="560" height="315" src="https://www.youtube.com/embed/J1gXBkBfnlc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="텐서플로우-RNN-텍스트-생성">텐서플로우 RNN 텍스트 생성</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>본 튜토리얼은 <strong>텐서플로우 공식 도큐먼트 튜토리얼</strong>에 대한 클론 코드입니다.</p>
<ul>
<li>Reference: <a href="https://www.tensorflow.org/tutorials/text/text_generation">순환 신경망을 활용한 문자열 생성</a></li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">tensorflow</span> <span class="k">as</span> <span class="nn">tf</span>

<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">os</span>
<span class="kn">import</span> <span class="nn">time</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="o">%%</span><span class="nx">javascript</span>
<span class="nx">IPython</span><span class="p">.</span><span class="nx">OutputArea</span><span class="p">.</span><span class="nx">auto_scroll_threshold</span> <span class="o">=</span> <span class="mi">20</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div id="d65f08ac-596e-48d9-bbb5-9bfce717147e"></div>
<div class="output_subarea output_javascript">
<script type="text/javascript">
var element = $('#d65f08ac-596e-48d9-bbb5-9bfce717147e');
IPython.OutputArea.auto_scroll_threshold = 20
</script>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="셰익스피어-데이터셋-다운로드">셰익스피어 데이터셋 다운로드</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>구글 데이터셋 서버로부터 <code>shakespear.txt</code> 데이터셋을 다운로드 받습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">path_to_file</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">utils</span><span class="o">.</span><span class="n">get_file</span><span class="p">(</span><span class="s1">'shakespeare.txt'</span><span class="p">,</span> <span class="s1">'https://storage.googleapis.com/download.tensorflow.org/data/shakespeare.txt'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">text</span> <span class="o">=</span> <span class="nb">open</span><span class="p">(</span><span class="n">path_to_file</span><span class="p">,</span> <span class="s1">'rb'</span><span class="p">)</span><span class="o">.</span><span class="n">read</span><span class="p">()</span><span class="o">.</span><span class="n">decode</span><span class="p">(</span><span class="n">encoding</span><span class="o">=</span><span class="s1">'utf-8'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="n">text</span><span class="p">[:</span><span class="mi">200</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>First Citizen:
Before we proceed any further, hear me speak.

All:
Speak, speak.

First Citizen:
You are all resolved rather to die than to famish?

All:
Resolved. resolved.

First Citizen:
First, you
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
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="nb">repr</span><span class="p">(</span><span class="n">text</span><span class="p">[:</span><span class="mi">200</span><span class="p">]))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>'First Citizen:\nBefore we proceed any further, hear me speak.\n\nAll:\nSpeak, speak.\n\nFirst Citizen:\nYou are all resolved rather to die than to famish?\n\nAll:\nResolved. resolved.\n\nFirst Citizen:\nFirst, you'
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
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 총 문장의 길이</span>
<span class="nb">len</span><span class="p">(</span><span class="n">text</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>1115394</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="고유-캐릭터-수를-출력합니다.">고유 캐릭터 수를 출력합니다.</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">vocab</span> <span class="o">=</span> <span class="nb">sorted</span><span class="p">(</span><span class="nb">set</span><span class="p">(</span><span class="n">text</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">vocab</span><span class="p">[:</span><span class="mi">10</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>['\n', ' ', '!', '$', '&amp;', "'", ',', '-', '.', '3']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">len</span><span class="p">(</span><span class="n">vocab</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>65</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="텍스트-전처리-(preprocessing)">텍스트 전처리 (preprocessing)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="STEP-1.-Character-사전-만들기">STEP 1. Character 사전 만들기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>Character를 index로 변환</strong>하는 사전을 만듭니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">char2idx</span> <span class="o">=</span> <span class="p">{</span><span class="n">u</span><span class="p">:</span> <span class="n">i</span> <span class="k">for</span> <span class="n">i</span><span class="p">,</span> <span class="n">u</span> <span class="ow">in</span> <span class="nb">enumerate</span><span class="p">(</span><span class="n">vocab</span><span class="p">)}</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">char2idx</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>{'\n': 0,
 ' ': 1,
 '!': 2,
 '$': 3,
 '&amp;': 4,
 "'": 5,
 ',': 6,
 '-': 7,
 '.': 8,
 '3': 9,
 ':': 10,
 ';': 11,
 '?': 12,
 'A': 13,
 'B': 14,
 'C': 15,
 'D': 16,
 'E': 17,
 'F': 18,
 'G': 19,
 'H': 20,
 'I': 21,
 'J': 22,
 'K': 23,
 'L': 24,
 'M': 25,
 'N': 26,
 'O': 27,
 'P': 28,
 'Q': 29,
 'R': 30,
 'S': 31,
 'T': 32,
 'U': 33,
 'V': 34,
 'W': 35,
 'X': 36,
 'Y': 37,
 'Z': 38,
 'a': 39,
 'b': 40,
 'c': 41,
 'd': 42,
 'e': 43,
 'f': 44,
 'g': 45,
 'h': 46,
 'i': 47,
 'j': 48,
 'k': 49,
 'l': 50,
 'm': 51,
 'n': 52,
 'o': 53,
 'p': 54,
 'q': 55,
 'r': 56,
 's': 57,
 't': 58,
 'u': 59,
 'v': 60,
 'w': 61,
 'x': 62,
 'y': 63,
 'z': 64}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>index -&gt; Character로 변환</strong>하는 사전을 만듭니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">idx2char</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">array</span><span class="p">(</span><span class="n">vocab</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">idx2char</span><span class="p">[</span><span class="mi">49</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'k'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Step-2.-텍스트-전체를-int로-변환합니다.">Step 2. 텍스트 전체를 int로 변환합니다.</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">text</span><span class="p">[:</span><span class="mi">200</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'First Citizen:\nBefore we proceed any further, hear me speak.\n\nAll:\nSpeak, speak.\n\nFirst Citizen:\nYou are all resolved rather to die than to famish?\n\nAll:\nResolved. resolved.\n\nFirst Citizen:\nFirst, you'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">char2idx</span><span class="p">[</span><span class="s1">'i'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>47</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">text_as_int</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">array</span><span class="p">([</span><span class="n">char2idx</span><span class="p">[</span><span class="n">c</span><span class="p">]</span> <span class="k">for</span> <span class="n">c</span> <span class="ow">in</span> <span class="n">text</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">len</span><span class="p">(</span><span class="n">text_as_int</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>1115394</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">text_as_int</span><span class="p">[:</span><span class="mi">10</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>array([18, 47, 56, 57, 58,  1, 15, 47, 58, 47])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>변환된 부분을 확인합니다. (처음 5개)</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 원문</span>
<span class="n">text</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'First'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 변환된 sequence</span>
<span class="n">text_as_int</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>array([18, 47, 56, 57, 58])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 각각의 단어사전으로 출력</span>
<span class="n">char2idx</span><span class="p">[</span><span class="s1">'F'</span><span class="p">],</span> <span class="n">char2idx</span><span class="p">[</span><span class="s1">'i'</span><span class="p">],</span> <span class="n">char2idx</span><span class="p">[</span><span class="s1">'r'</span><span class="p">],</span> <span class="n">char2idx</span><span class="p">[</span><span class="s1">'s'</span><span class="p">],</span> <span class="n">char2idx</span><span class="p">[</span><span class="s1">'t'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(18, 47, 56, 57, 58)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Step-3.-X,-Y-데이터셋-생성하기">Step 3. X, Y 데이터셋 생성하기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 단일 입력에 대해 원하는 문장의 최대 길이</span>
<span class="n">window_size</span> <span class="o">=</span> <span class="mi">100</span>
<span class="n">shuffle_buffer</span> <span class="o">=</span> <span class="mi">10000</span>
<span class="n">batch_size</span><span class="o">=</span><span class="mi">64</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Windowed Dataset을 만듭니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">windowed_dataset</span><span class="p">(</span><span class="n">series</span><span class="p">,</span> <span class="n">window_size</span><span class="p">,</span> <span class="n">shuffle_buffer</span><span class="p">,</span> <span class="n">batch_size</span><span class="p">):</span>
    <span class="n">series</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">series</span><span class="p">,</span> <span class="o">-</span><span class="mi">1</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">(</span><span class="n">series</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="n">window_size</span> <span class="o">+</span> <span class="mi">1</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">flat_map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="n">x</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="n">window_size</span> <span class="o">+</span> <span class="mi">1</span><span class="p">))</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">shuffle</span><span class="p">(</span><span class="n">shuffle_buffer</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="p">(</span><span class="n">x</span><span class="p">[:</span><span class="o">-</span><span class="mi">1</span><span class="p">],</span> <span class="n">x</span><span class="p">[</span><span class="mi">1</span><span class="p">:]))</span>
    <span class="k">return</span> <span class="n">ds</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="n">batch_size</span><span class="p">)</span><span class="o">.</span><span class="n">prefetch</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_data</span> <span class="o">=</span> <span class="n">windowed_dataset</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">array</span><span class="p">(</span><span class="n">text_as_int</span><span class="p">),</span> <span class="n">window_size</span><span class="p">,</span> <span class="n">shuffle_buffer</span><span class="p">,</span> <span class="n">batch_size</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 문자로 된 어휘 사전의 크기</span>
<span class="n">vocab_size</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="n">vocab</span><span class="p">)</span>
<span class="n">vocab_size</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>65</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 임베딩 차원</span>
<span class="n">embedding_dim</span> <span class="o">=</span> <span class="mi">256</span>

<span class="c1"># RNN 유닛(unit) 개수</span>
<span class="n">rnn_units</span> <span class="o">=</span> <span class="mi">1024</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">Sequential</span><span class="p">([</span>
    <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Embedding</span><span class="p">(</span><span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span>
                              <span class="n">batch_input_shape</span><span class="o">=</span><span class="p">[</span><span class="n">batch_size</span><span class="p">,</span> <span class="kc">None</span><span class="p">]),</span>
    <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">LSTM</span><span class="p">(</span><span class="n">rnn_units</span><span class="p">,</span>
                        <span class="n">return_sequences</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span>
                        <span class="n">stateful</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span>
                        <span class="n">recurrent_initializer</span><span class="o">=</span><span class="s1">'glorot_uniform'</span><span class="p">),</span>
    <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Dense</span><span class="p">(</span><span class="n">vocab_size</span><span class="p">)</span>
<span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">summary</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>Model: "sequential"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
embedding (Embedding)        (64, None, 256)           16640     
_________________________________________________________________
lstm (LSTM)                  (64, None, 1024)          5246976   
_________________________________________________________________
dense (Dense)                (64, None, 65)            66625     
=================================================================
Total params: 5,330,241
Trainable params: 5,330,241
Non-trainable params: 0
_________________________________________________________________
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>체크포인트를 생성합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 체크포인트가 저장될 디렉토리</span>
<span class="n">checkpoint_path</span> <span class="o">=</span> <span class="s1">'./models/my_checkpt.ckpt'</span>

<span class="n">checkpoint_callback</span><span class="o">=</span><span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">callbacks</span><span class="o">.</span><span class="n">ModelCheckpoint</span><span class="p">(</span>
    <span class="n">filepath</span><span class="o">=</span><span class="n">checkpoint_path</span><span class="p">,</span>
    <span class="n">save_weights_only</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> 
    <span class="n">save_best_only</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span>
    <span class="n">monitor</span><span class="o">=</span><span class="s1">'loss'</span><span class="p">,</span> 
    <span class="n">verbose</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> 
<span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Loss function을 정의합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">loss</span><span class="p">(</span><span class="n">labels</span><span class="p">,</span> <span class="n">logits</span><span class="p">):</span>
    <span class="k">return</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">losses</span><span class="o">.</span><span class="n">sparse_categorical_crossentropy</span><span class="p">(</span><span class="n">labels</span><span class="p">,</span> <span class="n">logits</span><span class="p">,</span> <span class="n">from_logits</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">compile</span><span class="p">(</span><span class="n">optimizer</span><span class="o">=</span><span class="s1">'adam'</span><span class="p">,</span> <span class="n">loss</span><span class="o">=</span><span class="n">loss</span><span class="p">,</span> <span class="n">metrics</span><span class="o">=</span><span class="p">[</span><span class="s1">'acc'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">fit</span><span class="p">(</span><span class="n">train_data</span><span class="p">,</span> 
          <span class="n">epochs</span><span class="o">=</span><span class="mi">10</span><span class="p">,</span> 
          <span class="n">steps_per_epoch</span><span class="o">=</span><span class="mi">1720</span><span class="p">,</span> 
          <span class="n">callbacks</span><span class="o">=</span><span class="p">[</span><span class="n">checkpoint_callback</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>Epoch 1/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.7094 - acc: 0.8217
Epoch 00001: loss improved from inf to 0.70912, saving model to ./models/my_checkpt.ckpt
1720/1720 [==============================] - 51s 30ms/step - loss: 0.7091 - acc: 0.8217
Epoch 2/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.3121 - acc: 0.9299
Epoch 00002: loss improved from 0.70912 to 0.31212, saving model to ./models/my_checkpt.ckpt
1720/1720 [==============================] - 51s 29ms/step - loss: 0.3121 - acc: 0.9299
Epoch 3/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.2816 - acc: 0.9363
Epoch 00003: loss improved from 0.31212 to 0.28167, saving model to ./models/my_checkpt.ckpt
1720/1720 [==============================] - 51s 29ms/step - loss: 0.2817 - acc: 0.9363
Epoch 4/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.2805 - acc: 0.9365
Epoch 00004: loss improved from 0.28167 to 0.28046, saving model to ./models/my_checkpt.ckpt
1720/1720 [==============================] - 51s 30ms/step - loss: 0.2805 - acc: 0.9365
Epoch 5/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.2882 - acc: 0.9353
Epoch 00005: loss did not improve from 0.28046
1720/1720 [==============================] - 51s 29ms/step - loss: 0.2883 - acc: 0.9353
Epoch 6/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.2803 - acc: 0.9371
Epoch 00006: loss improved from 0.28046 to 0.28026, saving model to ./models/my_checkpt.ckpt
1720/1720 [==============================] - 51s 29ms/step - loss: 0.2803 - acc: 0.9371
Epoch 7/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.2924 - acc: 0.9348
Epoch 00007: loss did not improve from 0.28026
1720/1720 [==============================] - 50s 29ms/step - loss: 0.2924 - acc: 0.9348
Epoch 8/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.2993 - acc: 0.9336
Epoch 00008: loss did not improve from 0.28026
1720/1720 [==============================] - 51s 30ms/step - loss: 0.2993 - acc: 0.9336
Epoch 9/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.2971 - acc: 0.9342
Epoch 00009: loss did not improve from 0.28026
1720/1720 [==============================] - 51s 30ms/step - loss: 0.2970 - acc: 0.9342
Epoch 10/10
1719/1720 [============================&gt;.] - ETA: 0s - loss: 0.3014 - acc: 0.9332
Epoch 00010: loss did not improve from 0.28026
1720/1720 [==============================] - 51s 30ms/step - loss: 0.3014 - acc: 0.9332
</pre>
</div>
</div>
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>&lt;tensorflow.python.keras.callbacks.History at 0x7fd01070b780&gt;</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="예측을-위한-모델-재정의">예측을 위한 모델 재정의</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>batch_size -&gt; 1로 변경합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">Sequential</span><span class="p">([</span>
    <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Embedding</span><span class="p">(</span><span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span>
                              <span class="n">batch_input_shape</span><span class="o">=</span><span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="kc">None</span><span class="p">]),</span>
    <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">LSTM</span><span class="p">(</span><span class="n">rnn_units</span><span class="p">,</span>
                        <span class="n">return_sequences</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span>
                        <span class="n">stateful</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span>
                        <span class="n">recurrent_initializer</span><span class="o">=</span><span class="s1">'glorot_uniform'</span><span class="p">),</span>
    <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Dense</span><span class="p">(</span><span class="n">vocab_size</span><span class="p">)</span>
<span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">load_weights</span><span class="p">(</span><span class="n">checkpoint_path</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>&lt;tensorflow.python.training.tracking.util.CheckpointLoadStatus at 0x7fcfc419ad68&gt;</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">build</span><span class="p">(</span><span class="n">tf</span><span class="o">.</span><span class="n">TensorShape</span><span class="p">([</span><span class="mi">1</span><span class="p">,</span> <span class="kc">None</span><span class="p">]))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">summary</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>Model: "sequential_2"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
embedding_2 (Embedding)      (1, None, 256)            16640     
_________________________________________________________________
lstm_2 (LSTM)                (1, None, 1024)           5246976   
_________________________________________________________________
dense_2 (Dense)              (1, None, 65)             66625     
=================================================================
Total params: 5,330,241
Trainable params: 5,330,241
Non-trainable params: 0
_________________________________________________________________
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>generate_text 함수를 활용하여, 문자를 연속적으로 예측합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">generate_text</span><span class="p">(</span><span class="n">model</span><span class="p">,</span> <span class="n">start_string</span><span class="p">):</span>
    <span class="c1"># 평가 단계 (학습된 모델을 사용하여 텍스트 생성)</span>

    <span class="c1"># 생성할 문자의 수</span>
    <span class="n">num_generate</span> <span class="o">=</span> <span class="mi">1000</span>

    <span class="c1"># 시작 문자열을 숫자로 변환(벡터화)</span>
    <span class="n">input_eval</span> <span class="o">=</span> <span class="p">[</span><span class="n">char2idx</span><span class="p">[</span><span class="n">s</span><span class="p">]</span> <span class="k">for</span> <span class="n">s</span> <span class="ow">in</span> <span class="n">start_string</span><span class="p">]</span>
    <span class="n">input_eval</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">input_eval</span><span class="p">,</span> <span class="mi">0</span><span class="p">)</span>

    <span class="c1"># 결과를 저장할 빈 문자열</span>
    <span class="n">text_generated</span> <span class="o">=</span> <span class="p">[]</span>

    <span class="c1"># 온도가 낮으면 더 예측 가능한 텍스트가 됩니다.</span>
    <span class="c1"># 온도가 높으면 더 의외의 텍스트가 됩니다.</span>
    <span class="c1"># 최적의 세팅을 찾기 위한 실험</span>
    <span class="n">temperature</span> <span class="o">=</span> <span class="mf">1.0</span>

    <span class="c1"># 여기에서 배치 크기 == 1</span>
    <span class="n">model</span><span class="o">.</span><span class="n">reset_states</span><span class="p">()</span>
    <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">num_generate</span><span class="p">):</span>
        <span class="n">predictions</span> <span class="o">=</span> <span class="n">model</span><span class="p">(</span><span class="n">input_eval</span><span class="p">)</span>
        <span class="c1"># 배치 차원 제거</span>
        <span class="n">predictions</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">squeeze</span><span class="p">(</span><span class="n">predictions</span><span class="p">,</span> <span class="mi">0</span><span class="p">)</span>

        <span class="c1"># 범주형 분포를 사용하여 모델에서 리턴한 단어 예측</span>
        <span class="n">predictions</span> <span class="o">=</span> <span class="n">predictions</span> <span class="o">/</span> <span class="n">temperature</span>
        <span class="n">predicted_id</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">categorical</span><span class="p">(</span><span class="n">predictions</span><span class="p">,</span> <span class="n">num_samples</span><span class="o">=</span><span class="mi">1</span><span class="p">)[</span><span class="o">-</span><span class="mi">1</span><span class="p">,</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">numpy</span><span class="p">()</span>

        <span class="c1"># 예측된 단어를 다음 입력으로 모델에 전달</span>
        <span class="c1"># 이전 은닉 상태와 함께</span>
        <span class="n">input_eval</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">([</span><span class="n">predicted_id</span><span class="p">],</span> <span class="mi">0</span><span class="p">)</span>

        <span class="n">text_generated</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">idx2char</span><span class="p">[</span><span class="n">predicted_id</span><span class="p">])</span>

    <span class="k">return</span> <span class="p">(</span><span class="n">start_string</span> <span class="o">+</span> <span class="s1">''</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">text_generated</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="최종-결과물-출력">최종 결과물 출력</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="n">generate_text</span><span class="p">(</span><span class="n">model</span><span class="p">,</span> <span class="n">start_string</span><span class="o">=</span><span class="sa">u</span><span class="s2">"ROMEO: "</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>ROMEO: what news be true,
Poor queen and this is he than for.

CLARENCE:
Feak man confeigned friend,
And their true sovereign, whom they must obey?
Nay, whom they shall obey, and love thee too,
Unless;
So servitor.

CLARENCE:
Belike the e once agree,
Is Clarence, Edward's brother, reception brief and Clarence commore he that hope I have of heavenly bliss,
That I am sour words him from thence the Thracian fatal steeds,
So we, well cover'd with tears,
And fault, you should have foull him as me of all kindness at my hand
That your estate requires and mine can yield.

WARWICK:
Henry now lives in Scotland at his ease,
Where comes the king.

Scotland him ere's Clarence, welcome unto Warwick;
And welcome, Somerset: I hold it cowardice
To rest mistrustful where a noble heart
Hath pawn'd an open hand in sign of love;
Else might I think that Clarence, Edwargis it flay:
My queen in person will Well deserves it;
And here, to pledge my vow, I give my hand.

KING LEWIS XI:
Why stay we now? My crown is cal 
</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>