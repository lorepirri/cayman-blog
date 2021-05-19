---
layout: page
title: "TensorFlow2.0 GradientTape의 활용법"
description: "TensorFlow2.0 GradientTape의 활용해 보는 방법에 대해 알아보겠습니다."
headline: "TensorFlow2.0 GradientTape의 활용해 보는 방법에 대해 알아보겠습니다."
categories: tensorflow
tags: [python, colab, tensorflow, deep-learning, gradient-tape]
comments: true
published: true
typora-copy-images-to: ../images/2020-05-25
---

TensorFlow 2.0의 자동 미분 기능인 **GradientTape**에 대하여 알아보겠습니다.

GradientTape은 자동 미분을 통해 **동적으로 Gradient 값들을 확인해 볼 수 있다는 장점**을 가지고 있습니다.

직접 print 해볼 수 있고, 또한 시각화 해 볼 수 있습니다.

아래 TensorFlow 공식 도큐먼트의 튜토리얼 진행을 통해 GradientTape의 자동미분 기능에 대하여 알아보도록 하겠습니다.

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>본 튜토리얼은 <strong>TensorFlow 공식 문서</strong>를 참조(reference) 하여 작성되었습니다.</p>
<p><strong>출처</strong></p>
<ul>
<li><a href="https://www.tensorflow.org/tutorials/customization/autodiff?hl=ko">TensorFlow - GradientTape</a></li>
<li><a href="https://www.tensorflow.org/tutorials/quickstart/advanced?hl=ko">TensorFlow - 전문가를 위한 빠른시작</a></li>
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
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">tf</span><span class="o">.</span><span class="n">__version__</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'2.2.0'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="샘플데이터-로드-(mnist)">샘플데이터 로드 (mnist)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">mnist</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">datasets</span><span class="o">.</span><span class="n">mnist</span>

<span class="p">(</span><span class="n">x_train</span><span class="p">,</span> <span class="n">y_train</span><span class="p">),</span> <span class="p">(</span><span class="n">x_test</span><span class="p">,</span> <span class="n">y_test</span><span class="p">)</span> <span class="o">=</span> <span class="n">mnist</span><span class="o">.</span><span class="n">load_data</span><span class="p">()</span>
<span class="n">x_train</span><span class="p">,</span> <span class="n">x_test</span> <span class="o">=</span> <span class="n">x_train</span> <span class="o">/</span> <span class="mf">255.0</span><span class="p">,</span> <span class="n">x_test</span> <span class="o">/</span> <span class="mf">255.0</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x_train</span><span class="o">.</span><span class="n">min</span><span class="p">(),</span> <span class="n">x_train</span><span class="o">.</span><span class="n">max</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(0.0, 1.0)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 차원을 1 늘려줍니다</span>
<span class="n">x_train</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">x_train</span><span class="p">,</span> <span class="o">-</span><span class="mi">1</span><span class="p">)</span>
<span class="n">x_test</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">x_test</span><span class="p">,</span> <span class="o">-</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x_train</span><span class="o">.</span><span class="n">shape</span><span class="p">,</span> <span class="n">x_test</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(TensorShape([60000, 28, 28, 1]), TensorShape([10000, 28, 28, 1]))</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Dataset을-만듭니다">Dataset을 만듭니다</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">((</span><span class="n">x_train</span><span class="p">,</span> <span class="n">y_train</span><span class="p">))</span><span class="o">.</span><span class="n">shuffle</span><span class="p">(</span><span class="mi">10000</span><span class="p">)</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="mi">32</span><span class="p">)</span>
<span class="n">test_ds</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">data</span><span class="o">.</span><span class="n">Dataset</span><span class="o">.</span><span class="n">from_tensor_slices</span><span class="p">((</span><span class="n">x_test</span><span class="p">,</span> <span class="n">y_test</span><span class="p">))</span><span class="o">.</span><span class="n">batch</span><span class="p">(</span><span class="mi">32</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="STEP-1.-Model을-정의합니다.">STEP 1. Model을 정의합니다.</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># layer 정의</span>
<span class="n">input_</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Input</span><span class="p">(</span><span class="n">shape</span><span class="o">=</span><span class="p">(</span><span class="mi">28</span><span class="p">,</span> <span class="mi">28</span><span class="p">,</span> <span class="mi">1</span><span class="p">))</span>
<span class="n">x</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Conv2D</span><span class="p">(</span><span class="mi">32</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">)(</span><span class="n">input_</span><span class="p">)</span>
<span class="n">x</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Conv2D</span><span class="p">(</span><span class="mi">64</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">)(</span><span class="n">x</span><span class="p">)</span>
<span class="n">x</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Flatten</span><span class="p">()(</span><span class="n">x</span><span class="p">)</span>
<span class="n">x</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Dense</span><span class="p">(</span><span class="mi">128</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">)(</span><span class="n">x</span><span class="p">)</span>
<span class="n">output_</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">layers</span><span class="o">.</span><span class="n">Dense</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'softmax'</span><span class="p">)(</span><span class="n">x</span><span class="p">)</span>

<span class="c1"># model을 정의</span>
<span class="n">model</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">models</span><span class="o">.</span><span class="n">Model</span><span class="p">(</span><span class="n">input_</span><span class="p">,</span> <span class="n">output_</span><span class="p">)</span>
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
<pre>Model: "model"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
input_1 (InputLayer)         [(None, 28, 28, 1)]       0         
_________________________________________________________________
conv2d_4 (Conv2D)            (None, 26, 26, 32)        320       
_________________________________________________________________
conv2d_5 (Conv2D)            (None, 24, 24, 64)        18496     
_________________________________________________________________
flatten_4 (Flatten)          (None, 36864)             0         
_________________________________________________________________
dense_8 (Dense)              (None, 128)               4718720   
_________________________________________________________________
dense_9 (Dense)              (None, 10)                1290      
=================================================================
Total params: 4,738,826
Trainable params: 4,738,826
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
<h2 id="STEP-2.-Loss-Function을-정의합니다.">STEP 2. Loss Function을 정의합니다.</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">loss_function</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">losses</span><span class="o">.</span><span class="n">SparseCategoricalCrossentropy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="STEP-3.-Optimizer를-정의합니다.">STEP 3. Optimizer를 정의합니다.</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">optimizer</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">optimizers</span><span class="o">.</span><span class="n">Adam</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="STEP-4.-Metric을-정의합니다.">STEP 4. Metric을 정의합니다.</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_loss</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">metrics</span><span class="o">.</span><span class="n">Mean</span><span class="p">()</span>
<span class="n">train_acc</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">metrics</span><span class="o">.</span><span class="n">SparseCategoricalAccuracy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">test_loss</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">metrics</span><span class="o">.</span><span class="n">Mean</span><span class="p">()</span>
<span class="n">test_acc</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">metrics</span><span class="o">.</span><span class="n">SparseCategoricalAccuracy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="STEP-5.-Train/Test-step-함수를-정의합니다.">STEP 5. Train/Test step 함수를 정의합니다.</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="GradientTape-(그라디언트-테이프)">GradientTape (그라디언트 테이프)</h3><p>텐서플로는 <strong>자동 미분(주어진 입력 변수에 대한 연산의 그래디언트(gradient)를 계산하는 것)</strong> 을 위한 tf.GradientTape API를 제공합니다.</p>
<p>tf.GradientTape는 컨텍스트(context) 안에서 실행된 모든 연산을 테이프(tape)에 "기록"합니다.</p>
<p>그 다음 텐서플로는 후진 방식 자동 미분(reverse mode differentiation)을 사용해 테이프에 "기록된" 연산의 그래디언트를 계산합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nd">@tf</span><span class="o">.</span><span class="n">function</span>
<span class="k">def</span> <span class="nf">train_step</span><span class="p">(</span><span class="n">images</span><span class="p">,</span> <span class="n">labels</span><span class="p">):</span>
    <span class="c1"># 미분을 위한 GradientTape을 적용합니다.</span>
    <span class="k">with</span> <span class="n">tf</span><span class="o">.</span><span class="n">GradientTape</span><span class="p">()</span> <span class="k">as</span> <span class="n">tape</span><span class="p">:</span>
        <span class="c1"># 1. 예측 (prediction)</span>
        <span class="n">predictions</span> <span class="o">=</span> <span class="n">model</span><span class="p">(</span><span class="n">images</span><span class="p">)</span>
        <span class="c1"># 2. Loss 계산</span>
        <span class="n">loss</span> <span class="o">=</span> <span class="n">loss_function</span><span class="p">(</span><span class="n">labels</span><span class="p">,</span> <span class="n">predictions</span><span class="p">)</span>
    
    <span class="c1"># 3. 그라디언트(gradients) 계산</span>
    <span class="n">gradients</span> <span class="o">=</span> <span class="n">tape</span><span class="o">.</span><span class="n">gradient</span><span class="p">(</span><span class="n">loss</span><span class="p">,</span> <span class="n">model</span><span class="o">.</span><span class="n">trainable_variables</span><span class="p">)</span>
    
    <span class="c1"># 4. 오차역전파(Backpropagation) - weight 업데이트</span>
    <span class="n">optimizer</span><span class="o">.</span><span class="n">apply_gradients</span><span class="p">(</span><span class="nb">zip</span><span class="p">(</span><span class="n">gradients</span><span class="p">,</span> <span class="n">model</span><span class="o">.</span><span class="n">trainable_variables</span><span class="p">))</span>
    
    <span class="c1"># loss와 accuracy를 업데이트 합니다.</span>
    <span class="n">train_loss</span><span class="p">(</span><span class="n">loss</span><span class="p">)</span>
    <span class="n">train_acc</span><span class="p">(</span><span class="n">labels</span><span class="p">,</span> <span class="n">predictions</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nd">@tf</span><span class="o">.</span><span class="n">function</span>
<span class="k">def</span> <span class="nf">test_step</span><span class="p">(</span><span class="n">images</span><span class="p">,</span> <span class="n">labels</span><span class="p">):</span>
    <span class="c1"># 1. 예측 (prediction)</span>
    <span class="n">predictions</span> <span class="o">=</span> <span class="n">model</span><span class="p">(</span><span class="n">images</span><span class="p">)</span>
    <span class="c1"># 2. Loss 계산</span>
    <span class="n">loss</span> <span class="o">=</span> <span class="n">loss_function</span><span class="p">(</span><span class="n">labels</span><span class="p">,</span> <span class="n">predictions</span><span class="p">)</span>
    
    <span class="c1"># Test셋에 대해서는 gradient를 계산 및 backpropagation 하지 않습니다.</span>
    
    <span class="c1"># loss와 accuracy를 업데이트 합니다.</span>
    <span class="n">test_loss</span><span class="p">(</span><span class="n">loss</span><span class="p">)</span>
    <span class="n">test_acc</span><span class="p">(</span><span class="n">labels</span><span class="p">,</span> <span class="n">predictions</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">EPOCHS</span> <span class="o">=</span> <span class="mi">5</span>

<span class="k">for</span> <span class="n">epoch</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">EPOCHS</span><span class="p">):</span>
    <span class="k">for</span> <span class="n">images</span><span class="p">,</span> <span class="n">labels</span> <span class="ow">in</span> <span class="n">train_ds</span><span class="p">:</span>
        <span class="n">train_step</span><span class="p">(</span><span class="n">images</span><span class="p">,</span> <span class="n">labels</span><span class="p">)</span>
        
    <span class="k">for</span> <span class="n">test_images</span><span class="p">,</span> <span class="n">test_labels</span> <span class="ow">in</span> <span class="n">test_ds</span><span class="p">:</span>
        <span class="n">test_step</span><span class="p">(</span><span class="n">test_images</span><span class="p">,</span> <span class="n">test_labels</span><span class="p">)</span>

    <span class="n">template</span> <span class="o">=</span> <span class="s1">'에포크: </span><span class="si">{}</span><span class="s1">, 손실: </span><span class="si">{:.5f}</span><span class="s1">, 정확도: </span><span class="si">{:.2f}</span><span class="s1">%, 테스트 손실: </span><span class="si">{:.5f}</span><span class="s1">, 테스트 정확도: </span><span class="si">{:.2f}</span><span class="s1">%'</span>
    <span class="nb">print</span> <span class="p">(</span><span class="n">template</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">epoch</span><span class="o">+</span><span class="mi">1</span><span class="p">,</span>
                           <span class="n">train_loss</span><span class="o">.</span><span class="n">result</span><span class="p">(),</span>
                           <span class="n">train_acc</span><span class="o">.</span><span class="n">result</span><span class="p">()</span><span class="o">*</span><span class="mi">100</span><span class="p">,</span>
                           <span class="n">test_loss</span><span class="o">.</span><span class="n">result</span><span class="p">(),</span>
                           <span class="n">test_acc</span><span class="o">.</span><span class="n">result</span><span class="p">()</span><span class="o">*</span><span class="mi">100</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>에포크: 1, 손실: 0.01474, 정확도: 99.55%, 테스트 손실: 0.06000, 테스트 정확도: 98.74%
에포크: 2, 손실: 0.01392, 정확도: 99.57%, 테스트 손실: 0.06164, 테스트 정확도: 98.75%
에포크: 3, 손실: 0.01332, 정확도: 99.59%, 테스트 손실: 0.06439, 테스트 정확도: 98.75%
에포크: 4, 손실: 0.01273, 정확도: 99.61%, 테스트 손실: 0.06755, 테스트 정확도: 98.74%
에포크: 5, 손실: 0.01231, 정확도: 99.63%, 테스트 손실: 0.07177, 테스트 정확도: 98.72%
</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>