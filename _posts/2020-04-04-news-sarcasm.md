---
layout: page
title: "TensorFlow 2.0 - 단어 토큰화, Embedding, LSTM layer를 활용한 뉴스 데이터 sarcasm 판단"
description: "TensorFlow 2.0 - 단어 토큰화, Embedding, LSTM layer를 활용한 뉴스 데이터 sarcasm 판단에 대하여 알아보겠습니다."
headline: "TensorFlow 2.0 - 단어 토큰화, Embedding, LSTM layer를 활용한 뉴스 데이터 sarcasm 판단에 대하여 알아보겠습니다."
categories: deep-learning
tags: [pytho, colab, deep-learning, tensorflow2.0]
comments: true
published: true
---

캐글의 뉴스의 Sarcasm 에 대한 판단을 해주는 딥러닝 모델을 tensorflow 2.0을 활용하여 만들어 보겠습니다.

<body>
<div class="border-box-sizing" id="notebook" tabindex="-1">
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>sarcastic (sarcasm)</strong></p>
<ul>
<li>미국식 [sɑːrˈk-]  영국식 [sɑːˈkæstɪk]</li>
<li>뜻: 빈정대는, 비꼬는</li>
</ul>
<p>출처: 네이버사전</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="개요">개요</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>뉴스 기사의 헤드라인(영문장)을 통하여 sarcasm (비꼬는 기사) 인지 아닌지 여부를 판단하는 <code>classification</code> 문제입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>캐글 대회 링크
<a href="https://www.kaggle.com/rmisra/news-headlines-dataset-for-sarcasm-detection">News Headlines Dataset For Sarcasm Detection</a></li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="0.-필요한-라이브러리-import">0. 필요한 라이브러리 import</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [1]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">json</span>
<span class="kn">import</span> <span class="nn">tensorflow</span> <span class="k">as</span> <span class="nn">tf</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">urllib</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.preprocessing.text</span> <span class="kn">import</span> <span class="n">Tokenizer</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.preprocessing.sequence</span> <span class="kn">import</span> <span class="n">pad_sequences</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.layers</span> <span class="kn">import</span> <span class="n">Dense</span><span class="p">,</span> <span class="n">Embedding</span><span class="p">,</span> <span class="n">LSTM</span><span class="p">,</span> <span class="n">Bidirectional</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.models</span> <span class="kn">import</span> <span class="n">Sequential</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="1.-sarcasm-데이터-로드">1. sarcasm 데이터 로드</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [2]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">url</span> <span class="o">=</span> <span class="s1">'https://storage.googleapis.com/download.tensorflow.org/data/sarcasm.json'</span>
<span class="n">urllib</span><span class="o">.</span><span class="n">request</span><span class="o">.</span><span class="n">urlretrieve</span><span class="p">(</span><span class="n">url</span><span class="p">,</span> <span class="s1">'sarcasm.json'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[2]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>('sarcasm.json', &lt;http.client.HTTPMessage at 0x7fbf3b535668&gt;)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>json.load()를 활용하여 sarcasm 데이터를 로드합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [3]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">with</span> <span class="nb">open</span><span class="p">(</span><span class="s1">'sarcasm.json'</span><span class="p">,</span> <span class="s1">'r'</span><span class="p">)</span> <span class="k">as</span> <span class="n">f</span><span class="p">:</span>
    <span class="n">data</span> <span class="o">=</span> <span class="n">json</span><span class="o">.</span><span class="n">load</span><span class="p">(</span><span class="n">f</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [4]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">data</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[4]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>[{'article_link': 'https://www.huffingtonpost.com/entry/versace-black-code_us_5861fbefe4b0de3a08f600d5',
  'headline': "former versace store clerk sues over secret 'black code' for minority shoppers",
  'is_sarcastic': 0},
 {'article_link': 'https://www.huffingtonpost.com/entry/roseanne-revival-review_us_5ab3a497e4b054d118e04365',
  'headline': "the 'roseanne' revival catches up to our thorny political mood, for better and worse",
  'is_sarcastic': 0},
 {'article_link': 'https://local.theonion.com/mom-starting-to-fear-son-s-web-series-closest-thing-she-1819576697',
  'headline': "mom starting to fear son's web series closest thing she will have to grandchild",
  'is_sarcastic': 1},
 {'article_link': 'https://politics.theonion.com/boehner-just-wants-wife-to-listen-not-come-up-with-alt-1819574302',
  'headline': 'boehner just wants wife to listen, not come up with alternative debt-reduction ideas',
  'is_sarcastic': 1},
 {'article_link': 'https://www.huffingtonpost.com/entry/jk-rowling-wishes-snape-happy-birthday_us_569117c4e4b0cad15e64fdcb',
  'headline': 'j.k. rowling wishes snape happy birthday in the most magical way',
  'is_sarcastic': 0}]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>article_link</code>에는 신문기사의 링크가, <code>headline</code>에는 신문 기사의 헤드라인이, <code>is_sarcastic</code>에는 sarcasm 여부를 판단하는 label이 표기되어 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="2.-feature,-label-정의">2. feature, label 정의</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [5]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">sentences</span> <span class="o">=</span> <span class="p">[]</span>
<span class="n">labels</span> <span class="o">=</span> <span class="p">[]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [6]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">d</span> <span class="ow">in</span> <span class="n">data</span><span class="p">:</span>
    <span class="n">sentences</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">d</span><span class="p">[</span><span class="s1">'headline'</span><span class="p">])</span>
    <span class="n">labels</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">d</span><span class="p">[</span><span class="s1">'is_sarcastic'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="3.-train,-validation-dataset-분할">3. train, validation dataset 분할</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [7]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># train dataset을 사용할 ratio를 정의합니다.</span>
<span class="n">train_ratio</span> <span class="o">=</span> <span class="mf">0.8</span>

<span class="n">train_size</span> <span class="o">=</span> <span class="nb">int</span><span class="p">(</span><span class="nb">len</span><span class="p">(</span><span class="n">data</span><span class="p">)</span> <span class="o">*</span> <span class="n">train_ratio</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [8]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_size</span><span class="p">,</span> <span class="nb">len</span><span class="p">(</span><span class="n">data</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[8]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>(21367, 26709)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [9]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># train 분할</span>
<span class="n">train_sentences</span> <span class="o">=</span> <span class="n">sentences</span><span class="p">[:</span><span class="n">train_size</span><span class="p">]</span>
<span class="n">valid_sentences</span> <span class="o">=</span> <span class="n">sentences</span><span class="p">[</span><span class="n">train_size</span><span class="p">:]</span>
<span class="c1"># label 분할</span>
<span class="n">train_labels</span> <span class="o">=</span> <span class="n">labels</span><span class="p">[:</span><span class="n">train_size</span><span class="p">]</span>
<span class="n">valid_labels</span> <span class="o">=</span> <span class="n">labels</span><span class="p">[</span><span class="n">train_size</span><span class="p">:]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="4.-토근화-(Tokenize)">4. 토근화 (Tokenize)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>vocab_size 는 Token화 진행시 최대 <strong>빈도숫자가 높은 1000개의 단어만을 활용</strong>하고 나머지는 <oov> 처리하겠다는 의미입니다.</oov></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [10]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">vocab_size</span> <span class="o">=</span> <span class="mi">1000</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [11]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">token</span> <span class="o">=</span> <span class="n">Tokenizer</span><span class="p">(</span><span class="n">num_words</span><span class="o">=</span><span class="n">vocab_size</span><span class="p">,</span> <span class="n">oov_token</span><span class="o">=</span><span class="s1">'&lt;OOV&gt;'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [12]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">token</span><span class="o">.</span><span class="n">fit_on_texts</span><span class="p">(</span><span class="n">sentences</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [13]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">word_index</span> <span class="o">=</span> <span class="n">token</span><span class="o">.</span><span class="n">word_index</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [14]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">word_index</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[14]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>{'&lt;OOV&gt;': 1,
 'to': 2,
 'of': 3,
 'the': 4,
 'in': 5,
 'for': 6,
 'a': 7,
 'on': 8,
 'and': 9,
 'with': 10,
 ...
 ...
 ...
 'explains': 990,
 'table': 991,
 'energy': 992,
 'users': 993,
 'feeling': 994,
 'sales': 995,
 'colbert': 996,
 'apparently': 997,
 "let's": 998,
 'amazing': 999,
 'went': 1000,
 ...}</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>단어: index로 맵핑된 dict 가 완성되었음을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [15]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">word_index</span><span class="p">[</span><span class="s1">'party'</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[15]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>149</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="5.-Sequence로-변환">5. Sequence로 변환</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [16]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_sequences</span> <span class="o">=</span> <span class="n">token</span><span class="o">.</span><span class="n">texts_to_sequences</span><span class="p">(</span><span class="n">train_sentences</span><span class="p">)</span>
<span class="n">valid_sequences</span> <span class="o">=</span> <span class="n">token</span><span class="o">.</span><span class="n">texts_to_sequences</span><span class="p">(</span><span class="n">valid_sentences</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>단어로 이루어진 <strong>sentences</strong>를 <code>Tokenizer</code>를 통해 기계가 알아들을 수 있는 <strong>numerical value로 변환</strong>하였습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [17]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_sentences</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[17]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>["former versace store clerk sues over secret 'black code' for minority shoppers",
 "the 'roseanne' revival catches up to our thorny political mood, for better and worse",
 "mom starting to fear son's web series closest thing she will have to grandchild",
 'boehner just wants wife to listen, not come up with alternative debt-reduction ideas',
 'j.k. rowling wishes snape happy birthday in the most magical way']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [18]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_sequences</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[18]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>[[308, 1, 679, 1, 1, 48, 382, 1, 1, 6, 1, 1],
 [4, 1, 1, 1, 22, 2, 166, 1, 416, 1, 6, 258, 9, 1],
 [145, 838, 2, 907, 1, 1, 582, 1, 221, 143, 39, 46, 2, 1],
 [1, 36, 224, 400, 2, 1, 29, 319, 22, 10, 1, 1, 1, 968],
 [767, 719, 1, 908, 1, 623, 594, 5, 4, 95, 1, 92]]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="6.-문장의-길이-맞추기-(pad_sequences)">6. 문장의 길이 맞추기 (pad_sequences)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>학습을 위해서는 input의 길이가 동일 해야합니다.</p>
<p>지금의 <strong>sequences</strong>는 길이가 들쭉날쭉합니다.</p>
<p>pad_sequences를 통해 길이를 맞춰주고, 길이가 긴 문장을 자르거나, 길이가 짧은 문장은 padding 처리를 해줄 수 있습니다.</p>
<p>padding 처리를 한다는 말은 <strong>0이나 특정 constant로 채워 준다는 의미</strong> 이기도 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong> <code>pad_sequences</code> 옵션 값 </strong></p>
<ul>
<li>truncating: 'post' / 'pre'- 문장의 길이가 <code>maxlen</code>보다 길 때, 뒷 / 앞 부분을 잘라줍니다.</li>
<li>padding: 'post' / 'pre' - 문장의 길이가 <code>maxlen</code>보다 길 때, 뒷 / 앞 부분을 잘라줍니다.</li>
<li>maxlen: 최대 문장 길이를 정의합니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [19]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">_truncating</span> <span class="o">=</span> <span class="s1">'post'</span>
<span class="n">_padding</span> <span class="o">=</span> <span class="s1">'post'</span>
<span class="n">_maxlen</span> <span class="o">=</span> <span class="mi">120</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [20]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_padded</span> <span class="o">=</span> <span class="n">pad_sequences</span><span class="p">(</span><span class="n">train_sequences</span><span class="p">,</span> <span class="n">truncating</span><span class="o">=</span><span class="n">_truncating</span><span class="p">,</span> <span class="n">padding</span><span class="o">=</span><span class="n">_padding</span><span class="p">,</span> <span class="n">maxlen</span><span class="o">=</span><span class="n">_maxlen</span><span class="p">)</span>
<span class="n">valid_padded</span> <span class="o">=</span> <span class="n">pad_sequences</span><span class="p">(</span><span class="n">valid_sequences</span><span class="p">,</span> <span class="n">truncating</span><span class="o">=</span><span class="n">_truncating</span><span class="p">,</span> <span class="n">padding</span><span class="o">=</span><span class="n">_padding</span><span class="p">,</span> <span class="n">maxlen</span><span class="o">=</span><span class="n">_maxlen</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="7.-label을-np.array로-변환">7. label을 np.array로 변환</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>list 타입은 허용하지 않기 때문에, <strong>labels</strong>를 <code>np.array</code>로 변환합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [21]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_labels</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">asarray</span><span class="p">(</span><span class="n">train_labels</span><span class="p">)</span>
<span class="n">valid_labels</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">asarray</span><span class="p">(</span><span class="n">valid_labels</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [22]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">train_labels</span><span class="p">,</span> <span class="n">valid_labels</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt output_prompt">Out[22]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>(array([0, 0, 1, ..., 0, 1, 1]), array([1, 1, 1, ..., 0, 0, 0]))</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="8.-모델링-(Modeling)">8. 모델링 (Modeling)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>현재 <strong>vocab_size = 1000</strong>으로 정의되어 있기때문에 우리의 단어들은 1000차원 공간안에 정의되어 있다고 볼 수 있습니다.</p>
<p>우리는 이를 16차원으로 내려 <strong>Data Sparsity</strong>를 해결하고 효율적으로 학습할 수 있도록 합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [23]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">embedding_dim</span> <span class="o">=</span> <span class="mi">16</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [24]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span> <span class="o">=</span> <span class="n">Sequential</span><span class="p">([</span>
        <span class="n">Embedding</span><span class="p">(</span><span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">input_length</span><span class="o">=</span><span class="n">_maxlen</span><span class="p">),</span>
        <span class="n">Bidirectional</span><span class="p">(</span><span class="n">LSTM</span><span class="p">(</span><span class="mi">32</span><span class="p">)),</span>
        <span class="n">Dense</span><span class="p">(</span><span class="mi">24</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'relu'</span><span class="p">),</span>
        <span class="n">Dense</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'sigmoid'</span><span class="p">)</span>
    <span class="p">])</span>
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
embedding (Embedding)        (None, 120, 16)           16000     
_________________________________________________________________
bidirectional (Bidirectional (None, 64)                12544     
_________________________________________________________________
dense (Dense)                (None, 24)                1560      
_________________________________________________________________
dense_1 (Dense)              (None, 1)                 25        
=================================================================
Total params: 30,129
Trainable params: 30,129
Non-trainable params: 0
_________________________________________________________________
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="9.-Callback-정의---validation-best-weight를-저장하기-위함">9. Callback 정의 - validation best weight를 저장하기 위함</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>validation performance가 갱신이 될 때마다 저장합니다. (나중에 이를 load 하여 prediction할 예정입니다)</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [26]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">checkpoint_path</span> <span class="o">=</span> <span class="s1">'best_performed_model.ckpt'</span>
<span class="n">checkpoint</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">callbacks</span><span class="o">.</span><span class="n">ModelCheckpoint</span><span class="p">(</span><span class="n">checkpoint_path</span><span class="p">,</span> 
                                                <span class="n">save_weights_only</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> 
                                                <span class="n">save_best_only</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> 
                                                <span class="n">monitor</span><span class="o">=</span><span class="s1">'val_loss'</span><span class="p">,</span>
                                                <span class="n">verbose</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>adam</code> optimizer를 사용하며, 0, 1을 맞추는 것이므로 <code>binary_crossentropy</code>를 사용합니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [27]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">model</span><span class="o">.</span><span class="n">compile</span><span class="p">(</span><span class="n">loss</span><span class="o">=</span><span class="s1">'binary_crossentropy'</span><span class="p">,</span> <span class="n">optimizer</span><span class="o">=</span><span class="s1">'adam'</span><span class="p">,</span> <span class="n">metrics</span><span class="o">=</span><span class="p">[</span><span class="s1">'accuracy'</span><span class="p">])</span>
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
<div class="highlight hl-ipython3"><pre><span></span><span class="n">history</span> <span class="o">=</span> <span class="n">model</span><span class="o">.</span><span class="n">fit</span><span class="p">(</span><span class="n">train_padded</span><span class="p">,</span> <span class="n">train_labels</span><span class="p">,</span> 
                    <span class="n">validation_data</span><span class="o">=</span><span class="p">(</span><span class="n">valid_padded</span><span class="p">,</span> <span class="n">valid_labels</span><span class="p">),</span>
                    <span class="n">callbacks</span><span class="o">=</span><span class="p">[</span><span class="n">checkpoint</span><span class="p">],</span>
                    <span class="n">epochs</span><span class="o">=</span><span class="mi">20</span><span class="p">,</span> 
                    <span class="n">verbose</span><span class="o">=</span><span class="mi">2</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>Train on 21367 samples, validate on 5342 samples
Epoch 1/20

Epoch 00001: val_loss improved from inf to 0.38502, saving model to best_performed_model.ckpt
21367/21367 - 14s - loss: 0.4568 - accuracy: 0.7666 - val_loss: 0.3850 - val_accuracy: 0.8231
Epoch 2/20

Epoch 00002: val_loss improved from 0.38502 to 0.38251, saving model to best_performed_model.ckpt
21367/21367 - 12s - loss: 0.3507 - accuracy: 0.8391 - val_loss: 0.3825 - val_accuracy: 0.8210
Epoch 3/20

Epoch 00003: val_loss improved from 0.38251 to 0.36455, saving model to best_performed_model.ckpt
21367/21367 - 12s - loss: 0.3296 - accuracy: 0.8521 - val_loss: 0.3645 - val_accuracy: 0.8287
Epoch 4/20

Epoch 00004: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.3169 - accuracy: 0.8585 - val_loss: 0.3683 - val_accuracy: 0.8362
Epoch 5/20

Epoch 00005: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.3081 - accuracy: 0.8603 - val_loss: 0.3691 - val_accuracy: 0.8347
Epoch 6/20

Epoch 00006: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.3016 - accuracy: 0.8678 - val_loss: 0.3703 - val_accuracy: 0.8355
Epoch 7/20

Epoch 00007: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2964 - accuracy: 0.8699 - val_loss: 0.3706 - val_accuracy: 0.8328
Epoch 8/20

Epoch 00008: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2893 - accuracy: 0.8736 - val_loss: 0.3983 - val_accuracy: 0.8291
Epoch 9/20

Epoch 00009: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2819 - accuracy: 0.8770 - val_loss: 0.3820 - val_accuracy: 0.8353
Epoch 10/20

Epoch 00010: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2745 - accuracy: 0.8796 - val_loss: 0.3855 - val_accuracy: 0.8353
Epoch 11/20

Epoch 00011: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2653 - accuracy: 0.8859 - val_loss: 0.3906 - val_accuracy: 0.8338
Epoch 12/20

Epoch 00012: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2573 - accuracy: 0.8883 - val_loss: 0.4042 - val_accuracy: 0.8345
Epoch 13/20

Epoch 00013: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2510 - accuracy: 0.8930 - val_loss: 0.4072 - val_accuracy: 0.8276
Epoch 14/20

Epoch 00014: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2429 - accuracy: 0.8959 - val_loss: 0.4236 - val_accuracy: 0.8311
Epoch 15/20

Epoch 00015: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2362 - accuracy: 0.8981 - val_loss: 0.4175 - val_accuracy: 0.8300
Epoch 16/20

Epoch 00016: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2287 - accuracy: 0.9049 - val_loss: 0.4293 - val_accuracy: 0.8291
Epoch 17/20

Epoch 00017: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2214 - accuracy: 0.9064 - val_loss: 0.4573 - val_accuracy: 0.8287
Epoch 18/20

Epoch 00018: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2138 - accuracy: 0.9103 - val_loss: 0.4570 - val_accuracy: 0.8274
Epoch 19/20

Epoch 00019: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2082 - accuracy: 0.9140 - val_loss: 0.4661 - val_accuracy: 0.8313
Epoch 20/20

Epoch 00020: val_loss did not improve from 0.36455
21367/21367 - 12s - loss: 0.2007 - accuracy: 0.9170 - val_loss: 0.4926 - val_accuracy: 0.8255
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="10.-best-model의-weight-load">10. best model의 weight load</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [29]:</div>
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
<div class="prompt output_prompt">Out[29]:</div>
<div class="output_text output_subarea output_execute_result">
<pre>&lt;tensorflow.python.training.tracking.util.CheckpointLoadStatus at 0x7fbf3b991780&gt;</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>이제 새로운 데이터에 대하여 똑같이 <strong>토큰화 - 텍스트를 시퀀스 변환 - pad_sequence</strong> 스텝으로 처리한 후</p>
<p>우리가 정의한 model로 prediction을 할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="11.-시각화">11. 시각화</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [30]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">matplotlib.pyplot</span> <span class="k">as</span> <span class="nn">plt</span>

<span class="o">%</span><span class="k">matplotlib</span> inline
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Loss">Loss</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [31]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span><span class="o">+</span><span class="mi">1</span><span class="p">,</span> <span class="n">history</span><span class="o">.</span><span class="n">history</span><span class="p">[</span><span class="s1">'loss'</span><span class="p">],</span> <span class="n">label</span><span class="o">=</span><span class="s1">'Loss'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span><span class="o">+</span><span class="mi">1</span><span class="p">,</span> <span class="n">history</span><span class="o">.</span><span class="n">history</span><span class="p">[</span><span class="s1">'val_loss'</span><span class="p">],</span> <span class="n">label</span><span class="o">=</span><span class="s1">'Validation Loss'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'losses over training'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">20</span><span class="p">)</span>

<span class="n">plt</span><span class="o">.</span><span class="n">xlabel</span><span class="p">(</span><span class="s1">'epochs'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">15</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s1">'loss'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">15</span><span class="p">)</span>

<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">()</span>
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
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Accuracy">Accuracy</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">
<div class="prompt input_prompt">In [32]:</div>
<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">(</span><span class="n">figsize</span><span class="o">=</span><span class="p">(</span><span class="mi">12</span><span class="p">,</span> <span class="mi">6</span><span class="p">))</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span><span class="o">+</span><span class="mi">1</span><span class="p">,</span> <span class="n">history</span><span class="o">.</span><span class="n">history</span><span class="p">[</span><span class="s1">'accuracy'</span><span class="p">],</span> <span class="n">label</span><span class="o">=</span><span class="s1">'Accuracy'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">np</span><span class="o">.</span><span class="n">arange</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span><span class="o">+</span><span class="mi">1</span><span class="p">,</span> <span class="n">history</span><span class="o">.</span><span class="n">history</span><span class="p">[</span><span class="s1">'val_accuracy'</span><span class="p">],</span> <span class="n">label</span><span class="o">=</span><span class="s1">'Validation Accuracy'</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="s1">'Accuracy over training'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">20</span><span class="p">)</span>

<span class="n">plt</span><span class="o">.</span><span class="n">xlabel</span><span class="p">(</span><span class="s1">'epochs'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">15</span><span class="p">)</span>
<span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s1">'Accuracy'</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">15</span><span class="p">)</span>

<span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">()</span>
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
<img src="data:image/png;base64,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XG5a2mFXpfSoxYsXc/LJJ7NkyZKjdozm5uajtm8REREROTw9nXyvAEab2UgziwAuB15oO8DMUs2sJa7v4K18gj/+ObyTMZf2YMxHRVVVFe+88w6PPPLIAcn3vffey+TJk8nJyeH2228HYNOmTZx55pnk5OQwbdo0Nm/ezOuvv855553Xut3XvvY1Fi5cCHhX9rz77rs5+eSTWbp0KQ899BAzZswgJyeHSy65hJqaGgCKi4uZO3cuOTk55OTk8K9//Yvvfe973H///a37/e53v8uvf/3rHnhHRERERPq/Hl3txDnXZGZfA17GW2rwUefcR2Z2N5DnnHsBOA34iZk54E3gv/zN5wGnAilmNt9vm++cW/1Z4/nBXz5iXVHFZ928QxOGJfD98ycectyyZcs455xzGDNmDMnJyaxatYri4mKWLVvGe++9R0xMDKWlpQBcddVV3H777cydO5e6ujoCgQAFBQUH3X9UVBRvv/02AHv37uWmm24C4I477uCRRx7hlltu4etf/zqzZs3iueeeo7m5maqqKoYNG8bFF1/MN77xDQKBAEuWLOH9998/wndFRERERCAI63w7514EXmzXdmebx88Az3Sw3Z+BPx/1AHvI4sWL+eY3vwnA5ZdfzuLFiwkEAlx//fXExMQAkJycTGVlJTt27GDu3LmAl1R3xWWXXdb6+MMPP+SOO+6gvLycqqoqzj77bABee+01Hn/8cQBCQ0NJTEwkMTGRlJQUPvjgA4qLi5k6dSopKSkdHkNERESkN3DOUVJZz/pdlYwbEk96QtfypWDo8eS7N+nKDPXRsHfvXl577TU+/PBDzIzm5mbMjEsuueRTK2441/58VE9YWBiBwP7zTdsvkRcbG9v6eP78+SxbtoycnBwWLlzI66+/ftD4brzxRhYuXMiuXbv40pe+dJivTkREROToqW9q5pPiKjbsqmT9zgo27Kpg/c5KSqsbALj30inMy808xF6CZ0An38HyzDPPcO211/LHP/6xtW3WrFkkJyfz6KOPcuWVV7aWnSQnJ5ORkcGyZcu46KKLqK+vp7m5maysLNatW0d9fT11dXW8+uqrnHzyyR0er7KykqFDh9LY2MgTTzzB8OHe6o5nnHEGDzzwAN/85jdpbm6murqahIQE5s6dy5133kljYyNPPvlkj7wnIiIiIm0559hdWc+6nRVs2FnpJ9kVbC6ppjngTU5GhoUwdkg8Z41PZ9zQeMYPTWDisIQgR35wSr6DYPHixa0nU7a45JJLWL9+PRdccAG5ublERERw7rnncs8997Bo0SJuvvlm7rzzTsLDw1m6dCmjRo1i3rx5TJkyhdGjRzN16tROj/fDH/6Q448/nqysLCZPnkxlZSUA999/PwsWLOCRRx4hNDSUBx54gBNPPJGIiAhmz57NoEGDCA0NParvhYiIiEhdYzObdlexfqc3i92SaJfVNLaOGT4omnFD4pkzYUhrop2dEktoSN+6Tod1VtbQH+Tm5rq8vLwD2tavX8/48eODFFHfEAgEmDZtGkuXLmX06NHBDqdH6fMhIiJy9DjnKK6o95Jsv1xkw84KtuzZP5sdFR7C2CEJjB/iJdjjhsQzbkgCiTHhQY7+4MxspXMu91DjNPMtB1i3bh3nnXcec+fOHXCJt4iIiHSfukavNnu9P4u9YWcl63dVUN5uNnv80HjOmTSEcUMSGD80nqw+OJt9OJR8ywEmTJjAli1bgh2GiIiI9CG1Dc2sKSxn1fYy1hVVsGFXJVtKqvAns4kOD2XskHg+P2mIP5udwNgh8SRG9+7Z7KNBybeIiIiIHJbdFXXkbSsjL7+MldtK+aiogiY/085Iimb80ATObUm0hyaQlRxDSD+ezT4cSr5FREREpFOBgOPj3ZV+ol1G3rZSCkprAW+1kZzMQSw4dRS52UlMG5HEoJiIIEfcuyn5FhEREZFWNQ1NrC4oZ2V+GXnbyli1vYzKuiYAUuMiyc1K4roTs5melcTEYYlEhIUEOeK+Rcm3iIiIyABWXFFHXr43o71yWxkfFVW0rjwyJj2O86YMIzcridzsJEYkx3zqgoByePRVpYeddtppvPzyywe03XfffXz1q1896HZxcXEAFBUVcemll3a67/ZLK7Z33333UVNT0/r83HPPpby8vCuhd0lOTg5XXHFFt+1PREREuk9zwLGuqIJF/97GN5d8wMn/7zWOv+dV/uvJVSx+fzvR4aF8edYo/jR/BmvunMMrt87iJxdP5pLpGWSlxCrx7gaa+e5hV1xxBUuWLOHss89ubVuyZAk/+9nPurT9sGHDeOaZZz7z8e+77z6uvvpqYmJiAHjxxRc/877aW79+PYFAgDfffJPq6uoDLnHfnZqamggL00dXRETkUKrrvRKSlpnt1dvLqaz3SkgGx0eSm53E/M9lk5udzMRhCYSHal72aNM73MMuvfRS/vrXv1JfXw9Afn4+RUVFnHzyyVRVVXHGGWcwbdo0Jk+ezPPPP/+p7fPz85k0aRIAtbW1XH755UyZMoXLLruM2tra1nFf+cpXyM3NZeLEiXz/+98H4Ne//jVFRUXMnj2b2bNnA5Cdnc2ePXsA+OUvf8mkSZOYNGkS9913X+vxxo8fz0033cTEiROZM2fOAcdp68knn+Saa65hzpw5vPDCC63tmzZt4swzzyQnJ4dp06axefNmAO69914mT55MTk5O6xU/287e79mzh+zsbAAWLlzIF7/4Rc4//3zmzJlz0Pfq8ccfZ8qUKeTk5HDNNddQWVnJyJEjaWz01hWtqKggOzu79bmIiEh/sXNfLX9ZU8RdL3zEeb95iyk/eIWrHn6P+179mJLKei44bhi/uiyHt749m/f+9wx+f9V0bjxlFMdlDlLi3UMG9vThS7fDrv907z6HTIbP/7TT7pSUFGbOnMnf//53LrzwQpYsWcJll12GmREVFcVzzz1HQkICe/bs4YQTTuCCCy7o9E88DzzwADExMaxdu5a1a9cybdq01r4f//jHJCcn09zczBlnnMHatWv5+te/zi9/+UuWL19OamrqAftauXIlf/rTn3jvvfdwznH88ccza9YskpKS+OSTT1i8eDEPPfQQ8+bN49lnn+Xqq6/+VDxPPfUU//jHP9i4cSO//e1vW8tPrrrqKm6//Xbmzp1LXV0dgUCAl156iWXLlvHee+8RExNDaWnpId/ad999l7Vr15KcnExTU1OH79W6dev48Y9/zDvvvENqaiqlpaXEx8dz2mmn8be//Y2LLrqIJUuWcMkllxAePvDWFhURkf4jEHBsLqni/fxS8vLLWJFfSmGZN0EWHR7KcZmD+OppxzA9K4mpI5IG5JravdHATr6DpKX0pCX5fvTRRwHvkqv/+7//y5tvvklISAg7duyguLiYIUOGdLifN998k69//esATJkyhSlTprT2Pf300zz44IM0NTWxc+dO1q1bd0B/e2+//TZz585tLRW5+OKLeeutt7jgggsYOXIkxx13HADTp08nPz//U9uvWLGCtLQ0srKyyMjI4Etf+hJlZWWEhYWxY8cO5s6dC0BUVBQA//znP7n++utby1+Sk5MP+b6dddZZreM6e69ee+01Lr300tYvFy3jb7zxRu69914uuugi/vSnP/HQQw8d8ngiIiK9SUNTgA+L9rFiaykr/PW1y/yrRabGRTIjO4nrTxrJjOwkxg9VCUlvNbCT74PMUB9NF110Ed/61rdYtWoVtbW1rTPWTzzxBCUlJaxcuZLw8HCys7Opq6s76L46mhXfunUrP//5z1mxYgVJSUnMnz//kPtxznXaFxkZ2fo4NDS0w7KTxYsXs2HDhtYykYqKCp599lnmzZvX6fE6ij0sLIxAIADwqZjb1pB39l51tt+TTjqJ/Px83njjDZqbm1tLd0RERHqryrpGPthezor8Ulbkl7K6oJy6Ru//yJGpsZw1IZ3c7GRmZCeTnaJVSPoKfSUKgri4OE477TS+9KUvHbAyyL59+xg8eDDh4eEsX76cbdu2HXQ/p556Kk888QQAH374IWvXrgW8xDc2NpbExESKi4t56aWXWreJj4+nsrKyw30tW7aMmpoaqquree655zjllFO69HoCgQBLly5l7dq15Ofnk5+fz/PPP8/ixYtJSEggIyODZcuWAVBfX09NTQ1z5szh0UcfbV15paXsJDs7m5UrVwIc9MTSzt6rM844g6effpq9e/cesF+Aa6+9liuuuILrr7++S69LRESkJ+2urONva3e21mvn/OAVrn30fX63fBPV9c1cOTOLB66axorvnsny207j3ktzmJebychUrULSlwzsme8guuKKK7j44otZsmRJa9tVV13F+eefT25uLscddxzjxo076D6+8pWvcP311zNlyhSOO+44Zs6cCXjL/U2dOpWJEycyatQoTjrppNZtFixYwOc//3mGDh3K8uXLW9unTZvG/PnzW/dx4403MnXq1A5LTNp78803GT58OMOHD29tO/XUU1m3bh07d+5k0aJF3Hzzzdx5552Eh4ezdOlSzjnnHFavXk1ubi4RERGce+653HPPPdx2223MmzePRYsWcfrpp3d6zM7eq4kTJ/Ld736XWbNmERoaytSpU1m4cGHrNnfccYeWQhQRkaBzzrF1T7U/q+3Va2/b601IRYWHMDUzia+dPpoZ2V69dlykUrb+wg5WbtDX5ebmuvbrXq9fv57x48cHKSIJpmeeeYbnn3+eRYsWdTpGnw8RETkampoDrNtZwftbS1uX/dtT1QBAcmwEuVlJzMhOJjc7iUnDE1Wv3QeZ2UrnXO6hxulrlAwI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rwIuzvK8LwFfynkBC9iS+hQAs8ar5ltERESkGMXd7ER6IJFMMax/NRNGDMh3UURERETkBCh8F5FEspEZ44ZhmhpeREREpCgpfBeJxv3NrNu6V01ORERERIqYwneRWLqhEYAZ6mwpIiIiUrQUvovE0voUFQbn1Sh8i4iIiBQrhe8ikUg2cvYpgxnQN/YBakRERESklyh8F4HWaHIdtfcWERERKW4K30Vg7ZY97GtuZeZ4NTkRERERKWYK30UgkQyT68zUtPIiIiIiRU3huwgsqU8xYmAfxg3vn++iiIiIiEgPKHwXgaWaXEdERESkJCh8F7id+5p5ffs+NTkRERERKQEK3wUuUR/ae2ukExEREZHip/Bd4BLJFFUVxrSaIfkuioiIiIj0kMJ3gUskU0w+dTD9qivzXRQRERER6SGF7wLW0trG8g271N5bREREpEQofBewVzbv4cChVmaqvbeIiIhISVD4LmAdk+toZksRERGRUqDwXcCW1KcYPbgvY4eelO+iiIiIiEgvUPguYIlkipmaXEdERESkZCh8F6ite5rYsPOAOluKiIiIlBCF7wKVqG8EUGdLERERkRKi8F2gliZT9KmsYOrYwfkuioiIiIj0EoXvApVIppgydjB9qzS5joiIiEipUPguQM0tbaxo2MUstfcWERERKSkK3wVo1abdHGxpU3tvERERkRKj8F2AEvXtk+sofIuIiIiUEoXvApRIphg79CROGdIv30URERERkV6k8F2AEvUpZmhKeREREZGSo/BdYDbvamLjriY1OREREREpQQrfBSaRjNp7q7OliIiISMmJPXyb2dVmtsbM1pnZHVm2jzOzZ8xsqZmtMLNr0rb9XfS8NWb2tnhLHo8l9Sn6VlUweYwm1xEREREpNVVxvpmZVQL3AlcBDcAiM5vv7qvSdvsH4BF3/46ZTQYWAKdF9+cCU4BTgf80s7PcvTXOnyHXEskU02qG0KdKFyVERERESk3cCW82sM7dX3P3ZuAh4LqMfRxor/YdAmyM7l8HPOTuB939dWBd9Holo+lQKyvf2K323iIiIiIlKu7wPRbYkPa4IVqX7i7g/WbWQKj1vv04nouZ3Wpmi81s8bZt23qr3LFYuXEXza2aXEdERESkVMUdvi3LOs94PA/4obvXANcAPzGzim4+F3e/z93r3L1u5MiRPS5wnBL1jYAm1xER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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="정리">정리</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="prompt input_prompt">
</div><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>epoch=2 이후로는 validation loss가 증가하는 모습입니다. (overfitting 문제가 있을 수 있습니다)</li>
<li>accuracy는 82%대에서 epoch이 늘어나도 크게 변동이 없어보입니다.</li>
<li>Dense Layer를 깊게 쌓아 보거나, Conv1D, 혹은 LSTM을 두겹으로 쌓는 등 모델 개선의 여지는 충분히 있습니다.</li>
</ul>
</div>
</div>
</div>
</div>
</div>
</body>