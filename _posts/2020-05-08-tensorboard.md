---
layout: page
title: "TensorBoard 활용법 및 colab에서 로드하기"
description: "TensorBoard 활용법 및 colab에서 로드하는 방법에 대하여 알아보겠습니다."
headline: "TensorBoard 활용법 및 colab에서 로드하는 방법에 대하여 알아보겠습니다."
categories: tensorflow
tags: [python, colab, tensorflow, deep-learning, tensorboard]
comments: true
published: true
---

TensorBoard 사용을 위한 callback을 만드는 방법과 colab에서 바로 로드하여 확인할 수 있는 `magic command`에 대한 내용입니다.

밑에서 추가로 언급하지만, **Jupyter Notebook 서버나 로컬에서 돌리시는 분들은 별도의 extension 설치**를 해주셔야 하며, TensorBoard extension을 통해 텐서보드를 확인하실 수 있습니다.

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h1 id="사전-설치사항">사전 설치사항</h1>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>구글 코랩 (Google Colab) 에서는 별도의 설치 없이 바로 동작 가능합니다.</li>
<li>local이나 Jupyter Notebook 서버에서 실행하실 분들은 별도의 설치 과정이 필요합니다.</li>
<li>아래 안내해 드리는 방법을 통해 jupyter-tensorboard 설치후, Jupyter Notebook에서 <strong>Tensorboard</strong>를 클릭하시면, 바로 텐서보드를 보실 수 있습니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Jupyter-Notebook-서버에서-Tensorboard-로드를-위한-설치">Jupyter Notebook 서버에서 Tensorboard 로드를 위한 설치</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li><a href="https://pypi.org/project/jupyter-tensorboard/">pip 패키지 주소</a></li>
<li><a href="https://github.com/lspvic/jupyter_tensorboard">jupyter-tensorboard 깃헙</a></li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>설치</li>
</ul>
<p><code>pip install jupyter-tensorboard</code></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="도커를-통하여-실행">도커를 통하여 실행</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>docker pull lspvic/tensorboard-notebook</code></p>
<p><code>docker run -it --rm -p 8888:8888 lspvic/tensorboard-notebook</code></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h1 id="실습-START">실습 START</h1>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="필요한-라이브러리-import">필요한 라이브러리 import</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">tensorflow</span> <span class="k">as</span> <span class="nn">tf</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.layers</span> <span class="k">import</span> <span class="n">Dense</span><span class="p">,</span> <span class="n">Flatten</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.models</span> <span class="k">import</span> <span class="n">Sequential</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.callbacks</span> <span class="k">import</span> <span class="n">ModelCheckpoint</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="데이터-로드-&amp;-전처리">데이터 로드 &amp; 전처리</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">fashion_mnist</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">datasets</span><span class="o">.</span><span class="n">fashion_mnist</span>

<span class="p">(</span><span class="n">x_train</span><span class="p">,</span> <span class="n">y_train</span><span class="p">),</span> <span class="p">(</span><span class="n">x_test</span><span class="p">,</span> <span class="n">y_test</span><span class="p">)</span> <span class="o">=</span> <span class="n">fashion_mnist</span><span class="o">.</span><span class="n">load_data</span><span class="p">()</span>

<span class="n">x_train</span> <span class="o">=</span> <span class="n">x_train</span> <span class="o">/</span> <span class="mf">255.0</span>
<span class="n">x_test</span> <span class="o">=</span> <span class="n">x_test</span> <span class="o">/</span> <span class="mf">255.0</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>Downloading data from https://storage.googleapis.com/tensorflow/tf-keras-datasets/train-labels-idx1-ubyte.gz
32768/29515 [=================================] - 0s 2us/step
Downloading data from https://storage.googleapis.com/tensorflow/tf-keras-datasets/train-images-idx3-ubyte.gz
26427392/26421880 [==============================] - 1s 0us/step
Downloading data from https://storage.googleapis.com/tensorflow/tf-keras-datasets/t10k-labels-idx1-ubyte.gz
8192/5148 [===============================================] - 0s 0us/step
Downloading data from https://storage.googleapis.com/tensorflow/tf-keras-datasets/t10k-images-idx3-ubyte.gz
4423680/4422102 [==============================] - 0s 0us/step
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="간단한-모델링">간단한 모델링</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span> <span class="o">=</span> <span class="n">Sequential</span><span class="p">([</span>
    <span class="n">Flatten</span><span class="p">(</span><span class="n">input_shape</span><span class="o">=</span><span class="p">(</span><span class="mi">28</span><span class="p">,</span> <span class="mi">28</span><span class="p">)),</span>
    <span class="n">Dense</span><span class="p">(</span><span class="mi">512</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">),</span>
    <span class="n">Dense</span><span class="p">(</span><span class="mi">256</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">),</span>
    <span class="n">Dense</span><span class="p">(</span><span class="mi">128</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">),</span>
    <span class="n">Dense</span><span class="p">(</span><span class="mi">64</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">),</span>
    <span class="n">Dense</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'softmax'</span><span class="p">)</span>
<span class="p">])</span>
    
<span class="n">model</span><span class="o">.</span><span class="n">compile</span><span class="p">(</span><span class="n">optimizer</span><span class="o">=</span><span class="s1">'adam'</span><span class="p">,</span>
                <span class="n">loss</span><span class="o">=</span><span class="s1">'sparse_categorical_crossentropy'</span><span class="p">,</span>
                <span class="n">metrics</span><span class="o">=</span><span class="p">[</span><span class="s1">'acc'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="[핵심코드]-텐서보드-콜백-만들기">[핵심코드] 텐서보드 콜백 만들기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 시간정보를 활용하여 폴더 생성</span>
<span class="kn">import</span> <span class="nn">datetime</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 학습데이터의 log를 저장할 폴더 생성 (지정)</span>
<span class="n">log_dir</span> <span class="o">=</span> <span class="s2">"logs/my_board/"</span> <span class="o">+</span> <span class="n">datetime</span><span class="o">.</span><span class="n">datetime</span><span class="o">.</span><span class="n">now</span><span class="p">()</span><span class="o">.</span><span class="n">strftime</span><span class="p">(</span><span class="s2">"%Y%m</span><span class="si">%d</span><span class="s2">-%H%M%S"</span><span class="p">)</span>

<span class="c1"># 텐서보드 콜백 정의 하기</span>
<span class="n">tensorboard_callback</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">callbacks</span><span class="o">.</span><span class="n">TensorBoard</span><span class="p">(</span><span class="n">log_dir</span><span class="o">=</span><span class="n">log_dir</span><span class="p">,</span> <span class="n">histogram_freq</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">fit</span><span class="p">(</span><span class="n">x_train</span><span class="p">,</span> <span class="n">y_train</span><span class="p">,</span>
            <span class="n">validation_data</span><span class="o">=</span><span class="p">(</span><span class="n">x_test</span><span class="p">,</span> <span class="n">y_test</span><span class="p">),</span> 
            <span class="n">epochs</span><span class="o">=</span><span class="mi">10</span><span class="p">,</span> 
            <span class="n">callbacks</span><span class="o">=</span><span class="p">[</span><span class="n">tensorboard_callback</span><span class="p">],</span>
            <span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>Train on 60000 samples, validate on 10000 samples
Epoch 1/10
60000/60000 [==============================] - 6s 99us/sample - loss: 0.0853 - acc: 0.9695 - val_loss: 0.6725 - val_acc: 0.8950
Epoch 2/10
60000/60000 [==============================] - 6s 97us/sample - loss: 0.0796 - acc: 0.9712 - val_loss: 0.7866 - val_acc: 0.8898
Epoch 3/10
60000/60000 [==============================] - 6s 95us/sample - loss: 0.0755 - acc: 0.9720 - val_loss: 0.7241 - val_acc: 0.8978
Epoch 4/10
60000/60000 [==============================] - 6s 96us/sample - loss: 0.0822 - acc: 0.9707 - val_loss: 0.8183 - val_acc: 0.8965
Epoch 5/10
60000/60000 [==============================] - 6s 98us/sample - loss: 0.0770 - acc: 0.9723 - val_loss: 0.7377 - val_acc: 0.8930
Epoch 6/10
60000/60000 [==============================] - 6s 98us/sample - loss: 0.0786 - acc: 0.9721 - val_loss: 0.8396 - val_acc: 0.8920
Epoch 7/10
60000/60000 [==============================] - 6s 98us/sample - loss: 0.0788 - acc: 0.9714 - val_loss: 0.8566 - val_acc: 0.8976
Epoch 8/10
60000/60000 [==============================] - 6s 96us/sample - loss: 0.0730 - acc: 0.9742 - val_loss: 0.8196 - val_acc: 0.8976
Epoch 9/10
60000/60000 [==============================] - 6s 98us/sample - loss: 0.0704 - acc: 0.9746 - val_loss: 0.8780 - val_acc: 0.8948
Epoch 10/10
60000/60000 [==============================] - 6s 99us/sample - loss: 0.0715 - acc: 0.9746 - val_loss: 0.8415 - val_acc: 0.8940
</pre>
</div>
</div>
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>&lt;tensorflow.python.keras.callbacks.History at 0x7fe8d7cfa780&gt;</pre>
</div>
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
flatten (Flatten)            (None, 784)               0         
_________________________________________________________________
dense (Dense)                (None, 512)               401920    
_________________________________________________________________
dense_1 (Dense)              (None, 256)               131328    
_________________________________________________________________
dense_2 (Dense)              (None, 128)               32896     
_________________________________________________________________
dense_3 (Dense)              (None, 64)                8256      
_________________________________________________________________
dense_4 (Dense)              (None, 10)                650       
=================================================================
Total params: 575,050
Trainable params: 575,050
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
<h2 id="텐서보드를-colab에서-바로-로드-하기">텐서보드를 colab에서 바로 로드 하기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>텐서보드 extension 로드를 위한 <code>magic command</code></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="o">%</span><span class="k">load_ext</span> tensorboard
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>텐서보드를 로드 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="o">%</span><span class="k">tensorboard</span> --logdir {log_dir}
</pre></div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>