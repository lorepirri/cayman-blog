---
layout: page
title: "#08-Pandas(판다스) Concat(연결), Merge(병합)"
description: "Pandas(판다스) Concat(연결), Merge(병합)에 대해 알아보겠습니다."
headline: "Pandas(판다스) Concat(연결), Merge(병합)에 대해 알아보겠습니다."
categories: pandas
tags: [python, pandas, concat, merge, data science, 데이터 분석, 딥러닝, 딥러닝 자격증, 머신러닝, 빅데이터, 테디노트]
comments: true
published: true
typora-copy-images-to: ../images/2021-06-12
---

이번 에피소드에서는 Pandas DataFrame의 여러 개의 DataFrame으로 이루어진 데이터를 합치는 방법인 `concat()`(연결), `merge()`(병합)에 대하여 다뤄 보도록 하겠습니다. 

`concat()`은 2개 이상의 DataFrame을 행 혹은 열 방향으로 연결합니다.

`merge()`는 2개의 DataFrame을 특정 Key를 기준으로 병합할 때 활용하는 메서드입니다. 

<body class="jp-Notebook" data-jp-theme-light="true" data-jp-theme-name="JupyterLab Light">
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="모듈-import">모듈 import</h2>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="kn">from</span> <span class="nn">IPython.display</span> <span class="kn">import</span> <span class="n">Image</span>
<span class="kn">import</span> <span class="nn">numpy</span> <span class="k">as</span> <span class="nn">np</span>
<span class="kn">import</span> <span class="nn">pandas</span> <span class="k">as</span> <span class="nn">pd</span>
<span class="kn">import</span> <span class="nn">seaborn</span> <span class="k">as</span> <span class="nn">sns</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="데이터셋-로드">데이터셋 로드</h2>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>1월 부터 6월 까지 상반기</strong> 데이터 로드</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">gas1</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'https://bit.ly/3znNjEX'</span><span class="p">,</span> <span class="n">encoding</span><span class="o">=</span><span class="s1">'euc-kr'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="n">gas1</span><span class="o">.</span><span class="n">shape</span><span class="p">)</span>
<span class="n">gas1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>(90590, 11)
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>번호</th>
<th>지역</th>
<th>상호</th>
<th>주소</th>
<th>기간</th>
<th>상표</th>
<th>셀프여부</th>
<th>고급휘발유</th>
<th>휘발유</th>
<th>경유</th>
<th>실내등유</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190101</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>1</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190102</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>2</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190103</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>3</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190104</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>4</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190105</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">gas2</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">read_csv</span><span class="p">(</span><span class="s1">'https://bit.ly/2Sv5oAn'</span><span class="p">,</span> <span class="n">encoding</span><span class="o">=</span><span class="s1">'euc-kr'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><strong>7월 부터 12월 까지 하반기</strong> 데이터 로드</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="nb">print</span><span class="p">(</span><span class="n">gas2</span><span class="o">.</span><span class="n">shape</span><span class="p">)</span>
<span class="n">gas2</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedText jp-OutputArea-output" data-mime-type="text/plain">
<pre>(91124, 11)
</pre>
</div>
</div>
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>번호</th>
<th>지역</th>
<th>상호</th>
<th>주소</th>
<th>기간</th>
<th>상표</th>
<th>셀프여부</th>
<th>고급휘발유</th>
<th>휘발유</th>
<th>경유</th>
<th>실내등유</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190701</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
<tr>
<th>1</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190702</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
<tr>
<th>2</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190703</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
<tr>
<th>3</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190704</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
<tr>
<th>4</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190705</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="concat()---데이터-연결">concat() - 데이터 연결</h2><p><code>concat()</code>은 DataFrame을 연결합니다.</p>
<p>단순하게 지정한 DataFrame을 이어서 연결합니다.</p>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="행-방향으로-연결">행 방향으로 연결</h3><p>기본 값인 <code>axis=0</code>이 지정되어 있고, 행 방향으로 연결합니다.</p>
<p>또한, 같은 column을 알아서 찾아서 데이터를 연결합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">concat</span><span class="p">([</span><span class="n">gas1</span><span class="p">,</span> <span class="n">gas2</span><span class="p">])</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>번호</th>
<th>지역</th>
<th>상호</th>
<th>주소</th>
<th>기간</th>
<th>상표</th>
<th>셀프여부</th>
<th>고급휘발유</th>
<th>휘발유</th>
<th>경유</th>
<th>실내등유</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190101</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>1</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190102</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>2</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190103</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>3</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190104</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>4</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190105</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>91119</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191227</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>91120</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191228</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>91121</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191229</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>91122</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191230</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>91123</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191231</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
</tbody>
</table>
<p>181714 rows × 11 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>연결시 위와 같이 index가 초기화가 되지 않아 <strong>전체 DataFrame의 개수와 index가 맞지 않는</strong> 모습입니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">concat</span><span class="p">([</span><span class="n">gas1</span><span class="p">,</span> <span class="n">gas2</span><span class="p">])</span><span class="o">.</span><span class="n">iloc</span><span class="p">[</span><span class="mi">90588</span><span class="p">:</span><span class="mi">90593</span><span class="p">]</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>번호</th>
<th>지역</th>
<th>상호</th>
<th>주소</th>
<th>기간</th>
<th>상표</th>
<th>셀프여부</th>
<th>고급휘발유</th>
<th>휘발유</th>
<th>경유</th>
<th>실내등유</th>
</tr>
</thead>
<tbody>
<tr>
<th>90588</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20190629</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1529</td>
<td>1389</td>
<td>0</td>
</tr>
<tr>
<th>90589</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20190630</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1529</td>
<td>1389</td>
<td>0</td>
</tr>
<tr>
<th>0</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190701</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
<tr>
<th>1</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190702</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
<tr>
<th>2</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190703</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1777</td>
<td>1577</td>
<td>1477</td>
<td>0</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>연결 하면서 <strong>index를 무시하고 연결</strong> 할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">gas</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">concat</span><span class="p">([</span><span class="n">gas1</span><span class="p">,</span> <span class="n">gas2</span><span class="p">],</span> <span class="n">ignore_index</span><span class="o">=</span><span class="kc">True</span><span class="p">)</span>
<span class="n">gas</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>번호</th>
<th>지역</th>
<th>상호</th>
<th>주소</th>
<th>기간</th>
<th>상표</th>
<th>셀프여부</th>
<th>고급휘발유</th>
<th>휘발유</th>
<th>경유</th>
<th>실내등유</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190101</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>1</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190102</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>2</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190103</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>3</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190104</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>4</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190105</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>181709</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191227</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181710</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191228</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181711</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191229</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181712</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191230</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181713</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191231</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
</tbody>
</table>
<p>181714 rows × 11 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="열-방향으로-연결">열 방향으로 연결</h3><p>열(column) 방향으로 연결 가능하며, <code>axis=1</code>로 지정합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell jp-mod-noOutputs">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># 실습을 위한 DataFrame 임의 분할</span>
<span class="n">gas1</span> <span class="o">=</span> <span class="n">gas</span><span class="o">.</span><span class="n">iloc</span><span class="p">[:,</span> <span class="p">:</span><span class="mi">5</span><span class="p">]</span>
<span class="n">gas2</span> <span class="o">=</span> <span class="n">gas</span><span class="o">.</span><span class="n">iloc</span><span class="p">[:,</span> <span class="mi">5</span><span class="p">:]</span>
</pre></div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">gas1</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>번호</th>
<th>지역</th>
<th>상호</th>
<th>주소</th>
<th>기간</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190101</td>
</tr>
<tr>
<th>1</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190102</td>
</tr>
<tr>
<th>2</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190103</td>
</tr>
<tr>
<th>3</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190104</td>
</tr>
<tr>
<th>4</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190105</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">gas2</span><span class="o">.</span><span class="n">head</span><span class="p">()</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>상표</th>
<th>셀프여부</th>
<th>고급휘발유</th>
<th>휘발유</th>
<th>경유</th>
<th>실내등유</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>1</th>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>2</th>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>3</th>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>4</th>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p>같은 index 행끼리 연결됩니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">concat</span><span class="p">([</span><span class="n">gas1</span><span class="p">,</span> <span class="n">gas2</span><span class="p">],</span> <span class="n">axis</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>번호</th>
<th>지역</th>
<th>상호</th>
<th>주소</th>
<th>기간</th>
<th>상표</th>
<th>셀프여부</th>
<th>고급휘발유</th>
<th>휘발유</th>
<th>경유</th>
<th>실내등유</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190101</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>1</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190102</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>2</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190103</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>3</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190104</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>4</th>
<td>A0006039</td>
<td>서울 강남구</td>
<td>(주)동하힐탑셀프주유소</td>
<td>서울 강남구 논현로 640</td>
<td>20190105</td>
<td>SK에너지</td>
<td>셀프</td>
<td>1673</td>
<td>1465</td>
<td>1365</td>
<td>0</td>
</tr>
<tr>
<th>...</th>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
<td>...</td>
</tr>
<tr>
<th>181709</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191227</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181710</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191228</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181711</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191229</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181712</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191230</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
<tr>
<th>181713</th>
<td>A0032659</td>
<td>서울 중랑구</td>
<td>지에스칼텍스㈜ 소망주유소</td>
<td>서울 중랑구 망우로 475</td>
<td>20191231</td>
<td>GS칼텍스</td>
<td>셀프</td>
<td>0</td>
<td>1540</td>
<td>1389</td>
<td>1100</td>
</tr>
</tbody>
</table>
<p>181714 rows × 11 columns</p>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h2 id="merge()---병합">merge() - 병합</h2><p>서로 <strong>다른 구성의 DataFrame이지만, 공통된 key값(컬럼)을 가지고 있다면 병합</strong>할 수 있습니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">({</span>
    <span class="s1">'고객명'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'박세리'</span><span class="p">,</span> <span class="s1">'이대호'</span><span class="p">,</span> <span class="s1">'손흥민'</span><span class="p">,</span> <span class="s1">'김연아'</span><span class="p">,</span> <span class="s1">'마이클조던'</span><span class="p">],</span>
    <span class="s1">'생년월일'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'1980-01-02'</span><span class="p">,</span> <span class="s1">'1982-02-22'</span><span class="p">,</span> <span class="s1">'1993-06-12'</span><span class="p">,</span> <span class="s1">'1988-10-16'</span><span class="p">,</span> <span class="s1">'1970-03-03'</span><span class="p">],</span>
    <span class="s1">'성별'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'여자'</span><span class="p">,</span> <span class="s1">'남자'</span><span class="p">,</span> <span class="s1">'남자'</span><span class="p">,</span> <span class="s1">'여자'</span><span class="p">,</span> <span class="s1">'남자'</span><span class="p">]})</span>
<span class="n">df1</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>생년월일</th>
<th>성별</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
</tr>
<tr>
<th>1</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
</tr>
<tr>
<th>3</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
</tr>
<tr>
<th>4</th>
<td>마이클조던</td>
<td>1970-03-03</td>
<td>남자</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">({</span>
    <span class="s1">'고객명'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'김연아'</span><span class="p">,</span> <span class="s1">'박세리'</span><span class="p">,</span> <span class="s1">'손흥민'</span><span class="p">,</span> <span class="s1">'이대호'</span><span class="p">,</span> <span class="s1">'타이거우즈'</span><span class="p">],</span>
    <span class="s1">'연봉'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'2000원'</span><span class="p">,</span> <span class="s1">'3000원'</span><span class="p">,</span> <span class="s1">'1500원'</span><span class="p">,</span> <span class="s1">'2500원'</span><span class="p">,</span> <span class="s1">'3500원'</span><span class="p">]})</span>
<span class="n">df2</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>김연아</td>
<td>2000원</td>
</tr>
<tr>
<th>1</th>
<td>박세리</td>
<td>3000원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>이대호</td>
<td>2500원</td>
</tr>
<tr>
<th>4</th>
<td>타이거우즈</td>
<td>3500원</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">merge</span><span class="p">(</span><span class="n">df1</span><span class="p">,</span> <span class="n">df2</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>생년월일</th>
<th>성별</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
<td>3000원</td>
</tr>
<tr>
<th>1</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
<td>2500원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
<td>2000원</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="병합하는-방법-4가지">병합하는 방법 4가지</h3>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>how</code> 옵션 값을 지정하여 4가지 방식으로 병합을 할 수 있으며, 각기 다른 결과를 냅니다.</p>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<ul>
<li><strong>how</strong> : {<code>left</code>, <code>right</code>, <code>outer</code>, <code>inner</code>}, </li>
<li><strong>default</strong>로 설정된 값은<code>inner</code> 입니다.</li>
</ul>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="c1"># how='inner' 입니다.</span>
<span class="n">pd</span><span class="o">.</span><span class="n">merge</span><span class="p">(</span><span class="n">df1</span><span class="p">,</span> <span class="n">df2</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>생년월일</th>
<th>성별</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
<td>3000원</td>
</tr>
<tr>
<th>1</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
<td>2500원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
<td>2000원</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">merge</span><span class="p">(</span><span class="n">df1</span><span class="p">,</span> <span class="n">df2</span><span class="p">,</span> <span class="n">how</span><span class="o">=</span><span class="s1">'left'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>생년월일</th>
<th>성별</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
<td>3000원</td>
</tr>
<tr>
<th>1</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
<td>2500원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
<td>2000원</td>
</tr>
<tr>
<th>4</th>
<td>마이클조던</td>
<td>1970-03-03</td>
<td>남자</td>
<td>NaN</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">merge</span><span class="p">(</span><span class="n">df1</span><span class="p">,</span> <span class="n">df2</span><span class="p">,</span> <span class="n">how</span><span class="o">=</span><span class="s1">'right'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>생년월일</th>
<th>성별</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
<td>2000원</td>
</tr>
<tr>
<th>1</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
<td>3000원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
<td>2500원</td>
</tr>
<tr>
<th>4</th>
<td>타이거우즈</td>
<td>NaN</td>
<td>NaN</td>
<td>3500원</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">merge</span><span class="p">(</span><span class="n">df1</span><span class="p">,</span> <span class="n">df2</span><span class="p">,</span> <span class="n">how</span><span class="o">=</span><span class="s1">'outer'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>생년월일</th>
<th>성별</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
<td>3000원</td>
</tr>
<tr>
<th>1</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
<td>2500원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
<td>2000원</td>
</tr>
<tr>
<th>4</th>
<td>마이클조던</td>
<td>1970-03-03</td>
<td>남자</td>
<td>NaN</td>
</tr>
<tr>
<th>5</th>
<td>타이거우즈</td>
<td>NaN</td>
<td>NaN</td>
<td>3500원</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<h3 id="병합하려는-컬럼의-이름이-다른-경우">병합하려는 컬럼의 이름이 다른 경우</h3>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df1</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">({</span>
    <span class="s1">'이름'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'박세리'</span><span class="p">,</span> <span class="s1">'이대호'</span><span class="p">,</span> <span class="s1">'손흥민'</span><span class="p">,</span> <span class="s1">'김연아'</span><span class="p">,</span> <span class="s1">'마이클조던'</span><span class="p">],</span>
    <span class="s1">'생년월일'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'1980-01-02'</span><span class="p">,</span> <span class="s1">'1982-02-22'</span><span class="p">,</span> <span class="s1">'1993-06-12'</span><span class="p">,</span> <span class="s1">'1988-10-16'</span><span class="p">,</span> <span class="s1">'1970-03-03'</span><span class="p">],</span>
    <span class="s1">'성별'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'여자'</span><span class="p">,</span> <span class="s1">'남자'</span><span class="p">,</span> <span class="s1">'남자'</span><span class="p">,</span> <span class="s1">'여자'</span><span class="p">,</span> <span class="s1">'남자'</span><span class="p">]})</span>
<span class="n">df1</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>이름</th>
<th>생년월일</th>
<th>성별</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
</tr>
<tr>
<th>1</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
</tr>
<tr>
<th>3</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
</tr>
<tr>
<th>4</th>
<td>마이클조던</td>
<td>1970-03-03</td>
<td>남자</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">df2</span> <span class="o">=</span> <span class="n">pd</span><span class="o">.</span><span class="n">DataFrame</span><span class="p">({</span>
    <span class="s1">'고객명'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'김연아'</span><span class="p">,</span> <span class="s1">'박세리'</span><span class="p">,</span> <span class="s1">'손흥민'</span><span class="p">,</span> <span class="s1">'이대호'</span><span class="p">,</span> <span class="s1">'타이거우즈'</span><span class="p">],</span>
    <span class="s1">'연봉'</span><span class="p">:</span> <span class="p">[</span><span class="s1">'2000원'</span><span class="p">,</span> <span class="s1">'3000원'</span><span class="p">,</span> <span class="s1">'1500원'</span><span class="p">,</span> <span class="s1">'2500원'</span><span class="p">,</span> <span class="s1">'3500원'</span><span class="p">]})</span>
<span class="n">df2</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>고객명</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>김연아</td>
<td>2000원</td>
</tr>
<tr>
<th>1</th>
<td>박세리</td>
<td>3000원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>이대호</td>
<td>2500원</td>
</tr>
<tr>
<th>4</th>
<td>타이거우즈</td>
<td>3500원</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-inputWrapper"><div class="jp-RenderedHTMLCommon jp-RenderedMarkdown jp-MarkdownOutput" data-mime-type="text/markdown">
<p><code>left_on</code>가 <code>right_on</code>을 지정합니다.</p>
<p>이름과 고객명 컬럼이 모두 drop되지 않고 살아 있음을 확인합니다.</p>
</div>
</div><div class="jp-Cell jp-CodeCell jp-Notebook-cell">
<div class="jp-Cell-inputWrapper">
<div class="jp-InputArea jp-Cell-inputArea">

<div class="jp-CodeMirrorEditor jp-Editor jp-InputArea-editor" data-type="inline">
<div class="CodeMirror cm-s-jupyter">
<div class="highlight hl-ipython3"><pre><span></span><span class="n">pd</span><span class="o">.</span><span class="n">merge</span><span class="p">(</span><span class="n">df1</span><span class="p">,</span> <span class="n">df2</span><span class="p">,</span> <span class="n">left_on</span><span class="o">=</span><span class="s1">'이름'</span><span class="p">,</span> <span class="n">right_on</span><span class="o">=</span><span class="s1">'고객명'</span><span class="p">)</span>
</pre></div>
</div>
</div>
</div>
</div>
<div class="jp-Cell-outputWrapper">
<div class="jp-OutputArea jp-Cell-outputArea">
<div class="jp-OutputArea-child">

<div class="jp-RenderedHTMLCommon jp-RenderedHTML jp-OutputArea-output jp-OutputArea-executeResult" data-mime-type="text/html">
<div>
<style scoped="">
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
<thead>
<tr style="text-align: right;">
<th></th>
<th>이름</th>
<th>생년월일</th>
<th>성별</th>
<th>고객명</th>
<th>연봉</th>
</tr>
</thead>
<tbody>
<tr>
<th>0</th>
<td>박세리</td>
<td>1980-01-02</td>
<td>여자</td>
<td>박세리</td>
<td>3000원</td>
</tr>
<tr>
<th>1</th>
<td>이대호</td>
<td>1982-02-22</td>
<td>남자</td>
<td>이대호</td>
<td>2500원</td>
</tr>
<tr>
<th>2</th>
<td>손흥민</td>
<td>1993-06-12</td>
<td>남자</td>
<td>손흥민</td>
<td>1500원</td>
</tr>
<tr>
<th>3</th>
<td>김연아</td>
<td>1988-10-16</td>
<td>여자</td>
<td>김연아</td>
<td>2000원</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
</body>