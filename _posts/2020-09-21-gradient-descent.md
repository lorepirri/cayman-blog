---
layout: page
title: "경사하강법 (Gradient Descent) 직접 구현하기"
description: "경사하강법 (Stocastic Gradient Descent) 직접 구현하는 방법에 대해 알아보겠습니다."
headline: "경사하강법 (Stocastic Gradient Descent) 직접 구현하는 방법에 대해 알아보겠습니다."
categories: scikit-learn
tags: [python, tensorflow, scikit-learn, 경사하강법, gradient descent, 선형회귀, linear regression,텐서플로우, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2020-09-21
---



이번에는 머신러닝 뿐만아니라, 인공신경망 모델의 가장 기초가 되는 **경사하강법 (Gradient Descent)**에 대하여 알아보도록 하겠습니다. 경사하강법을 **Python으로 직접 구현해보는 튜토리얼** 입니다. 자세한 설명은 유튜브 영상을 참고해 보셔도 좋습니다.



## 코드

![Colab으로 열기](../images/2020-09-21/colab_logo_32px.png) [Colab으로 열기](https://colab.research.google.com/github/teddylee777/machine-learning/blob/master/10-scikit-learn/02-%EA%B2%BD%EC%82%AC%ED%95%98%EA%B0%95%EB%B2%95(Gradient_Descent).ipynb)

![GitHub](../images/2020-09-21/GitHub-Mark-32px.png) [GitHub에서 소스보기](https://github.com/teddylee777/machine-learning/blob/master/10-scikit-learn/02-%EA%B2%BD%EC%82%AC%ED%95%98%EA%B0%95%EB%B2%95(Gradient_Descent).ipynb)



<body>

<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h1 id="경사하강법-(Gradient-Descent)">경사하강법 (Gradient Descent)</h1>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>기본 개념은 함수의 기울기(경사)를 구하여 기울기가 낮은 쪽으로 계속 이동시켜서 극값에 이를 때까지 반복시키는 것 입니다.</p>
<p>비용 함수 (Cost Function 혹은 Loss Function)를 최소화하기 위해 반복해서 파라미터를 업데이트 해 나가는 방식입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">


<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">IPython.display</span> <span class="k">import</span> <span class="n">YouTubeVideo</span><span class="p">,</span> <span class="n">Image</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">matplotlib.pyplot</span> <span class="k">as</span> <span class="nn">plt</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">Image</span><span class="p">(</span><span class="n">url</span><span class="o">=</span><span class="s1">'https://img.pngio.com/scikit-learn-batch-gradient-descent-versus-stochastic-gradient-descent-png-592_319.png'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>

<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<img src="https://img.pngio.com/scikit-learn-batch-gradient-descent-versus-stochastic-gradient-descent-png-592_319.png"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="경사-하강법을-수학으로-쉽게-이해하기">경사 하강법을 수학으로 쉽게 이해하기</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">YouTubeVideo</span><span class="p">(</span><span class="s1">'GEdLNvPIbiM'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<iframe allowfullscreen="" frameborder="0" height="300" src="https://www.youtube.com/embed/GEdLNvPIbiM" width="400"></iframe>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="경사-하강법을-활용한-파이썬-코드-구현">경사 하강법을 활용한 파이썬 코드 구현</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">YouTubeVideo</span><span class="p">(</span><span class="s1">'KgH3ZWmMxLE'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_html rendered_html output_subarea output_execute_result">
<iframe allowfullscreen="" frameborder="0" height="300" src="https://www.youtube.com/embed/KgH3ZWmMxLE" width="400"></iframe>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="샘플에-활용할-데이터-셋-만들기">샘플에 활용할 데이터 셋 만들기</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">make_linear</span><span class="p">(</span><span class="n">w</span><span class="o">=</span><span class="mf">0.5</span><span class="p">,</span> <span class="n">b</span><span class="o">=</span><span class="mf">0.8</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="mi">50</span><span class="p">,</span> <span class="n">noise</span><span class="o">=</span><span class="mf">1.0</span><span class="p">):</span>
    <span class="n">x</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">rand</span><span class="p">(</span><span class="n">size</span><span class="p">)</span>
    <span class="n">y</span> <span class="o">=</span> <span class="n">w</span> <span class="o">*</span> <span class="n">x</span> <span class="o">+</span> <span class="n">b</span>
    <span class="n">noise</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="o">-</span><span class="nb">abs</span><span class="p">(</span><span class="n">noise</span><span class="p">),</span> <span class="nb">abs</span><span class="p">(</span><span class="n">noise</span><span class="p">),</span> <span class="n">size</span><span class="o">=</span><span class="n">y</span><span class="o">.</span><span class="n">shape</span><span class="p">)</span>
    <span class="n">yy</span> <span class="o">=</span> <span class="n">y</span> <span class="o">+</span> <span class="n">noise</span>
    <span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>
    <span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s1">'r'</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="n">f</span><span class="s1">'y = </span><span class="si">{w}</span><span class="s1">*x + </span><span class="si">{b}</span><span class="s1">'</span><span class="p">)</span>
    <span class="n">plt</span><span class="o">.</span><span class="n">scatter</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="n">yy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s1">'data'</span><span class="p">)</span>
    <span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">(</span><span class="n">fontsize</span><span class="o">=</span><span class="mi">20</span><span class="p">)</span>
    <span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'w: </span><span class="si">{w}</span><span class="s1">, b: </span><span class="si">{b}</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">x</span><span class="p">,</span> <span class="n">yy</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x</span><span class="p">,</span> <span class="n">y</span> <span class="o">=</span> <span class="n">make_linear</span><span class="p">(</span><span class="n">w</span><span class="o">=</span><span class="mf">0.3</span><span class="p">,</span> <span class="n">b</span><span class="o">=</span><span class="mf">0.5</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="mi">100</span><span class="p">,</span> <span class="n">noise</span><span class="o">=</span><span class="mf">0.01</span><span class="p">)</span>
<span class="c1"># 임의로 2개의 outlier를 추가해 보도록 하겠습니다.</span>
<span class="n">y</span><span class="p">[</span><span class="mi">5</span><span class="p">]</span> <span class="o">=</span> <span class="mf">0.75</span>
<span class="n">y</span><span class="p">[</span><span class="mi">10</span><span class="p">]</span> <span class="o">=</span> <span class="mf">0.75</span>

<span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>
<span class="n">plt</span><span class="o">.</span><span class="n">scatter</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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jz9eI0eO1LJly/Tuu+/GnF+5cqXefvttjR8/Xp///OfTMMKgffv2aeXKlerevbtOO+20mPNjx46VFJwGbI1//etfevXVV9W1a1cNGTKk6Xj37t113XXX6ZVXXtGrr76qHTt26PDDD9fq1as1evShDQgmTJigK6+8Uq+++qquu+66puN79uzRhRdeqH379umPf/yjPvvZz7ZqnK0V+nMaM2ZMzLkRI0aoe/fuWrlypfbt2+f7nrW1tXrwwQd1++2367777tOqVavabLwAEC3ZJwXLigMqnzBUgcICmXOqmjVOM/4yp+n80VOf1sl//kRTF7ypmto6OR1aHJ/uoOXn6cLsc/XV0htvpHsUzTv5ZOnuu1t1ix/96EdatmyZ5syZozvuuCPi3Jw5wX8Bf/jDH/q6V0VFhd5I4s+ssLBQV199dcLrNm/erIaGBh111FHq3Dn2X7djjz1WkjyDYnMqKyu1ePFiHThwQNXV1Vq0aJF2796te++9V3379m26bs+ePbr77rt1zz33aNiwYVq5cqU+/vhjfelLX9LMmTN19tmH/k/ozjvv1MqVK3XHHXdo1KhRGjNmjK688kpt2LBBN9xwQ7NVw/ayaVNwoedxxx0Xc65z584aPHiw1q9fry1btuiEE07wdc8333xTl112WcSx//iP/9AjjzyioUOHtn7QANAoqScFw5QVB1S2ZZU0aVLTsQe/MkG3nP49SVJtXX3Me0KL45u7b6p1zJCVI8rKytS/f3/NnTtXv/zlL9W1a1dJwcrE448/rqOPPlpf+9rXfN2roqJCDz/8sO/vPWjQIF8ha9euXZKkXr16eZ4PHa+trfX9vaVgyLr55pubXvfo0UMPPfSQLr744qZjBw8eVElJiYqKivS3v/1NNTU1WrdunZYtW6Z58+bpe9/7nqZMmdI0Zdi1a1fNnz9fp5xyir7zne/oZz/7mebOnasRI0bohhtuSGp8qdLWf54/+clPNHHiRB133HHq1q2b3nnnHc2aNUsLFizQqFGj9MYbbygQSN9fUAA6luaeFGw2DEVt3XXmzYv1/p7E3y/eovn20jFDVisrRNmic+fO+v73v69bbrlFTz75pL75zW9Kkh555BHV1dXp8ssv972n3Ny5czV37twUjtZbcM1g8nvfXXHFFbriiiu0d+9effDBB/rd736n73znO1qxYoV+97vfSQquyXr++eebni6sqTlUNp48ebLGjRsXM6127LHH6oEHHtC3vvUtTZ06VX379tWf/vQn5eVFrgdozvLlyzVy5Mi4571+r8uWLdMZZ5zh+3vEk+yf55133hnxuqSkRE888YQmTZqkJ598UnfccYd+9atftXpcACD5eFIw2rx50kUXHXp9zDHSe+9py/RnfX2//oUFyQ6xTXXMkJVDLr/8ct1+++164IEHmkLWnDlz1KVLF333u99N8+gOVVZCFZhou3fvjrguWd26ddMJJ5yge+65R/v27dMDDzygr33ta5rUWFKO175Bkj7zmc/oM5/5TMzxs846Sz179tTu3bt1/vnnJ13JKSoq0o033hhzfO7cuaqtrfWsAPrt35XqP8+QK664Qk8++aRefvnlVt0HAML1LyxQjUeg6l9YoIq1NZq9ZJO21dapf2GBVsw4M/KiLVukwYObvU+4gvw8TR09pNlrUo2QleUCgYC+/vWv66mnntLGjRu1c+dOvf3227rwwguVzBZFqVqTdcwxxygvL09btmzRgQMHYtZlvffee5K81xgla+zYsXrggQe0fPnyppAV7owzzlBVVVWz93DO6Tvf+Y52796tvn37as6cOZo8ebJGjBjhexxFRUW66aabYo4vX75cVVVVnuf8GjJkiCorK/Xuu+/q1FNPjTh34MABffDBB+rcubOOOuqoFn8PSU3/7nz66aetug8AhJs6ekjEmiwpGIZGHt+v6fgp1Ru1cNbUyDc6l/A++Z1Mn+nWWbV76tW/sEBTRw9J63osiZDVIfzoRz/SU089pTlz5mjnzp2S/C94D0nVmqyuXbtq+PDheuWVV/TKK6/ETKM9//zzktQmi8pD04FeC+z9mj17tl544QV961vf0rRp0zRs2DB985vf1BtvvBGxoD5dRo0apUcffVQvvPCCLgovoSvYDX/Pnj0aMWJE0/q8lgo9YdjasAYA4UKhJ7xiNXX0kKa1WlWzxkVcf/kVv9ac+6/yfZ90h6oY8RpopeuLZqTJO3jwoDvuuONc7969XUFBgTvuuOPSPaQIfpqR7tq1K+I927Ztcxs3bnS1tbURx5cvX+4aGhpivsfmzZtd//79nST35z//uUXjXLVqlcvPz3fHHHNMU3PU+++/30ly5557rjvYyiZ3bdWMtG/fvkk1I/3000/dxo0b3YcffhhxfM2aNe7f//53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
"/>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>w: 0.3, b: 0.5
</pre>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="초기값-(Initializer)과-y_hat-(예측,-prediction)-함수-정의">초기값 (Initializer)과 y_hat (예측, prediction) 함수 정의</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>w, b 값에 대하여 random한 초기 값을 설정해 줍니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">w</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">b</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>y_hat</code>은 <code>prediction</code>은 값 입니다. 즉, 가설함수에서 실제 값 (y)를 뺀 함수를 정의합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">y_hat</span> <span class="o">=</span> <span class="n">w</span> <span class="o">*</span> <span class="n">x</span> <span class="o">+</span> <span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="오차(Error)-정의">오차(Error) 정의</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>Loss Function 혹은 Cost Function을 정의 합니다.</p>
<p>Loss (Cost) Function은 예측값인 <code>y_hat</code>과 <code>y</code>의 차이에 <strong>제곱</strong>으로 정의합니다.</p>
<p>제곱은 오차에 대한 음수 값을 허용하지 않으며, 이는 <strong>Mean Squared Error(MSE)</strong>인 평균 제곱 오차 평가 지표와 관련 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">error</span> <span class="o">=</span> <span class="p">(</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span> <span class="o">**</span> <span class="mi">2</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="학습률-(Learning-Rate)">학습률 (Learning Rate)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">Image</span><span class="p">(</span><span class="n">url</span><span class="o">=</span><span class="s1">'https://www.deeplearningwizard.com/deep_learning/boosting_models_pytorch/images/lr1.png'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>

<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="output_html rendered_html output_subarea output_execute_result">
<img src="https://www.deeplearningwizard.com/deep_learning/boosting_models_pytorch/images/lr1.png"/>
</div>

</div>
</div>
</div>
</div>

<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>한 번 학습할 때 <strong>얼마만큼 가중치(weight)를 업데이트</strong> 해야 하는지 학습 양을 의미합니다.</p>
<p>너무 큰 학습률 (Learning Rate)은 가중치 갱신이 크게 되어 <strong>자칫 Error가 수렴하지 못하고 발산</strong>할 수 있으며,</p>
<p>너무 작은 학습률은 가중치 갱신이 작게 되어 <strong>가중치 갱신이 충분히 되지 않고, 학습이 끝나</strong> 버릴 수 있습니다. 즉 과소 적합되어 있는 상태로 남아 있을 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Gradient-Descent-구현-(단항식)">Gradient Descent 구현 (단항식)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 최대 반복 횟수</span>
<span class="n">num_epoch</span> <span class="o">=</span> <span class="mi">5000</span>

<span class="c1"># 학습율 (learning_rate)</span>
<span class="n">learning_rate</span> <span class="o">=</span> <span class="mf">0.5</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">errors</span> <span class="o">=</span> <span class="p">[]</span>
<span class="c1"># random 한 값으로 w, b를 초기화 합니다.</span>
<span class="n">w</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">b</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>

<span class="k">for</span> <span class="n">epoch</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">num_epoch</span><span class="p">):</span>
    <span class="n">y_hat</span> <span class="o">=</span> <span class="n">x</span> <span class="o">*</span> <span class="n">w</span> <span class="o">+</span> <span class="n">b</span>

    <span class="n">error</span> <span class="o">=</span> <span class="p">((</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span><span class="o">**</span><span class="mi">2</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    <span class="k">if</span> <span class="n">error</span> <span class="o">&lt;</span> <span class="mf">0.0005</span><span class="p">:</span>
        <span class="k">break</span>
    
    <span class="n">w</span> <span class="o">=</span> <span class="n">w</span> <span class="o">-</span> <span class="n">learning_rate</span> <span class="o">*</span> <span class="p">((</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span> <span class="o">*</span> <span class="n">x</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    <span class="n">b</span> <span class="o">=</span> <span class="n">b</span> <span class="o">-</span> <span class="n">learning_rate</span> <span class="o">*</span> <span class="p">(</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    
    <span class="n">errors</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">error</span><span class="p">)</span>
    
    <span class="k">if</span> <span class="n">epoch</span> <span class="o">%</span> <span class="mi">5</span> <span class="o">==</span> <span class="mi">0</span><span class="p">:</span>
        <span class="nb">print</span><span class="p">(</span><span class="s2">"</span><span class="si">{0:2}</span><span class="s2"> w = </span><span class="si">{1:.5f}</span><span class="s2">, b = </span><span class="si">{2:.5f}</span><span class="s2"> error = </span><span class="si">{3:.5f}</span><span class="s2">"</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">epoch</span><span class="p">,</span> <span class="n">w</span><span class="p">,</span> <span class="n">b</span><span class="p">,</span> <span class="n">error</span><span class="p">))</span>

<span class="nb">print</span><span class="p">(</span><span class="s2">"----"</span> <span class="o">*</span> <span class="mi">15</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="s2">"</span><span class="si">{0:2}</span><span class="s2"> w = </span><span class="si">{1:.1f}</span><span class="s2">, b = </span><span class="si">{2:.1f}</span><span class="s2"> error = </span><span class="si">{3:.5f}</span><span class="s2">"</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">epoch</span><span class="p">,</span> <span class="n">w</span><span class="p">,</span> <span class="n">b</span><span class="p">,</span> <span class="n">error</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre> 0 w = -0.46180, b = 0.36141 error = 2.62472
 5 w = -0.14031, b = 0.74770 error = 0.01775
10 w = -0.07254, b = 0.71248 error = 0.01277
15 w = -0.01624, b = 0.68073 error = 0.00925
20 w = 0.03144, b = 0.65382 error = 0.00672
25 w = 0.07182, b = 0.63103 error = 0.00491
30 w = 0.10601, b = 0.61173 error = 0.00361
35 w = 0.13497, b = 0.59539 error = 0.00268
40 w = 0.15950, b = 0.58155 error = 0.00201
45 w = 0.18027, b = 0.56982 error = 0.00153
50 w = 0.19786, b = 0.55990 error = 0.00119
55 w = 0.21276, b = 0.55149 error = 0.00094
60 w = 0.22538, b = 0.54437 error = 0.00076
65 w = 0.23607, b = 0.53834 error = 0.00064
70 w = 0.24512, b = 0.53323 error = 0.00054
------------------------------------------------------------
74 w = 0.2, b = 0.5 error = 0.00049
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>시각화</strong></p>
<p>학습 진행(epoch)에 따른 오차를 시각화 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">errors</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">xlabel</span><span class="p">(</span><span class="s1">'Epochs'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s1">'Error'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAmEAAAGpCAYAAADFpuEPAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAADh0RVh0U29mdHdhcmUAbWF0cGxvdGxpYiB2ZXJzaW9uMy4xLjIsIGh0dHA6Ly9tYXRwbG90bGliLm9yZy8li6FKAAAgAElEQVR4nO3dfZClV30f+O/vvrSEkQYMGqNXECQKYVwxYCYEh1TCkk1KOC7IlvFaVJw4bLaUODiGKrJe4z/sjStJ5aXKThxcdikGY7JeY4INkbeIHdYhwc4LYSQLG0kmEQSHCRIaxKKRAGmmu0/+uLen7/TcvnN7+nnmzkx/PlVd/dzn7Z4+mh5955zfPU+11gIAwMU1WHUDAAAOIiEMAGAFhDAAgBUQwgAAVkAIAwBYgdGqG7BX1113Xbv11ltX3QwAgPO65557vtRaOzzv2GUXwm699dYcO3Zs1c0AADivqvr93Y6ZjgQAWAEhDABgBYQwAIAVEMIAAFZACAMAWAEhDABgBYQwAIAVEMIAAFZACAMAWAEhDABgBYQwAIAVEMIAAFZACAMAWAEhDABgBYSwHZ46vZHfe+RkTj51etVNAQCuYELYDg89+mRu/0e/mf/wmcdW3RQA4AomhO2wNpp0yemNzRW3BAC4kglhO4yHky5Z32grbgkAcCUTwnYYDytJcspIGADQIyFsh7Wh6UgAoH9C2A5b05Gn14UwAKA/QtgO4zOF+WrCAID+CGE7qAkDAC4GIWyH8UBNGADQPyFsh8GgMhqUEAYA9EoIm2M0LDVhAECvhLA5xsNBTvl0JADQIyFsjrXhwHQkANArIWyOsRAGAPSstxBWVbdU1Uer6sGqur+q3jrnnNdU1eNVdd/060f6as9ejEfl2ZEAQK9GPd57PcnbW2v3VtW1Se6pqo+01h7Ycd5vtta+o8d27Nl4OLBOGADQq95GwlprD7fW7p1uP5HkwSQ39fV+XVITBgD07aLUhFXVrUlenuTjcw5/W1V9sqr+ZVV98y7X31lVx6rq2IkTJ3ps6cSkJsx0JADQn95DWFVdk+SXk7yttXZyx+F7k7ygtfbSJP8kyYfm3aO1dldr7Whr7ejhw4f7bXAmjy4yEgYA9KnXEFZV40wC2C+01n5l5/HW2snW2pPT7Q8nGVfVdX22aRnWCQMA+tbnpyMrybuSPNha+/Fdzrl+el6q6pXT9jzWV5uWtTZSEwYA9KvPT0e+OslfTPK7VXXfdN8PJ3l+krTWfibJG5N8X1WtJ/l6kjtaaysvxlITBgD0rbcQ1lr7rSR1nnPemeSdfbXhQnmANwDQNyvmzzEeWScMAOiXEDaHdcIAgL4JYXOMh5XT62rCAID+CGFzjIeDrG8aCQMA+iOEzWGdMACgb0LYHJN1wkxHAgD9EcLm8NgiAKBvQtgck5qwls1No2EAQD+EsDnGw0m3nFacDwD0RAibY20rhKkLAwB6IoTNMR5OnrZ02ickAYCeCGFzjM6MhAlhAEA/hLA5tqYjPT8SAOiLEDbHeDSdjlQTBgD0RAibY2w6EgDomRA2hxAGAPRNCJvDEhUAQN+EsDmMhAEAfRPC5rBOGADQNyFsjvHIEhUAQL+EsDnUhAEAfRPC5lATBgD0TQib40xNmBAGAPRECJtjayTslMJ8AKAnQtgcYzVhAEDPhLA5TEcCAH0TwubYWqJCCAMA+iKEzWGJCgCgb0LYHJaoAAD6JoTNMRxUBiWEAQD9EcJ2MR4OPLYIAOiNELaLteEgp9fVhAEA/RDCdjEeDUxHAgC9EcJ2MR6WEAYA9EYI28VooCYMAOiPELaLtdHAOmEAQG+EsF2Mh5XTHuANAPRECNvFeKgwHwDojxC2C+uEAQB9EsJ2sTYcZF1NGADQEyFsF+ORJSoAgP4IYbtQEwYA9EkI28WkJsx0JADQDyFsF2tGwgCAHglhu/DYIgCgT0LYLsbDgcVaAYDeCGG7GKkJAwB6JITtYs10JADQIyFsF5aoAAD6JITtYjwSwgCA/ghhu5iMhLW0pi4MAOieELaLtWElSdY3hTAAoHtC2C7Gw0nXmJIEAPoghO3iTAhbNxIGAHRPCNvFeDTpmlNGwgCAHghhu9iqCTMdCQD0QQjbhZowAKBPvYWwqrqlqj5aVQ9W1f1V9dY551RV/WRVPVRVv1NV39pXe/ZKCAMA+jTq8d7rSd7eWru3qq5Nck9VfaS19sDMOa9Lctv0648l+enp95UbT6cjTynMBwB60NtIWGvt4dbavdPtJ5I8mOSmHae9Icl728R/TPLsqrqhrzbthZEwAKBPF6UmrKpuTfLyJB/fceimJJ+feX085wa1VNWdVXWsqo6dOHGir2aeRQgDAPrUewirqmuS/HKSt7XWTu48POeSc+b/Wmt3tdaOttaOHj58uI9mnmMrhFmiAgDoQ68hrKrGmQSwX2it/cqcU44nuWXm9c1JvtBnm5a1Npo+tmhDTRgA0L0+Px1ZSd6V5MHW2o/vctrdSf7S9FOSr0ryeGvt4b7atBemIwGAPvX56chXJ/mLSX63qu6b7vvhJM9PktbazyT5cJJvT/JQkq8leXOP7dkTIQwA6FNvIay19luZX/M1e05L8pa+2rAf2zVhpiMBgO5ZMX8Xa2ce4G0kDADonhC2i/HIsyMBgP4IYbtQEwYA9EkI28V4oCYMAOiPELYL05EAQJ+EsF2MFeYDAD0SwnYxGhgJAwD6I4TtoqqyNhyoCQMAeiGELTAeVtaNhAEAPRDCFhiPBqYjAYBeCGELjE1HAgA9EcIWWBsaCQMA+iGELTAelhAGAPRCCFtgbCQMAOiJELbAeDjIqXU1YQBA94SwBUxHAgB9EcIWMB0JAPRFCFtACAMA+iKELTAeWScMAOiHELbA2rByet1IGADQPSFsgfFwkPVNIQwA6J4QtsCkJsx0JADQPSFsgck6YUbCAIDuCWELrI2sEwYA9EMIW8ASFQBAX4SwBdSEAQB9EcIWGA8HOWUkDADogRC2wNazI1szGgYAdEsIW2A8HKS1ZGNTCAMAuiWELTAeTrpHXRgA0DUhbIHxsJJEXRgA0DkhbIG10dZImBAGAHRLCFtgazpy3XQkANAxIWyB7ZowI2EAQLeEsAXUhAEAfRHCFlgzEgYA9EQIW+DMdOS6mjAAoFtC2ALj6acjTUcCAF0TwhbYqgkzHQkAdE0IW8CnIwGAvghhCwhhAEBfhLAFzixRoTAfAOiYELaAJSoAgL4IYQuYjgQA+iKELbC1RIVnRwIAXRPCFvDYIgCgL0LYAmrCAIC+CGELqAkDAPoihC2wHcLUhAEA3RLCFtheJ8xIGADQLSFsgarKaFCmIwGAzglh5zEeDoQwAKBzQth5jIelJgwA6JwQdh5ro4F1wgCAzglh5zEeDnJaYT4A0DEh7DzUhAEAfRDCzmM8rJzeVBMGAHSrtxBWVe+uqker6lO7HH9NVT1eVfdNv36kr7bsh+lIAKAPox7v/Z4k70zy3gXn/GZr7Tt6bMO+rY1MRwIA3ettJKy19rEkX+7r/hfLpCbMdCQA0K1V14R9W1V9sqr+ZVV9824nVdWdVXWsqo6dOHHiYrYv42FZogIA6NwqQ9i9SV7QWntpkn+S5EO7ndhau6u1drS1dvTw4cMXrYGJT0cCAP1YWQhrrZ1srT053f5wknFVXbeq9uxGCAMA+rCyEFZV11dVTbdfOW3LY6tqz27Gw8rpdTVhAEC3evt0ZFX9YpLXJLmuqo4n+dEk4yRprf1Mkjcm+b6qWk/y9SR3tNYuubRjJAwA6ENvIay19qbzHH9nJktYXNLWhp4dCQB0b9WfjrzkGQkDAPoghJ3HeFTWCQMAOieEnYeRMACgD0LYeawJYQBAD4Sw8/DYIgCgD0LYeYyHg2xstmxsCmIAQHeEsPMYjypJTEkCAJ0Sws5jbTjpIiEMAOiSEHYeo8HWSJjpSACgO+cNYVU1rKp/eDEacykaj4yEAQDdO28Ia61tJHnF1sO2D5rxdDry1LoQBgB0Z9lnR/52kn9RVf88yVe3drbWfqWXVl1C1IQBAH1YNoQ9J8ljSV47s68lueJD2PhMCFMTBgB0Z6kQ1lp7c98NuVSNh5aoAAC6t9SnI6vq5qr6YFU9WlVfrKpfrqqb+27cpUBhPgDQh2WXqPi5JHcnuTHJTUl+dbrvirdmOhIA6MGyIexwa+3nWmvr06/3JDncY7suGWOF+QBAD5YNYV+qqu+Zrhk2rKrvyaRQ/4q3VRN2SggDADq0bAj735L8r0keSfJwkjdO913xzoyEWScMAOjQeT8dWVXDJN/ZWnv9RWjPJWdtpCYMAOjesivmv+EitOWStP3sSCNhAEB3ll2s9d9V1TuT/FLOXjH/3l5adQk589giIQwA6NCyIeyPT7//2My+lrNX0L8irVknDADowTI1YYMkP91ae/9FaM8lR2E+ANCHZWrCNpN8/0VoyyVp+7FFCvMBgO4su0TFR6rqb1bVLVX1nK2vXlt2iTgzErZpJAwA6M6yNWFba4K9ZWZfS/Kibptz6dmejjQSBgB0Z6kQ1lp7Yd8NuVQNB5XhoBTmAwCdWjgdWVU/OLP9XTuO/d2+GnWpGQ+FMACgW+erCbtjZvsdO47d3nFbLlnj4cA6YQBAp84XwmqX7Xmvr1hrw4GRMACgU+cLYW2X7Xmvr1ijYSnMBwA6db7C/JdW1clMRr2eMd3O9PXVvbbsEjI2EgYAdGxhCGutDS9WQy5la2rCAICOLbtY64FmJAwA6JoQtoTxqDy2CADolBC2BCNhAEDXhLAlCGEAQNeEsCVM1gkzHQkAdEcIW4LHFgEAXRPCljAeDnJqXQgDALojhC1hPFITBgB0SwhbgpowAKBrQtgSRgM1YQBAt4SwJZiOBAC6JoQtYU1hPgDQMSFsCZMlKtSEAQDdEcKWYMV8AKBrQtgSxsNB1jdbWjMaBgB0Qwhbwtpo0k2mJAGArghhSxgPK0lMSQIAnRHCljAebo2ECWEAQDeEsCVshbBTQhgA0BEhbAlrQzVhAEC3hLAljEfTmjALtgIAHRHCljAaqAkDALolhC1BTRgA0LXeQlhVvbuqHq2qT+1yvKrqJ6vqoar6nar61r7asl9rW9ORasIAgI70ORL2niS3Lzj+uiS3Tb/uTPLTPbZlXyxRAQB0rbcQ1lr7WJIvLzjlDUne2yb+Y5JnV9UNfbVnP86EMIX5AEBHVlkTdlOSz8+8Pj7dd46qurOqjlXVsRMnTlyUxs1SEwYAdG2VIazm7JtbdNVau6u1drS1dvTw4cM9N+tcW+uErasJAwA6ssoQdjzJLTOvb07yhRW1ZaEz64QZCQMAOrLKEHZ3kr80/ZTkq5I83lp7eIXt2ZXpSACga6O+blxVv5jkNUmuq6rjSX40yThJWms/k+TDSb49yUNJvpbkzX21Zb88tggA6FpvIay19qbzHG9J3tLX+3fJEhUAQNesmL+E8VBNGADQLSFsCaOtmjDrhAEAHRHClqAmDADomhC2BNORAEDXhLAlDAeVKiEMAOiOELaEqsp4OLBOGADQGSFsSWvDQU6vqwkDALohhC1pPKysbxoJAwC6IYQtaTwcqAkDADojhC1pPBzklOlIAKAjQtiS1kZGwgCA7ghhSxoPSwgDADojhC1pNDASBgB0Rwhb0ng0yCmPLQIAOiKELWltWDntAd4AQEeEsCVZogIA6JIQtiQhDADokhC2pMmzI9WEAQDdEMKWtDayRAUA0B0hbEnj4SDrQhgA0BEhbEmTmjDTkQBAN4SwJU1qwoyEAQDdEMKWtOaxRQBAh4SwJY2HA4u1AgCdEcKWNFITBgB0SAhb0tqwcmpjM60JYgDA/glhSxoPJ121vimEAQD7J4QtaTyadJXifACgC0LYkrZGwk6vGwkDAPZPCFvS2rCSxFphAEAnhLAlnRkJE8IAgA4IYUs6U5hvmQoAoANC2JK2CvNNRwIAXRDClrRVE2Y6EgDoghC2JDVhAECXhLAlCWEAQJeEsCWNtpaosE4YANABIWxJa0bCAIAOCWFLMh0JAHRJCFuSEAYAdEkIW9LaaOuxRWrCAID9E8KWtP0AbyNhAMD+CWFLMh0JAHRJCFvSmRC2aToSANg/IWxJa6YjAYAOCWFLGo88OxIA6I4QtiQ1YQBAl4SwJY0GlqgAALojhC2pqjIelpEwAKATQtgejIcDhfkAQCeEsD0YDwdGwgCATghhezAeDtSEAQCdEML2YE1NGADQESFsD8Yj05EAQDeEsD1QEwYAdEUI24NJCFMTBgDsnxC2B2rCAICu9BrCqur2qvp0VT1UVT805/hfrqoTVXXf9Ot/77M9+2U6EgDoyqivG1fVMMlPJfkzSY4n+URV3d1ae2DHqb/UWvv+vtrRpcliraYjAYD963Mk7JVJHmqtfba1dirJ+5K8ocf3691oWDllJAwA6ECfIeymJJ+feX18um+n76yq36mqD1TVLfNuVFV3VtWxqjp24sSJPtq6lDXTkQBAR/oMYTVn3865vF9Ncmtr7VuS/H9Jfn7ejVprd7XWjrbWjh4+fLjjZi5PTRgA0JU+Q9jxJLMjWzcn+cLsCa21x1prT09f/tMkr+ixPfs2WaxVTRgAsH99hrBPJLmtql5YVWtJ7khy9+wJVXXDzMvXJ3mwx/bs23hYObVuJAwA2L/ePh3ZWluvqu9P8utJhkne3Vq7v6p+LMmx1trdSX6gql6fZD3Jl5P85b7a0wU1YQBAV3oLYUnSWvtwkg/v2PcjM9vvSPKOPtvQJTVhAEBXrJi/B+PhIOtqwgCADghhezAeWScMAOiGELYHasIAgK4IYXswHg6y2ZKNTVOSAMD+CGF7MB5OustoGACwX0LYHoyHk4cAqAsDAPZLCNuDMyNhFmwFAPZJCNuD7elINWEAwP4IYXuwNR2pJgwA2C8hbA/WRpPuUhMGAOyXELYHPh0JAHRFCNuD7cJ8NWEAwP4IYXtwpiZs00gYALA/QtgerFmiAgDoiBC2B9dcPUqSfPmrp1bcEgDgcieE7cFt33RtBpU8+MgTq24KAHCZE8L24Blrw7zwumfmwYdPrropAMBlTgjboyM3PisPfEEIAwD2RwjboyM3HMp//8rX8/jXTq+6KQDAZUwI26OX3HBtkuQBU5IAwD4IYXt05MZDSaIuDADYFyFsj77p2qtz3TVXGQkDAPZFCLsAR248pDgfANgXIewCvOSGa/NfHn0ip6ycDwBcICHsAhy54VBOb7R85sSTq24KAHCZEsIuwDdPi/NNSQIAF0oIuwAvvO6aXD0eKM4HAC6YEHYBhoPKi593rZEwAOCCCWEX6MiNh/LgIyfTWlt1UwCAy5AQdoGO3HAoX/na6Tz8+FOrbgoAcBkSwi7QEcX5AMA+CGEX6MXXT0OY4nwA4AIIYRfomqtGufW532AkDAC4IELYPmwV5wMA7JUQtg9HbjiU33/sa3niqdOrbgoAcJkRwvZhqzj/9x55YsUtAQAuN0LYPrzkBp+QBAAujBC2D9cfujrf+A3jPOgTkgDAHglh+1BVOXLjIctUAAB7JoTt05EbDuX3Hnki6xubq24KAHAZEcL26SU3HMqp9c189ktfXXVTAIDLiBC2T1ufkFQXBgDshRC2T3/g8DVZGw58QhIA2BMhbJ/Gw0H+0PXXKM4HAPZECOvAS64/lAe+cDKttVU3BQC4TAhhHThy46E89tVTOfHE06tuCgBwmRDCOnBkunL+/aYkAYAlCWEdeMmNHl8EAOyNENaBQ1ePc/M3PkNxPgCwNCGsI0duOGStMABgaUJYR47ceCj/9UtfzddOra+6KQDAZUAI68jLbnl2Wkve9r778tiTPiUJACwmhHXkT/2hw3nH6/5w/s2nT+TP/sTH8uv3P7LqJgEAlzAhrCNVlb/6p/5AfvVv/Ilc/6yr81f/2T15+/s/mZNPnV510wCAS5AQ1rEXX39tPvjXX50feO0fzIfu+++5/Sc+ln/30JdW3SwA4BJTl9ujdo4ePdqOHTu26mYs5b7PfyVvf/99+cyJr+aOP3pLjt76nFx/6Opc/6yr8rxDV+faq8erbiIA0KOquqe1dnTusT5DWFXdnuQfJxkm+dnW2t/bcfyqJO9N8ookjyX57tba5xbd83IKYUny1OmN/INf+3Te8+//azZ3dPUz14Z53rOuznXXXJVnjIe5ejzIVaPt71eNBrlqPMh4OPlaGw4yGtZZ26PhIOPB5PtoWBkPts6pjAbb5w8H28dGM8dGg+n2oDIY1Go6CQCuUCsJYVU1TPKfk/yZJMeTfCLJm1prD8yc89eTfEtr7a9V1R1J/pfW2ncvuu/lFsK2PHV6I188+VQeefypPHLyqen20/niyady4smn8/TpjTy9vpmndnx/en0zGzvTW08GlYwGk8A2GkzC2nAa0IZnXtf09fb+ra+zXtf2NYOqMyFvWPP3Dafbo8Hk2NZ9JtuZs29y3WBQGVTO7J89f+u8mh4fVqW23qsyvXa6PXP+oHL2ebV9j63trfO3zp29x/bx7WurBFyAg2hRCBv1+L6vTPJQa+2z00a8L8kbkjwwc84bkvxf0+0PJHlnVVW73OZIl3D1eJgXPPeZecFzn7nnazc3W05vbub0Rsvp9c2c3tjM6c3J9vp0//rG5Jz1jZb1jc2c2piEt9MbLeubM9vTazc2NrO+2bK+2abHts/ZbNuv1zdbNjba9NzJvo2Z69Y3J/fcusfXT7ds7ji+udmy0SZt3Gzb+2aPbWxuH7vy/uvnrGBWVamcHdSyS3AbVFKZuW7m+GB6n53n1ux7DLavz5n3Pfv8yXvPXru9ncy0J9v3nX2PmnNtdpw/+3Nn9vw51097bO7x6eVnQm3tuFd2tG3rvbbPzcx9zr7n1kmz95k9b+f9d/73nX2f2XvOO5bZn+Gc95tzzpxj2eX6rTbv1pad52TB+57znrP3nOmfncfmWeae57vf2W3c/b12vsPZ91+ujXt5v4XHFr3jhR1a+I+6xdcter8L+4fi4nteoF0uvNA2LvK8Q1flRYev6fy+y+ozhN2U5PMzr48n+WO7ndNaW6+qx5M8N4lK9hmDQeWqwTBXjZJcterW9K9NQ9lGa9nczHZIO7NvO7i1ljPnTq7LmUC3eSbcZWZ7+5rZ7a3rZ89tc7a3jm+du7HZ0qZt3pzdN91uO87fPLN/ct3mTPuSmffL5Nqt+07uM3Nd227TmfffTFom+7f2zbZ7a192Xn/m3ptnX5vJ/rSZ9mzdf6bNZ+2fuTYzrzd3XJuZ82avn1423T77nrPH5r3HWcdnrs2Z83a+x/Y1Wz8HcLB8z6uen7/95//Iyt6/zxA2L7Lu/GtumXNSVXcmuTNJnv/85++/ZVzSajpl2ecfTliknRUwzw15k+3tc7avO/fYdsg79x5ZdK851+32Pju+7dqWXe+9SwDduX/nvc5+vzZz3qL7tF2PzWv/zvde1N79XLfoPu3c/y0t15aF919wzyXbtZcrL7SdC99t4X+HC7vrblf19Y+k5x1a7chGn/+fO57klpnXNyf5wi7nHK+qUZJnJfnyzhu11u5KclcyqQnrpbUAUzunAfcxsQKwqz7XCftEktuq6oVVtZbkjiR37zjn7iTfO91+Y5J/fSXWgwEA7NTbSNi0xuv7k/x6JktUvLu1dn9V/ViSY621u5O8K8k/q6qHMhkBu6Ov9gAAXEp6LbtprX04yYd37PuRme2nknxXn20AALgUeWwRAMAKCGEAACsghAEArIAQBgCwAkIYAMAKCGEAACsghAEArIAQBgCwAkIYAMAKCGEAACsghAEArIAQBgCwAtVaW3Ub9qSqTiT5/YvwVtcl+dJFeJ/LiT6ZT7+cS5/Mp1/OpU/m0y/nulz75AWttcPzDlx2IexiqapjrbWjq27HpUSfzKdfzqVP5tMv59In8+mXc12JfWI6EgBgBYQwAIAVEMJ2d9eqG3AJ0ifz6Zdz6ZP59Mu59Ml8+uVcV1yfqAkDAFgBI2EAACsghAEArIAQtkNV3V5Vn66qh6rqh1bdnlWpqndX1aNV9amZfc+pqo9U1X+Zfv/GVbbxYquqW6rqo1X1YFXdX1Vvne4/6P1ydVX9p6r65LRf/tZ0/wur6uPTfvmlqlpbdVsvtqoaVtVvV9X/O32tT6o+V1W/W1X3VdWx6b6D/jv07Kr6QFX93vTvl287yH1SVS+e/vnY+jpZVW+7EvtECJtRVcMkP5XkdUmOJHlTVR1ZbatW5j1Jbt+x74eS/EZr7bYkvzF9fZCsJ3l7a+0lSV6V5C3TPx8HvV+eTvLa1tpLk7wsye1V9aokfz/JT0z75f9P8ldW2MZVeWuSB2de65OJ/6m19rKZNZ8O+u/QP07ya621P5zkpZn8mTmwfdJa+/T0z8fLkrwiydeSfDBXYJ8IYWd7ZZKHWmufba2dSvK+JG9YcZtWorX2sSRf3rH7DUl+frr980n+/EVt1Iq11h5urd073X4ik78ob4p+aa21J6cvx9OvluS1ST4w3X/g+qWqbk7y55L87PR15YD3yQIH9neoqg4l+ZNJ3pUkrbVTrbWv5AD3yQ5/OslnWmu/nyuwT4Sws92U5PMzr49P9zHxvNbaw8kkkCT5phW3Z2Wq6tYkL0/y8eiXrWm3+5I8muQjST6T5CuttfXpKQfxd+kfJfnBJJvT18+NPkkmAf1fVdU9VXXndN9B/h16UZITSX5uOnX9s1X1zBzsPpl1R5JfnG5fcX0ihJ2t5uyzhgdnqaprkvxykre11k6uuj2XgtbaxnTq4OZMRpRfMu+0i9uq1amq70jyaGvtntndc049MH0y49WttW/NpOzjLVX1J1fdoBUbJfnWJD/dWnt5kq/mCphm68K0ZvL1Sf75qtvSFyHsbMeT3DLz+uYkX1hRWy5FX6yqG5Jk+v3RFbfnoquqcSYB7Bdaa78y3X3g+2XLdBrl32RSM/fsqhpNDx2036VXJ3l9VX0uk7KG12YyMnaQ+yRJ0lr7wvT7o5nU+bwyB/t36HiS4621j09ffyCTUHaQ+2TL65Lc21r74vT1FdcnQtjZPpHktuknmNYyGQa9e8VtupTcneR7p9vfm+RfrLAtF920puddSR5srf34zKGD3mMMivkAAAMoSURBVC+Hq+rZ0+1nJPmfM6mX+2iSN05PO1D90lp7R2vt5tbarZn8PfKvW2t/IQe4T5Kkqp5ZVddubSf5s0k+lQP8O9RaeyTJ56vqxdNdfzrJAznAfTLjTdmeikyuwD6xYv4OVfXtmfyLdZjk3a21v7PiJq1EVf1iktckuS7JF5P8aJIPJXl/kucn+W9Jvqu1trN4/4pVVX8iyW8m+d1s1/n8cCZ1YQe5X74lkyLZYSb/sHt/a+3HqupFmYwCPSfJbyf5ntba06tr6WpU1WuS/M3W2ncc9D6Z/vwfnL4cJfl/Wmt/p6qem4P9O/SyTD7AsZbks0nenOnvUg5un3xDJjXaL2qtPT7dd8X9ORHCAABWwHQkAMAKCGEAACsghAEArIAQBgCwAkIYAMAKCGHAZa+qNqrqvpmvzlYcr6pbq+pTXd0PYMvo/KcAXPK+Pn1sEsBlw0gYcMWqqs9V1d+vqv80/fqD0/0vqKrfqKrfmX5//nT/86rqg1X1yenXH5/ealhV/7Sq7q+qfzV9MkCq6geq6oHpfd63oh8TuEwJYcCV4Bk7piO/e+bYydbaK5O8M5OnYWS6/d7W2rck+YUkPznd/5NJ/m1r7aWZPL/v/un+25L8VGvtm5N8Jcl3Tvf/UJKXT+/z1/r64YArkxXzgcteVT3ZWrtmzv7PJXlta+2z04evP9Jae25VfSnJDa2109P9D7fWrquqE0lunn2UUFXdmuQjrbXbpq//zyTj1trfrqpfS/JkJo/0+lBr7cmef1TgCmIkDLjStV22dztnntnnO25ku572zyX5qSSvSHJPVamzBZYmhAFXuu+e+f4fptv/Pskd0+2/kOS3ptu/keT7kqSqhlV1aLebVtUgyS2ttY8m+cEkz05yzmgcwG78qw24Ejyjqu6bef1rrbWtZSquqqqPZ/KPzjdN9/1AkndX1f+R5ESSN0/3vzXJXVX1VzIZ8fq+JA/v8p7DJP93VT0rSSX5idbaVzr7iYArnpow4Io1rQk72lr70qrbArCT6UgAgBUwEgYAsAJGwgAAVkAIAwBYASEMAGAFhDAAgBUQwgAAVuB/AGP5RxPayrslAAAAAElFTkSuQmCC
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="다항식">다항식</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>샘플 데이터</strong>를 생성합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>이번에는 Feature Data, 즉 X 값이 여러 개인 다항식의 경우에 대해서도 구해보도록 하겠습니다.</p>
<p>다항식에서는 X의 갯수 만큼, W 갯수도 늘어날 것입니다.</p>
<p>다만, bias (b)의 계수는 1개인 점에 유의해 주세요.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x1</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">rand</span><span class="p">(</span><span class="mi">100</span><span class="p">)</span>
<span class="n">x2</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">rand</span><span class="p">(</span><span class="mi">100</span><span class="p">)</span>
<span class="n">x3</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">rand</span><span class="p">(</span><span class="mi">100</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">w1</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">w2</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">w3</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>

<span class="n">b</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>다항식을 정의</strong>합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">y</span> <span class="o">=</span> <span class="mf">0.3</span> <span class="o">*</span> <span class="n">x1</span> <span class="o">+</span> <span class="mf">0.5</span> <span class="o">*</span> <span class="n">x2</span> <span class="o">+</span> <span class="mf">0.7</span> <span class="o">*</span> <span class="n">x3</span> <span class="o">+</span> <span class="n">b</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Gradient-Descent-구현-(다항식)">Gradient Descent 구현 (다항식)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">errors</span> <span class="o">=</span> <span class="p">[]</span>
<span class="n">w1_grad</span> <span class="o">=</span> <span class="p">[]</span>
<span class="n">w2_grad</span> <span class="o">=</span> <span class="p">[]</span>
<span class="n">w3_grad</span> <span class="o">=</span> <span class="p">[]</span>

<span class="n">num_epoch</span><span class="o">=</span><span class="mi">5000</span>
<span class="n">learning_rate</span><span class="o">=</span><span class="mf">0.5</span>

<span class="n">w1</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">w2</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">w3</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>

<span class="n">b1</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">b2</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>
<span class="n">b3</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">uniform</span><span class="p">(</span><span class="n">low</span><span class="o">=-</span><span class="mf">1.0</span><span class="p">,</span> <span class="n">high</span><span class="o">=</span><span class="mf">1.0</span><span class="p">)</span>

<span class="k">for</span> <span class="n">epoch</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="n">num_epoch</span><span class="p">):</span>
    <span class="c1"># 예측값</span>
    <span class="n">y_hat</span> <span class="o">=</span> <span class="n">w1</span> <span class="o">*</span> <span class="n">x1</span> <span class="o">+</span> <span class="n">w2</span> <span class="o">*</span> <span class="n">x2</span> <span class="o">+</span> <span class="n">w3</span> <span class="o">*</span> <span class="n">x3</span> <span class="o">+</span> <span class="n">b</span>

    <span class="n">error</span> <span class="o">=</span> <span class="p">((</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span><span class="o">**</span><span class="mi">2</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    <span class="k">if</span> <span class="n">error</span> <span class="o">&lt;</span> <span class="mf">0.00001</span><span class="p">:</span>
        <span class="k">break</span>
    
    <span class="c1"># 미분값 적용 (Gradient)</span>
    <span class="n">w1</span> <span class="o">=</span> <span class="n">w1</span> <span class="o">-</span> <span class="n">learning_rate</span> <span class="o">*</span> <span class="p">((</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span> <span class="o">*</span> <span class="n">x1</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    <span class="n">w2</span> <span class="o">=</span> <span class="n">w2</span> <span class="o">-</span> <span class="n">learning_rate</span> <span class="o">*</span> <span class="p">((</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span> <span class="o">*</span> <span class="n">x2</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    <span class="n">w3</span> <span class="o">=</span> <span class="n">w3</span> <span class="o">-</span> <span class="n">learning_rate</span> <span class="o">*</span> <span class="p">((</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span> <span class="o">*</span> <span class="n">x3</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    
    <span class="n">w1_grad</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">w1</span><span class="p">)</span>
    <span class="n">w2_grad</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">w2</span><span class="p">)</span>
    <span class="n">w3_grad</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">w3</span><span class="p">)</span>
    
    <span class="n">b</span> <span class="o">=</span> <span class="n">b</span> <span class="o">-</span> <span class="n">learning_rate</span> <span class="o">*</span> <span class="p">(</span><span class="n">y_hat</span> <span class="o">-</span> <span class="n">y</span><span class="p">)</span><span class="o">.</span><span class="n">mean</span><span class="p">()</span>
    
    <span class="n">errors</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">error</span><span class="p">)</span>
    
    <span class="k">if</span> <span class="n">epoch</span> <span class="o">%</span> <span class="mi">5</span> <span class="o">==</span> <span class="mi">0</span><span class="p">:</span>
        <span class="nb">print</span><span class="p">(</span><span class="s2">"</span><span class="si">{0:2}</span><span class="s2"> w1 = </span><span class="si">{1:.5f}</span><span class="s2">, w2 = </span><span class="si">{2:.5f}</span><span class="s2">, w3 = </span><span class="si">{3:.5f}</span><span class="s2">, b = </span><span class="si">{4:.5f}</span><span class="s2"> error = </span><span class="si">{5:.5f}</span><span class="s2">"</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">epoch</span><span class="p">,</span> <span class="n">w1</span><span class="p">,</span> <span class="n">w2</span><span class="p">,</span> <span class="n">w3</span><span class="p">,</span> <span class="n">b</span><span class="p">,</span> <span class="n">error</span><span class="p">))</span>

<span class="nb">print</span><span class="p">(</span><span class="s2">"----"</span> <span class="o">*</span> <span class="mi">15</span><span class="p">)</span>
<span class="nb">print</span><span class="p">(</span><span class="s2">"</span><span class="si">{0:2}</span><span class="s2"> w1 = </span><span class="si">{1:.1f}</span><span class="s2">, w2 = </span><span class="si">{2:.1f}</span><span class="s2">, w3 = </span><span class="si">{3:.1f}</span><span class="s2">, b = </span><span class="si">{4:.1f}</span><span class="s2"> error = </span><span class="si">{5:.5f}</span><span class="s2">"</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">epoch</span><span class="p">,</span> <span class="n">w1</span><span class="p">,</span> <span class="n">w2</span><span class="p">,</span> <span class="n">w3</span><span class="p">,</span> <span class="n">b</span><span class="p">,</span> <span class="n">error</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre> 0 w1 = -0.46091, w2 = -0.19362, w3 = 0.10120, b = 1.55921 error = 3.59777
 5 w1 = -0.32075, w2 = -0.05618, w3 = 0.19562, b = 1.54160 error = 0.08839
10 w1 = -0.24220, w2 = 0.01936, w3 = 0.23409, b = 1.44080 error = 0.06879
15 w1 = -0.17415, w2 = 0.08407, w3 = 0.27131, b = 1.35162 error = 0.05367
20 w1 = -0.11510, w2 = 0.13957, w3 = 0.30690, b = 1.27268 error = 0.04197
25 w1 = -0.06379, w2 = 0.18725, w3 = 0.34060, b = 1.20277 error = 0.03288
30 w1 = -0.01915, w2 = 0.22827, w3 = 0.37226, b = 1.14084 error = 0.02580
35 w1 = 0.01974, w2 = 0.26361, w3 = 0.40181, b = 1.08596 error = 0.02027
40 w1 = 0.05367, w2 = 0.29410, w3 = 0.42925, b = 1.03731 error = 0.01595
45 w1 = 0.08330, w2 = 0.32044, w3 = 0.45461, b = 0.99416 error = 0.01256
50 w1 = 0.10921, w2 = 0.34324, w3 = 0.47795, b = 0.95589 error = 0.00990
55 w1 = 0.13190, w2 = 0.36298, w3 = 0.49936, b = 0.92192 error = 0.00782
60 w1 = 0.15177, w2 = 0.38012, w3 = 0.51893, b = 0.89178 error = 0.00617
65 w1 = 0.16921, w2 = 0.39500, w3 = 0.53679, b = 0.86502 error = 0.00488
70 w1 = 0.18452, w2 = 0.40795, w3 = 0.55304, b = 0.84126 error = 0.00385
75 w1 = 0.19798, w2 = 0.41922, w3 = 0.56780, b = 0.82016 error = 0.00305
80 w1 = 0.20982, w2 = 0.42906, w3 = 0.58117, b = 0.80142 error = 0.00241
85 w1 = 0.22024, w2 = 0.43764, w3 = 0.59328, b = 0.78476 error = 0.00191
90 w1 = 0.22942, w2 = 0.44514, w3 = 0.60422, b = 0.76996 error = 0.00151
95 w1 = 0.23752, w2 = 0.45170, w3 = 0.61410, b = 0.75681 error = 0.00120
100 w1 = 0.24466, w2 = 0.45744, w3 = 0.62300, b = 0.74511 error = 0.00095
105 w1 = 0.25097, w2 = 0.46248, w3 = 0.63102, b = 0.73472 error = 0.00075
110 w1 = 0.25654, w2 = 0.46690, w3 = 0.63823, b = 0.72548 error = 0.00059
115 w1 = 0.26147, w2 = 0.47078, w3 = 0.64471, b = 0.71726 error = 0.00047
120 w1 = 0.26582, w2 = 0.47419, w3 = 0.65053, b = 0.70995 error = 0.00037
125 w1 = 0.26968, w2 = 0.47719, w3 = 0.65576, b = 0.70345 error = 0.00030
130 w1 = 0.27309, w2 = 0.47983, w3 = 0.66045, b = 0.69767 error = 0.00023
135 w1 = 0.27611, w2 = 0.48216, w3 = 0.66465, b = 0.69252 error = 0.00019
140 w1 = 0.27879, w2 = 0.48421, w3 = 0.66841, b = 0.68795 error = 0.00015
145 w1 = 0.28116, w2 = 0.48602, w3 = 0.67178, b = 0.68388 error = 0.00012
150 w1 = 0.28327, w2 = 0.48762, w3 = 0.67480, b = 0.68025 error = 0.00009
155 w1 = 0.28513, w2 = 0.48903, w3 = 0.67750, b = 0.67703 error = 0.00007
160 w1 = 0.28679, w2 = 0.49028, w3 = 0.67992, b = 0.67416 error = 0.00006
165 w1 = 0.28826, w2 = 0.49138, w3 = 0.68207, b = 0.67161 error = 0.00005
170 w1 = 0.28956, w2 = 0.49235, w3 = 0.68400, b = 0.66934 error = 0.00004
175 w1 = 0.29072, w2 = 0.49322, w3 = 0.68573, b = 0.66732 error = 0.00003
180 w1 = 0.29175, w2 = 0.49398, w3 = 0.68727, b = 0.66552 error = 0.00002
185 w1 = 0.29266, w2 = 0.49466, w3 = 0.68864, b = 0.66392 error = 0.00002
190 w1 = 0.29347, w2 = 0.49526, w3 = 0.68987, b = 0.66249 error = 0.00001
195 w1 = 0.29420, w2 = 0.49579, w3 = 0.69097, b = 0.66122 error = 0.00001
------------------------------------------------------------
198 w1 = 0.3, w2 = 0.5, w3 = 0.7, b = 0.7 error = 0.00001
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>

<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">errors</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>[&lt;matplotlib.lines.Line2D at 0x7f1447f9e4a8&gt;]</pre>
</div>
</div>
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="가중치-(W1,-W2,-W3)-값들의-변화량-시각화">가중치 (W1, W2, W3) 값들의 변화량 시각화</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>Epoch</code>가 지남에 따라 어떻게 가중치들이 업데이트 되는지 시각화 해 봅니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>

<span class="n">plt</span><span class="o">.</span><span class="n">hlines</span><span class="p">(</span><span class="n">y</span><span class="o">=</span><span class="mf">0.3</span><span class="p">,</span> <span class="n">xmin</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">xmax</span><span class="o">=</span><span class="nb">len</span><span class="p">(</span><span class="n">w1_grad</span><span class="p">),</span> <span class="n">color</span><span class="o">=</span><span class="s1">'r'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">w1_grad</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s1">'g'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylim</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'W1'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">([</span><span class="s1">'W1 Change'</span><span class="p">,</span> <span class="s1">'W1'</span><span class="p">])</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>

<span class="n">plt</span><span class="o">.</span><span class="n">hlines</span><span class="p">(</span><span class="n">y</span><span class="o">=</span><span class="mf">0.5</span><span class="p">,</span> <span class="n">xmin</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">xmax</span><span class="o">=</span><span class="nb">len</span><span class="p">(</span><span class="n">w2_grad</span><span class="p">),</span> <span class="n">color</span><span class="o">=</span><span class="s1">'r'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">w2_grad</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s1">'g'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylim</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'W2'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">([</span><span class="s1">'W2 Change'</span><span class="p">,</span> <span class="s1">'W2'</span><span class="p">])</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">10</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>

<span class="n">plt</span><span class="o">.</span><span class="n">hlines</span><span class="p">(</span><span class="n">y</span><span class="o">=</span><span class="mf">0.7</span><span class="p">,</span> <span class="n">xmin</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">xmax</span><span class="o">=</span><span class="nb">len</span><span class="p">(</span><span class="n">w3_grad</span><span class="p">),</span> <span class="n">color</span><span class="o">=</span><span class="s1">'r'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">w3_grad</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s1">'g'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylim</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'W3'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">16</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">([</span><span class="s1">'W3 Change'</span><span class="p">,</span> <span class="s1">'W3'</span><span class="p">])</span>
<span class="n">plt</span><span class="o">.</span><span class="n">show</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_png output_subarea">
<img src="data:image/png;base64,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rtSLL76o5cuXq76+XuPGjdP48eMlSbNnz9acOXOUlZWlxYsX69vf/rbee+89r59hpw1TCzYt0L1v36vANUUlF7z3cmxkrO6ccKduGH0D344AAKAFDo1O5eXl6d5779X27duVl5enpKQknX322Y39MjMztWrVKu3YsUNXXHGFrrrqKvXp06fFrxMdHa3LLrtMkjR+/Hi98847kgLX2rr22mu1c+dO1dbWHnYNqBkzZigmJkYxMTHq3bu3ioqK9NFHH2nWrFmKi4uTJF1++eWSpAMHDigvL09XX3114/NrampO/QcT1GnDVFxUnAYkDZAkmQKhycy0Ye8G3fTSTXp8yeN67NLHNK7fuFCWCQBAix1vBKktHTpvavXq1crOzlZmZqYeeeQRJSYm6pZbbjmqf3p6ukaNGqWFCxfqqquuamwfMmSItm7dqvLyciUkJBz1vKioqMaBjoiICNXX10uS7rzzTt17772aOXOm3n//fT344IONzzl0uLDpcw4NpBypoaFBycnJWrGidUf3Ou05UxP7T9Qr172iV657RS9f97Jevu5lvXTtS1rxrRV6cuaTKthboNy5ufrm/G+quKI41OUCABC2Jk+erNdee00pKSmKiIhQSkqKysrKtGjRIk2aNElSYPSoqqpKklRaWqqPP/5Yw4YNO2w73bt316233qq77rpLtbW1kqSdO3fq6aefPu7r79u3TxkZGZKkefPmnbDec845R/Pnz1d1dbUOHDig119/XZKUmJiowYMH609/+pOkwBXPV65ceRI/ieZ12jB1LN2sm74x9htaf8d63TPxHj254kkN/fVQ/c+S/1GDO/pkOQAAurrRo0erpKREEydOPKwtKSlJvXr1kiTl5+frrLPO0pgxYzR16lR997vf1ejRo4/a1o9//GOlpaVp5MiRys7O1hVXXKG0tLTjvv6DDz6oq6++WlOmTGl8veM588wzNXPmTI0ZM0Zf+9rXlJubq6SkJEnSM888o9/97ncaM2aMRo0apVdeeeVkfhTNsmMNhbW13Nxct2TJkpC8dlP5xfm648079N6m9zQ5c7LmXj5XI9NGhrosAAAkBULKiBEjQl1Gh3PgwAHFx8ersrJS5557rubOnatx41p2ak9zP3MzW+qcy22uf5cbmTrSiLQR+ttNf9PvZ/1e+SX5ypmTo39b8G+qrufu3AAAdFSzZ89W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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="경사하강법을-활용한-SGDRegressor">경사하강법을 활용한 SGDRegressor</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><a href="https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.SGDRegressor.html">SGDRegressor 도큐먼트</a></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">sklearn.linear_model</span> <span class="k">import</span> <span class="n">SGDRegressor</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span> <span class="o">=</span> <span class="n">SGDRegressor</span><span class="p">(</span><span class="n">max_iter</span><span class="o">=</span><span class="mi">5000</span><span class="p">,</span> <span class="n">tol</span><span class="o">=</span><span class="mf">1e-5</span><span class="p">,</span> <span class="n">learning_rate</span><span class="o">=</span><span class="s1">'constant'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">x1</span> <span class="o">=</span> <span class="n">x1</span><span class="o">.</span><span class="n">reshape</span><span class="p">(</span><span class="o">-</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
<span class="n">x2</span> <span class="o">=</span> <span class="n">x2</span><span class="o">.</span><span class="n">reshape</span><span class="p">(</span><span class="o">-</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
<span class="n">x3</span> <span class="o">=</span> <span class="n">x3</span><span class="o">.</span><span class="n">reshape</span><span class="p">(</span><span class="o">-</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">X</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">concatenate</span><span class="p">([</span><span class="n">x1</span><span class="p">,</span> <span class="n">x2</span><span class="p">,</span> <span class="n">x3</span><span class="p">],</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">X</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(100, 3)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">fit</span><span class="p">(</span><span class="n">X</span><span class="p">,</span> <span class="n">y</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>SGDRegressor(alpha=0.0001, average=False, early_stopping=False, epsilon=0.1,
             eta0=0.01, fit_intercept=True, l1_ratio=0.15,
             learning_rate='constant', loss='squared_loss', max_iter=5000,
             n_iter_no_change=5, penalty='l2', power_t=0.25, random_state=None,
             shuffle=True, tol=1e-05, validation_fraction=0.1, verbose=0,
             warm_start=False)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">coef_</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>array([0.2868208 , 0.47813082, 0.68244513])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">intercept_</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>array([0.27063858])</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="s2">"w1 = </span><span class="si">{:.1f}</span><span class="s2">, w2 = </span><span class="si">{:.1f}</span><span class="s2">, w3 = </span><span class="si">{:.1f}</span><span class="s2">, b = </span><span class="si">{:.1f}</span><span class="s2">"</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">model</span><span class="o">.</span><span class="n">coef_</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span> <span class="n">model</span><span class="o">.</span><span class="n">coef_</span><span class="p">[</span><span class="mi">1</span><span class="p">],</span> <span class="n">model</span><span class="o">.</span><span class="n">coef_</span><span class="p">[</span><span class="mi">2</span><span class="p">],</span> <span class="n">model</span><span class="o">.</span><span class="n">intercept_</span><span class="p">[</span><span class="mi">0</span><span class="p">]))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>w1 = 0.3, w2 = 0.5, w3 = 0.7, b = 0.3
</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>