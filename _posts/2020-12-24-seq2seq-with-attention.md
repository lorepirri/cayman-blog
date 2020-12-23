---
layout: page
title: "Attention을 활용한 Seq2Seq 모델 생성과 데이터셋 구성"
description: "Attention을 활용한 Seq2Seq 모델 생성과 데이터셋 구성에 대하여 알아보겠습니다."
headline: "Attention을 활용한 Seq2Seq 모델 생성과 데이터셋 구성에 대하여 알아보겠습니다."
categories: tensorflow
tags: [python, tensorflow, rnn, nlp, 텐서플로우, 텐서플로우 강의, 텐서플로우 튜토리얼, TensorFlow Tutorial, seq2seq, attenstion, data science, 데이터 분석, 딥러닝]
comments: true
published: true
typora-copy-images-to: ../images/2020-12-24
---

이번 포스팅에서는 **Attention**을 활용한 Seq2Seq 모델을 생성하는 방법 그리고 Seq2Seq 모델의 학습을 위해 필요한 데이터셋을 구성하는 방법에 대하여 알아보도록 하겠습니다. 

<body>
<div class="border-box-sizing" id="notebook" >
<div class="container" id="notebook-container">
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">IPython.display</span> <span class="k">import</span> <span class="n">Image</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="Seq2Seq-모델을-활용한-챗봇-생성">Seq2Seq 모델을 활용한 챗봇 생성</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="Seq2Seq-모델의-개요">Seq2Seq 모델의 개요</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">Image</span><span class="p">(</span><span class="s1">'https://wikidocs.net/images/page/24996/</span><span class="si">%E</span><span class="s1">C%9D%B8</span><span class="si">%E</span><span class="s1">C%BD</span><span class="si">%94%</span><span class="s1">EB%8D</span><span class="si">%94%</span><span class="s1">EB</span><span class="si">%94%</span><span class="s1">94</span><span class="si">%E</span><span class="s1">C%BD</span><span class="si">%94%</span><span class="s1">EB%8D</span><span class="si">%94%</span><span class="s1">EB%AA%A8</span><span class="si">%E</span><span class="s1">B%8D%B8.PNG'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_png output_subarea output_execute_result">
<img src="data:image/png;base64,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
"/>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="데이터셋에-필요한-라이브러리를-다운로드-받습니다.">데이터셋에 필요한 라이브러리를 다운로드 받습니다.</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>Korpora</code>는 한글 자연어처리 데이터)셋입니다.</p>
<ul>
<li><a href="https://github.com/ko-nlp/Korpora">깃헙 주소 링크</a></li>
<li><a href="https://pypi.org/project/Korpora/">공식 도큐먼트</a></li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>설치 명령어</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># !pip install Korpora</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<ul>
<li>이 중 챗봇용 데이터셋인 <code>KoreanChatbotKorpus</code>를 다운로드 받습니다.</li>
<li><code>KoreanChatbotKorpus</code> 데이터셋을 활용하여 챗봇 모델을 학습합니다.</li>
<li>text, pair로 구성되어 있습니다.</li>
<li>질의는 <strong>text</strong>, 답변은 <strong>pair</strong>입니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">Korpora</span> <span class="k">import</span> <span class="n">KoreanChatbotKorpus</span>
<span class="n">corpus</span> <span class="o">=</span> <span class="n">KoreanChatbotKorpus</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>
    Korpora 는 다른 분들이 연구 목적으로 공유해주신 말뭉치들을
    손쉽게 다운로드, 사용할 수 있는 기능만을 제공합니다.

    말뭉치들을 공유해 주신 분들에게 감사드리며, 각 말뭉치 별 설명과 라이센스를 공유 드립니다.
    해당 말뭉치에 대해 자세히 알고 싶으신 분은 아래의 description 을 참고,
    해당 말뭉치를 연구/상용의 목적으로 이용하실 때에는 아래의 라이센스를 참고해 주시기 바랍니다.

    # Description
    Author : songys@github
    Repository : https://github.com/songys/Chatbot_data
    References :

    Chatbot_data_for_Korean v1.0
      1. 챗봇 트레이닝용 문답 페어 11,876개
      2. 일상다반사 0, 이별(부정) 1, 사랑(긍정) 2로 레이블링
    자세한 내용은 위의 repository를 참고하세요.

    # License
    CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
    Details in https://creativecommons.org/publicdomain/zero/1.0/

</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>예시 텍스트를 보면 구어체로 구성되어 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">corpus</span><span class="o">.</span><span class="n">get_all_texts</span><span class="p">()[:</span><span class="mi">10</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>['12시 땡!',
 '1지망 학교 떨어졌어',
 '3박4일 놀러가고 싶다',
 '3박4일 정도 놀러가고 싶다',
 'PPL 심하네',
 'SD카드 망가졌어',
 'SD카드 안돼',
 'SNS 맞팔 왜 안하지ㅠㅠ',
 'SNS 시간낭비인 거 아는데 매일 하는 중',
 'SNS 시간낭비인데 자꾸 보게됨']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>get_all_pairs()</code>는 <code>text</code>와 <code>pair</code>가 쌍으로 이루어져 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">corpus</span><span class="o">.</span><span class="n">get_all_pairs</span><span class="p">()[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">text</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'12시 땡!'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">corpus</span><span class="o">.</span><span class="n">get_all_pairs</span><span class="p">()[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">pair</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'하루가 또 가네요.'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="데이터-전처리">데이터 전처리</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>question</strong>과 <strong>answer</strong>를 분리합니다.</p>
<p><strong>question</strong>은 질의로 활용될 데이터셋, <strong>answer</strong>는 답변으로 활용될 데이터 셋입니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">texts</span> <span class="o">=</span> <span class="p">[]</span>
<span class="n">pairs</span> <span class="o">=</span> <span class="p">[]</span>

<span class="k">for</span> <span class="n">sentence</span> <span class="ow">in</span> <span class="n">corpus</span><span class="o">.</span><span class="n">get_all_pairs</span><span class="p">():</span>
    <span class="n">texts</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">sentence</span><span class="o">.</span><span class="n">text</span><span class="p">)</span>
    <span class="n">pairs</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">sentence</span><span class="o">.</span><span class="n">pair</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">list</span><span class="p">(</span><span class="nb">zip</span><span class="p">(</span><span class="n">texts</span><span class="p">,</span> <span class="n">pairs</span><span class="p">))[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>[('12시 땡!', '하루가 또 가네요.'),
 ('1지망 학교 떨어졌어', '위로해 드립니다.'),
 ('3박4일 놀러가고 싶다', '여행은 언제나 좋죠.'),
 ('3박4일 정도 놀러가고 싶다', '여행은 언제나 좋죠.'),
 ('PPL 심하네', '눈살이 찌푸려지죠.')]</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="특수문자는-제거합니다.">특수문자는 제거합니다.</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>한글과 숫자를 제외한 특수문자를 제거</strong>하도록 합니다.</p>
<p><em>[참고] 튜토리얼에서는 특수문자와 영문자를 제거하나, 실제 프로젝트에 적용해보기 위해서는 신중히 결정해야합니다.</em></p>
<p><em>챗봇 대화에서 영어도 많이 사용되고, 특수문자도 굉장히 많이 사용됩니다. 따라서, 선택적으로 제거할 특수기호나 영문자를 정의한 후에 전처리를 진행하야합니다.</em></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># re 모듈은 regex expression을 적용하기 위하여 활용합니다.</span>
<span class="kn">import</span> <span class="nn">re</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">clean_sentence</span><span class="p">(</span><span class="n">sentence</span><span class="p">):</span>
    <span class="c1"># 한글, 숫자를 제외한 모든 문자는 제거합니다.</span>
    <span class="n">sentence</span> <span class="o">=</span> <span class="n">re</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="sa">r</span><span class="s1">'[^0-9ㄱ-ㅎㅏ-ㅣ가-힣 ]'</span><span class="p">,</span><span class="sa">r</span><span class="s1">''</span><span class="p">,</span> <span class="n">sentence</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">sentence</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>적용한 예시</strong></p>
<p>한글, 숫자 이외의 모든 문자를 전부 제거됨을 확인할 수 있습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">clean_sentence</span><span class="p">(</span><span class="s1">'12시 땡^^!??'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'12시 땡'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">clean_sentence</span><span class="p">(</span><span class="s1">'abcef가나다^^$%@12시 땡^^!??'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>'가나다12시 땡'</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="한글-형태소-분석기-(Konlpy)">한글 형태소 분석기 (Konlpy)</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h3 id="형태소-분석기를-활용하여-문장을-분리합니다.">형태소 분석기를 활용하여 문장을 분리합니다.</h3>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>가방에 들어가신다 -&gt; 가방/NNG + 에/JKM + 들어가/VV + 시/EPH + ㄴ다/EFN</code></p>
<ul>
<li><strong>형태소 분석</strong> 이란 형태소를 비롯하여, 어근, 접두사/접미사, 품사(POS, part-of-speech) 등 다양한 언어적 속성의 구조를 파악하는 것입니다.</li>
<li><strong>konlpy 형태소 분석기를 활용</strong>하여 한글 문장에 대한 토큰화처리를 보다 효율적으로 처리합니다.</li>
</ul>
<p><a href="https://konlpy-ko.readthedocs.io/ko/v0.4.3/morph/">공식 도큐먼트</a></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>설치</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># !pip install konlpy</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p>konlpy 내부에는 Kkma, Okt, Twitter 등등의 형태소 분석기가 존재하지만, 이번 튜토리얼에서는 Okt를 활용하도록 하겠습니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">konlpy.tag</span> <span class="k">import</span> <span class="n">Okt</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">okt</span> <span class="o">=</span> <span class="n">Okt</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 형태소 변환에 활용하는 함수</span>
<span class="c1"># morphs 함수 안에 변환한 한글 문장을 입력 합니다.</span>
<span class="k">def</span> <span class="nf">process_morph</span><span class="p">(</span><span class="n">sentence</span><span class="p">):</span>
    <span class="k">return</span> <span class="s1">' '</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">okt</span><span class="o">.</span><span class="n">morphs</span><span class="p">(</span><span class="n">sentence</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>Seq2Seq</strong> 모델이 학습하기 위한 데이터셋을 구성할 때, 다음과 같이 <strong>3가지 데이터셋</strong>을 구성합니다.</p>
<ul>
<li><code>question</code>: encoder input 데이터셋 (질의 전체)</li>
<li><code>answer_input</code>: decoder input 데이터셋 (답변의 시작). START 토큰을 문장 처음에 추가 합니다.</li>
<li><code>answer_output</code>: decoder output 데이터셋 (답변의 끝). END 토큰을 문장 마지막에 추가 합니다.</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">clean_and_morph</span><span class="p">(</span><span class="n">sentence</span><span class="p">,</span> <span class="n">is_question</span><span class="o">=</span><span class="kc">True</span><span class="p">):</span>
    <span class="c1"># 한글 문장 전처리</span>
    <span class="n">sentence</span> <span class="o">=</span> <span class="n">clean_sentence</span><span class="p">(</span><span class="n">sentence</span><span class="p">)</span>
    <span class="c1"># 형태소 변환</span>
    <span class="n">sentence</span> <span class="o">=</span> <span class="n">process_morph</span><span class="p">(</span><span class="n">sentence</span><span class="p">)</span>
    <span class="c1"># Question 인 경우, Answer인 경우를 분기하여 처리합니다.</span>
    <span class="k">if</span> <span class="n">is_question</span><span class="p">:</span>
        <span class="k">return</span> <span class="n">sentence</span>
    <span class="k">else</span><span class="p">:</span>
        <span class="c1"># START 토큰은 decoder input에 END 토큰은 decoder output에 추가합니다.</span>
        <span class="k">return</span> <span class="p">(</span><span class="s1">'&lt;START&gt; '</span> <span class="o">+</span> <span class="n">sentence</span><span class="p">,</span> <span class="n">sentence</span> <span class="o">+</span> <span class="s1">' &lt;END&gt;'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">preprocess</span><span class="p">(</span><span class="n">texts</span><span class="p">,</span> <span class="n">pairs</span><span class="p">):</span>
    <span class="n">questions</span> <span class="o">=</span> <span class="p">[]</span>
    <span class="n">answer_in</span> <span class="o">=</span> <span class="p">[]</span>
    <span class="n">answer_out</span> <span class="o">=</span> <span class="p">[]</span>

    <span class="c1"># 질의에 대한 전처리</span>
    <span class="k">for</span> <span class="n">text</span> <span class="ow">in</span> <span class="n">texts</span><span class="p">:</span>
        <span class="c1"># 전처리와 morph 수행</span>
        <span class="n">question</span> <span class="o">=</span> <span class="n">clean_and_morph</span><span class="p">(</span><span class="n">text</span><span class="p">,</span> <span class="n">is_question</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
        <span class="n">questions</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">question</span><span class="p">)</span>

    <span class="c1"># 답변에 대한 전처리</span>
    <span class="k">for</span> <span class="n">pair</span> <span class="ow">in</span> <span class="n">pairs</span><span class="p">:</span>
        <span class="c1"># 전처리와 morph 수행</span>
        <span class="n">in_</span><span class="p">,</span> <span class="n">out_</span> <span class="o">=</span> <span class="n">clean_and_morph</span><span class="p">(</span><span class="n">pair</span><span class="p">,</span> <span class="n">is_question</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
        <span class="n">answer_in</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">in_</span><span class="p">)</span>
        <span class="n">answer_out</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">out_</span><span class="p">)</span>
    
    <span class="k">return</span> <span class="n">questions</span><span class="p">,</span> <span class="n">answer_in</span><span class="p">,</span> <span class="n">answer_out</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">questions</span><span class="p">,</span> <span class="n">answer_in</span><span class="p">,</span> <span class="n">answer_out</span> <span class="o">=</span> <span class="n">preprocess</span><span class="p">(</span><span class="n">texts</span><span class="p">,</span> <span class="n">pairs</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">questions</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>['12시 땡', '1 지망 학교 떨어졌어', '3 박 4일 놀러 가고 싶다', '3 박 4일 정도 놀러 가고 싶다', '심하네']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">answer_in</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>['&lt;START&gt; 하루 가 또 가네요',
 '&lt;START&gt; 위로 해 드립니다',
 '&lt;START&gt; 여행 은 언제나 좋죠',
 '&lt;START&gt; 여행 은 언제나 좋죠',
 '&lt;START&gt; 눈살 이 찌푸려지죠']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">answer_out</span><span class="p">[:</span><span class="mi">5</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>['하루 가 또 가네요 &lt;END&gt;',
 '위로 해 드립니다 &lt;END&gt;',
 '여행 은 언제나 좋죠 &lt;END&gt;',
 '여행 은 언제나 좋죠 &lt;END&gt;',
 '눈살 이 찌푸려지죠 &lt;END&gt;']</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">all_sentences</span> <span class="o">=</span> <span class="n">questions</span> <span class="o">+</span> <span class="n">answer_in</span> <span class="o">+</span> <span class="n">answer_out</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">a</span> <span class="o">=</span> <span class="p">(</span><span class="s1">' '</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">questions</span><span class="p">)</span> <span class="o">+</span> <span class="s1">' '</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">answer_in</span><span class="p">)</span> <span class="o">+</span> <span class="s1">' '</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">answer_out</span><span class="p">))</span><span class="o">.</span><span class="n">split</span><span class="p">()</span>
<span class="nb">len</span><span class="p">(</span><span class="nb">set</span><span class="p">(</span><span class="n">a</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>12638</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="토큰화">토큰화</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">warnings</span>
<span class="kn">import</span> <span class="nn">tensorflow</span> <span class="k">as</span> <span class="nn">tf</span>

<span class="kn">from</span> <span class="nn">tensorflow.keras.preprocessing.text</span> <span class="k">import</span> <span class="n">Tokenizer</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.preprocessing.sequence</span> <span class="k">import</span> <span class="n">pad_sequences</span>

<span class="c1"># WARNING 무시</span>
<span class="n">warnings</span><span class="o">.</span><span class="n">filterwarnings</span><span class="p">(</span><span class="s1">'ignore'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>토큰의 정의</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">tokenizer</span> <span class="o">=</span> <span class="n">Tokenizer</span><span class="p">(</span><span class="n">filters</span><span class="o">=</span><span class="s1">''</span><span class="p">,</span> <span class="n">lower</span><span class="o">=</span><span class="kc">False</span><span class="p">,</span> <span class="n">oov_token</span><span class="o">=</span><span class="s1">'&lt;OOV&gt;'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>Tokenizer</strong>로 문장에 대한 Word-Index Vocabulary(단어 사전)을 만듭니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">tokenizer</span><span class="o">.</span><span class="n">fit_on_texts</span><span class="p">(</span><span class="n">all_sentences</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>단어 사전 10개 출력</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">word</span><span class="p">,</span> <span class="n">idx</span> <span class="ow">in</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">word_index</span><span class="o">.</span><span class="n">items</span><span class="p">():</span>
    <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'</span><span class="si">{word}</span><span class="se">\t\t</span><span class="s1"> =&gt; </span><span class="se">\t</span><span class="si">{idx}</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">if</span> <span class="n">idx</span> <span class="o">&gt;</span> <span class="mi">10</span><span class="p">:</span>
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
<pre>&lt;OOV&gt;		 =&gt; 	1
&lt;START&gt;		 =&gt; 	2
&lt;END&gt;		 =&gt; 	3
이		 =&gt; 	4
을		 =&gt; 	5
거		 =&gt; 	6
가		 =&gt; 	7
예요		 =&gt; 	8
사람		 =&gt; 	9
요		 =&gt; 	10
에		 =&gt; 	11
</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>토큰의 갯수 확인</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">len</span><span class="p">(</span><span class="n">tokenizer</span><span class="o">.</span><span class="n">word_index</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>12637</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="치환:-텍스트를-시퀀스로-인코딩-(texts_to_sequences)">치환: 텍스트를 시퀀스로 인코딩 (<code>texts_to_sequences</code>)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">question_sequence</span> <span class="o">=</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">texts_to_sequences</span><span class="p">(</span><span class="n">questions</span><span class="p">)</span>
<span class="n">answer_in_sequence</span> <span class="o">=</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">texts_to_sequences</span><span class="p">(</span><span class="n">answer_in</span><span class="p">)</span>
<span class="n">answer_out_sequence</span> <span class="o">=</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">texts_to_sequences</span><span class="p">(</span><span class="n">answer_out</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="문장의-길이-맞추기-(pad_sequences)">문장의 길이 맞추기 (<code>pad_sequences</code>)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">MAX_LENGTH</span> <span class="o">=</span> <span class="mi">30</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">question_padded</span> <span class="o">=</span> <span class="n">pad_sequences</span><span class="p">(</span><span class="n">question_sequence</span><span class="p">,</span> <span class="n">maxlen</span><span class="o">=</span><span class="n">MAX_LENGTH</span><span class="p">,</span> <span class="n">truncating</span><span class="o">=</span><span class="s1">'post'</span><span class="p">,</span> <span class="n">padding</span><span class="o">=</span><span class="s1">'post'</span><span class="p">)</span>
<span class="n">answer_in_padded</span> <span class="o">=</span> <span class="n">pad_sequences</span><span class="p">(</span><span class="n">answer_in_sequence</span><span class="p">,</span> <span class="n">maxlen</span><span class="o">=</span><span class="n">MAX_LENGTH</span><span class="p">,</span> <span class="n">truncating</span><span class="o">=</span><span class="s1">'post'</span><span class="p">,</span> <span class="n">padding</span><span class="o">=</span><span class="s1">'post'</span><span class="p">)</span>
<span class="n">answer_out_padded</span> <span class="o">=</span> <span class="n">pad_sequences</span><span class="p">(</span><span class="n">answer_out_sequence</span><span class="p">,</span> <span class="n">maxlen</span><span class="o">=</span><span class="n">MAX_LENGTH</span><span class="p">,</span> <span class="n">truncating</span><span class="o">=</span><span class="s1">'post'</span><span class="p">,</span> <span class="n">padding</span><span class="o">=</span><span class="s1">'post'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">question_padded</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>(11823, 30)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">answer_in_padded</span><span class="o">.</span><span class="n">shape</span><span class="p">,</span> <span class="n">answer_out_padded</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>((11823, 30), (11823, 30))</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="모델">모델</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">tensorflow.keras.layers</span> <span class="k">import</span> <span class="n">Input</span><span class="p">,</span> <span class="n">Embedding</span><span class="p">,</span> <span class="n">LSTM</span><span class="p">,</span> <span class="n">Dense</span><span class="p">,</span> <span class="n">Dropout</span><span class="p">,</span> <span class="n">Attention</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.models</span> <span class="k">import</span> <span class="n">Model</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.callbacks</span> <span class="k">import</span> <span class="n">TensorBoard</span><span class="p">,</span> <span class="n">ModelCheckpoint</span>
<span class="kn">from</span> <span class="nn">tensorflow.keras.utils</span> <span class="k">import</span> <span class="n">plot_model</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="학습용-인코더-(Encoder)">학습용 인코더 (Encoder)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Encoder</span><span class="p">(</span><span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">Model</span><span class="p">):</span>
    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">units</span><span class="p">,</span> <span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">time_steps</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">(</span><span class="n">Encoder</span><span class="p">,</span> <span class="bp">self</span><span class="p">)</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">embedding</span> <span class="o">=</span> <span class="n">Embedding</span><span class="p">(</span><span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">input_length</span><span class="o">=</span><span class="n">time_steps</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="s1">'Embedding'</span><span class="p">)</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">dropout</span> <span class="o">=</span> <span class="n">Dropout</span><span class="p">(</span><span class="mf">0.2</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="s1">'Dropout'</span><span class="p">)</span>
        <span class="c1"># (attention) return_sequences=True 추가</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">lstm</span> <span class="o">=</span> <span class="n">LSTM</span><span class="p">(</span><span class="n">units</span><span class="p">,</span> <span class="n">return_state</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> <span class="n">return_sequences</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="s1">'LSTM'</span><span class="p">)</span>
        
    <span class="k">def</span> <span class="nf">call</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">inputs</span><span class="p">):</span>
        <span class="n">x</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">embedding</span><span class="p">(</span><span class="n">inputs</span><span class="p">)</span>
        <span class="n">x</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">dropout</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
        <span class="n">x</span><span class="p">,</span> <span class="n">hidden_state</span><span class="p">,</span> <span class="n">cell_state</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">lstm</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
        <span class="c1"># (attention) x return 추가</span>
        <span class="k">return</span> <span class="n">x</span><span class="p">,</span> <span class="p">[</span><span class="n">hidden_state</span><span class="p">,</span> <span class="n">cell_state</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="학습용-디코더-(Decoder)">학습용 디코더 (Decoder)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>Attention Layer</strong></p>
<p><a href="https://www.tensorflow.org/api_docs/python/tf/keras/layers/Attention">Attention Layer 공식 도큐먼트</a></p>
<p>Inputs are query tensor of shape [batch_size, Tq, dim], value tensor of shape [batch_size, Tv, dim] and key tensor of shape [batch_size, Tv, dim].</p>
<p>The calculation follows the steps:</p>
<ol>
<li>Calculate scores with shape [batch_size, Tq, Tv] as a query-key dot product: scores = tf.matmul(query, key, transpose_b=True).</li>
<li>Use scores to calculate a distribution with shape [batch_size, Tq, Tv]: distribution = tf.nn.softmax(scores).</li>
<li>Use distribution to create a linear combination of value with shape [batch_size, Tq, dim]: return tf.matmul(distribution, value).</li>
</ol>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Decoder</span><span class="p">(</span><span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">Model</span><span class="p">):</span>
    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">units</span><span class="p">,</span> <span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">time_steps</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">(</span><span class="n">Decoder</span><span class="p">,</span> <span class="bp">self</span><span class="p">)</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">embedding</span> <span class="o">=</span> <span class="n">Embedding</span><span class="p">(</span><span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">input_length</span><span class="o">=</span><span class="n">time_steps</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="s1">'Embedding'</span><span class="p">)</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">dropout</span> <span class="o">=</span> <span class="n">Dropout</span><span class="p">(</span><span class="mf">0.2</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="s1">'Dropout'</span><span class="p">)</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">lstm</span> <span class="o">=</span> <span class="n">LSTM</span><span class="p">(</span><span class="n">units</span><span class="p">,</span> 
                         <span class="n">return_state</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> 
                         <span class="n">return_sequences</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> 
                         <span class="n">name</span><span class="o">=</span><span class="s1">'LSTM'</span>
                        <span class="p">)</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">attention</span> <span class="o">=</span> <span class="n">Attention</span><span class="p">(</span><span class="n">name</span><span class="o">=</span><span class="s1">'Attention'</span><span class="p">)</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">dense</span> <span class="o">=</span> <span class="n">Dense</span><span class="p">(</span><span class="n">VOCAB_SIZE</span><span class="p">,</span> <span class="n">activation</span><span class="o">=</span><span class="s1">'softmax'</span><span class="p">,</span> <span class="n">name</span><span class="o">=</span><span class="s1">'Dense'</span><span class="p">)</span>
    
    <span class="k">def</span> <span class="nf">call</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">inputs</span><span class="p">,</span> <span class="n">initial_state</span><span class="p">):</span>
        <span class="c1"># (attention) encoder_inputs 추가</span>
        <span class="n">encoder_inputs</span><span class="p">,</span> <span class="n">decoder_inputs</span> <span class="o">=</span> <span class="n">inputs</span>
        <span class="n">x</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">embedding</span><span class="p">(</span><span class="n">decoder_inputs</span><span class="p">)</span>
        <span class="n">x</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">dropout</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
        <span class="n">x</span><span class="p">,</span> <span class="n">hidden_state</span><span class="p">,</span> <span class="n">cell_state</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">lstm</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="n">initial_state</span><span class="o">=</span><span class="n">initial_state</span><span class="p">)</span>
        
        <span class="c1"># (attention) key_value, attention_matrix 추가</span>
        <span class="c1"># 이전 hidden_state의 값을 concat으로 만들어 vector를 생성합니다.        </span>
        <span class="n">key_value</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">concat</span><span class="p">([</span><span class="n">initial_state</span><span class="p">[</span><span class="mi">0</span><span class="p">][:,</span> <span class="n">tf</span><span class="o">.</span><span class="n">newaxis</span><span class="p">,</span> <span class="p">:],</span> <span class="n">x</span><span class="p">[:,</span> <span class="p">:</span><span class="o">-</span><span class="mi">1</span><span class="p">,</span> <span class="p">:]],</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>        
        <span class="c1"># 이전 hidden_state의 값을 concat으로 만든 vector와 encoder에서 나온 출력 값들로 attention을 구합니다.</span>
        <span class="n">attention_matrix</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">attention</span><span class="p">([</span><span class="n">key_value</span><span class="p">,</span> <span class="n">encoder_inputs</span><span class="p">])</span>
        <span class="c1"># 위에서 구한 attention_matrix와 decoder의 출력 값을 concat 합니다.</span>
        <span class="n">x</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">concat</span><span class="p">([</span><span class="n">x</span><span class="p">,</span> <span class="n">attention_matrix</span><span class="p">],</span> <span class="n">axis</span><span class="o">=-</span><span class="mi">1</span><span class="p">)</span>
        
        <span class="n">x</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">dense</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
        <span class="k">return</span> <span class="n">x</span><span class="p">,</span> <span class="n">hidden_state</span><span class="p">,</span> <span class="n">cell_state</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>코드 세부설명</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>STEP 1) 인코더의 최종 hidden_state 값을 디코더 attention key의 첫 번째 state로 활용</strong></p>
<ul>
<li><code>initial_state[0]</code>: (batch_size, 128)</li>
<li><code>[initial_state[0][:, tf.newaxis, :]</code>: (batch_size, 1, 128)</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>STEP 2) 디코더의 이전 time_step의 hidden_state 값과 concat</strong></p>
<ul>
<li><code>x[:, :-1, :]</code>: (batch_size, 29, 128)</li>
</ul>
<p><em>병합 후</em></p>
<ul>
<li><code>tf.concat([initial_state[0][:, tf.newaxis, :], x[:, :-1, :]], axis=1)</code>: (batch_size, 30, 128)</li>
</ul>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>STEP 3) 1번 단계와 2번 단계에서 병합된 Key 값과 Encoder의 LSTM 전체 output value로 attention 계산</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>attention_matrix = self.attention([key_value, encoder_inputs])</code></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>STEP 4)최종 결과 도출 (concat)</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><code>tf.concat([x, attention_matrix], axis=-1)</code></p>
<p>디코더의 LSTM 전체 output과 attention 값을 concat 하여 Dense로 넘깁니다.</p>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="모델-결합">모델 결합</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">class</span> <span class="nc">Seq2Seq</span><span class="p">(</span><span class="n">tf</span><span class="o">.</span><span class="n">keras</span><span class="o">.</span><span class="n">Model</span><span class="p">):</span>
    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">units</span><span class="p">,</span> <span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">time_steps</span><span class="p">,</span> <span class="n">start_token</span><span class="p">,</span> <span class="n">end_token</span><span class="p">):</span>
        <span class="nb">super</span><span class="p">(</span><span class="n">Seq2Seq</span><span class="p">,</span> <span class="bp">self</span><span class="p">)</span><span class="o">.</span><span class="fm">__init__</span><span class="p">()</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">start_token</span> <span class="o">=</span> <span class="n">start_token</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">end_token</span> <span class="o">=</span> <span class="n">end_token</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">time_steps</span> <span class="o">=</span> <span class="n">time_steps</span>
        
        <span class="bp">self</span><span class="o">.</span><span class="n">encoder</span> <span class="o">=</span> <span class="n">Encoder</span><span class="p">(</span><span class="n">units</span><span class="p">,</span> <span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">time_steps</span><span class="p">)</span>
        <span class="bp">self</span><span class="o">.</span><span class="n">decoder</span> <span class="o">=</span> <span class="n">Decoder</span><span class="p">(</span><span class="n">units</span><span class="p">,</span> <span class="n">vocab_size</span><span class="p">,</span> <span class="n">embedding_dim</span><span class="p">,</span> <span class="n">time_steps</span><span class="p">)</span>
        
        
    <span class="k">def</span> <span class="nf">call</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">inputs</span><span class="p">,</span> <span class="n">training</span><span class="o">=</span><span class="kc">True</span><span class="p">):</span>
        <span class="k">if</span> <span class="n">training</span><span class="p">:</span>
            <span class="n">encoder_inputs</span><span class="p">,</span> <span class="n">decoder_inputs</span> <span class="o">=</span> <span class="n">inputs</span>
            <span class="c1"># (attention) encoder 출력 값 수정</span>
            <span class="n">encoder_outputs</span><span class="p">,</span> <span class="n">context_vector</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">encoder</span><span class="p">(</span><span class="n">encoder_inputs</span><span class="p">)</span>
            <span class="c1"># (attention) decoder 입력 값 수정</span>
            <span class="n">decoder_outputs</span><span class="p">,</span> <span class="n">_</span><span class="p">,</span> <span class="n">_</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">decoder</span><span class="p">((</span><span class="n">encoder_outputs</span><span class="p">,</span> <span class="n">decoder_inputs</span><span class="p">),</span> <span class="n">initial_state</span><span class="o">=</span><span class="n">context_vector</span><span class="p">)</span>
            <span class="k">return</span> <span class="n">decoder_outputs</span>
        <span class="k">else</span><span class="p">:</span>
            <span class="n">x</span> <span class="o">=</span> <span class="n">inputs</span>
            <span class="c1"># (attention) encoder 출력 값 수정</span>
            <span class="n">encoder_outputs</span><span class="p">,</span> <span class="n">context_vector</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">encoder</span><span class="p">(</span><span class="n">x</span><span class="p">)</span>
            <span class="n">target_seq</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">constant</span><span class="p">([[</span><span class="bp">self</span><span class="o">.</span><span class="n">start_token</span><span class="p">]],</span> <span class="n">dtype</span><span class="o">=</span><span class="n">tf</span><span class="o">.</span><span class="n">float32</span><span class="p">)</span>
            <span class="n">results</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">TensorArray</span><span class="p">(</span><span class="n">tf</span><span class="o">.</span><span class="n">int32</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">time_steps</span><span class="p">)</span>
            
            <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">tf</span><span class="o">.</span><span class="n">range</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">time_steps</span><span class="p">):</span>
                <span class="n">decoder_output</span><span class="p">,</span> <span class="n">decoder_hidden</span><span class="p">,</span> <span class="n">decoder_cell</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">decoder</span><span class="p">((</span><span class="n">encoder_outputs</span><span class="p">,</span> <span class="n">target_seq</span><span class="p">),</span> <span class="n">initial_state</span><span class="o">=</span><span class="n">context_vector</span><span class="p">)</span>
                <span class="n">decoder_output</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">cast</span><span class="p">(</span><span class="n">tf</span><span class="o">.</span><span class="n">argmax</span><span class="p">(</span><span class="n">decoder_output</span><span class="p">,</span> <span class="n">axis</span><span class="o">=-</span><span class="mi">1</span><span class="p">),</span> <span class="n">dtype</span><span class="o">=</span><span class="n">tf</span><span class="o">.</span><span class="n">int32</span><span class="p">)</span>
                <span class="n">decoder_output</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">reshape</span><span class="p">(</span><span class="n">decoder_output</span><span class="p">,</span> <span class="n">shape</span><span class="o">=</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="mi">1</span><span class="p">))</span>
                <span class="n">results</span> <span class="o">=</span> <span class="n">results</span><span class="o">.</span><span class="n">write</span><span class="p">(</span><span class="n">i</span><span class="p">,</span> <span class="n">decoder_output</span><span class="p">)</span>
                
                <span class="k">if</span> <span class="n">decoder_output</span> <span class="o">==</span> <span class="bp">self</span><span class="o">.</span><span class="n">end_token</span><span class="p">:</span>
                    <span class="k">break</span>
                    
                <span class="n">target_seq</span> <span class="o">=</span> <span class="n">decoder_output</span>
                <span class="n">context_vector</span> <span class="o">=</span> <span class="p">[</span><span class="n">decoder_hidden</span><span class="p">,</span> <span class="n">decoder_cell</span><span class="p">]</span>
                
            <span class="k">return</span> <span class="n">tf</span><span class="o">.</span><span class="n">reshape</span><span class="p">(</span><span class="n">results</span><span class="o">.</span><span class="n">stack</span><span class="p">(),</span> <span class="n">shape</span><span class="o">=</span><span class="p">(</span><span class="mi">1</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">time_steps</span><span class="p">))</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="단어별-원핫인코딩-적용">단어별 원핫인코딩 적용</h2><p>단어별 원핫인코딩을 적용하는 이유는 decoder의 output(출력)을 원핫인코딩 vector로 변환하기 위함</p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">VOCAB_SIZE</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="n">tokenizer</span><span class="o">.</span><span class="n">word_index</span><span class="p">)</span><span class="o">+</span><span class="mi">1</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">convert_to_one_hot</span><span class="p">(</span><span class="n">padded</span><span class="p">):</span>
    <span class="c1"># 원핫인코딩 초기화</span>
    <span class="n">one_hot_vector</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">zeros</span><span class="p">((</span><span class="nb">len</span><span class="p">(</span><span class="n">answer_out_padded</span><span class="p">),</span> <span class="n">MAX_LENGTH</span><span class="p">,</span> <span class="n">VOCAB_SIZE</span><span class="p">))</span>

    <span class="c1"># 디코더 목표를 원핫인코딩으로 변환</span>
    <span class="c1"># 학습시 입력은 인덱스이지만, 출력은 원핫인코딩 형식임</span>
    <span class="k">for</span> <span class="n">i</span><span class="p">,</span> <span class="n">sequence</span> <span class="ow">in</span> <span class="nb">enumerate</span><span class="p">(</span><span class="n">answer_out_padded</span><span class="p">):</span>
        <span class="k">for</span> <span class="n">j</span><span class="p">,</span> <span class="n">index</span> <span class="ow">in</span> <span class="nb">enumerate</span><span class="p">(</span><span class="n">sequence</span><span class="p">):</span>
            <span class="n">one_hot_vector</span><span class="p">[</span><span class="n">i</span><span class="p">,</span> <span class="n">j</span><span class="p">,</span> <span class="n">index</span><span class="p">]</span> <span class="o">=</span> <span class="mi">1</span>

    <span class="k">return</span> <span class="n">one_hot_vector</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">answer_in_one_hot</span> <span class="o">=</span> <span class="n">convert_to_one_hot</span><span class="p">(</span><span class="n">answer_in_padded</span><span class="p">)</span>
<span class="n">answer_out_one_hot</span> <span class="o">=</span> <span class="n">convert_to_one_hot</span><span class="p">(</span><span class="n">answer_out_padded</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">answer_in_one_hot</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">shape</span><span class="p">,</span> <span class="n">answer_in_one_hot</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">shape</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>((30, 12638), (30, 12638))</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="변환된-index를-다시-단어로-변환">변환된 index를 다시 단어로 변환</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">convert_index_to_text</span><span class="p">(</span><span class="n">indexs</span><span class="p">,</span> <span class="n">end_token</span><span class="p">):</span> 
    
    <span class="n">sentence</span> <span class="o">=</span> <span class="s1">''</span>
    
    <span class="c1"># 모든 문장에 대해서 반복</span>
    <span class="k">for</span> <span class="n">index</span> <span class="ow">in</span> <span class="n">indexs</span><span class="p">:</span>
        <span class="k">if</span> <span class="n">index</span> <span class="o">==</span> <span class="n">end_token</span><span class="p">:</span>
            <span class="c1"># 끝 단어이므로 예측 중비</span>
            <span class="k">break</span><span class="p">;</span>
        <span class="c1"># 사전에 존재하는 단어의 경우 단어 추가</span>
        <span class="k">if</span> <span class="n">index</span> <span class="o">&gt;</span> <span class="mi">0</span> <span class="ow">and</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">index_word</span><span class="p">[</span><span class="n">index</span><span class="p">]</span> <span class="ow">is</span> <span class="ow">not</span> <span class="kc">None</span><span class="p">:</span>
            <span class="n">sentence</span> <span class="o">+=</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">index_word</span><span class="p">[</span><span class="n">index</span><span class="p">]</span>
        <span class="k">else</span><span class="p">:</span>
        <span class="c1"># 사전에 없는 인덱스면 빈 문자열 추가</span>
            <span class="n">sentence</span> <span class="o">+=</span> <span class="s1">''</span>
            
        <span class="c1"># 빈칸 추가</span>
        <span class="n">sentence</span> <span class="o">+=</span> <span class="s1">' '</span>
    <span class="k">return</span> <span class="n">sentence</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="학습-(Training)">학습 (Training)</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>하이퍼 파라미터 정의</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">BUFFER_SIZE</span> <span class="o">=</span> <span class="mi">1000</span>
<span class="n">BATCH_SIZE</span> <span class="o">=</span> <span class="mi">64</span>
<span class="n">EMBEDDING_DIM</span> <span class="o">=</span> <span class="mi">100</span>
<span class="n">TIME_STEPS</span> <span class="o">=</span> <span class="n">MAX_LENGTH</span>
<span class="n">START_TOKEN</span> <span class="o">=</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">word_index</span><span class="p">[</span><span class="s1">'&lt;START&gt;'</span><span class="p">]</span>
<span class="n">END_TOKEN</span> <span class="o">=</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">word_index</span><span class="p">[</span><span class="s1">'&lt;END&gt;'</span><span class="p">]</span>

<span class="n">UNITS</span> <span class="o">=</span> <span class="mi">128</span>

<span class="n">VOCAB_SIZE</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="n">tokenizer</span><span class="o">.</span><span class="n">word_index</span><span class="p">)</span><span class="o">+</span><span class="mi">1</span>
<span class="n">DATA_LENGTH</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="n">questions</span><span class="p">)</span>
<span class="n">SAMPLE_SIZE</span> <span class="o">=</span> <span class="mi">3</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>체크포인트 생성</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">checkpoint_path</span> <span class="o">=</span> <span class="s1">'model/training_checkpoint-6.ckpt'</span>
<span class="n">checkpoint</span> <span class="o">=</span> <span class="n">ModelCheckpoint</span><span class="p">(</span><span class="n">filepath</span><span class="o">=</span><span class="n">checkpoint_path</span><span class="p">,</span> 
                             <span class="n">save_weights_only</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span>
                             <span class="n">save_best_only</span><span class="o">=</span><span class="kc">True</span><span class="p">,</span> 
                             <span class="n">monitor</span><span class="o">=</span><span class="s1">'loss'</span><span class="p">,</span> 
                             <span class="n">verbose</span><span class="o">=</span><span class="mi">1</span>
                            <span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>분산환경 설정</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">strategy</span> <span class="o">=</span> <span class="n">tf</span><span class="o">.</span><span class="n">distribute</span><span class="o">.</span><span class="n">MirroredStrategy</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">strategy</span><span class="o">.</span><span class="n">num_replicas_in_sync</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<p><strong>모델 생성 &amp; compile</strong></p>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 분산 환경 적용시</span>
<span class="k">with</span> <span class="n">strategy</span><span class="o">.</span><span class="n">scope</span><span class="p">():</span>
    <span class="n">seq2seq</span> <span class="o">=</span> <span class="n">Seq2Seq</span><span class="p">(</span><span class="n">UNITS</span><span class="p">,</span> <span class="n">VOCAB_SIZE</span><span class="p">,</span> <span class="n">EMBEDDING_DIM</span><span class="p">,</span> <span class="n">TIME_STEPS</span><span class="p">,</span> <span class="n">START_TOKEN</span><span class="p">,</span> <span class="n">END_TOKEN</span><span class="p">)</span>
    <span class="n">seq2seq</span><span class="o">.</span><span class="n">compile</span><span class="p">(</span><span class="n">optimizer</span><span class="o">=</span><span class="s1">'adam'</span><span class="p">,</span> <span class="n">loss</span><span class="o">=</span><span class="s1">'categorical_crossentropy'</span><span class="p">,</span> <span class="n">metrics</span><span class="o">=</span><span class="p">[</span><span class="s1">'acc'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">seq2seq</span> <span class="o">=</span> <span class="n">Seq2Seq</span><span class="p">(</span><span class="n">UNITS</span><span class="p">,</span> <span class="n">VOCAB_SIZE</span><span class="p">,</span> <span class="n">EMBEDDING_DIM</span><span class="p">,</span> <span class="n">TIME_STEPS</span><span class="p">,</span> <span class="n">START_TOKEN</span><span class="p">,</span> <span class="n">END_TOKEN</span><span class="p">)</span>
<span class="n">seq2seq</span><span class="o">.</span><span class="n">compile</span><span class="p">(</span><span class="n">optimizer</span><span class="o">=</span><span class="s1">'adam'</span><span class="p">,</span> <span class="n">loss</span><span class="o">=</span><span class="s1">'categorical_crossentropy'</span><span class="p">,</span> <span class="n">metrics</span><span class="o">=</span><span class="p">[</span><span class="s1">'acc'</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 연속하여 학습시 체크포인트를 로드하여 이어서 학습합니다.</span>
<span class="n">seq2seq</span><span class="o">.</span><span class="n">load_weights</span><span class="p">(</span><span class="n">checkpoint_path</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>&lt;tensorflow.python.training.tracking.util.CheckpointLoadStatus at 0x7f56a0067f60&gt;</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">make_prediction</span><span class="p">(</span><span class="n">model</span><span class="p">,</span> <span class="n">question_inputs</span><span class="p">):</span>
    <span class="n">results</span> <span class="o">=</span> <span class="n">model</span><span class="p">(</span><span class="n">inputs</span><span class="o">=</span><span class="n">question_inputs</span><span class="p">,</span> <span class="n">training</span><span class="o">=</span><span class="kc">False</span><span class="p">)</span>
    <span class="c1"># 변환된 인덱스를 문장으로 변환</span>
    <span class="n">results</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">asarray</span><span class="p">(</span><span class="n">results</span><span class="p">)</span><span class="o">.</span><span class="n">reshape</span><span class="p">(</span><span class="o">-</span><span class="mi">1</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">results</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">for</span> <span class="n">epoch</span> <span class="ow">in</span> <span class="nb">range</span><span class="p">(</span><span class="mi">35</span><span class="p">):</span>
    <span class="n">seq2seq</span><span class="o">.</span><span class="n">fit</span><span class="p">([</span><span class="n">question_padded</span><span class="p">,</span> <span class="n">answer_in_padded</span><span class="p">],</span>
                <span class="n">answer_out_one_hot</span><span class="p">,</span>
                <span class="n">epochs</span><span class="o">=</span><span class="mi">10</span><span class="p">,</span>
                <span class="n">batch_size</span><span class="o">=</span><span class="mi">16</span><span class="p">,</span> 
                <span class="n">callbacks</span><span class="o">=</span><span class="p">[</span><span class="n">checkpoint</span><span class="p">]</span>
               <span class="p">)</span>
    <span class="c1"># 랜덤한 샘플 번호 추출</span>
    <span class="n">samples</span> <span class="o">=</span> <span class="n">np</span><span class="o">.</span><span class="n">random</span><span class="o">.</span><span class="n">randint</span><span class="p">(</span><span class="n">DATA_LENGTH</span><span class="p">,</span> <span class="n">size</span><span class="o">=</span><span class="n">SAMPLE_SIZE</span><span class="p">)</span>

    <span class="c1"># 예측 성능 테스트</span>
    <span class="k">for</span> <span class="n">idx</span> <span class="ow">in</span> <span class="n">samples</span><span class="p">:</span>
        <span class="n">question_inputs</span> <span class="o">=</span> <span class="n">question_padded</span><span class="p">[</span><span class="n">idx</span><span class="p">]</span>
        <span class="c1"># 문장 예측</span>
        <span class="n">results</span> <span class="o">=</span> <span class="n">make_prediction</span><span class="p">(</span><span class="n">seq2seq</span><span class="p">,</span> <span class="n">np</span><span class="o">.</span><span class="n">expand_dims</span><span class="p">(</span><span class="n">question_inputs</span><span class="p">,</span> <span class="mi">0</span><span class="p">))</span>
        
        <span class="c1"># 변환된 인덱스를 문장으로 변환</span>
        <span class="n">results</span> <span class="o">=</span> <span class="n">convert_index_to_text</span><span class="p">(</span><span class="n">results</span><span class="p">,</span> <span class="n">END_TOKEN</span><span class="p">)</span>
        
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'Q: </span><span class="si">{questions[idx]}</span><span class="s1">'</span><span class="p">)</span>
        <span class="nb">print</span><span class="p">(</span><span class="n">f</span><span class="s1">'A: </span><span class="si">{results}</span><span class="se">\n</span><span class="s1">'</span><span class="p">)</span>
        <span class="nb">print</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="예측">예측</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 자연어 (질문 입력) 대한 전처리 함수</span>
<span class="k">def</span> <span class="nf">make_question</span><span class="p">(</span><span class="n">sentence</span><span class="p">):</span>
    <span class="n">sentence</span> <span class="o">=</span> <span class="n">clean_and_morph</span><span class="p">(</span><span class="n">sentence</span><span class="p">)</span>
    <span class="n">question_sequence</span> <span class="o">=</span> <span class="n">tokenizer</span><span class="o">.</span><span class="n">texts_to_sequences</span><span class="p">([</span><span class="n">sentence</span><span class="p">])</span>
    <span class="n">question_padded</span> <span class="o">=</span> <span class="n">pad_sequences</span><span class="p">(</span><span class="n">question_sequence</span><span class="p">,</span> <span class="n">maxlen</span><span class="o">=</span><span class="n">MAX_LENGTH</span><span class="p">,</span> <span class="n">truncating</span><span class="o">=</span><span class="s1">'post'</span><span class="p">,</span> <span class="n">padding</span><span class="o">=</span><span class="s1">'post'</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">question_padded</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">make_question</span><span class="p">(</span><span class="s1">'오늘 날씨가 정말 화창합니다'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>array([[ 76, 534,   7, 110,   1,   0,   0,   0,   0,   0,   0,   0,   0,
          0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
          0,   0,   0,   0]], dtype=int32)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">make_question</span><span class="p">(</span><span class="s1">'찐찐찐찐찐이야~ 완전 찐이야~'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">

<div class="output_text output_subarea output_execute_result">
<pre>array([[  1,   1,   1,   1,   1, 870,   1,   0,   0,   0,   0,   0,   0,
          0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
          0,   0,   0,   0]], dtype=int32)</pre>
</div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">def</span> <span class="nf">run_chatbot</span><span class="p">(</span><span class="n">question</span><span class="p">):</span>
    <span class="n">question_inputs</span> <span class="o">=</span> <span class="n">make_question</span><span class="p">(</span><span class="n">question</span><span class="p">)</span>
    <span class="n">results</span> <span class="o">=</span> <span class="n">make_prediction</span><span class="p">(</span><span class="n">seq2seq</span><span class="p">,</span> <span class="n">question_inputs</span><span class="p">)</span>
    <span class="n">results</span> <span class="o">=</span> <span class="n">convert_index_to_text</span><span class="p">(</span><span class="n">results</span><span class="p">,</span> <span class="n">END_TOKEN</span><span class="p">)</span>
    <span class="k">return</span> <span class="n">results</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="cell border-box-sizing text_cell rendered"><div class="inner_cell">
<div class="text_cell_render border-box-sizing rendered_html">
<h2 id="유저로부터-Text-입력-값을-받아-답변-출력">유저로부터 Text 입력 값을 받아 답변 출력</h2>
</div>
</div>
</div>
<div class="cell border-box-sizing code_cell rendered">
<div class="input">

<div class="inner_cell">
<div class="input_area">
<div class="highlight hl-ipython3"><pre><span></span><span class="k">while</span> <span class="kc">True</span><span class="p">:</span>
    <span class="n">user_input</span> <span class="o">=</span> <span class="nb">input</span><span class="p">(</span><span class="s1">'&lt;&lt; 말을 걸어 보세요!</span><span class="se">\n</span><span class="s1">'</span><span class="p">)</span>
    <span class="k">if</span> <span class="n">user_input</span> <span class="o">==</span> <span class="s1">'q'</span><span class="p">:</span>
        <span class="k">break</span>
    <span class="nb">print</span><span class="p">(</span><span class="s1">'&gt;&gt; 챗봇 응답: </span><span class="si">{}</span><span class="s1">'</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">run_chatbot</span><span class="p">(</span><span class="n">user_input</span><span class="p">)))</span>
</pre></div>
</div>
</div>
</div>
<div class="output_wrapper">
<div class="output">
<div class="output_area">
<div class="prompt"></div>
<div class="output_subarea output_stream output_stdout output_text">
<pre>&lt;&lt; 말을 걸어 보세요!
커피를 마시고 싶습니다
&gt;&gt; 챗봇 응답: 저 랑 한 잔 해 요 
&lt;&lt; 말을 걸어 보세요!
여행 가고 싶습니다
&gt;&gt; 챗봇 응답: 화장실 가세 요 
&lt;&lt; 말을 걸어 보세요!
살 빼야 합니다
&gt;&gt; 챗봇 응답: 운동 을 시작 해보세요 
&lt;&lt; 말을 걸어 보세요!
다이어트 하고 싶다
&gt;&gt; 챗봇 응답: 기초 대 사량 을 높 여보세요 
&lt;&lt; 말을 걸어 보세요!
q
</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>