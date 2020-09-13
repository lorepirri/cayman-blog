---
layout: page
title: "TensorFlow LSTM layer 활용법"
description: "TensorFlow LSTM layer 활용법에 대해 알아보겠습니다."
headline: "TensorFlow LSTM layer 활용법에 대해 알아보겠습니다."
categories: tensorflow
tags: [python, tensorflow, lstm, rnn,텐서플로우, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2020-09-13
---

시계열 데이터 그리고 NLP에서 흔히 사용되는 **LSTM Layer**의 주요 Hyper Parameter에 대하여 알아보고, 많이 헷갈려 하시는 **input_shape 지정과 결과 값 (output)**에 대해서도 직접 실행해 보면서 어떻게 동작하는지 살펴보도록 하겠습니다.


실습을 위한 파일은 아래에서 확인할 수 있습니다.

- [Colab 파일](https://colab.research.google.com/github/teddylee777/machine-learning/blob/master/04-TensorFlow2.0/09-LSTM/LSTM%20Layer.ipynb)
- [GitHub](https://github.com/teddylee777/machine-learning/blob/master/04-TensorFlow2.0/09-LSTM/LSTM%20Layer.ipynb)


<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="LSTM-Layer-파헤치기">LSTM Layer</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>Sequence 혹은 Time Series (시계열) 데이터</strong>를 다룰 때, <code>LSTM</code> layer를 어떻게 활용하여 접근하면 되는지 이해하기 위한 튜토리얼 코드입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>필요한 모듈을 import 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">tensorflow</span> <span class="k">as</span> <span class="nn">tf</span>

<span class="kn">from</span> <span class="nn">tensorflow.keras.layers</span> <span class="k">import</span> <span class="n">Dense</span><span class="p">,</span> <span class="n">Conv1D</span><span class="p">,</span> <span class="n">LSTM</span><span class="p">,</span> <span class="n">Input</span><span class="p">,</span> <span class="n">TimeDistributed</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.models</span> <span class="k">import</span> <span class="n">Model</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="0.-Hyper-Parameter-설명">0. Hyper Parameter 설명</h2><p>출처: keras.io</p>
<ul>
<li><code>units</code>: 양의 정수, 아웃풋 공간의 차원입니다.</li>
<li><code>activation</code>: 사용할 활성화 함수 (활성화를 참조하십시오). 디폴트: 쌍곡 탄젠트 (tanh). None을 전달하는 경우, 활성화가 적용되지 않습니다 (다시 말해, "선형적" 활성화: a(x) = x).</li>
<li><code>recurrent_activation</code>: 순환 단계에 사용할 활성화 함수 (활성화를 참조하십시오). 디폴트 값: 하드 시그모이드 (hard_sigmoid). None을 전달하는 경우, 활성화가 적용되지 않습니다 (다시 말해, "선형적" 활성화: a(x) = x).</li>
<li><code>use_bias</code>: 불리언, 레이어가 편향 벡터를 사용하는지 여부.</li>
<li><code>kernel_initializer</code>: kernel 가중치 행렬의 초기값 설정기. 인풋의 선형적 변형에 사용됩니다 ( 초기값 설정기를 참조하십시오).</li>
<li><code>recurrent_initializer</code>: recurrent_kernel 가중치 행렬의 초기값 설정기. 순환 상태의 선형적 변형에 사용됩니다 ( 초기값 설정기를 참조하십시오).</li>
<li><code>bias_initializer</code>: 편향 벡터의 초기값 설정기 ( 초기값 설정기를 참조하십시오).</li>
<li><code>unit_forget_bias</code>: 불리언. 참일 경우, 초기값 설정 시 망각 회로에 1을 더합니다. 참으로 설정 시 강제적으로 bias_initializer="zeros"가 됩니다. 이는 [Jozefowicz et al. (2015)] 에서 권장됩니다. (<a href="http://www.jmlr.org/proceedings/papers/v37/jozefowicz15.pdf">http://www.jmlr.org/proceedings/papers/v37/jozefowicz15.pdf</a>).</li>
<li><code>kernel_regularizer</code>: kernel 가중치 행렬에 적용되는 정규화 함수 (정규화를 참조하십시오).</li>
<li><code>recurrent_regularizer</code>: recurrent_kernel 가중치 행렬에 적용되는 정규화 함수 (정규화를 참조하십시오).</li>
<li><code>bias_regularizer</code>: 편향 벡터에 적용되는 정규화 함수 (정규화를 참조하십시오).</li>
<li><code>activity_regularizer</code>: 레이어의 아웃풋(레이어의 “활성화”)에 적용되는 정규화 함수 (정규화를 참조하십시오).</li>
<li><code>kernel_constraint</code>: kernel 가중치 행렬에 적용되는 제약 함수 (제약을 참조하십시오).</li>
<li><code>recurrent_constraint</code>: recurrent_kernel 가중치 행렬에 적용되는 제약 함수 (제약을 참조하십시오).</li>
<li><code>bias_constraint</code>: 편향 벡터에 적용하는 제약 함수 (제약을 참조하십시오).</li>
<li><code>dropout</code>: 0과 1사이 부동소수점. 인풋의 선형적 변형을 실행하는데 드롭시킬(고려하지 않을) 유닛의 비율.</li>
<li><code>recurrent_dropout</code>: 0과 1사이 부동소수점. 순환 상태의 선형적 변형을 실행하는데 드롭시킬(고려하지 않을) 유닛의 비율.</li>
<li><code>implementation</code>: 실행 모드, 1 혹은 2. 모드 1은 비교적 많은 수의 소규모의 점곱과 덧셈을 이용해 연산을 구성하는데 반해, 모드 2는 이를 소수의 대규모 연산으로 묶습니다. 이 두 모드는, 하드웨어나 어플리케이션에 따라서 성능의 차이를 보입니다.</li>
<li><code>return_sequences</code>: 불리언. 아웃풋 시퀀스의 마지막 아웃풋을 반환할지, 혹은 시퀀스 전체를 반환할지 여부.</li>
<li><code>return_state</code>: 불리언. 아웃풋에 더해 마지막 상태도 반환할지 여부. 상태 리스트의 반환된 성분은 각각 은닉 성분과 셀 상태입니다.</li>
<li><code>go_backwards</code>: 불리언 (디폴트 값은 거짓). 참인 경우, 인풋 시퀀스를 거꾸로 처리하여 뒤집힌 시퀀스를 반환합니다.</li>
<li><code>stateful</code>: 불리언 (디폴트 값은 거짓). 참인 경우, 배치 내 색인 i의 각 샘플의 마지막 상태가 다음 배치의 색인 i 샘플의 초기 상태로 사용됩니다.</li>
<li><code>unroll</code>: 불리언 (디폴트 값은 거짓). 참인 경우, 신경망을 펼쳐서 사용하고 그렇지 않은 경우 심볼릭 루프가 사용됩니다. 신경망을 펼쳐 순환 신경망의 속도를 높일 수 있지만, 메모리 소모가 큰 경향이 있습니다. 신경망 펼치기는 짧은 시퀀스에만 적합합니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="1.-LSTM-Layer와-input_shape">1. LSTM Layer와 input_shape</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>주요 hyper parameter는 다음과 같습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li><code>batch</code>: 32</li>
<li><code>time_step</code>: 3</li>
<li><code>window_size</code>: 25</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="sample-data-생성">sample data 생성</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>아래와 같이 샘플 데이터를 생성합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">shape</span><span class="o">=</span><span class="p">(</span><span class="mi">32</span><span class="p">,</span> <span class="mi">25</span><span class="p">,</span> <span class="mi">1</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

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

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 25, 1])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>32는 <code>batch</code>의 크기, 25는 <code>time_step</code>의 크기, 1은 <code>feature</code>의 갯수를 나타냅니다.</p>
<p>여기서 batch는 얼마만큼 <code>batch</code>로 묶어 주느냐에 따라 달라지는 hyper parameter이므로 크게 걱정할 이유가 없습니다.</p>
<p>25는 <code>window_size</code>를 나타내며, 일자로 예를 들자면, 25일치의 <code>time_step</code>을 input으로 공급하겠다는 겁니다.</p>
<p>1은 <code>feature_size</code>이며, 주가 데이터를 예로 들자면, <strong>종가</strong> 데이터 한 개만 본다면 1로 설정합니다.</p>
<p>만약에, [종가, 시가, 고가] 3가지 feature를 모두 본다면, 3이 될 것 입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="1-1.-return_sequences=False-인-경우">1-1. return_sequences=False 인 경우</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">lstm</span> <span class="o">=</span> <span class="n">LSTM</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_a</span> <span class="o">=</span> <span class="n">lstm</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_a</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>&lt;tf.Tensor: shape=(5, 20), dtype=float32, numpy=
array([[ 0.0559595 , -0.05586447,  0.01562458,  0.00130411,  0.11520934,
        -0.01569717,  0.05896714,  0.10633335, -0.10099649, -0.0895073 ,
         0.09156958, -0.1250121 ,  0.12915154,  0.15041941,  0.1687898 ,
         0.07545557,  0.03136618, -0.04485515, -0.09611584,  0.12217667],
       [ 0.04599508, -0.04271319,  0.0081454 ,  0.00164716,  0.09110518,
        -0.01368569,  0.04619731,  0.08265037, -0.08071719, -0.06956011,
         0.07104722, -0.10059189,  0.10163817,  0.11899291,  0.13383332,
         0.05991678,  0.01784938, -0.03414863, -0.07282522,  0.09431793],
       [ 0.06210867, -0.0611512 ,  0.01134113, -0.00031514,  0.11764027,
        -0.0059853 ,  0.06296651,  0.10995053, -0.10714778, -0.09964801,
         0.09775616, -0.1289017 ,  0.1313088 ,  0.1475695 ,  0.17655191,
         0.07755531,  0.04121136, -0.04944682, -0.10082759,  0.12683724],
       [ 0.06118734, -0.05681478,  0.01048003, -0.00192574,  0.10665021,
        -0.00235509,  0.05783206,  0.10174502, -0.10025527, -0.09348387,
         0.09050924, -0.11905503,  0.11846406,  0.13178083,  0.1623766 ,
         0.07083748,  0.04227899, -0.0449112 , -0.08791713,  0.11635619],
       [ 0.04599692, -0.04286867,  0.01018664,  0.0018954 ,  0.09253937,
        -0.01562607,  0.04626926,  0.08421714, -0.08112663, -0.06940781,
         0.07189781, -0.10184712,  0.10289992,  0.1220342 ,  0.13545088,
         0.06110865,  0.01777248, -0.03410698, -0.07323777,  0.09567976]],
      dtype=float32)&gt;</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_a</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 20])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>결과 해석</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ol>
<li><code>output_a</code>의 shape이 <code>(32, 20)</code>으로 출력됌을 확인할 수 있습니다.</li>
<li>shape가 (32, 20)의 32는 <code>batch</code>의 갯수, 20은 LSTM에서 지정한 unit 수입니다.</li>
</ol>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="1-2.-return_sequences=True-인-경우">1-2. return_sequences=True 인 경우</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">lstm</span> <span class="o">=</span> <span class="n">LSTM</span><span class="p">(</span><span class="mi">20</span><span class="p">,</span> <span class="n">return_sequences</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_b</span> <span class="o">=</span> <span class="n">lstm</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_b</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>&lt;tf.Tensor: shape=(5, 25, 20), dtype=float32, numpy=
array([[[-6.91634882e-03, -4.04341053e-03,  6.21243054e-03, ...,
          7.58407870e-03, -3.25062720e-04, -1.47329073e-03],
        [-2.06746031e-02, -1.08890701e-02,  1.55969486e-02, ...,
          1.73443239e-02, -3.73853181e-05, -3.49483034e-03],
        [-2.18609478e-02, -7.35620642e-03,  8.67534988e-03, ...,
          5.99182071e-03,  2.08930578e-03, -1.74945698e-03],
        ...,
        [-1.01823017e-01, -1.00899421e-01,  9.87281185e-03, ...,
         -5.48081733e-02, -2.31647189e-03, -1.25635583e-02],
        [-1.03763044e-01, -1.04729980e-01,  1.02752009e-02, ...,
         -5.55874892e-02, -2.92765023e-03, -1.28240734e-02],
        [-9.86392871e-02, -9.67352986e-02,  1.54064583e-05, ...,
         -7.25554973e-02, -2.79210624e-03, -1.11444229e-02]],

       [[-9.59449541e-03, -5.72652696e-03,  8.59007984e-03, ...,
          1.03698019e-02, -4.58031893e-04, -2.06191349e-03],
        [-3.38549390e-02, -2.00388301e-02,  2.63345391e-02, ...,
          2.82616075e-02, -3.84227140e-04, -6.21371856e-03],
        [-5.02647795e-02, -2.38164701e-02,  2.88210493e-02, ...,
          2.65311822e-02,  2.50042020e-03, -6.62869588e-03],
        ...,
        [-8.76383483e-02, -8.58218521e-02,  7.06382561e-03, ...,
         -4.82912883e-02, -2.40367511e-03, -1.11308573e-02],
        [-7.91377723e-02, -7.59990737e-02, -5.55552309e-03, ...,
         -6.73908815e-02, -1.79042050e-03, -8.22893437e-03],
        [-7.71381855e-02, -8.24860632e-02, -1.70605350e-03, ...,
         -5.83744757e-02, -3.10560898e-03, -8.61989893e-03]],
    
       [[-1.59474593e-02, -1.00039979e-02,  1.41566917e-02, ...,
          1.66321900e-02, -7.90547871e-04, -3.50086601e-03],
        [-2.86680162e-02, -1.36203067e-02,  1.85103342e-02, ...,
          1.93397626e-02,  7.45981932e-04, -4.10943758e-03],
        [-5.10837361e-02, -2.68819015e-02,  3.21634226e-02, ...,
          2.94159763e-02,  2.26915744e-03, -7.22551439e-03],
        ...,
        [-9.33784992e-02, -9.36683193e-02, -5.56931132e-03, ...,
         -7.95175880e-02, -3.51546751e-03, -1.07136853e-02],
        [-9.80285853e-02, -1.11742929e-01,  6.97054481e-03, ...,
         -5.60363494e-02, -5.85044315e-03, -1.25691984e-02],
        [-9.78036374e-02, -1.05837978e-01,  2.17540981e-03, ...,
         -6.69823959e-02, -5.77096501e-03, -1.26095992e-02]],
    
       [[-1.49003845e-02, -9.27021448e-03,  1.32469060e-02, ...,
          1.56339500e-02, -7.34022469e-04, -3.25945904e-03],
        [-2.63381843e-02, -1.22847129e-02,  1.68679692e-02, ...,
          1.76599640e-02,  7.30803469e-04, -3.71031626e-03],
        [-3.52938809e-02, -1.46696828e-02,  1.78440604e-02, ...,
          1.46052158e-02,  2.63590855e-03, -3.73368850e-03],
        ...,
        [-9.38644484e-02, -9.44664404e-02,  1.70192551e-02, ...,
         -3.60308774e-02, -1.24518608e-03, -1.27476202e-02],
        [-8.81559402e-02, -8.07080567e-02,  8.66725110e-04, ...,
         -6.22238182e-02, -4.83962009e-04, -1.00275036e-02],
        [-9.01275948e-02, -9.16617513e-02,  7.35164806e-03, ...,
         -5.00768647e-02, -1.86052639e-03, -1.05984611e-02]],
    
       [[-1.76479835e-02, -1.12210223e-02,  1.56273004e-02, ...,
          1.82245020e-02, -8.83857021e-04, -3.89660243e-03],
        [-3.00902762e-02, -1.41149592e-02,  1.89057179e-02, ...,
          1.95368137e-02,  8.82956549e-04, -4.23357589e-03],
        [-3.55992392e-02, -1.36518329e-02,  1.55022042e-02, ...,
          1.08106369e-02,  3.16457124e-03, -3.26062646e-03],
        ...,
        [-9.09940302e-02, -8.53373185e-02,  9.03800875e-03, ...,
         -4.54341955e-02, -2.20963778e-03, -1.12294136e-02],
        [-8.23520198e-02, -7.55181760e-02, -4.28883731e-03, ...,
         -6.62041605e-02, -1.39420782e-03, -8.22980050e-03],
        [-7.89705813e-02, -8.10285807e-02, -2.02405010e-03, ...,
         -6.00483268e-02, -2.49556405e-03, -8.32242612e-03]]],
      dtype=float32)&gt;</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_b</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 25, 20])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>결과 해석</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ol>
<li><code>output_b</code>의 shape이 <code>(32, 25, 20)</code>으로 출력됌을 확인할 수 있습니다.</li>
<li>shape가 (32, 25, 20)의 32는 <code>batch</code>의 갯수, (25, 20)은 LSTM에서 지정한 unit 수입니다.</li>
</ol>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="2.-LSTM-layer의-결과-값을-Dense로-넘겨줄-경우">2. LSTM layer의 결과 값을 Dense로 넘겨줄 경우</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>아래와 같이 <code>output_a</code>는 return_sequence=False 에 대한 결과 값이며,</p>
<p><code>output_b</code>는 return_sequences=True 에 대한 결과 값입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_a</span><span class="o">.</span><span class="n">shape</span><span class="p">,</span> <span class="n">output_b</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(TensorShape([32, 20]), TensorShape([32, 25, 20]))</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>shape가 다름</strong>을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="2-1.-return_sequence=False-를-Dense에-넘겨줄-경우">2-1. return_sequence=False 를 Dense에 넘겨줄 경우</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_a</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 20])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dense</span> <span class="o">=</span> <span class="n">Dense</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dense</span><span class="p">(</span><span class="n">output_a</span><span class="p">)</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 10])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>위의 결과에서도 나타나듯이, LSTM으로부터 <strong>넘겨 받은 20개의 unit</strong>이 <strong>Dense를 거쳐 10</strong>개로 변환됩니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="2-2.-return_sequence=True-를-Dense에-넘겨줄-경우">2-2. return_sequence=True 를 Dense에 넘겨줄 경우</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_b</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 25, 20])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dense</span> <span class="o">=</span> <span class="n">Dense</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dense</span><span class="p">(</span><span class="n">output_b</span><span class="p">)</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 25, 10])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>이번에도 마찬가지로, LSTM으로부터 <strong>넘겨 받은 20개의 unit</strong>이 <strong>Dense를 거쳐 10</strong>개로 변환됩니다.</p>
<p>단, shape는 이전 케이스와는 다르게 모든 sequence에 대한 유닛 20개를 10개로 변환된 것을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="2-3.-TimeDistributed-layer-활용">2-3. TimeDistributed layer 활용</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>TimeDistributed layer는 <code>return_sequences=True</code> 인 경우, sequence로 받은 데이터에 대하여 처리할 수 있지만, 사실상 Dense를 써주면 동작은 동일하게 나타납니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>유의해야할 점은, <code>return_sequences=False</code>로 받은 값은 <strong>2차원이기 때문에 TimeDistributed에 넘겨줄 수 없습니다.</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>Dense를 사용한 경우</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dense</span> <span class="o">=</span> <span class="n">Dense</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">dense</span><span class="p">(</span><span class="n">output_b</span><span class="p">)</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 25, 10])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>TimeDistributed를 사용한 경우</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">time</span> <span class="o">=</span> <span class="n">TimeDistributed</span><span class="p">(</span><span class="n">Dense</span><span class="p">(</span><span class="mi">10</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">time</span><span class="p">(</span><span class="n">output_b</span><span class="p">)</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 25, 10])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="3.-cell-state와-hidden-layer">3. cell state와 hidden layer</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>LSTM layer에서 결과 값에 대한 <strong>hidden layer 값</strong>과, <strong>cell state</strong>를 받아볼 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">lstm</span> <span class="o">=</span> <span class="n">LSTM</span><span class="p">(</span><span class="mi">20</span><span class="p">,</span> <span class="n">return_sequences</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> <span class="n">return_state</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_c</span><span class="p">,</span> <span class="n">_hidden</span><span class="p">,</span> <span class="n">_state</span> <span class="o">=</span> <span class="n">lstm</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">output_c</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 25, 20])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">_hidden</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 20])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">_state</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>TensorShape([32, 20])</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>