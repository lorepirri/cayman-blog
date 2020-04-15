---
layout: page
title: "tensorflow 2.0 Dataset, batch, window, flat_map을 활용한 loader 만들기"
description: "tensorflow 2.0 Dataset, batch, window, flat_map을 활용한 loader 만드는 방법에 대하여 알아보겠습니다."
headline: "tensorflow 2.0 Dataset, batch, window, flat_map을 활용한 loader 만드는 방법에 대하여 알아보겠습니다."
categories: tensorflow
tags: [pytho, colab, tensorflow, deep-learning]
comments: true
published: true
---

`tf.data.Dataset`을 활용하여 다양한 Dataset 로더를 만들 수 있습니다. 
그리고, 로더를 활용하여, `shuffle`, `batch_size`, `window` 데이터셋 생성등 다양한 종류를 데이터 셋을 상황에 맞게 생성하고 모델에 feed할 수 있도록 제공해 줍니다.

더 이상 numpy로 한땀 한땀 만들어 줄 필요없이, 간단한 옵션 몇 개면 데이터세트를 완성할 수 있습니다.

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [1]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">tensorflow</span> <span class="k">as</span> <span class="nn">tf</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [2]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
<span class="n">x</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[2]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>array([ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
       17, 18, 19])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [3]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[3]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>(20,)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="1.-dimension을-1만큼-늘려주기">1. dimension을 1만큼 늘려주기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="1-1.-tensorflow-의-expand_dim-:-차원-늘리기">1-1. tensorflow 의 expand_dim : 차원 늘리기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [4]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">tf</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[4]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([20, 1])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="1-2.-numpy의-expand_dims와-동일">1-2. numpy의 expand_dims와 동일</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [5]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">np</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[5]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>(20, 1)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="numpy-array나-list를-tensor-dataset으로-변환">numpy array나 list를 tensor dataset으로 변환</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>from_tensor_slices</code>는 <strong>list</strong>와 <strong>numpy array</strong> 모두 변환하도록 지원하고 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [6]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">([</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="mi">5</span><span class="p">])</span>

<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor(1, shape=(), dtype=int32)
tf.Tensor(2, shape=(), dtype=int32)
tf.Tensor(3, shape=(), dtype=int32)
tf.Tensor(4, shape=(), dtype=int32)
tf.Tensor(5, shape=(), dtype=int32)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [7]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">10</span><span class="p">))</span>
<span class="n">ds</span>

<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor(0, shape=(), dtype=int64)
tf.Tensor(1, shape=(), dtype=int64)
tf.Tensor(2, shape=(), dtype=int64)
tf.Tensor(3, shape=(), dtype=int64)
tf.Tensor(4, shape=(), dtype=int64)
tf.Tensor(5, shape=(), dtype=int64)
tf.Tensor(6, shape=(), dtype=int64)
tf.Tensor(7, shape=(), dtype=int64)
tf.Tensor(8, shape=(), dtype=int64)
tf.Tensor(9, shape=(), dtype=int64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="2.-batch">2. batch</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>batch는 model에 학습시킬 때 <code>batch_size</code>를 지정하여 <code>size</code>만큼 데이터를 읽어 들여 학습시킬 때 유용한 method입니다.</p>
<p>이미지와 같은 큰 사이즈는 <strong>memory에 한 번에 올라가지 못하기 때문</strong>에, 이렇게 batch를 나누어서 학습시키기도 하구요.</p>
<p>또한, model이 weight를 업데이트 할 때, 1개의 batch가 끝나고 난 후 업데이트를 하게 되는데, <strong>업데이트 빈도를 조절하는 효과</strong>도 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>drop_remainder</code>는 마지만 남은 데이터를 drop 할 것인지 여부</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [8]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">8</span><span class="p">)</span> 
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="mi">3</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="nb">list</span><span class="p">(</span><span class="n">ds</span><span class="o">.</span><span class="n">as_numpy_iterator</span><span class="p">())</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[8]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>[array([0, 1, 2]), array([3, 4, 5])]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>원래는 6, 7 이 <code>batch</code>로 출력되어야 하지만 <code>drop_remainder=True</code> 옵션이 나머지를 버린다</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [9]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">8</span><span class="p">)</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="mi">3</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor([0 1 2], shape=(3,), dtype=int64)
tf.Tensor([3 4 5], shape=(3,), dtype=int64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="3.-window:-Time-Series-데이터셋-생성에-유용">3. window: Time Series 데이터셋 생성에 유용</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Time Series 데이터셋을 구성할 때 굉장히 유용하게 활용할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li><code>window</code>: 그룹화 할 윈도우 크기(갯수)</li>
<li><code>drop_remainder</code>: 남은 부분을 버릴지 살릴지 여부</li>
<li><code>shift</code>는 1 iteration당 몇 개씩 이동할 것인지</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>drop_remainder=False</code> 인 경우</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [10]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span> 
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="mi">5</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="nb">list</span><span class="p">(</span><span class="n">d</span><span class="o">.</span><span class="n">as_numpy_iterator</span><span class="p">()))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>[0, 1, 2, 3, 4]
[1, 2, 3, 4, 5]
[2, 3, 4, 5, 6]
[3, 4, 5, 6, 7]
[4, 5, 6, 7, 8]
[5, 6, 7, 8, 9]
[6, 7, 8, 9]
[7, 8, 9]
[8, 9]
[9]
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>drop_remainder=True</code> 인 경우</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [11]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span> 
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="mi">5</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="nb">list</span><span class="p">(</span><span class="n">d</span><span class="o">.</span><span class="n">as_numpy_iterator</span><span class="p">()))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>[0, 1, 2, 3, 4]
[1, 2, 3, 4, 5]
[2, 3, 4, 5, 6]
[3, 4, 5, 6, 7]
[4, 5, 6, 7, 8]
[5, 6, 7, 8, 9]
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [12]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span> 
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="mi">5</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="nb">list</span><span class="p">(</span><span class="n">d</span><span class="o">.</span><span class="n">as_numpy_iterator</span><span class="p">()))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>[0, 1, 2, 3, 4]
[1, 2, 3, 4, 5]
[2, 3, 4, 5, 6]
[3, 4, 5, 6, 7]
[4, 5, 6, 7, 8]
[5, 6, 7, 8, 9]
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="4.-flat_map">4. flat_map</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>flat_map</code>은 dataset에 함수를 apply해주고, 결과를 flatten하게 펼쳐 줍니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>아래는 lambda 함수를 통해 3개의 batch를 읽어들인 뒤 flatten된 리턴값을 받습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [13]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span> 
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="mi">5</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">flat_map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">w</span><span class="p">:</span> <span class="n">w</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="mi">3</span><span class="p">))</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor([0 1 2], shape=(3,), dtype=int64)
tf.Tensor([3 4], shape=(2,), dtype=int64)
tf.Tensor([1 2 3], shape=(3,), dtype=int64)
tf.Tensor([4 5], shape=(2,), dtype=int64)
tf.Tensor([2 3 4], shape=(3,), dtype=int64)
tf.Tensor([5 6], shape=(2,), dtype=int64)
tf.Tensor([3 4 5], shape=(3,), dtype=int64)
tf.Tensor([6 7], shape=(2,), dtype=int64)
tf.Tensor([4 5 6], shape=(3,), dtype=int64)
tf.Tensor([7 8], shape=(2,), dtype=int64)
tf.Tensor([5 6 7], shape=(3,), dtype=int64)
tf.Tensor([8 9], shape=(2,), dtype=int64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [14]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span> 
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="mi">5</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">flat_map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">w</span><span class="p">:</span> <span class="n">w</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="mi">5</span><span class="p">))</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor([0 1 2 3 4], shape=(5,), dtype=int64)
tf.Tensor([1 2 3 4 5], shape=(5,), dtype=int64)
tf.Tensor([2 3 4 5 6], shape=(5,), dtype=int64)
tf.Tensor([3 4 5 6 7], shape=(5,), dtype=int64)
tf.Tensor([4 5 6 7 8], shape=(5,), dtype=int64)
tf.Tensor([5 6 7 8 9], shape=(5,), dtype=int64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="5.-shuffle">5. shuffle</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>shuffle은 <code>Dataset</code>을 섞어주는 역할을 하며, 반드시 학습전에 <strong>shuffle을 통해 적절하게 Dataset을 섞어</strong>주어야 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [15]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">10</span><span class="p">))</span><span class="c1">#.shuffle()</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor(0, shape=(), dtype=int64)
tf.Tensor(1, shape=(), dtype=int64)
tf.Tensor(2, shape=(), dtype=int64)
tf.Tensor(3, shape=(), dtype=int64)
tf.Tensor(4, shape=(), dtype=int64)
tf.Tensor(5, shape=(), dtype=int64)
tf.Tensor(6, shape=(), dtype=int64)
tf.Tensor(7, shape=(), dtype=int64)
tf.Tensor(8, shape=(), dtype=int64)
tf.Tensor(9, shape=(), dtype=int64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [16]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">10</span><span class="p">))</span><span class="o">.</span><span class="n">shuffle</span><span class="p">(</span><span class="n">buffer_size</span><span class="o">=</span><span class="mi">5</span><span class="p">)</span>
<span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor(2, shape=(), dtype=int64)
tf.Tensor(3, shape=(), dtype=int64)
tf.Tensor(4, shape=(), dtype=int64)
tf.Tensor(5, shape=(), dtype=int64)
tf.Tensor(0, shape=(), dtype=int64)
tf.Tensor(7, shape=(), dtype=int64)
tf.Tensor(8, shape=(), dtype=int64)
tf.Tensor(6, shape=(), dtype=int64)
tf.Tensor(1, shape=(), dtype=int64)
tf.Tensor(9, shape=(), dtype=int64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>위의 shuffle함수에서 꼭 지정해주어야하는 인자는 <code>buffer_size</code> 입니다.</p>
<p>텐서플로우 공식 도큐먼트에 의하면,</p>
<ul>
<li><p>데이터세트는 <code>buffer_size</code> 요소로 버퍼를 채운 다음이 버퍼에서 요소를 <strong>무작위로 샘플링하여 선택한 요소를 새 요소로 바꿉니다</strong>.</p>
</li>
<li><p>완벽한 셔플 링을 위해서는 <strong>데이터 세트의 전체 크기보다 크거나 같은 버퍼 크기가 필요</strong>합니다.</p>
</li>
<li><p>예를 들어, 데이터 집합에 10,000 개의 요소가 있지만 <code>buffer_size</code>가 1,000으로 설정된 경우 셔플은 처음에 버퍼의 처음 1,000 개 요소 중 임의의 요소 만 선택합니다.</p>
</li>
<li><p>요소가 선택되면 버퍼의 공간이 다음 요소 (즉, 1,001-st)로 대체되어 1,000 요소 버퍼를 유지합니다.</p>
</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="6.-map">6. map</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Dataset의 <code>map</code>함수는 pandas의 <code>map</code>과 유사합니다.</p>
<p>Dataset <strong>전체에 함수를 맵핑</strong>합니다.</p>
<p>Time Series Dataset을 만드려는 경우, <strong>train/label 값을 분류하는 용도로 활용</strong>할 수 있습니다.</p>
<p>x[:-1], x[-1:] 의 의도는 각 row의 <strong>마지막 index 전까지는 train data로, 마지막 index는 label로 활용</strong>하겠다는 의도입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [17]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">window_size</span><span class="o">=</span><span class="mi">5</span>

<span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span> 
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="n">window_size</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">flat_map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">w</span><span class="p">:</span> <span class="n">w</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="n">window_size</span><span class="p">))</span>
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">shuffle</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span>

<span class="c1"># 첫 4개와 마지막 1개를 분리</span>
<span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="p">(</span><span class="n">x</span><span class="p">[:</span><span class="o">-</span><span class="mi">1</span><span class="p">],</span> <span class="n">x</span><span class="p">[</span><span class="o">-</span><span class="mi">1</span><span class="p">:]))</span>
<span class="k">for</span> <span class="n">x</span><span class="p">,</span> <span class="n">y</span> <span class="ow">in</span> <span class="n">ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'train set: </span><span class="si">{}</span><span class="s1">'</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">x</span><span class="p">))</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'label set: </span><span class="si">{}</span><span class="s1">'</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">y</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>train set: [3 4 5 6]
label set: [7]
train set: [5 6 7 8]
label set: [9]
train set: [0 1 2 3]
label set: [4]
train set: [4 5 6 7]
label set: [8]
train set: [2 3 4 5]
label set: [6]
train set: [1 2 3 4]
label set: [5]
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="실습-예제:-Sunspots-데이터셋을-활용하여-window_dataset-만들기">실습 예제: Sunspots 데이터셋을 활용하여 window_dataset 만들기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [18]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">csv</span>
<span class="kn">import</span> <span class="nn">tensorflow</span> <span class="k">as</span> <span class="nn">tf</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">urllib</span>


<span class="n">url</span> <span class="o">=</span> <span class="s1">'https://storage.googleapis.com/download.tensorflow.org/data/Sunspots.csv'</span>
<span class="n">urllib</span><span class="o">.</span><span class="n">request</span><span class="o">.</span><span class="n">urlretrieve</span><span class="p">(</span><span class="n">url</span><span class="p">,</span> <span class="s1">'sunspots.csv'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[18]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>('sunspots.csv', &lt;http.client.HTTPMessage at 0x7f909c770048&gt;)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [19]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">with</span> <span class="nb">open</span><span class="p">(</span><span class="s1">'sunspots.csv'</span><span class="p">)</span> <span class="k">as</span> <span class="n">csvfile</span><span class="p">:</span>
    <span class="n">reader</span> <span class="o">=</span> <span class="n">csv</span><span class="o">.</span><span class="n">reader</span><span class="p">(</span><span class="n">csvfile</span><span class="p">,</span> <span class="n">delimiter</span><span class="o">=</span><span class="s1">','</span><span class="p">)</span>
    <span class="nb">next</span><span class="p">(</span><span class="n">reader</span><span class="p">)</span>
    <span class="n">i</span> <span class="o">=</span> <span class="mi">0</span>
    <span class="k">for</span> <span class="n">row</span> <span class="ow">in</span> <span class="n">reader</span><span class="p">:</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">row</span><span class="p">)</span>
        <span class="n">i</span><span class="o">+=</span><span class="mi">1</span>
        <span class="k">if</span> <span class="n">i</span> <span class="o">&gt;</span> <span class="mi">5</span><span class="p">:</span>
            <span class="k">break</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>['0', '1749-01-31', '96.7']
['1', '1749-02-28', '104.3']
['2', '1749-03-31', '116.7']
['3', '1749-04-30', '92.8']
['4', '1749-05-31', '141.7']
['5', '1749-06-30', '139.2']
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>각 row의 2번 index의 데이터를 우리가 time series 데이터로 만들어 보려고 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [20]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_data</span> <span class="o">=</span> <span class="p">[]</span>

<span class="k">with</span> <span class="nb">open</span><span class="p">(</span><span class="s1">'sunspots.csv'</span><span class="p">)</span> <span class="k">as</span> <span class="n">csvfile</span><span class="p">:</span>
    <span class="n">reader</span> <span class="o">=</span> <span class="n">csv</span><span class="o">.</span><span class="n">reader</span><span class="p">(</span><span class="n">csvfile</span><span class="p">,</span> <span class="n">delimiter</span><span class="o">=</span><span class="s1">','</span><span class="p">)</span>
    <span class="c1"># 첫 줄은 header이므로 skip 합니다.</span>
    <span class="nb">next</span><span class="p">(</span><span class="n">reader</span><span class="p">)</span>
    <span class="k">for</span> <span class="n">row</span> <span class="ow">in</span> <span class="n">reader</span><span class="p">:</span>
        <span class="n">train_data</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="nb">float</span><span class="p">(</span><span class="n">row</span><span class="p">[</span><span class="mi">2</span><span class="p">]))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [21]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_data</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[21]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>[96.7, 104.3, 116.7, 92.8, 141.7]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>일단, list에 모든 데이터를 담았습니다.</p>
<p>이제 Dataset 모듈을 통해 <code>window_dataset</code>을 만들어 보겠습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [22]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_data</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">asarray</span><span class="p">(</span><span class="n">train_data</span><span class="p">)</span>
<span class="n">train_data</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[22]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>(3235,)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>train_data의 dimension을 늘려주었습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [23]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_data</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">train_data</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
<span class="n">train_data</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[23]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>(3235, 1)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>tensor slices로 변환하겠습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [24]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dataset</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">(</span><span class="n">train_data</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [25]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">i</span><span class="o">=</span><span class="mi">0</span>
<span class="k">for</span> <span class="n">data</span> <span class="ow">in</span> <span class="n">dataset</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">data</span><span class="p">)</span>
    <span class="n">i</span><span class="o">+=</span><span class="mi">1</span>
    <span class="k">if</span> <span class="n">i</span> <span class="o">&gt;</span> <span class="mi">5</span><span class="p">:</span>
        <span class="k">break</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor([96.7], shape=(1,), dtype=float64)
tf.Tensor([104.3], shape=(1,), dtype=float64)
tf.Tensor([116.7], shape=(1,), dtype=float64)
tf.Tensor([92.8], shape=(1,), dtype=float64)
tf.Tensor([141.7], shape=(1,), dtype=float64)
tf.Tensor([139.2], shape=(1,), dtype=float64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>그 다음으로는 원하는 <code>window_size</code>만큼 묶어 주어야합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>내가 과거의 20일의 데이터를 보고 21일 째의 데이터를 예측해야한다라고 가정한다면,</p>
<p><code>window_size</code> = 20 + 1 로 잡아줍니다.</p>
<p>20개는 train data의 갯수, 1은 label의 갯수입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [26]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">window_size</span><span class="o">=</span><span class="mi">20</span> <span class="o">+</span> <span class="mi">1</span>

<span class="n">dataset</span> <span class="o">=</span> <span class="n">dataset</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="n">window_size</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>그 다음에는 <code>flat_map</code>을 통해서 각 batch 별로 flatten하게 shape을 펼쳐줍니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [27]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dataset</span> <span class="o">=</span> <span class="n">dataset</span><span class="o">.</span><span class="n">flat_map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">w</span><span class="p">:</span> <span class="n">w</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="n">window_size</span> <span class="o">+</span> <span class="mi">1</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [28]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 2개만 출력해서 결과를 살펴보겠습니다.</span>
<span class="k">for</span> <span class="n">data</span> <span class="ow">in</span> <span class="n">dataset</span><span class="o">.</span><span class="n">take</span><span class="p">(</span><span class="mi">2</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">data</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>tf.Tensor(
[[ 96.7]
 [104.3]
 [116.7]
 [ 92.8]
 [141.7]
 [139.2]
 [158. ]
 [110.5]
 [126.5]
 [125.8]
 [264.3]
 [142. ]
 [122.2]
 [126.5]
 [148.7]
 [147.2]
 [150. ]
 [166.7]
 [142.3]
 [171.7]
 [152. ]], shape=(21, 1), dtype=float64)
tf.Tensor(
[[104.3]
 [116.7]
 [ 92.8]
 [141.7]
 [139.2]
 [158. ]
 [110.5]
 [126.5]
 [125.8]
 [264.3]
 [142. ]
 [122.2]
 [126.5]
 [148.7]
 [147.2]
 [150. ]
 [166.7]
 [142.3]
 [171.7]
 [152. ]
 [109.5]], shape=(21, 1), dtype=float64)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>그 다음은 <code>batch</code>별로 shuffle을 해주면 좋겠네요~</p>
<p><code>buffer_size</code>는 임의로 500개를 지정하겠습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [29]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dataset</span> <span class="o">=</span> <span class="n">dataset</span><span class="o">.</span><span class="n">shuffle</span><span class="p">(</span><span class="mi">500</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>가장 중요한 마지막 단계 입니다.</p>
<p>train/label이 섞여서 21개의 데이터가 각 <code>batch</code>에 잡혀 있습니다.</p>
<p>train/label로 섞인 <code>batch</code>를 train (20개), label (1개)로 분리해주면 됩니다.</p>
<p>분리해줄 때 <strong>tuple로 묶어주지 않으면 error</strong>를 내뱉습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [30]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dataset</span> <span class="o">=</span> <span class="n">dataset</span><span class="o">.</span><span class="n">map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">x</span><span class="p">:</span> <span class="p">(</span><span class="n">x</span><span class="p">[:</span><span class="o">-</span><span class="mi">1</span><span class="p">],</span> <span class="n">x</span><span class="p">[</span><span class="o">-</span><span class="mi">1</span><span class="p">:]))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [31]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">train</span><span class="p">,</span> <span class="n">label</span> <span class="ow">in</span> <span class="n">dataset</span><span class="o">.</span><span class="n">take</span><span class="p">(</span><span class="mi">2</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'train: </span><span class="si">{}</span><span class="s1">'</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">train</span><span class="p">))</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'label: </span><span class="si">{}</span><span class="s1">'</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">label</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>train: [[263.7]
 [246.8]
 [186.7]
 [173.3]
 [237.5]
 [133.5]
 [ 85. ]
 [116.8]
 [138.8]
 [183. ]
 [210.5]
 [174. ]
 [172.7]
 [220.3]
 [170.5]
 [ 60. ]
 [ 77. ]
 [ 77.8]
 [108.2]
 [254.5]]
label: [[199.2]]
train: [[143.3]
 [156.2]
 [128.3]
 [100. ]
 [ 97.8]
 [164.5]
 [124.5]
 [ 88.3]
 [113.8]
 [174.5]
 [162.8]
 [122.5]
 [110. ]
 [ 85. ]
 [ 45.5]
 [111.7]
 [ 58.7]
 [ 90. ]
 [ 62.5]
 [ 61.7]]
label: [[68.3]]
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [32]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">dataset</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span><span class="o">.</span><span class="n">take</span><span class="p">(</span><span class="mi">2</span><span class="p">):</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>(&lt;tf.Tensor: shape=(10, 20, 1), dtype=float64, numpy=
array([[[ 62.8],
        [ 71.7],
        [ 71.7],
        [ 80.5],
        [ 73.3],
        [ 78. ],
        [ 78.3],
        [ 81.7],
        [ 83.3],
        [ 85. ],
        [118.8],
        [128.7],
        [ 99.5],
        [ 77.2],
        [ 95. ],
        [112.2],
        [ 99.2],
        [124.5],
        [ 97.2],
        [120. ]],

       [[ 68. ],
        [ 71.2],
        [ 73.5],
        [ 91.2],
        [ 88.8],
        [ 89.2],
        [110.2],
        [ 77.2],
        [ 71.2],
        [129.5],
        [129. ],
        [ 87.7],
        [111.3],
        [124.7],
        [129.7],
        [151. ],
        [186.3],
        [123.2],
        [107. ],
        [107.2]],

       [[  5. ],
        [  5.5],
        [  6.7],
        [  7.2],
        [  8.3],
        [  9.5],
        [ 32. ],
        [ 45.7],
        [ 50. ],
        [ 71.7],
        [ 54.8],
        [ 49.7],
        [ 55.5],
        [ 36.5],
        [ 68. ],
        [ 71.2],
        [ 73.5],
        [ 91.2],
        [ 88.8],
        [ 89.2]],

       [[ 63.3],
        [ 60. ],
        [ 52.8],
        [ 36.7],
        [ 65. ],
        [ 46.7],
        [ 41.7],
        [ 33.3],
        [ 11.2],
        [  0. ],
        [  5. ],
        [  2.8],
        [ 22.8],
        [ 34.5],
        [ 44.5],
        [ 31.3],
        [ 20.5],
        [ 13.7],
        [ 40.2],
        [ 22. ]],

       [[ 65. ],
        [159.2],
        [133.8],
        [134.5],
        [158.3],
        [186.7],
        [193.7],
        [177.5],
        [243.3],
        [262.2],
        [295.5],
        [182.2],
        [223.3],
        [241.7],
        [398.2],
        [286. ],
        [255. ],
        [233.3],
        [286.2],
        [260.5]],

       [[241.7],
        [398.2],
        [286. ],
        [255. ],
        [233.3],
        [286.2],
        [260.5],
        [250.5],
        [175. ],
        [191.2],
        [276.2],
        [196.7],
        [241.7],
        [233.3],
        [189.5],
        [238.3],
        [186.7],
        [185. ],
        [206.7],
        [190. ]],

       [[ 15. ],
        [ 26.2],
        [ 34.5],
        [ 43.8],
        [ 60.5],
        [ 33.3],
        [ 53.3],
        [ 78.7],
        [ 67. ],
        [ 45.5],
        [ 62. ],
        [ 79.3],
        [ 79.5],
        [142.3],
        [153.8],
        [ 98.3],
        [138.3],
        [149.5],
        [185.8],
        [187.2]],

       [[ 96.7],
        [104.3],
        [116.7],
        [ 92.8],
        [141.7],
        [139.2],
        [158. ],
        [110.5],
        [126.5],
        [125.8],
        [264.3],
        [142. ],
        [122.2],
        [126.5],
        [148.7],
        [147.2],
        [150. ],
        [166.7],
        [142.3],
        [171.7]],

       [[ 76.2],
        [100.3],
        [ 66.5],
        [128.5],
        [ 56.3],
        [112.8],
        [114.2],
        [115.5],
        [129.7],
        [128.7],
        [ 94.2],
        [ 53.2],
        [ 57. ],
        [ 54.8],
        [ 54.5],
        [ 59.7],
        [ 90.3],
        [ 44.2],
        [113.5],
        [ 77.2]],

       [[  0. ],
        [  0. ],
        [ 14.3],
        [  5.3],
        [ 29.7],
        [ 39.5],
        [ 11.3],
        [ 33.3],
        [ 20.8],
        [ 11.8],
        [  9. ],
        [ 15.7],
        [ 20.8],
        [ 21.5],
        [  6. ],
        [ 10.7],
        [ 19.7],
        [ 23.8],
        [ 28.3],
        [ 15.7]]])&gt;, &lt;tf.Tensor: shape=(10, 1, 1), dtype=float64, numpy=
array([[[ 80.5]],

       [[161.2]],

       [[110.2]],

       [[  7. ]],

       [[250.5]],

       [[183.3]],

       [[193.3]],

       [[152. ]],

       [[101.5]],

       [[ 23.5]]])&gt;)
(&lt;tf.Tensor: shape=(10, 20, 1), dtype=float64, numpy=
array([[[171.7],
        [186.7],
        [149.5],
        [223.3],
        [225.8],
        [171.7],
        [212.5],
        [160.5],
        [156.7],
        [155. ],
        [151.7],
        [115.5],
        [145. ],
        [128.8],
        [140.5],
        [136.7],
        [123.3],
        [121.2],
        [103.3],
        [123.3]],

       [[ 89.2],
        [110.2],
        [ 77.2],
        [ 71.2],
        [129.5],
        [129. ],
        [ 87.7],
        [111.3],
        [124.7],
        [129.7],
        [151. ],
        [186.3],
        [123.2],
        [107. ],
        [107.2],
        [161.2],
        [122.7],
        [157.3],
        [197.7],
        [200.5]],

       [[200. ],
        [195. ],
        [171.7],
        [186.7],
        [149.5],
        [223.3],
        [225.8],
        [171.7],
        [212.5],
        [160.5],
        [156.7],
        [155. ],
        [151.7],
        [115.5],
        [145. ],
        [128.8],
        [140.5],
        [136.7],
        [123.3],
        [121.2]],

       [[125.8],
        [264.3],
        [142. ],
        [122.2],
        [126.5],
        [148.7],
        [147.2],
        [150. ],
        [166.7],
        [142.3],
        [171.7],
        [152. ],
        [109.5],
        [105.5],
        [125.7],
        [116.7],
        [ 72.5],
        [ 75.5],
        [ 94. ],
        [101.2]],

       [[149.5],
        [ 76.7],
        [ 73. ],
        [121.3],
        [ 76.2],
        [100.3],
        [ 66.5],
        [128.5],
        [ 56.3],
        [112.8],
        [114.2],
        [115.5],
        [129.7],
        [128.7],
        [ 94.2],
        [ 53.2],
        [ 57. ],
        [ 54.8],
        [ 54.5],
        [ 59.7]],

       [[  9.5],
        [ 32. ],
        [ 45.7],
        [ 50. ],
        [ 71.7],
        [ 54.8],
        [ 49.7],
        [ 55.5],
        [ 36.5],
        [ 68. ],
        [ 71.2],
        [ 73.5],
        [ 91.2],
        [ 88.8],
        [ 89.2],
        [110.2],
        [ 77.2],
        [ 71.2],
        [129.5],
        [129. ]],

       [[243.3],
        [262.2],
        [295.5],
        [182.2],
        [223.3],
        [241.7],
        [398.2],
        [286. ],
        [255. ],
        [233.3],
        [286.2],
        [260.5],
        [250.5],
        [175. ],
        [191.2],
        [276.2],
        [196.7],
        [241.7],
        [233.3],
        [189.5]],

       [[ 99.7],
        [ 39.2],
        [ 38.7],
        [ 47.5],
        [ 73.3],
        [ 58.3],
        [ 83.3],
        [118.3],
        [ 98.8],
        [ 99.5],
        [ 66. ],
        [130.7],
        [ 48.8],
        [ 45.2],
        [ 77.7],
        [ 62.7],
        [ 66.7],
        [ 73.3],
        [ 53.3],
        [ 76.2]],

       [[ 29.7],
        [ 39.5],
        [ 11.3],
        [ 33.3],
        [ 20.8],
        [ 11.8],
        [  9. ],
        [ 15.7],
        [ 20.8],
        [ 21.5],
        [  6. ],
        [ 10.7],
        [ 19.7],
        [ 23.8],
        [ 28.3],
        [ 15.7],
        [ 23.5],
        [ 35.3],
        [ 43.7],
        [ 50. ]],

       [[ 71.7],
        [ 54.8],
        [ 49.7],
        [ 55.5],
        [ 36.5],
        [ 68. ],
        [ 71.2],
        [ 73.5],
        [ 91.2],
        [ 88.8],
        [ 89.2],
        [110.2],
        [ 77.2],
        [ 71.2],
        [129.5],
        [129. ],
        [ 87.7],
        [111.3],
        [124.7],
        [129.7]]])&gt;, &lt;tf.Tensor: shape=(10, 1, 1), dtype=float64, numpy=
array([[[128.7]],

       [[248. ]],

       [[103.3]],

       [[ 84.5]],

       [[ 90.3]],

       [[ 87.7]],

       [[238.3]],

       [[ 63.3]],

       [[ 63.5]],

       [[151. ]]])&gt;)
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>종합하여 함수형으로 만들면 다음과 같이 됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [33]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_data</span> <span class="o">=</span> <span class="p">[]</span>

<span class="k">with</span> <span class="nb">open</span><span class="p">(</span><span class="s1">'sunspots.csv'</span><span class="p">)</span> <span class="k">as</span> <span class="n">csvfile</span><span class="p">:</span>
    <span class="n">reader</span> <span class="o">=</span> <span class="n">csv</span><span class="o">.</span><span class="n">reader</span><span class="p">(</span><span class="n">csvfile</span><span class="p">,</span> <span class="n">delimiter</span><span class="o">=</span><span class="s1">','</span><span class="p">)</span>
    <span class="c1"># 첫 줄은 header이므로 skip 합니다.</span>
    <span class="nb">next</span><span class="p">(</span><span class="n">reader</span><span class="p">)</span>
    <span class="k">for</span> <span class="n">row</span> <span class="ow">in</span> <span class="n">reader</span><span class="p">:</span>
        <span class="n">train_data</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="nb">float</span><span class="p">(</span><span class="n">row</span><span class="p">[</span><span class="mi">2</span><span class="p">]))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [34]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">windowed_dataset</span><span class="p">(</span><span class="n">data</span><span class="p">,</span> <span class="n">window_size</span><span class="p">,</span> <span class="n">batch_size</span><span class="p">,</span> <span class="n">shuffle_buffer</span><span class="p">):</span>
    <span class="n">data</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">data</span><span class="p">,</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">(</span><span class="n">data</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">window</span><span class="p">(</span><span class="n">window_size</span> <span class="o">+</span> <span class="mi">1</span><span class="p">,</span> <span class="n">shift</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">drop_remainder</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">flat_map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">w</span><span class="p">:</span> <span class="n">w</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="n">window_size</span> <span class="o">+</span> <span class="mi">1</span><span class="p">))</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">shuffle</span><span class="p">(</span><span class="n">shuffle_buffer</span><span class="p">)</span>
    <span class="n">ds</span> <span class="o">=</span> <span class="n">ds</span><span class="o">.</span><span class="n">map</span><span class="p">(</span><span class="k">lambda</span> <span class="n">w</span><span class="p">:</span> <span class="p">(</span><span class="n">w</span><span class="p">[:</span><span class="o">-</span><span class="mi">1</span><span class="p">],</span> <span class="n">w</span><span class="p">[</span><span class="o">-</span><span class="mi">1</span><span class="p">:]))</span>
    <span class="k">return</span> <span class="n">ds</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="n">batch_size</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [35]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">window_ds</span> <span class="o">=</span> <span class="n">windowed_dataset</span><span class="p">(</span><span class="n">train_data</span><span class="p">,</span> <span class="n">window_size</span><span class="o">=</span><span class="mi">20</span><span class="p">,</span> <span class="n">batch_size</span><span class="o">=</span><span class="mi">10</span><span class="p">,</span> <span class="n">shuffle_buffer</span><span class="o">=</span><span class="mi">500</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>window_ds</code>의 shape은 (10, 20, 1)로 출력이 되게 됩니다.</p>
<ul>
<li>10은 <code>batch_size</code></li>
<li>20은 <code>window_size</code> (train data)</li>
<li>1은 <code>label</code></li>
</ul>
<p>로 return 되는 것을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [36]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">window_ds</span><span class="p">:</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">d</span><span class="p">)</span>
    <span class="k">break</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>(&lt;tf.Tensor: shape=(10, 20, 1), dtype=float64, numpy=
array([[[116.7],
        [ 92.8],
        [141.7],
        [139.2],
        [158. ],
        [110.5],
        [126.5],
        [125.8],
        [264.3],
        [142. ],
        [122.2],
        [126.5],
        [148.7],
        [147.2],
        [150. ],
        [166.7],
        [142.3],
        [171.7],
        [152. ],
        [109.5]],

       [[ 75. ],
        [ 73.3],
        [ 64.5],
        [104.2],
        [ 62.8],
        [ 71.7],
        [ 71.7],
        [ 80.5],
        [ 73.3],
        [ 78. ],
        [ 78.3],
        [ 81.7],
        [ 83.3],
        [ 85. ],
        [118.8],
        [128.7],
        [ 99.5],
        [ 77.2],
        [ 95. ],
        [112.2]],

       [[ 14.3],
        [  5.3],
        [ 29.7],
        [ 39.5],
        [ 11.3],
        [ 33.3],
        [ 20.8],
        [ 11.8],
        [  9. ],
        [ 15.7],
        [ 20.8],
        [ 21.5],
        [  6. ],
        [ 10.7],
        [ 19.7],
        [ 23.8],
        [ 28.3],
        [ 15.7],
        [ 23.5],
        [ 35.3]],

       [[ 68.2],
        [ 72. ],
        [ 78. ],
        [109. ],
        [ 92.8],
        [ 73. ],
        [ 85.5],
        [ 47.5],
        [ 29.2],
        [ 11. ],
        [ 13.2],
        [ 23.3],
        [ 29.5],
        [ 20.3],
        [  7.3],
        [  0. ],
        [ 19.3],
        [ 18.7],
        [  6.5],
        [ 20.5]],

       [[ 61. ],
        [ 10. ],
        [ 44.7],
        [  5. ],
        [  5.5],
        [  6.7],
        [  7.2],
        [  8.3],
        [  9.5],
        [ 32. ],
        [ 45.7],
        [ 50. ],
        [ 71.7],
        [ 54.8],
        [ 49.7],
        [ 55.5],
        [ 36.5],
        [ 68. ],
        [ 71.2],
        [ 73.5]],

       [[ 60. ],
        [ 52.8],
        [ 36.7],
        [ 65. ],
        [ 46.7],
        [ 41.7],
        [ 33.3],
        [ 11.2],
        [  0. ],
        [  5. ],
        [  2.8],
        [ 22.8],
        [ 34.5],
        [ 44.5],
        [ 31.3],
        [ 20.5],
        [ 13.7],
        [ 40.2],
        [ 22. ],
        [  7. ]],

       [[ 18.7],
        [  6.5],
        [ 20.5],
        [  1.7],
        [ 13.2],
        [  5.3],
        [  9.3],
        [ 25.2],
        [ 13.2],
        [ 36.2],
        [ 19.3],
        [ 10.5],
        [ 36.3],
        [ 18.7],
        [ 31.7],
        [  1.7],
        [ 40.3],
        [ 26.7],
        [ 50. ],
        [ 58.3]],

       [[ 47.3],
        [ 46.2],
        [ 21.2],
        [ 48.8],
        [ 43.8],
        [ 68.2],
        [ 72. ],
        [ 78. ],
        [109. ],
        [ 92.8],
        [ 73. ],
        [ 85.5],
        [ 47.5],
        [ 29.2],
        [ 11. ],
        [ 13.2],
        [ 23.3],
        [ 29.5],
        [ 20.3],
        [  7.3]],

       [[ 43.8],
        [ 68.2],
        [ 72. ],
        [ 78. ],
        [109. ],
        [ 92.8],
        [ 73. ],
        [ 85.5],
        [ 47.5],
        [ 29.2],
        [ 11. ],
        [ 13.2],
        [ 23.3],
        [ 29.5],
        [ 20.3],
        [  7.3],
        [  0. ],
        [ 19.3],
        [ 18.7],
        [  6.5]],

       [[250.5],
        [175. ],
        [191.2],
        [276.2],
        [196.7],
        [241.7],
        [233.3],
        [189.5],
        [238.3],
        [186.7],
        [185. ],
        [206.7],
        [190. ],
        [183.3],
        [116.7],
        [163.3],
        [163.3],
        [158.3],
        [178.7],
        [146.7]]])&gt;, &lt;tf.Tensor: shape=(10, 1, 1), dtype=float64, numpy=
array([[[105.5]],

       [[ 99.2]],

       [[ 43.7]],

       [[  1.7]],

       [[ 91.2]],

       [[ 17. ]],

       [[ 66.7]],

       [[  0. ]],

       [[ 20.5]],

       [[143.3]]])&gt;)
</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>